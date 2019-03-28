# frozen_string_literal: true

require "language/node"

class Metanorma < Formula
  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"
  url "https://github.com/metanorma/metanorma-cli/archive/v1.1.6.tar.gz"
  # curl -sL https://github.com/metanorma/metanorma-cli/archive/v1.1.6.tar.gz | shasum -a 256
  sha256 "29cfff9debbb7494a8343eb2ea9464b2aae9909984989a64005c7867dcc9e9f7"

  depends_on "latexml"
  depends_on "node"
  depends_on "plantuml"

  resource "puppeteer" do
    # required by 'metanorma-csd' gem
    url "https://registry.npmjs.org/puppeteer/-/puppeteer-1.11.0.tgz"
    sha256 "5ea179dd3ce90231dc70439876fd2a0b2abd04d7c30f588fb6e2a3b3459d0716"
  end

  def install
    ENV["GEM_HOME"] = libexec

    # on some mac it cannot lookup x86 libraries so we restrict to x86_64 only
    ENV["ARCHFLAGS"] = "-arch x86_64"
    system "gem", "install", "nokogiri", "-v", "1.8.5"
    ENV["ARCHFLAGS"] = ""

    system "gem", "build", "metanorma-cli.gemspec"
    system "gem", "install", "metanorma-cli-#{version}.gem"

    resource("puppeteer").stage do
      # Skip chromium download at install
      # to avoid 'Failed changing dylib ID of **/libEGL.dylib' postpone chrome installation to first run
      # we will continue chrome download on post_install
      # https://discourse.brew.sh/t/how-to-prevent-dylib-from-linkage-fixing/3843
      ENV["PUPPETEER_SKIP_CHROMIUM_DOWNLOAD"] = "1"
      system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    end

    bin.install Dir[libexec/"bin/metanorma"]
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"], :NODE_PATH => libexec/"lib/node_modules")
  end

  def post_install
    cd libexec/"lib/node_modules/puppeteer/" do
      npm_cache = *Language::Node.npm_cache_config
      system "npm", "install", "--cache=#{npm_cache}" # rubocop:disable FormulaAudit/Miscellaneous
    end
  end

  test do
    METANORMA_TEST_DOC = <<~'ADOC'
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
    ADOC

    METANORMA_LATEXML_TEST_DOC = <<~'ADOC'
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

    (testpath/"test-iso.adoc").write(METANORMA_TEST_DOC)
    system bin/"metanorma", "--type", "iso", testpath/"test-iso.adoc"
    assert_predicate testpath/"test-iso.xml", :exist?
    assert_predicate testpath/"test-iso.html", :exist?

    (testpath/"test-csd.adoc").write(METANORMA_TEST_DOC)
    system bin/"metanorma", "--type", "csd", testpath/"test-csd.adoc"
    assert_predicate testpath/"test-csd.pdf", :exist?
    assert_predicate testpath/"test-csd.html", :exist?

    (testpath/"test-standoc.adoc").write(METANORMA_LATEXML_TEST_DOC)
    system bin/"metanorma", "--type", "standoc", "--extensions", "xml", testpath/"test-standoc.adoc"
    assert_predicate testpath/"test-standoc.xml", :exist?
  end
end
