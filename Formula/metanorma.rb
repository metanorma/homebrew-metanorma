# frozen_string_literal: true

require "language/node"
require "language/python"

class Metanorma < Formula
  include Language::Python::Virtualenv

  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"
  url "https://github.com/metanorma/metanorma-cli/archive/v1.2.9.tar.gz"
  # curl -sL https://github.com/metanorma/metanorma-cli/archive/v1.2.9.tar.gz | shasum -a 256
  sha256 "8cc8a1406bf810ce148ba7c01f1330236208d3ec37a061efb6ae3e14fed453da"

  depends_on "latexml"
  depends_on "node"
  depends_on "plantuml"
  depends_on "python"
  depends_on "yq"
  uses_from_macos "ruby"
  uses_from_macos "libxml2"
  uses_from_macos "libxslt"
  uses_from_macos "zlib"

  resource "puppeteer" do
    # required by 'metanorma-csd' gem
    url "https://registry.npmjs.org/puppeteer/-/puppeteer-2.1.1.tgz"
    sha256 "e7fea5db70b0c2de89a417a46368c3dccf9051da2559e0b8f5900cc52fcae55e"
  end

  resource "idnits" do
    url "https://files.pythonhosted.org/packages/7b/a6/ec79a56c11c9e1d75224196e62c4b130370317f7194dbe4b49f794a656c0/idnits-3.0.0.tar.gz"
    sha256 "ad1027cf2ac04139ca1116eb64f8bb7c0485f050e71f844b11e035a9e0d6ad68"
  end

  resource "xml2rfc" do
    url "https://files.pythonhosted.org/packages/2f/39/9bc4535ca8fb1bd1b3b02d193d109943765d9f0611de578420ef5a101c10/xml2rfc-2.39.0.tar.gz"
    sha256 "bf4a3b4cfa873c25f94bb84c9bb8a3775dfb8127a4991c57e609c019fe4471f2"
  end

  resource "idnits_files" do
    url "https://tools.ietf.org/tools/idnits/idnits-2.16.02.tgz"
    sha256 "e9a501fc1f3a4584dda854067398eaebba29f128fb09f80048a760e950c35c49"
  end

  def install
    ENV["GEM_HOME"] = libexec

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
