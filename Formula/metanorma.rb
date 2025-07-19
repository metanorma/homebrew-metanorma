# frozen_string_literal: true

class Metanorma < Formula
  desc "Publishing standards for tomorrow, today"
  homepage "https://www.metanorma.org"

  url "https://github.com/metanorma/packed-mn/archive/v1.13.0.tar.gz"
  sha256 "7195a3a39ef0f8e5721414573c815d3ae6fc0206c8dbbe98e98eead90f4b7c76"

  license "BSD-2-Clause"
  revision 1

  depends_on "git"
  depends_on "gflags"
  depends_on "graphviz"
  depends_on "xml2rfc" # required by 'metanorma-ietf' gem
  depends_on "openjdk"
  depends_on "plantuml"

  on_macos do
    on_arm do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-mn/releases/download/v1.13.0/metanorma-darwin-arm64.tgz"
        sha256 "56912978cc8d209d3ba5ad773698304f733201e7ec2f6d10e1a61621bf520274"
      end
    end

    on_intel do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-mn/releases/download/v1.13.0/metanorma-darwin-x86_64.tgz"
        sha256 "c64f164760ed4aed7ff414ef8f58c86755e794ec8bffdbcc939528a1d8207fb3"
      end
    end
  end

  on_linux do
    depends_on "libxslt"

    on_arm do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-mn/releases/download/v1.13.0/metanorma-linux-aarch64.tgz"
        sha256 "87adec81d9c3e53a3ba134dd11d65c3664b179862e913ac209fa6b315deeffff"
      end
    end

    on_intel do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-mn/releases/download/v1.13.0/metanorma-linux-x86_64.tgz"
        sha256 "0e7a147430e29c2233233f7606581075569d7cd78d515d6ab4ad5119188d1e33"
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

    if OS.linux?
      ENV.prepend_path "PATH", Formula["libxslt"].opt_bin.to_s
      ENV.prepend_path "PATH", Formula["libxml2"].opt_bin.to_s
    end

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

    # (testpath / "test-csa.adoc").write(test_doc)
    # system bin / "metanorma", "--type", "csa", testpath / "test-csa.adoc",
    #        "--agree-to-terms"
    # assert_predicate testpath / "test-csa.pdf", :exist?
    # assert_predicate testpath / "test-csa.html", :exist?

    #(testpath / "test-ietf.adoc").write(ietf_test_doc)
    #system bin / "metanorma", testpath / "test-ietf.adoc", "--agree-to-terms"
    #assert_predicate testpath / "test-ietf.html", :exist?

    #(testpath / "test-standoc.adoc").write(latexml_test_doc)
    #system bin / "metanorma", "--type", "standoc", "--extensions", "xml",
    #       testpath / "test-standoc.adoc", "--agree-to-terms"
    #assert_predicate testpath / "test-standoc.xml", :exist?
  end
end
