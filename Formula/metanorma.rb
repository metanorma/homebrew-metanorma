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

    if OS.linux?
      # Install sqlite3 with brew's libsqlite3
      system "gem", "install", "sqlite3", "-v", "1.7.3", "--no-document",
             "--platform=ruby",
             "--",
             "--enable-system-libraries",
             "--with-sqlite3-include=#{Formula["sqlite"].opt_include}",
             "--with-sqlite3-lib=#{Formula["sqlite"].opt_lib}"

      # Install pngcheck with brew's zlib (libz.so.1)
      ENV.append "CFLAGS", "-I$(brew --prefix zlib)/include"
      ENV.append "LDFLAGS", "-L$(brew --prefix zlib)/lib -Wl,-rpath,$(brew --prefix zlib)/lib"
      ENV.append "PKG_CONFIG_PATH", "$(brew --prefix zlib)/lib/pkgconfig"
      system "gem", "install", "pngcheck", "--no-document", "--platform=ruby"
    end

    gems = [
      "mini_portile2",
      "link_header",
      "bigdecimal",
      "bcp47_spec",
      "parslet",
      "connection_pool",
      "io-console",
      "rdf",
      "matrix",
      "pubid-core",
      "net-http-persistent",
      "reline",
      "rexml",
      "unicode-types",
      "sxp",
      "scanf",
      "htmlentities",
      "base64",
      "rack",
      "multi_json",
      "json-canonicalization",
      "tilt",
      "thor",
      "temple",
      "racc",
      "pubid-iso",
      "pubid-iec",
      "stringio",
      "date",
      "sparql-client",
      "readline",
      "rdf-xsd",
      "rdf-aggregate-repo",
      "logger",
      "ebnf",
      "builder",
      "json-ld",
      "public_suffix",
      "rdf-vocab",
      "haml",
      "concurrent-ruby",
      "latex-decode",
      "rubyzip",
      "nokogiri",
      "lightly",
      "pubid-cen",
      "moxml",
      "mime-types-data",
      "domain_name",
      "ruby2_keywords",
      "faraday-net_http",
      "psych",
      "sparql",
      "json-ld-preloaded",
      "rdf-turtle",
      "addressable",
      "rdf-rdfa",
      "hamster",
      "relaton-logger",
      "iso639",
      "bibtex-ruby",
      "pubid-nist",
      "pubid-jis",
      "pubid-itu",
      "pubid-ieee",
      "pubid-etsi",
      "pubid-ccsds",
      "pubid-bsi",
      "lutaml-model",
      "webrobots",
      "webrick",
      "rubyntlm",
      "nkf",
      "net-http-digest_auth",
      "mime-types",
      "http-cookie",
      "fiber-storage",
      "uri",
      "tzinfo",
      "securerandom",
      "minitest",
      "i18n",
      "drb",
      "benchmark",
      "faraday",
      "timeout",
      "cldr-plurals-runtime-rb",
      "camertron-eprun",
      "uuidtools",
      "sterile",
      "csv",
      "asciidoctor",
      "strscan",
      "yaml-ld",
      "shex",
      "shacl",
      "rdf-trix",
      "rdf-trig",
      "rdf-tabular",
      "rdf-reasoner",
      "rdf-rdfxml",
      "rdf-ordered-repo",
      "rdf-normalize",
      "rdf-n3",
      "rdf-microdata",
      "rdf-json",
      "rdf-isomorphic",
      "rdf-hamster-repo",
      "ld-patch",
      "relaton-bib",
      "isoics",
      "relaton-index",
      "pubid",
      "loc_mods",
      "ieee-idams",
      "mechanize",
      "graphql",
      "activesupport",
      "faraday-net_http_persistent",
      "time",
      "net-protocol",
      "twitter_cldr",
      "metanorma-utils",
      "liquid",
      "ffi",
      "unitsdb",
      "mml",
      "rake",
      "linkeddata",
      "relaton-iso-bib",
      "gb-agencies",
      "cnccs",
      "relaton-nist",
      "relaton-ietf",
      "relaton-ieee",
      "relaton-bipm",
      "graphql-client",
      "algolia",
      "net-ftp",
      "unicode-display_width",
      "tzinfo-data",
      "isodoc-i18n",
      "marcel",
      "image_size",
      "emf2svg",
      "unitsml",
      "ox",
      "css_parser",
      "ffi-compiler2",
      "ffi-libarchive",
      "bundler",
      "hollaback",
      "relaton-xsf",
      "relaton-w3c",
      "relaton-un",
      "relaton-plateau",
      "relaton-omg",
      "relaton-ogc",
      "relaton-oasis",
      "relaton-jis",
      "relaton-itu",
      "relaton-iso",
      "relaton-isbn",
      "relaton-iho",
      "relaton-iec",
      "relaton-iana",
      "relaton-gb",
      "relaton-etsi",
      "relaton-ecma",
      "relaton-doi",
      "relaton-cie",
      "relaton-cen",
      "relaton-ccsds",
      "relaton-calconnect",
      "relaton-bsi",
      "relaton-3gpp",
      "zeitwerk",
      "terminal-table",
      "ruby-progressbar",
      "benchmark-ips",
      "relaton-render",
      "vectory",
      "thread_safe",
      "plurimath",
      "plane1converter",
      "sys-proctable",
      "reverse_markdown",
      "premailer",
      "nokogiri-styles",
      "descriptive_statistics",
      "cliver",
      "yaml",
      "rchardet",
      "seven-zip",
      "ruby-ole",
      "libmspack",
      "ffi-libarchive-binary",
      "arr-pm",
      "thor-hollaback",
      "relaton",
      "xmi",
      "ruby-graphviz",
      "lutaml-xsd",
      "lutaml-path",
      "hashie",
      "expressir",
      "rouge",
      "roman-numerals",
      "mn2pdf",
      "mn-requirements",
      "html2doc",
      "word-to-markdown",
      "oscal",
      "ttfunk",
      "sys-uname",
      "socksify",
      "plist",
      "json",
      "git",
      "fuzzy_match",
      "extract_ttc",
      "excavate",
      "down",
      "optout",
      "relaton-cli",
      "ogc-gml",
      "lutaml",
      "isodoc",
      "coradoc",
      "glossarist",
      "fontist",
      "sqlite3",
      "sequel",
      "creek",
      "ruby-jing",
      "relaton-iev",
      "pngcheck",
      "metanorma-plugin-lutaml",
      "metanorma-plugin-glossarist",
      "metanorma",
      "iev",
      "crass",
      "tokenizer",
      "mnconvert",
      "metanorma-standoc",
      "metanorma-iso",
      "japanese_calendar",
      "metanorma-jis",
      "iso-639",
      "metanorma-generic",
      "metanorma-ietf-data",
      "metanorma-plateau",
      "metanorma-ogc",
      "metanorma-itu",
      "metanorma-iho",
      "metanorma-ietf",
      "metanorma-ieee",
      "metanorma-iec",
      "metanorma-csa",
      "metanorma-cc",
      "metanorma-bipm",
      "metanorma-cli",
    ]

    arch = if OS.mac?
             Hardware::CPU.arm? ? "arm64-darwin" : "x86_64-darwin"
           else
             Hardware::CPU.arm? ? "aarch64-linux-gnu" : "x86_64-linux-gnu"
           end

    for gem in gems
      files = Dir["vendor/cache/#{gem}-[0-9]*-#{arch}.gem"]
      files = Dir["vendor/cache/#{gem}-[0-9]*.gem"] if files.empty?

      # Install .gem files from vendor/cache/
      if files.length > 1 || files.empty?
        puts "!!! #{files.inspect}"
      end

      files.each do |gem_file|
        system "gem", "install", "--local", gem_file, "--install-dir", libexec, "--no-document", "--force"
      end
    end

    # Install metanorma
    system "gem", "install", cached_download, "--no-document"

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
