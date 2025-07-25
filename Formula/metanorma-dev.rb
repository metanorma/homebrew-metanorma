# frozen_string_literal: true

# Metanorma formula
class MetanormaDev < Formula
  include Language::Python::Virtualenv
  desc "Publishing standards for tomorrow, today (development version)"
  homepage "https://www.metanorma.org"

  # > formula-set-version.sh metanorma-cli #
  url "https://api.github.com/repos/metanorma/metanorma-cli/tarball/v1.13.0"
  sha256 "89db2f422fb0646ffa2d29f6d62eaf017446091afb1d127ff67351a5f90ed96d"
  # < formula-set-version.sh metanorma-cli #

  license "BSD-2-Clause"

  depends_on "git"
  depends_on "gflags"
  depends_on "graphviz"
  depends_on "xml2rfc" # required by 'metanorma-ietf' gem
  depends_on "openjdk"
  depends_on "plantuml"
  depends_on "ruby@3"

  uses_from_macos "libxml2"
  uses_from_macos "libxslt"
  uses_from_macos "zlib"

  on_linux do
    depends_on "libxml2"
    depends_on "libxslt"
  end

  def install
    ENV["GEM_HOME"] = libexec

    # Configure sqlite3 to use brew's libsqlite3 (from PR #100)
    system "bundle", "config", "build.sqlite3",
           "--enable-system-libraries",
           "--with-sqlite3-include=#{Formula["sqlite"].opt_include}",
           "--with-sqlite3-lib=#{Formula["sqlite"].opt_lib}"

    # Configure pngcheck to use brew's zlib on Linux (from PR #100)
    if OS.linux?
      zlib = Formula["zlib"]
      ENV.append "CFLAGS", "-I#{zlib.opt_include}"
      ENV.append "LDFLAGS", "-L#{zlib.opt_lib} -Wl,-rpath,#{zlib.opt_lib}"
      ENV.append "PKG_CONFIG_PATH", "#{zlib.opt_lib}/pkgconfig"

      ENV.prepend_path "PATH", Formula["libxslt"].opt_bin.to_s
      ENV.prepend_path "PATH", Formula["libxml2"].opt_bin.to_s
    end

    # Use Homebrew Ruby formula pattern
    system "bundle", "config", "set", "without", "development", "test"
    system "bundle", "install"
    system "gem", "build", "metanorma-cli.gemspec"
    system "gem", "install", "--ignore-dependencies", "metanorma-cli-#{version}.gem"

    # Install binaries with proper environment scripts
    bin.install libexec/"bin/metanorma"
    bin.env_script_all_files(
      libexec/"bin",
      PATH: "#{Formula["ruby@3"].opt_bin}:$PATH",
      GEM_HOME: ENV["GEM_HOME"],
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
    metanorma_test_doc = <<~'ADOC'
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
    ADOC

    metanorma_latexml_test_doc = <<~'ADOC'
      = File
      :stem

      [latexmath]
      ++++
      M =
      \\begin{bmatrix}
      -\\sin λ_0 & \\cos λ_0 & 0 \\\\
      -\\sin φ_0 \\cos λ_0 & -\\sin φ_0 \\sin λ_0 & \\cos φ_0 \\\\
      \\cos φ_0 \\cos λ_0 & \\cos φ_0 \\sin λ_0 & \\sin φ_0
      \\end{bmatrix}
      ++++
    ADOC

    ietf_test_doc = <<~'ADOC'
      :sort-refs: true
      :revdate: 2018-04-15T00:00:00Z
      :fullname: Test Test
      :initials: T.
      :surname: Test
      :email: test@test.org
      :docfile: document.adoc
      :mn-document-class: ietf
      :mn-output-extensions: rfc,xml,txt,html,rxl

      == Clause
      Clause
    ADOC

    (testpath / "test-iso.adoc").write(metanorma_test_doc)
    system bin / "metanorma", "--type", "iso", testpath / "test-iso.adoc",
           "--agree-to-terms"
    assert_predicate testpath / "test-iso.xml", :exist?
    assert_predicate testpath / "test-iso.html", :exist?

    (testpath / "test-csa.adoc").write(metanorma_test_doc)
    system bin / "metanorma", "--type", "csa", testpath / "test-csa.adoc",
           "--agree-to-terms"
    assert_predicate testpath / "test-csa.html", :exist?

    #(testpath / "test-ietf.adoc").write(ietf_test_doc)
    #system bin / "metanorma", testpath / "test-ietf.adoc", "--agree-to-terms"
    #assert_predicate testpath / "test-ietf.html", :exist?

    #(testpath / "test-standoc.adoc").write(metanorma_latexml_test_doc)
    #system bin / "metanorma", "--type", "standoc", "--extensions", "xml",
    #       testpath / "test-standoc.adoc", "--agree-to-terms"
    #assert_predicate testpath / "test-standoc.xml", :exist?
  end
end
