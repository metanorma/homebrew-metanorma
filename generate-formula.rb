#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'erb'
require 'digest'
require 'fileutils'
require 'net/http'
require 'uri'

begin
  require 'octokit'
rescue LoadError
  puts "Error: octokit gem is required. Install it with: gem install octokit"
  exit 1
end

class FormulaGenerator

  RESOURCES_AND_TEMPLATES ={
    "metanorma/packed-mn" => {
      "src" => {
        "type" => "source"
      },
      "darwin-arm64" => {
        "type" => "release-artifact",
        "filename" => "metanorma-darwin-arm64.tgz",
      },
      "darwin-x86_64" => {
        "type" => "release-artifact",
        "filename" => "metanorma-darwin-x86_64.tgz",
      },
      "linux-x86_64" => {
        "type" => "release-artifact",
        "filename" => "metanorma-linux-x86_64.tgz",
      },
      "linux-aarch64" => {
        "type" => "release-artifact",
        "filename" => "metanorma-linux-aarch64.tgz",
      }
    },
    "metanorma/metanorma-cli" => {
      "src" => {
        "type" => "source"
      }
    },
  }

  def initialize(metadata_file = 'formula-metadata.json')
    @metadata_file = metadata_file
    @metadata = load_metadata
    @dry_run = false
    @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def generate(version:, dry_run: false)
    @dry_run = dry_run

    raise "Version must be specified (e.g. v1.0.0)" unless version
    raise "Version must be a valid semantic version with 'v' prefix (e.g. v1.0.0)" unless version.match?(/^v\d+\.\d+\.\d+$/)

    puts "Fetching SHA256 hashes..."
    results = update_sha256_hashes(version)

    puts "Generating formulas..."
    generate_formula('metanorma', 'templates/metanorma.rb.erb', 'Formula/metanorma.rb')
    generate_formula('metanorma-dev', 'templates/metanorma-dev.rb.erb', 'Formula/metanorma-dev.rb')

    puts "Saving metadata..."
    save_metadata(results)

    puts "\nFormulas generated successfully!"
  end

  private

  def load_metadata
    unless File.exist?(@metadata_file)
      raise "Metadata file #{@metadata_file} not found"
    end

    JSON.parse(File.read(@metadata_file))
  end

  def save_metadata(metadata)
    if @dry_run
      puts "\n--- #{@metadata_file} (DRY RUN) ---"
      puts '```json'
      puts JSON.pretty_generate(metadata)
      puts '```'
      puts "--- END #{@metadata_file} ---\n"
      return
    end

    File.write(@metadata_file, JSON.pretty_generate(metadata))
  end

  def update_sha256_hashes(version)
    result = {}

    # Process each resource group in RESOURCES_AND_TEMPLATES
    RESOURCES_AND_TEMPLATES.each do |resource_repo, resources|

      puts "Processing #{resource_repo}..."

      # resource_repo is in the format "metanorma/packed-mn"
      release = @client.release_for_tag(resource_repo, version)
      raise "Release not found for #{resource_repo} at tag #{version}" unless release

      result[resource_repo.to_s] = {}
      resources.each do |resource_name, resource_info|
        puts "  Processing resource: #{resource_name} (#{resource_info['type']})"
        url = case resource_info['type']
        when 'source'
          if release.tarball_url?
            release.tarball_url
          else
            raise "No tarball URL found for source resource in release #{version}"
          end
        when 'release-artifact'
          asset_name = resource_info['filename']
          asset = release.assets.find { |a| a.name == asset_name }
          raise "Asset '#{asset_name}' not found in release #{version}" unless asset
          if asset.browser_download_url?
            asset.browser_download_url
          else
            raise "No download URL found for asset '#{asset_name}' in release #{version}"
          end
        end

        puts "    Downloading from #{url}"
        content = download_http(url)
        hash = Digest::SHA256.hexdigest(content)
        puts "    SHA256: #{hash}"

        result[resource_repo.to_s][resource_name] = {
          "url" => url,
          "sha256" => hash
        }
      end
    end

    result
  end

  def download_http(url)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)
      request['User-Agent'] = 'Homebrew Formula Generator'
      response = http.request(request)

      case response
      when Net::HTTPSuccess
        response.body
      when Net::HTTPRedirection
        location = response['location']
        raise "Redirect without location" unless location
        location = URI.join(url, location).to_s if location.start_with?('/')
        download_http(location)
      else
        raise "HTTP #{response.code}: #{response.message}"
      end
    end
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
      return
    end

    File.write(output_path, content)
    puts "  Generated: #{output_path}"
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
  # rescue => e
  #   puts "Error: #{e.message}"
  #   exit 1
  end
end
