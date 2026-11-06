# frozen_string_literal: true

class Metanorma < Formula
  desc "Publishing standards for tomorrow, today"
  homepage "https://www.metanorma.org"

  url "https://github.com/metanorma/metanorma-cli/archive/refs/tags/v1.17.0.tar.gz"
  sha256 "0f51f4110e84605c0613babe452b5a4692436c275c855781d2954353f8f5961c"

  license "BSD-2-Clause"
  revision 1

  depends_on "gflags"
  depends_on "git"
  depends_on "graphviz"
  depends_on "openjdk"
  depends_on "xml2rfc" # required by 'metanorma-ietf' gem

  on_macos do
    on_arm do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-metanorma/releases/download/v1.17.0-4/metanorma-darwin-arm64.tgz"
        sha256 "5ec85fde02bd5f8c949727e80c7e7b78ba5a8610a30e145fe19e8fcd7c603a27"
      end
    end
  end

  on_linux do
    depends_on "libxslt"

    on_intel do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-metanorma/releases/download/v1.17.0-4/metanorma-linux-x86_64.tgz"
        sha256 "fd2350446c090d1de65b3180c9f74840ab4b3d0f66eb7c42ede5ae45d9be27c4"
      end
    end
  end

  def install
    platform = if OS.mac?
      unless Hardware::CPU.arm?
        odie "metanorma #{version}: no Intel Mac binary in this release (packed-metanorma ships darwin-arm64 only)"
      end
      "darwin-arm64"
    elsif OS.linux?
      if Hardware::CPU.arm?
        odie "metanorma #{version}: no runnable Linux ARM binary in this release " \
             "(the musl-arm64 build is musl-dynamic; linux-gnu-arm64 is unshipped — metanorma/packed-metanorma#280)"
      end
      "linux-x86_64"
    end

    resource("packed-mn").stage do
      bin.install "metanorma-#{platform}"
    end

    if OS.linux?
      ENV.prepend_path "PATH", formula_opt_bin("libxslt").to_s
      ENV.prepend_path "PATH", formula_opt_bin("libxml2").to_s
    end

    (bin / "metanorma").write_env_script(
      bin / "metanorma-#{platform}",
      JAVA_HOME: Language::Java.java_home("1.8+"),
      PATH:      [libexec/"bin", "$PATH"].join(":"),
    )
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
    # Compile only the asserted outputs: the default output set includes pdf,
    # which goes through mn2pdf/java and can exceed brew test's per-command
    # timeout on a loaded CI runner.
    system bin / "metanorma", "--type", "iso", "--extensions", "xml,html",
           testpath / "test-iso.adoc", "--agree-to-terms"
    assert_path_exists testpath / "test-iso.xml"
    assert_path_exists testpath / "test-iso.html"

    # (testpath / "test-csa.adoc").write(test_doc)
    # system bin / "metanorma", "--type", "csa", testpath / "test-csa.adoc",
    #        "--agree-to-terms"
    # assert_predicate testpath / "test-csa.pdf", :exist?
    # assert_predicate testpath / "test-csa.html", :exist?
  end
end
