# frozen_string_literal: true

require "language/node"

class Metanorma < Formula
  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"
  url "https://github.com/riboseinc/metanorma-cli/archive/v1.1.5.tar.gz"
  # curl -sL https://github.com/riboseinc/metanorma-cli/archive/v1.1.5.tar.gz | shasum -a 256
  sha256 "45c4bcc72a616dd060a6246fdd64e4a372003c3b48d918ce2605e59e772fcf43"

  depends_on "node"
  depends_on "plantuml"
  depends_on "latexml"

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

    (testpath/"test-iso.adoc").write(METANORMA_TEST_DOC)
    system bin/"metanorma", "--type", "iso", testpath/"test-iso.adoc"
    assert_predicate testpath/"test-iso.xml", :exist?
    assert_predicate testpath/"test-iso.html", :exist?

    # blocked by issue https://github.com/riboseinc/homebrew-metanorma/pull/2#issuecomment-455129746
    # (testpath/"test-csd.adoc").write(METANORMA_TEST_DOC)
    # system bin/"metanorma", "--type", "csd", testpath/"test-csd.adoc"
    # assert_predicate testpath/"test-csd.pdf", :exist?
    # assert_predicate testpath/"test-csd.html", :exist?
  end
end
