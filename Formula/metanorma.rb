class Metanorma < Formula
  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"
  url "https://github.com/metanorma/metanorma-cli/releases/download/v1.12.8/vendored-gems.tar.gz"
  sha256 "697b48ee98f9baceac914033f8ed48551a64ea96ce1ca7ee6fd46b618745a8bd"
  license "0BSD"

  depends_on "pkgconf" => :build
  depends_on "gflags"
  depends_on "graphviz"
  depends_on "openjdk"
  depends_on "plantuml"
  depends_on "readline"
  depends_on "ruby@3.4"
  depends_on "xml2rfc"

  uses_from_macos "sqlite"
  uses_from_macos "zlib"

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

    # Ensure Ruby 3.4 is used
    ENV.prepend_path "PATH", Formula["ruby@3.4"].opt_bin

    # Unpack the vendored gems (includes Gemfile, Gemfile.lock, vendor/cache/*.gem)
    resource("vendor-gems").stage do
      cp_r ".", buildpath
    end

    inreplace "Gemfile.lock", "remote: https://rubygems.org/", "remote: file:vendor/cache"
    inreplace "Gemfile", 'source "https://rubygems.org"', 'source "file:vendor/cache"'
    system "gem", "install", "metanorma-cli"

    # Configure sqlite3 to use brew's libsqlite3
    system "bundle", "config", "build.sqlite3",
           "--enable-system-libraries",
           "--with-sqlite3-include=#{Formula['sqlite'].opt_include}",
           "--with-sqlite3-lib=#{Formula['sqlite'].opt_lib}"

    if OS.linux?
      # Configure pngcheck to use brew's zlib (libz.so.1)
      zlib = Formula["zlib"]
      ENV.append "CFLAGS", "-I#{zlib.opt_include}"
      ENV.append "LDFLAGS", "-L#{zlib.opt_lib} -Wl,-rpath,#{zlib.opt_lib}"
      ENV.append "PKG_CONFIG_PATH", "#{zlib.opt_lib}/pkgconfig"
    end
    # "3.4.0", not "3.4.x"
    # ruby_series = "#{Formula['ruby@3.4'].any_installed_version.major_minor}.0"
    # bin.install libexec/"ruby/#{ruby_series}/bin/metanorma"
    bin.install libexec/"bin/metanorma"
    bin.env_script_all_files(
      libexec/"bin",
      PATH: "#{Formula["ruby@3.4"].opt_bin}:$PATH",
      #GEM_HOME: ENV["GEM_HOME"],
      #GEM_PATH: ENV["GEM_PATH"],
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
    system libexec/"bin/metanorma", "--type", "iso", testpath / "test-iso.adoc",
           "--agree-to-terms"
    assert_path_exists testpath / "test-iso.xml"
    assert_path_exists testpath / "test-iso.html"

    (testpath / "test-csa.adoc").write(test_doc)
    system libexec/"bin/metanorma", "--type", "csa", testpath / "test-csa.adoc",
           "--agree-to-terms"
    assert_path_exists testpath / "test-csa.pdf"
    assert_path_exists testpath / "test-csa.html"
  end
end
