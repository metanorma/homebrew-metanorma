class Metanorma < Formula
  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"
  url "https://rubygems.org/downloads/metanorma-cli-1.12.8.gem"
  sha256 "b746637b00a051ca409ccf98fc82c12c443d27183c3d4bdd3535ad47eb015573"
  license "0BSD"

  depends_on "pkgconf" => :build
  depends_on "gflags"
  depends_on "graphviz"
  depends_on "openjdk"
  depends_on "plantuml"
  depends_on "readline"
  depends_on "ruby@3.3"
  depends_on "xml2rfc"

  uses_from_macos "sqlite"

  on_linux do
    depends_on "libxslt"
  end

  resource "vendor-gems" do
    url "https://github.com/metanorma/metanorma-cli/releases/download/v1.12.8/vendored-gems.tar.gz"
    sha256 "697b48ee98f9baceac914033f8ed48551a64ea96ce1ca7ee6fd46b618745a8bd"
  end

  def install
    ENV["GEM_HOME"] = libexec
    ENV["GEM_PATH"] = libexec

    # Unpack the vendored gems (includes Gemfile, Gemfile.lock, vendor/cache/*.gem)
    resource("vendor-gems").stage do
      cp_r ".", buildpath
    end

    gems = [
      "mini_portile2-2.8.9",
      "link_header-0.0.8",
      "bigdecimal-3.2.2",
      "bcp47_spec-0.2.1",
      "parslet-2.0.0",
      "connection_pool-2.4.1",
      "io-console-0.8.0",
      "rdf-3.3.2",
      "matrix-0.4.2",
      "pubid-core-1.12.11",
      "net-http-persistent-4.0.6",
      "reline-0.6.1",
      "rexml-3.4.1",
      "unicode-types-1.10.0",
      "sxp-2.0.0",
      "scanf-1.0.0",
      "htmlentities-4.3.4",
      "base64-0.3.0",
      "rack-3.1.16",
      "multi_json-1.15.0",
      "json-canonicalization-1.0.0",
      "tilt-2.6.0",
      "thor-1.3.2",
      "temple-0.10.3",
      "racc-1.8.1",
      "pubid-iso-0.7.8",
      "pubid-iec-0.3.2",
      "stringio-3.1.7",
      "date-3.4.1",
      "sparql-client-3.3.0",
      "readline-0.0.4",
      "rdf-xsd-3.3.0",
      "rdf-aggregate-repo-3.3.0",
      "logger-1.6.6",
      "ebnf-2.6.0",
      "builder-3.3.0",
      "json-ld-3.3.2",
      "public_suffix-6.0.2",
      "rdf-vocab-3.3.2",
      "haml-6.3.0",
      "concurrent-ruby-1.3.5",
      "latex-decode-0.4.0",
      "rubyzip-2.3.2",
      "nokogiri-1.18.8",
      "lightly-0.4.0",
      "pubid-cen-0.2.4",
      "moxml-0.1.4",
      "mime-types-data-3.2025.0603",
      "domain_name-0.6.20240107",
      "ruby2_keywords-0.0.5",
      "faraday-net_http-3.0.2",
      "psych-5.2.6",
      "sparql-3.3.2",
      "json-ld-preloaded-3.3.1",
      "rdf-turtle-3.3.1",
      "addressable-2.8.7",
      "rdf-rdfa-3.3.0",
      "hamster-3.0.0",
      "relaton-logger-0.2.2",
      "iso639-1.3.3",
      "bibtex-ruby-6.1.0",
      "pubid-nist-0.4.2",
      "pubid-jis-0.3.2",
      "pubid-itu-0.1.3",
      "pubid-ieee-0.2.2",
      "pubid-etsi-0.1.0",
      "pubid-ccsds-0.1.6",
      "pubid-bsi-0.3.4",
      "lutaml-model-0.7.3",
      "webrobots-0.1.2",
      "webrick-1.9.1",
      "rubyntlm-0.6.5",
      "nkf-0.2.0",
      "net-http-digest_auth-1.4.1",
      "mime-types-3.7.0",
      "http-cookie-1.0.8",
      "fiber-storage-1.0.1",
      "uri-1.0.3",
      "tzinfo-2.0.6",
      "securerandom-0.4.1",
      "minitest-5.25.5",
      "i18n-1.14.7",
      "drb-2.2.3",
      "benchmark-0.4.1",
      "faraday-2.7.12",
      "timeout-0.4.3",
      "cldr-plurals-runtime-rb-1.1.0",
      "camertron-eprun-1.1.1",
      "uuidtools-3.0.0",
      "sterile-1.0.26",
      "csv-3.3.5",
      "asciidoctor-2.0.23",
      "strscan-3.1.5",
      "yaml-ld-0.0.3",
      "shex-0.8.1",
      "shacl-0.4.2",
      "rdf-trix-3.3.0",
      "rdf-trig-3.3.0",
      "rdf-tabular-3.3.0",
      "rdf-reasoner-0.9.0",
      "rdf-rdfxml-3.3.0",
      "rdf-ordered-repo-3.3.0",
      "rdf-normalize-0.7.0",
      "rdf-n3-3.3.1",
      "rdf-microdata-3.3.0",
      "rdf-json-3.3.0",
      "rdf-isomorphic-3.3.0",
      "rdf-hamster-repo-3.3.0",
      "ld-patch-3.3.1",
      "relaton-bib-1.20.7",
      "isoics-0.1.13",
      "relaton-index-0.2.16",
      "pubid-0.1.2",
      "loc_mods-0.2.7",
      "ieee-idams-0.2.14",
      "mechanize-2.14.0",
      "graphql-2.5.9",
      "activesupport-8.0.2",
      "faraday-net_http_persistent-2.3.0",
      "time-0.4.1",
      "net-protocol-0.2.2",
      "twitter_cldr-6.14.0",
      "metanorma-utils-1.11.3",
      "liquid-5.8.6",
      "ffi-1.17.2",
      "unitsdb-1.0.0",
      "mml-2.0.3",
      "rake-13.3.0",
      "linkeddata-3.3.3",
      "relaton-iso-bib-1.20.0",
      "gb-agencies-0.0.7",
      "cnccs-0.1.6",
      "relaton-nist-1.20.0",
      "relaton-ietf-1.20.0",
      "relaton-ieee-1.20.1",
      "relaton-bipm-1.20.4",
      "graphql-client-0.26.0",
      "algolia-2.3.4",
      "net-ftp-0.1.4",
      "unicode-display_width-2.6.0",
      "tzinfo-data-1.2025.2",
      "isodoc-i18n-1.3.2",
      "marcel-1.0.4",
      "image_size-3.4.0",
      "emf2svg-1.4.3",
      "unitsml-0.4.7",
      "ox-2.14.23",
      "css_parser-1.21.1",
      "ffi-compiler2-2.3.0",
      "ffi-libarchive-1.1.14",
      "hollaback-0.1.1",
      "relaton-xsf-1.20.0",
      "relaton-w3c-1.20.0",
      "relaton-un-1.20.1",
      "relaton-plateau-1.20.0",
      "relaton-omg-1.20.0",
      "relaton-ogc-1.20.1",
      "relaton-oasis-1.20.0",
      "relaton-jis-1.20.0",
      "relaton-itu-1.20.2",
      "relaton-iso-1.20.0",
      "relaton-isbn-1.20.1",
      "relaton-iho-1.20.1",
      "relaton-iec-1.20.0",
      "relaton-iana-1.20.0",
      "relaton-gb-1.20.1",
      "relaton-etsi-1.20.0",
      "relaton-ecma-1.20.0",
      "relaton-doi-1.20.0",
      "relaton-cie-1.20.0",
      "relaton-cen-1.20.1",
      "relaton-ccsds-1.20.2",
      "relaton-calconnect-1.20.0",
      "relaton-bsi-1.20.0",
      "relaton-3gpp-1.20.0",
      "zeitwerk-2.7.3",
      "terminal-table-3.0.2",
      "ruby-progressbar-1.13.0",
      "benchmark-ips-2.14.0",
      "relaton-render-0.9.1",
      "vectory-0.8.0",
      "thread_safe-0.3.6",
      "plurimath-0.9.6",
      "plane1converter-0.0.1",
      "sys-proctable-1.3.0",
      "reverse_markdown-2.1.1",
      "premailer-1.27.0",
      "nokogiri-styles-0.1.2",
      "descriptive_statistics-2.5.1",
      "cliver-0.3.2",
      "yaml-0.4.0",
      "rchardet-1.9.0",
      "seven-zip-1.4.2",
      "ruby-ole-1.2.13.1",
      "libmspack-0.11.0",
      "ffi-libarchive-binary-0.4.1",
      "arr-pm-0.0.12",
      "thor-hollaback-0.2.1",
      "relaton-1.20.1",
      "xmi-0.3.18",
      "ruby-graphviz-1.2.5",
      "lutaml-xsd-1.0.4",
      "lutaml-path-0.1.0",
      "hashie-4.1.0",
      "expressir-2.1.22",
      "rouge-4.5.2",
      "roman-numerals-0.3.0",
      "mn2pdf-2.25",
      "mn-requirements-0.5.2",
      "html2doc-1.9.2",
      "word-to-markdown-1.1.9",
      "oscal-0.1.1",
      "ttfunk-1.8.0",
      "sys-uname-1.3.1",
      "socksify-1.7.1",
      "plist-3.7.2",
      "json-2.12.2",
      "git-1.19.1",
      "fuzzy_match-2.1.0",
      "extract_ttc-0.3.6",
      "excavate-0.3.7",
      "down-5.4.2",
      "optout-0.0.2",
      "relaton-cli-1.20.2",
      "ogc-gml-1.0.4",
      "lutaml-0.9.33",
      "isodoc-3.1.10",
      "coradoc-1.1.7",
      "glossarist-2.3.6",
      "fontist-1.21.2",
      "sqlite3-1.7.3",
      "sequel-5.93.0",
      "creek-2.6.3",
      "ruby-jing-0.0.3",
      "relaton-iev-1.2.1",
      "pngcheck-0.3.1",
      "metanorma-plugin-lutaml-0.7.32",
      "metanorma-plugin-glossarist-0.2.4",
      "metanorma-2.1.10",
      "iev-0.3.6",
      "crass-1.0.6",
      "tokenizer-0.3.0",
      "mnconvert-1.68.0",
      "metanorma-standoc-3.0.9",
      "metanorma-iso-3.0.8",
      "japanese_calendar-0.4.2",
      "metanorma-jis-0.5.7",
      "iso-639-0.3.8",
      "metanorma-generic-3.0.3",
      "metanorma-ietf-data-0.2.0",
      "metanorma-plateau-1.0.7",
      "metanorma-ogc-2.7.7",
      "metanorma-itu-2.6.7",
      "metanorma-iho-1.1.7",
      "metanorma-ietf-3.5.6",
      "metanorma-ieee-1.4.7",
      "metanorma-iec-2.6.7",
      "metanorma-csa-2.6.7",
      "metanorma-cc-2.6.7",
      "metanorma-bipm-2.6.8",
    ]

    arch = if OS.mac?
             Hardware::CPU.arm? ? "arm64-darwin" : "x86_64-darwin"
           else
             Hardware::CPU.arm? ? "aarch64-linux" : "x86_64-linux"
           end

    gems.each { |gem|
      # Prefer arch-specific gem
      files = Dir["vendor/cache/#{gem}-#{arch}.gem"]
      files = Dir["vendor/cache/#{gem}.gem"] if files.empty?
      gem_file = files.first

      args = [
        "gem", "install", "--local", gem_file,
        "--install-dir", libexec, "--no-document",
        "--ignore-dependencies",
      ]

      if gem.start_with?("sqlite3-")
        # Link sqlite3 with brew's libsqlite3
        args += [
          "--",
          "--enable-system-libraries",
          "--with-sqlite3-include=#{Formula["sqlite"].opt_include}",
          "--with-sqlite3-lib=#{Formula["sqlite"].opt_lib}"
        ]
      elsif gem.start_with?("pngcheck-") and OS.linux?
        # Link pngcheck with brew's zlib (libz.so.1)
        ENV.append "CFLAGS", "-I$(brew --prefix zlib)/include"
        ENV.append "LDFLAGS", "-L$(brew --prefix zlib)/lib -Wl,-rpath,$(brew --prefix zlib)/lib"
        ENV.append "PKG_CONFIG_PATH", "$(brew --prefix zlib)/lib/pkgconfig"
      end

      system(*args)
    }

    # Install metanorma
    system "gem", "install", "--local", cached_download, "--install-dir", libexec,
           "--no-document", "--ignore-dependencies"

    bin.install Dir["#{libexec}/bin/metanorma"]
    bin.env_script_all_files(
      libexec/"bin",
      PATH:      [libexec/"bin", "$PATH"].join(":"),
      GEM_HOME:  ENV["GEM_HOME"],
      JAVA_HOME: Language::Java.overridable_java_home_env[:JAVA_HOME],
    )
  end

  def caveats
    <<~EOS
      inkscape >= 1.0 is required to generate Word output using SVG images.
      Install it by running `brew cask install inkscape` or
      directly download from https://inkscape.org/release/inkscape-1.0/
    EOS
  end

  test do
    test_doc = <<~ADOC
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
    ADOC

    (testpath / "test-iso.adoc").write(test_doc)
    system bin / "metanorma", "--type", "iso", testpath / "test-iso.adoc",
           "--agree-to-terms"
    assert_path_exists testpath / "test-iso.xml"
    assert_path_exists testpath / "test-iso.html"

    (testpath / "test-csa.adoc").write(test_doc)
    system bin / "metanorma", "--type", "csa", testpath / "test-csa.adoc",
           "--agree-to-terms"
    assert_path_exists testpath / "test-csa.pdf"
    assert_path_exists testpath / "test-csa.html"
  end
end
