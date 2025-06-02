class Metanorma < Formula
  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"

  url "https://rubygems.org/downloads/metanorma-cli-1.12.8.gem"
  sha256 "b746637b00a051ca409ccf98fc82c12c443d27183c3d4bdd3535ad47eb015573"

  license "0BSD"

  depends_on "pkgconf" => :build
  # depends_on "cmake"
  # depends_on "make"
  # depends_on "gcc"
  depends_on "gflags"
  #depends_on "graphviz"
  #depends_on "openjdk"
  #depends_on "plantuml"
  depends_on "readline"
  depends_on "ruby@3.3"
  depends_on "sqlite"
  depends_on "xml2rfc"

  uses_from_macos "zlib"

  on_linux do
    depends_on "libxslt"
    depends_on "zlib"
  end

  def delete_selected_gems(gem_names)
    gem_names.each do |gem_name|
      gem_dir = Pathname.glob("#{libexec}/gems/#{gem_name}-*").first
      puts "Deleting #{gem_name}"
      rm_r(gem_dir)
    end
  end

  def install
    ENV["GEM_HOME"] = libexec
    ENV["GEM_PATH"] = libexec

    # Ensure Homebrew's libsqlite is found before the system version.
    #sqlite = Formula["sqlite"]
    #ENV.append "LDFLAGS", "-L#{sqlite.opt_lib}"
    #ENV.append "CFLAGS", "-I#{sqlite.opt_include}"

    puts(Formula["sqlite"].opt_lib/shared_library("libsqlite3"))

    system "gem", "install", "sqlite3", "-v", "1.7.3", "--no-document", "--platform=ruby", "--force",
           "--",
           "--enable-system-libraries",
           "--with-sqlite3-include=" + Formula["sqlite"].opt_include, "--with-sqlite3-lib=" + Formula["sqlite"].opt_lib

    ENV.append "CFLAGS", "-I$(brew --prefix zlib)/include"
    ENV.append "LDFLAGS", "-L$(brew --prefix zlib)/lib -Wl,-rpath,$(brew --prefix zlib)/lib"
    ENV.append "PKG_CONFIG_PATH", "$(brew --prefix zlib)/lib/pkgconfig"

    system "gem", "install", "pngcheck", "--no-document", "--platform=ruby"

    system "gem", "install", cached_download, "--no-document"

    system "gem", "contents", "sqlite3"

    #system "find", libexec.to_s, "-type", "f"

    bin.install Dir["#{libexec}/bin/metanorma"]
    bin.env_script_all_files(
      libexec/"bin",
      PATH:      [libexec/"bin", "$PATH"].join(":"),
      GEM_HOME:  ENV["GEM_HOME"],
      JAVA_HOME: Language::Java.java_home("1.8+"),
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
