class Metanorma < Formula
  desc "Metanorma publishing toolchain"
  homepage "https://www.metanorma.com"
  url "https://github.com/riboseinc/metanorma-cli/archive/v1.0.10.tar.gz"
  sha256 "6cbce57107af95730767dab7d1f246ffaef3ef82ab6a798c5d5fe5cb45211aca"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "4248d1886cd623bb95f05fdc6cad5c6579c5edb6545536e44e10dcb457722401" => :mojave
    # sha256 "XXX" => :high_sierra
    # sha256 "XXX" => :sierra
  end

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "metanorma-cli.gemspec"
    system "gem", "install", "metanorma-cli-#{version}.gem"
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  ASCIIDOC_BLANK_HDR = <<~"HDR"
    = Document title
    Author
    :docfile: test.adoc
    :nodoc:
    :novalid:
    :no-isobib:

  HDR

  test do
    (testpath/"test.adoc").write(ASCIIDOC_BLANK_HDR)
    system bin/"metanorma", "-iso", testpath/"test.adoc"
    assert_predicate testpath/"test.xml", :exist?
    assert_predicate testpath/"test.html", :exist?

    # (testpath/"test.adoc").write("= AsciiDoc is Writing Zen")
    # system bin/"asciidoctor", "-b", "html5", "-o", "test.html", "test.adoc"
    # assert_match "<h1>AsciiDoc is Writing Zen</h1>", File.read("test.html")
  end
end
