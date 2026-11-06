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
        url "https://github.com/metanorma/packed-metanorma/releases/download/v1.17.0-6/metanorma-darwin-arm64.tgz"
        sha256 "118ddba51566759ee1e420ed520438a6d3a9db2325d5a3dc55055e750645dd2a"
      end
    end

    on_intel do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-metanorma/releases/download/v1.17.0-6/metanorma-darwin-x86_64.tgz"
        sha256 "3211125cfa960f1715c040a013f8598bd4938bcffad6baeea1b9c7184e0e4cf9"
      end
    end
  end

  on_linux do
    depends_on "libxslt"

    on_arm do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-metanorma/releases/download/v1.17.0-6/metanorma-linux-arm64.tgz"
        sha256 "d6014bcf41b0de2e37013b6f1e0fad90a9c406f3bb257bec8ee1d75867290581"
      end
    end

    on_intel do
      resource "packed-mn" do
        url "https://github.com/metanorma/packed-metanorma/releases/download/v1.17.0-6/metanorma-linux-x86_64.tgz"
        sha256 "919e5a41de282895a2fde0cd3c93393e8189618c7a58856248042afd4295e07d"
      end
    end
  end

  def install
    platform = if OS.mac?
      Hardware::CPU.arm? ? "darwin-arm64" : "darwin-x86_64"
    elsif OS.linux?
      Hardware::CPU.arm? ? "linux-arm64" : "linux-x86_64"
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
