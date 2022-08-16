# frozen_string_literal: true

class Metanorma < Formula
  include Language::Python::Virtualenv

  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"

  # > formula-set-version.sh packed-mn #
  url "https://github.com/metanorma/packed-mn/archive/v1.5.22.tar.gz"
  sha256 "2bc17c7c32c16e202b943fdff5e16272065a1097c963324225f6b13a9a0a3fbc"
  # < formula-set-version.sh packed-mn #

  license "0BSD"
  revision 1

  depends_on "git"
  depends_on "graphviz"
  depends_on "libxslt" if OS.linux?
  depends_on "metanorma/metanorma/xml2rfc" # required by 'metanorma-ietf' gem
  depends_on "openjdk"
  depends_on "plantuml"

  if OS.mac?
    resource "packed-mn" do
      # > formula-set-version.sh packed-mn-darwin #
      url "https://github.com/metanorma/packed-mn/releases/download/v1.5.22/metanorma-darwin-x86_64.tgz"
      sha256 "fccd938d2b7428a2b14e173964b44628ac59af94a4cc02ec3984dec26aaf8e64"
      # < formula-set-version.sh packed-mn-darwin #
    end
  end

  if OS.linux?
    resource "packed-mn" do
      # > formula-set-version.sh packed-mn-linux #
      url "https://github.com/metanorma/packed-mn/releases/download/v1.5.22/metanorma-linux-x86_64.tgz"
      sha256 "efa3fc31a8d164036a73804ecaa299c737243ec15e55417fa43d2a28f4595a81"
      # < formula-set-version.sh packed-mn-linux #
    end
  end

  def install
    platform = OS.linux? ? :linux : :darwin

    resource("packed-mn").stage do
      bin.install "metanorma-#{platform}-x86_64"
    end

    ENV.prepend_path "PATH", Formula["libxslt"].opt_bin.to_s if OS.linux?
    ENV.prepend_path "PATH", Formula["libxml2"].opt_bin.to_s if OS.linux?

    (bin/"metanorma").write_env_script(
      bin/"metanorma-#{platform}-x86_64",
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

    (testpath / "test-ietf.adoc").write(ietf_test_doc)
    system bin / "metanorma", testpath / "test-ietf.adoc", "--agree-to-terms"
    assert_predicate testpath / "test-ietf.html", :exist?

    (testpath / "test-standoc.adoc").write(latexml_test_doc)
    system bin / "metanorma", "--type", "standoc", "--extensions", "xml",
           testpath / "test-standoc.adoc", "--agree-to-terms"
    assert_predicate testpath / "test-standoc.xml", :exist?
  end
end
