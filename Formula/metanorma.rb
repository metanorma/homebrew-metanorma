# frozen_string_literal: true

require "language/python"

# https://github.com/metanorma/packed-mn
class Metanorma < Formula # rubocop:disable Metrics/ClassLength
  include Language::Python::Virtualenv

  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"

  # > formula-set-version.sh packed-mn #
  url "https://github.com/metanorma/packed-mn/archive/v1.4.5pre.tar.gz"
  sha256 "8eaef9980bb94bdb2cd180cdd71ebbc5a91d8d880182c8c46e8937de761a1154"
  # < formula-set-version.sh packed-mn #

  license "0BSD"
  revision 1

  depends_on "openjdk"
  depends_on "plantuml"
  depends_on "python@3.8"
  depends_on "yq"

  if OS.mac?
    resource "packed-mn" do
      # > formula-set-version.sh packed-mn-darwin #
      url "https://github.com/metanorma/packed-mn/releases/download/v1.4.5pre/metanorma-darwin-x64.tgz"
      sha256 "ec50cfd2a5c621be93633259779e03e21fa72ade9584540dd31db102771e6651"
      # < formula-set-version.sh packed-mn-darwin #
    end
  end

  if OS.linux?
    resource "packed-mn" do
      # > formula-set-version.sh packed-mn-linux #
      url "https://github.com/metanorma/packed-mn/releases/download/v1.4.5pre/metanorma-linux-x64.tgz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
      # < formula-set-version.sh packed-mn-linux #
    end
  end

  resource "idnits" do
    # required by 'metanorma-ietf' gem
    url "https://files.pythonhosted.org/packages/7b/a6/ec79a56c11c9e1d75224196e62c4b130370317f7194dbe4b49f794a656c0/idnits-3.0.0.tar.gz"
    sha256 "ad1027cf2ac04139ca1116eb64f8bb7c0485f050e71f844b11e035a9e0d6ad68"
  end

  resource "idnits_files" do
    # required by 'metanorma-ietf' gem
    url "https://tools.ietf.org/tools/idnits/idnits-2.16.02.tgz"
    sha256 "e9a501fc1f3a4584dda854067398eaebba29f128fb09f80048a760e950c35c49"
  end

  resource "xml2rfc" do
    # required by 'metanorma-ietf' gem
    url "https://files.pythonhosted.org/packages/5a/7a/05d3f54ed020133300b79e211b97238ab5023601432ef0ad5f626fda0ace/xml2rfc-2.42.0.tar.gz"
    sha256 "bd5bc9781dad18e4e0fd318d68b029635fbd6fb373267a46deb45c5d06ea65f2"
  end

  # Dependencies, `hashin decorator==4.4.2 ... -r requirements.txt --verbose` can help build list below
  resource "decorator" do
    url "https://files.pythonhosted.org/packages/da/93/84fa12f2dc341f8cf5f022ee09e109961055749df2d0c75c5f98746cfe6c/decorator-4.4.2.tar.gz"
    sha256 "e3a62f0520172440ca0dcc823749319382e377f37f140a0b99ef45fecb84bfe7"
  end

  resource "id2xml" do
    url "https://files.pythonhosted.org/packages/8c/19/ceec1753304e686371428126bc15b0ddf8a8e0cc6a42d53783e7669cdf36/id2xml-1.5.0.tar.gz"
    sha256 "589c74051e0da91096b46af5d6ab33a616085a0551405b4e2fc254e3180c1107"
  end

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/94/d8/65c86584e7e97ef824a1845c72bbe95d79f5b306364fa778a3c3e401b309/pathlib2-2.3.5.tar.gz"
    sha256 "6cd9a47b597b37cc57de1c05e56fb1a1c9cc9fab04fe78c29acd090418529868"
  end

  resource "python-magic" do
    url "https://files.pythonhosted.org/packages/65/0b/c6b31f686420420b5a16b24a722fe980724b28d76f65601c9bc324f08d02/python-magic-0.4.13.tar.gz"
    sha256 "604eace6f665809bebbb07070508dfa8cabb2d7cb05be9a56706c60f864f1289"
  end

  resource "python-magic-win64" do
    url "https://files.pythonhosted.org/packages/74/20/4371916b3344b66b7d1deb93f8548f8b330a0a589d0adf5d793d46ce5957/python-magic-win64-0.4.13.tar.gz"
    sha256 "9a4e749bfcfc54f1b8e6c4830640ff3e337a1c567298079ffd65b9e1fe229b7c"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/41/bf/9d214a5af07debc6acf7f3f257265618f1db242a3f8e49a9b516f24523a6/certifi-2019.11.28.tar.gz"
    sha256 "25b64c7da4cd7479594d035c08c2d809eb4aab3a26e5a990ea98cc450c320f1f"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "google-i18n-address" do
    url "https://files.pythonhosted.org/packages/06/23/807154ef37cfb508a773d6db590be689ad2e206ef5e87e910dd8738c7ad0/google-i18n-address-2.3.5.tar.gz"
    sha256 "7c6cd436e9abcdd69ea347d2e440d718019eed55e98b7078051f902a521f6fce"
  end

  resource "html5lib" do
    url "https://files.pythonhosted.org/packages/85/3e/cf449cf1b5004e87510b9368e7a5f1acd8831c2d6691edd3c62a0823f98f/html5lib-1.0.1.tar.gz"
    sha256 "66cb0dcfdbbc4f9c3ba1a63fdb511ffdbd4f513b2b6d81b80cd26ce6b3fb3736"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/cb/19/57503b5de719ee45e83472f339f617b0c01ad75cba44aba1e4c97c2b0abd/idna-2.9.tar.gz"
    sha256 "7588d1c14ae4c77d74036e8c22ff447b26d0fde8f007354fd48a7814db15b7cb"
  end

  resource "intervaltree" do
    url "https://files.pythonhosted.org/packages/e8/f9/76237755b2020cd74549e98667210b2dd54d3fb17c6f4a62631e61d31225/intervaltree-3.0.2.tar.gz"
    sha256 "cb4f61c81dcb4fea6c09903f3599015a83c9bdad1f0bbd232495e6681e19e273"
  end

  resource "kitchen" do
    url "https://files.pythonhosted.org/packages/d9/ca/3365cb1160533be8c8b57dbfd6502f367d35e30935ee89a003c664740714/kitchen-1.2.6.tar.gz"
    sha256 "b84cf582f1bd1556b60ebc7370b9d331eb9247b6b070ce89dfe959cba2c0b03c"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/39/2b/0a66d5436f237aff76b91e68b4d8c041d145ad0a2cdeefe2c42f76ba2857/lxml-4.5.0.tar.gz"
    sha256 "8620ce80f50d023d414183bf90cc2576c2837b88e00bea3f33ad2630133bbb60"
  end

  resource "pycountry" do
    url "https://files.pythonhosted.org/packages/16/b6/154fe93072051d8ce7bf197690957b6d0ac9a21d51c9a1d05bd7c6fdb16f/pycountry-19.8.18.tar.gz"
    sha256 "3c57aa40adcf293d59bebaffbe60d8c39976fba78d846a018dc0c2ec9c6cb3cb"
  end

  resource "pyflakes" do
    url "https://files.pythonhosted.org/packages/52/64/87303747635c2988fcaef18af54bfdec925b6ea3b80bcd28aaca5ba41c9e/pyflakes-2.1.1.tar.gz"
    sha256 "d976835886f8c5b31d47970ed689944a0262b5f3afa00a5a7b4dc81e5449f8a2"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/f5/4f/280162d4bd4d8aad241a21aecff7a6e46891b905a4341e7ab549ebaf7915/requests-2.23.0.tar.gz"
    sha256 "b3f43d496c6daba4493e7c431722aeb7dbc6288f52a6e04e7b6023b0247817e6"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz"
    sha256 "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a"
  end

  resource "sortedcontainers" do
    url "https://files.pythonhosted.org/packages/29/e0/135df2e733790a3d3bcda970fd080617be8cea3bd98f411e76e6847c17ef/sortedcontainers-2.1.0.tar.gz"
    sha256 "974e9a32f56b17c1bac2aebd9dcf197f3eb9cd30553c5852a3187ad162e1a03a"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/09/06/3bc5b100fe7e878d3dee8f807a4febff1a40c213d2783e3246edde1f3419/urllib3-1.25.8.tar.gz"
    sha256 "87716c2d2a7121198ebcb7ce7cccf6ce5e9ba539041cfbaeecfb641dc0bf6acc"
  end

  resource "webencodings" do
    url "https://files.pythonhosted.org/packages/0b/02/ae6ceac1baeda530866a85075641cec12989bd8d31af6d5ab4a3e8c92f47/webencodings-0.5.1.tar.gz"
    sha256 "b36a1c245f2d304965eb4e0a82848379241dc04b865afcc4aab16748587e1923"
  end

  def install # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    platform = OS.linux? ? :linux : :darwin

    resource("packed-mn").stage do
      bin.install "metanorma-#{platform}-x64"
    end

    venv = virtualenv_create(libexec/"venv", "python3")
    %w[lxml idnits xml2rfc decorator id2xml pathlib2 python-magic python-magic-win64 certifi
       chardet google-i18n-address html5lib idna intervaltree kitchen pycountry
       pyflakes requests six sortedcontainers urllib3 webencodings].each do |r|
      venv.pip_install resource(r)
    end

    resource("idnits_files").stage do
      %w[control idnits].each do |f|
        (libexec/"idnits_files").install f
      end
    end

    (bin/"metanorma").write_env_script(
      bin/"metanorma-#{platform}-x64",
      PYTHONPATH: libexec/"venv/site-packages",
      PATH:       [libexec/"idnits_files", libexec/"bin", libexec/"venv/bin", ENV["PATH"]].join(":"),
    )
  end

  def caveats
    <<~EOS
      inkscape >= 1.0 is required to generate Word output using SVG images.
      Install it by running `brew cask install inkscape` or
      directly download from https://inkscape.org/release/inkscape-1.0/
    EOS
  end

  test do # rubocop:disable Metrics/BlockLength
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

    METANORMA_IETF_TEST_DOC = <<~'ADOC'
      :doctype: rfc
      :mn-document-class: ietf
      :mn-output-extensions: xml,rfc,txt,html,rxl
      :docfile: document.adoc

      == Clause
      Clause
    ADOC

    (testpath/"test-iso.adoc").write(METANORMA_TEST_DOC)
    system bin/"metanorma", "--type", "iso", testpath/"test-iso.adoc"
    assert_predicate testpath/"test-iso.xml", :exist?
    assert_predicate testpath/"test-iso.html", :exist?

    (testpath/"test-csa.adoc").write(METANORMA_TEST_DOC)
    system bin/"metanorma", "--type", "csa", testpath/"test-csa.adoc"
    assert_predicate testpath/"test-csa.pdf", :exist?
    assert_predicate testpath/"test-csa.html", :exist?

    (testpath/"test-standoc.adoc").write(METANORMA_LATEXML_TEST_DOC)
    system bin/"metanorma", "--type", "standoc", "--extensions", "xml", testpath/"test-standoc.adoc"
    assert_predicate testpath/"test-standoc.xml", :exist?
  end
end
