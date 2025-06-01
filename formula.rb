require 'open-uri'
require 'digest'

input = <<~GEMS
  socksify-1.7.1
  thor-1.3.2
  hollaback-0.1.1
  thor-hollaback-0.2.1
  rubyzip-2.3.2
  logger-1.6.6
  relaton-logger-0.2.2
  parslet-2.0.0
  pubid-core-1.12.11
  relaton-index-0.2.16
  racc-1.8.1
  nokogiri-1.18.7-x86_64-darwin
  iso639-1.3.3
  htmlentities-4.3.4
  latex-decode-0.4.0
  bibtex-ruby-6.1.0
  public_suffix-6.0.1
  addressable-2.8.7
  relaton-bib-1.20.7
  nkf-0.2.0
  base64-0.2.0
  rubyntlm-0.6.5
  webrobots-0.1.2
  webrick-1.9.1
  connection_pool-2.5.0
  net-http-persistent-4.0.5
  net-http-digest_auth-1.4.1
  mime-types-data-3.2025.0408
  mime-types-3.6.2
  domain_name-0.6.20240107
  http-cookie-1.0.8
  mechanize-2.14.0
  relaton-xsf-1.20.0
  rexml-3.4.1
  bigdecimal-3.1.9
  bcp47_spec-0.2.1
  link_header-0.0.8
  rdf-3.3.2
  rdf-xsd-3.3.0
  sparql-client-3.3.0
  matrix-0.4.2
  sxp-2.0.0
  builder-3.3.0
  unicode-types-1.10.0
  scanf-1.0.0
  ebnf-2.6.0
  rdf-aggregate-repo-3.3.0
  sparql-3.3.1
  csv-3.3.4
  rack-3.1.13
  multi_json-1.15.0
  json-canonicalization-1.0.0
  json-ld-3.3.2
  json-ld-preloaded-3.3.1
  shex-0.8.1
  rdf-normalize-0.7.0
  date-3.4.1
  stringio-3.1.6
  psych-5.2.3
  yaml-ld-0.0.3
  shacl-0.4.2
  ld-patch-3.3.1
  rdf-vocab-3.3.2
  rdf-turtle-3.3.1
  rdf-trix-3.3.0
  rdf-trig-3.3.0
  rdf-tabular-3.3.0
  rdf-reasoner-0.9.0
  rdf-rdfxml-3.3.0
  tilt-2.6.0
  temple-0.10.3
  haml-6.3.0
  rdf-rdfa-3.3.0
  rdf-ordered-repo-3.3.0
  rdf-n3-3.3.1
  rdf-microdata-3.3.0
  rdf-json-3.3.0
  rdf-isomorphic-3.3.0
  concurrent-ruby-1.3.5
  hamster-3.0.0
  rdf-hamster-repo-3.3.0
  linkeddata-3.3.1
  relaton-w3c-1.20.0
  ruby2_keywords-0.0.5
  faraday-net_http-3.0.2
  faraday-2.7.12
  relaton-un-1.20.1
  relaton-plateau-1.20.0
  relaton-omg-1.20.0
  isoics-0.1.13
  relaton-iso-bib-1.20.0
  relaton-ogc-1.20.1
  relaton-oasis-1.20.0
  pubid-etsi-0.1.0
  pubid-iso-0.7.8
  pubid-iec-0.3.2
  pubid-cen-0.2.4
  pubid-bsi-0.3.4
  pubid-jis-0.3.2
  pubid-itu-0.1.3
  pubid-ccsds-0.1.6
  pubid-ieee-0.2.2
  lightly-0.4.0
  pubid-nist-0.4.2
  pubid-0.1.2
  moxml-0.1.3
  lutaml-model-0.7.3
  loc_mods-0.2.7
  relaton-nist-1.20.0
  relaton-jis-1.20.0
  relaton-itu-1.20.2
  relaton-iso-1.20.0
  relaton-isbn-1.20.0
  relaton-iho-1.20.0
  relaton-ietf-1.20.0
  mini_portile2-2.8.8
  ieee-idams-0.2.13
  relaton-ieee-1.20.0
  relaton-iec-1.20.0
  relaton-iana-1.20.0
  gb-agencies-0.0.7
  cnccs-0.1.6
  relaton-gb-1.20.0
  relaton-etsi-1.20.0
  relaton-ecma-1.20.0
  relaton-bipm-1.20.3
  relaton-doi-1.20.0
  relaton-cie-1.20.0
  relaton-cen-1.20.1
  relaton-ccsds-1.20.2
  relaton-calconnect-1.20.0
  fiber-storage-1.0.0
  graphql-2.5.3
  benchmark-0.4.0
  uri-1.0.3
  securerandom-0.4.1
  drb-2.2.1
  minitest-5.25.5
  tzinfo-2.0.6
  i18n-1.14.7
  activesupport-8.0.2
  graphql-client-0.25.0
  faraday-net_http_persistent-2.3.0
  algolia-2.3.4
  relaton-bsi-1.20.0
  time-0.4.1
  timeout-0.4.3
  net-protocol-0.2.2
  net-ftp-0.1.4
  relaton-3gpp-1.20.0
  relaton-1.20.0
  strscan-3.1.3
  liquid-5.8.6
  relaton-cli-1.20.1
  mnconvert-1.68.0
  relaton-iev-1.2.0
  rake-13.2.1
  ffi-1.17.2-x86_64-darwin
  bundler-2.6.6
  pngcheck-0.3.1-x86_64-darwin
  optout-0.0.2
  ruby-jing-0.0.3
  uuidtools-3.0.0
  sterile-1.0.26
  asciidoctor-2.0.23
  metanorma-utils-1.10.3
  ogc-gml-1.0.4
  xmi-0.3.18
  ruby-graphviz-1.2.5
  zeitwerk-2.7.2
  lutaml-xsd-1.0.4
  lutaml-path-0.1.0
  hashie-4.1.0
  benchmark-ips-2.14.0
  expressir-2.1.17
  lutaml-0.9.32
  sys-proctable-1.3.0
  reverse_markdown-2.1.1
  css_parser-1.21.1
  premailer-1.27.0
  nokogiri-styles-0.1.2
  descriptive_statistics-2.5.1
  cliver-0.3.2
  word-to-markdown-1.1.9
  unitsdb-1.0.0
  mml-2.0.3
  unitsml-0.4.6
  ox-2.14.22
  plurimath-0.9.2
  yaml-0.4.0
  oscal-0.1.1
  marcel-1.0.4
  coradoc-1.1.7
  metanorma-plugin-lutaml-0.7.26
  glossarist-2.3.5
  metanorma-plugin-glossarist-0.2.3
  cldr-plurals-runtime-rb-1.1.0
  camertron-eprun-1.1.1
  twitter_cldr-6.14.0
  thread_safe-0.3.6
  rouge-4.5.1
  roman-numerals-0.3.0
  tzinfo-data-1.2025.2
  isodoc-i18n-1.3.2
  relaton-render-0.9.1
  mn-requirements-0.5.1
  mn2pdf-2.20
  image_size-3.4.0
  emf2svg-1.4.3-x86_64-darwin
  vectory-0.7.7
  plane1converter-0.0.1
  html2doc-1.9.0
  isodoc-3.1.4
  metanorma-plugin-datastruct-0.3.1
  seven-zip-1.4.2
  ruby-ole-1.2.13.1
  ffi-compiler2-2.3.0
  libmspack-0.11.0
  ffi-libarchive-1.1.14
  ffi-libarchive-binary-0.4.1-x86_64-darwin
  arr-pm-0.0.12
  excavate-0.3.7
  plist-3.7.2
  ttfunk-1.8.0
  rchardet-1.9.0
  git-1.19.1
  sys-uname-1.3.1
  json-2.10.2
  fuzzy_match-2.1.0
  extract_ttc-0.3.6-x86_64-darwin
  down-5.4.2
  fontist-1.21.2
  metanorma-2.1.7
  sqlite3-1.7.3
  sequel-5.91.0
  creek-2.6.3
  iev-0.3.5
  crass-1.0.6
  metanorma-standoc-3.0.6
  tokenizer-0.3.0
  metanorma-iso-3.0.4
  japanese_calendar-0.4.2
  metanorma-jis-0.5.4
  metanorma-plateau-1.0.2
  iso-639-0.3.8
  metanorma-ogc-2.7.4
  metanorma-itu-2.6.4
  metanorma-generic-3.0.2
  metanorma-iho-1.1.4
  metanorma-ietf-data-0.2.0
  metanorma-ietf-3.5.4
  metanorma-ieee-1.4.4
  metanorma-iec-2.6.4
  metanorma-csa-2.6.4
  metanorma-cc-2.6.4
  metanorma-bipm-2.6.5
  metanorma-cli-1.12.8
GEMS

input.lines.each do |line|
  gem_name, version_platform = line.strip.split("-", 2)
  next unless gem_name && version_platform

  version = version_platform
  platform = nil

  # Check if platform-specific gem
  if version_platform =~ /(\d+\.\d+\.\d+)-(.+)/
    version = $1
    platform = $2
  end

  filename = "#{gem_name}-#{version}"
  filename += "-#{platform}" if platform
  filename += ".gem"

  url = "https://rubygems.org/gems/#{filename}"

  # puts "Fetching #{filename}..."

  begin
    gem_data = URI.open(url).read
    sha256 = Digest::SHA256.hexdigest(gem_data)

    puts <<~RUBY

      resource "#{gem_name}" do
        url "#{url}"
        sha256 "#{sha256}"
      end
    RUBY

  rescue OpenURI::HTTPError => e
    warn "Failed to fetch #{url}: #{e.message}"
  end
end
