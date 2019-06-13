# frozen_string_literal: true

require "language/node"
require "language/python"

class Metanorma < Formula
  include Language::Python::Virtualenv

  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"
  url "https://github.com/metanorma/metanorma-cli/archive/v1.1.8.tar.gz"
  # curl -sL https://github.com/metanorma/metanorma-cli/archive/v1.1.8.tar.gz | shasum -a 256
  sha256 "977345b1c0a00989cfed3de2ad47ef14013b7d5048cbc0ad5673aefafdc29db1"

  depends_on "latexml"
  depends_on "node"
  depends_on "plantuml"
  depends_on "python"
  depends_on "ruby"

  resource "puppeteer" do
    # required by 'metanorma-csd' gem
    url "https://registry.npmjs.org/puppeteer/-/puppeteer-1.11.0.tgz"
    sha256 "5ea179dd3ce90231dc70439876fd2a0b2abd04d7c30f588fb6e2a3b3459d0716"
  end

  resource "idnits" do
    url "https://files.pythonhosted.org/packages/source/i/idnits/idnits-3.0.0.tar.gz"
    sha256 "ad1027cf2ac04139ca1116eb64f8bb7c0485f050e71f844b11e035a9e0d6ad68"
  end

  resource "xml2rfc" do
    url "https://files.pythonhosted.org/packages/source/x/xml2rfc/xml2rfc-2.22.3.tar.gz"
    sha256 "943bdb59c532be2ae4981d1cdaa56191e4d2fa0a79cf13125a8ac1a06b391e4e"
  end

  resource "idnits_files" do
    url "https://tools.ietf.org/tools/idnits/idnits-2.16.02"
    sha256 "e9a501fc1f3a4584dda854067398eaebba29f128fb09f80048a760e950c35c49"
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

    venv = virtualenv_create(libexec/"venv", "python3")
    %w[idnits xml2rfc].each do |r|
      venv.pip_install resource(r)
    end

    resource("idnits_files").stage do
      %w[control idnits].each do |f|
        (libexec/"idnits_files").install f
      end
    end

    bin.install Dir[libexec/"bin/metanorma"]
    bin.env_script_all_files(libexec/"bin",
      :PATH       => "#{libexec/"idnits_files"}:#{libexec/"bin"}:#{ENV["PATH"]}",
      :GEM_HOME   => ENV["GEM_HOME"],
      :NODE_PATH  => libexec/"lib/node_modules",
      :PYTHONPATH => libexec/"venv/site-packages")
  end

  def post_install
    cd libexec/"lib/node_modules/puppeteer/" do
      npm_cache = Language::Node.npm_cache_config
      system "npm", "install", "--#{npm_cache}" # rubocop:disable FormulaAudit/Miscellaneous
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
