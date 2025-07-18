#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'erb'
require 'net/http'
require 'uri'
require 'digest'
require 'fileutils'

begin
  require 'octokit'
rescue LoadError
  puts "Error: octokit gem is required. Install it with: gem install octokit"
  exit 1
end

class FormulaGenerator
  GITHUB_OWNER = 'metanorma'
  PACKED_MN_REPO = 'packed-mn'
  METANORMA_CLI_REPO = 'metanorma-cli'
  SUCCESS_CODE = '200'
  REDIRECT_CODES = %w[301 302 303 307 308].freeze
  ASSET_EXTENSION = '.tgz'
  SHA256_SUFFIX = '.sha256.txt'

  def initialize(metadata_file = 'formula-metadata.json')
    @metadata_file = metadata_file
    @metadata = load_metadata
    @dry_run = false
    @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    @client.auto_paginate = true
  end

  def generate(version: nil, dry_run: false)
    @dry_run = dry_run

    if version
      @metadata['version'] = version
      puts "Updating to version #{version}"
    end

    puts "Fetching SHA256 hashes..."
    update_sha256_hashes

    puts "Generating formulas..."
    generate_formula('metanorma', 'templates/metanorma.rb.erb', 'Formula/metanorma.rb')
    generate_formula('metanorma-dev', 'templates/metanorma-dev.rb.erb', 'Formula/metanorma-dev.rb')

    if @dry_run
      puts "\nDry run completed. No files were modified."
    else
      puts "\nFormulas generated successfully!"
      save_metadata
    end
  end

  private

  def load_metadata
    unless File.exist?(@metadata_file)
      raise "Metadata file #{@metadata_file} not found"
    end

    JSON.parse(File.read(@metadata_file))
  end

  def save_metadata
    File.write(@metadata_file, JSON.pretty_generate(@metadata))
  end

  def update_sha256_hashes
    version = @metadata['version']

    # Update source archives
    update_source_archive('packed_mn', PACKED_MN_REPO, version)
    update_source_archive('metanorma_cli', METANORMA_CLI_REPO, version)

    # Update binary SHA256s using GitHub releases API
    update_binary_hashes(version)
  end

  def update_source_archive(key, repo_name, version)
    archive_info = @metadata[key]
    archive_info['url'] = substitute_version(archive_info['url_template'], version)
    archive_info['sha256'] = fetch_sha256_from_github_archive(GITHUB_OWNER, repo_name, version)
  end

  def update_binary_hashes(version)
    @metadata['binaries'].each do |platform, info|
      info['url'] = substitute_version(info['url_template'], version)

      # Try to fetch SHA256 from GitHub release assets
      sha256 = fetch_sha256_from_github_release(GITHUB_OWNER, PACKED_MN_REPO, version, platform)

      if sha256.nil?
        puts "  Warning: Could not fetch SHA256 from GitHub API, downloading binary..."
        sha256 = fetch_sha256(info['url'])
      end

      info['sha256'] = sha256
      puts "  #{platform}: #{sha256}"
    end
  end

  def substitute_version(template, version)
    template.gsub('{version}', version)
  end

  def fetch_sha256_from_github_archive(owner, repo, version)
    puts "  Fetching SHA256 for #{owner}/#{repo} archive v#{version}..."

    begin
      # Get the tarball URL and download it to calculate SHA256
      tarball_url = @client.archive_link("#{owner}/#{repo}", ref: "v#{version}", format: 'tarball')
      fetch_sha256(tarball_url)
    rescue Octokit::NotFound, StandardError => e
      warning_msg = e.is_a?(Octokit::NotFound) ?
        "Release v#{version} not found for #{owner}/#{repo}" :
        "GitHub API error for #{owner}/#{repo}: #{e.message}"
      puts "  Warning: #{warning_msg}"

      # Fallback to direct URL construction
      fallback_url = "https://github.com/#{owner}/#{repo}/archive/v#{version}.tar.gz"
      fetch_sha256(fallback_url)
    end
  end

  def fetch_sha256_from_github_release(owner, repo, version, platform)
    puts "  Fetching SHA256 for #{owner}/#{repo} release v#{version} (#{platform})..."

    begin
      release = @client.release_for_tag("#{owner}/#{repo}", "v#{version}")

      # Try SHA256 file first, then binary asset
      sha256_from_file = try_fetch_sha256_file(release, platform)
      return sha256_from_file if sha256_from_file

      sha256_from_binary = try_fetch_sha256_from_binary(release, platform)
      return sha256_from_binary if sha256_from_binary

      puts "    No matching assets found for platform #{platform}"
      nil

    rescue Octokit::NotFound
      puts "    Release v#{version} not found for #{owner}/#{repo}"
      nil
    rescue => e
      puts "    GitHub API error: #{e.message}"
      nil
    end
  end

  def try_fetch_sha256_file(release, platform)
    sha256_asset_name = build_asset_name(platform, SHA256_SUFFIX)
    sha256_asset = find_asset(release, sha256_asset_name)

    return nil unless sha256_asset

    puts "    Found SHA256 file: #{sha256_asset.name}"
    sha256_content = fetch_asset_content(sha256_asset.browser_download_url)
    sha256_content&.strip&.split&.first
  end

  def try_fetch_sha256_from_binary(release, platform)
    binary_asset_name = build_asset_name(platform)
    binary_asset = find_asset(release, binary_asset_name)

    return nil unless binary_asset

    puts "    Found binary asset: #{binary_asset.name}, calculating SHA256..."
    fetch_sha256(binary_asset.browser_download_url)
  end

  def build_asset_name(platform, suffix = ASSET_EXTENSION)
    "metanorma-#{platform}#{suffix}"
  end

  def find_asset(release, asset_name)
    release.assets.find { |asset| asset.name == asset_name }
  end

  def fetch_asset_content(url)
    response = make_http_request(url)
    response.code == SUCCESS_CODE ? response.body : nil
  rescue => e
    puts "    Warning: Failed to fetch asset content from #{url}: #{e.message}"
    nil
  end

  def fetch_sha256_from_file(url)
    response = make_http_request(url)

    if response.code == SUCCESS_CODE
      # SHA256 files typically contain "hash filename", we want just the hash
      response.body.strip.split.first
    else
      nil
    end
  rescue => e
    puts "  Warning: Failed to fetch SHA256 from #{url}: #{e.message}"
    nil
  end

  def make_http_request(url)
    uri = URI(url)
    Net::HTTP.get_response(uri)
  end

  def fetch_sha256(url, max_redirects = 5)
    uri = URI(url)

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)

      http.request(request) do |response|
        case response.code
        when SUCCESS_CODE
          digest = Digest::SHA256.new
          response.read_body do |chunk|
            digest.update(chunk)
          end
          return digest.hexdigest
        when *REDIRECT_CODES
          if max_redirects > 0
            location = resolve_redirect_location(response, uri)
            return fetch_sha256(location, max_redirects - 1)
          else
            raise "Too many redirects for #{url}"
          end
        else
          raise "Failed to download #{url}: HTTP #{response.code}"
        end
      end
    end
  rescue => e
    puts "  Error fetching SHA256 for #{url}: #{e.message}"
    raise
  end

  def resolve_redirect_location(response, original_uri)
    location = response['location']
    location.start_with?('/') ? "#{original_uri.scheme}://#{original_uri.host}#{location}" : location
  end

  def generate_formula(name, template_path, output_path)
    unless File.exist?(template_path)
      raise "Template file #{template_path} not found"
    end

    template = ERB.new(File.read(template_path), trim_mode: '-')
    content = template.result(binding)

    if @dry_run
      puts "\n--- #{output_path} (DRY RUN) ---"
      puts content
      puts "--- END #{output_path} ---\n"
    else
      # Create backup
      if File.exist?(output_path)
        backup_path = "#{output_path}.backup.#{Time.now.to_i}"
        FileUtils.cp(output_path, backup_path)
        puts "  Created backup: #{backup_path}"
      end

      File.write(output_path, content)
      puts "  Generated: #{output_path}"
    end
  end

  def metadata
    @metadata
  end
end

# CLI interface
if __FILE__ == $0
  require 'optparse'

  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options]"

    opts.on('-v', '--version VERSION', 'Set version number') do |v|
      options[:version] = v
    end

    opts.on('-d', '--dry-run', 'Show what would be generated without writing files') do
      options[:dry_run] = true
    end

    opts.on('-h', '--help', 'Show this help') do
      puts opts
      exit
    end
  end.parse!

  begin
    generator = FormulaGenerator.new
    generator.generate(
      version: options[:version],
      dry_run: options[:dry_run]
    )
  rescue => e
    puts "Error: #{e.message}"
    exit 1
  end
end
