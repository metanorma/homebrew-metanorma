# frozen_string_literal: true

class Metanorma < Formula
  include Language::Python::Virtualenv

  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"

  # > formula-set-version.sh packed-mn #
  url "https://github.com/metanorma/packed-mn/archive/v1.12.10.tar.gz"
  sha256 "d39fd44db266d02f4d7c3ca232861222612492f1293b7ab9ee388d5255bcab9f"
  # < formula-set-version.sh packed-mn #

  license "0BSD"
  revision 1

  depends_on "git"
  depends_on "gflags"
  depends_on "graphviz"
  depends_on "libxslt" if OS.linux?
  depends_on "metanorma/xml2rfc/xml2rfc" # required by 'metanorma-ietf' gem
  depends_on "openjdk"
  depends_on "plantuml"

  if OS.mac?
    if Hardware::CPU.arm?
      resource "packed-mn" do
      # > formula-set-version.sh packed-mn-darwin-arm64 #
      url "https://github.com/metanorma/packed-mn/releases/download/v1.12.10/metanorma-darwin-arm64.tgz"
      sha256 "3978978ab6098495de9e527a924fe5313cd750d71decb1b7b542a726433145ce"
      # < formula-set-version.sh packed-mn-darwin-arm64 #
      end
    else # assume Hardware::CPU.intel
      resource "packed-mn" do
      # > formula-set-version.sh packed-mn-darwin-x86_64 #
      url "https://github.com/metanorma/packed-mn/releases/download/v1.12.10/metanorma-darwin-x86_64.tgz"
      sha256 "ec39648587029bc257fd263493c6af954c8ef3fdfe6422d48ae5da18a942c021"
      # < formula-set-version.sh packed-mn-darwin-x86_64 #
      end
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      resource "packed-mn" do
        # > formula-set-version.sh packed-mn-linux-arm #
        url "https://github.com/metanorma/packed-mn/releases/download/v1.12.10/metanorma-linux-aarch64.tgz"
        sha256 "99077a5102e62b7eed262b9da6163b30de7de44c2e2e703bc404ee0fc1e0e02a"
        # < formula-set-version.sh packed-mn-linux-arm #
      end
    else # assume Hardware::CPU.intel
      resource "packed-mn" do
        # > formula-set-version.sh packed-mn-linux #
        url "https://github.com/metanorma/packed-mn/releases/download/v1.12.10/metanorma-linux-x86_64.tgz"
        sha256 "a6873dda3b66acf553a825f58b974dc24df12895c02fe49aba752ceb3a984ca7"
        # < formula-set-version.sh packed-mn-linux #
      end
    end
  end

  def install
    platform = if OS.mac?
                 Hardware::CPU.arm? ? "darwin-arm64" : "darwin-x86_64"
               elsif OS.linux?
                 Hardware::CPU.arm? ? "linux-aarch64" : "linux-x86_64"
               end

    resource("packed-mn").stage do
      bin.install "metanorma-#{platform}"
    end

    ENV.prepend_path "PATH", Formula["libxslt"].opt_bin.to_s if OS.linux?
    ENV.prepend_path "PATH", Formula["libxml2"].opt_bin.to_s if OS.linux?

    (bin / "metanorma").write_env_script(
      bin / "metanorma-#{platform}",
      JAVA_HOME:  Language::Java.java_home("1.8+"),
      PATH:       [libexec/"bin", "$PATH"].join(":"),
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
    test_doc = <<~'ADOC'
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
    ADOC

    latexml_test_doc = <<~'ADOC'
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

    (testpath / "test-iso.adoc").write(test_doc)
    system bin / "metanorma", "--type", "iso", testpath / "test-iso.adoc",
           "--agree-to-terms"
    assert_predicate testpath / "test-iso.xml", :exist?
    assert_predicate testpath / "test-iso.html", :exist?

    (testpath / "test-csa.adoc").write(test_doc)
    system bin / "metanorma", "--type", "csa", testpath / "test-csa.adoc",
           "--agree-to-terms"
    assert_predicate testpath / "test-csa.pdf", :exist?
    assert_predicate testpath / "test-csa.html", :exist?

    #(testpath / "test-ietf.adoc").write(ietf_test_doc)
    #system bin / "metanorma", testpath / "test-ietf.adoc", "--agree-to-terms"
    #assert_predicate testpath / "test-ietf.html", :exist?

    #(testpath / "test-standoc.adoc").write(latexml_test_doc)
    #system bin / "metanorma", "--type", "standoc", "--extensions", "xml",
    #       testpath / "test-standoc.adoc", "--agree-to-terms"
    #assert_predicate testpath / "test-standoc.xml", :exist?
  end
end
