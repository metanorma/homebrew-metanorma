class Metanorma < Formula
  desc "Toolchain for publishing metanorma documentation"
  homepage "https://www.metanorma.com"

  url "https://rubygems.org/downloads/metanorma-cli-1.12.8.gem"
  sha256 "b746637b00a051ca409ccf98fc82c12c443d27183c3d4bdd3535ad47eb015573"

  license "0BSD"

  depends_on "pkgconf" => :build
  depends_on "gflags"
  depends_on "graphviz"
  depends_on "openjdk"
  depends_on "plantuml"
  depends_on "readline"
  depends_on "ruby@3.3"
  depends_on "xml2rfc"

  uses_from_macos "zlib" => :build

  on_linux do
    depends_on "libxslt"
    depends_on "zlib" => :build
  end

  resource "socksify" do
    url "https://rubygems.org/gems/socksify-1.7.1.gem"
    sha256 "d1b2c7ae908ad1a3f1ea5184065e856b7edbabef61b40c00a4231c4f2ebae4ba"
  end

  resource "thor" do
    url "https://rubygems.org/gems/thor-1.3.2.gem"
    sha256 "eef0293b9e24158ccad7ab383ae83534b7ad4ed99c09f96f1a6b036550abbeda"
  end

  resource "hollaback" do
    url "https://rubygems.org/gems/hollaback-0.1.1.gem"
    sha256 "5a0826d92a5785a345b713de611dbf08cdfdaaa2380cb36203393080a3cc94bc"
  end

  resource "thor" do
    url "https://rubygems.org/gems/thor-hollaback-0.2.1.gem"
    sha256 "6f385d10a3e7ade35548fec134ef5be2ef04e09ccebf5e279f89f7de72d29e3b"
  end

  resource "rubyzip" do
    url "https://rubygems.org/gems/rubyzip-2.3.2.gem"
    sha256 "3f57e3935dc2255c414484fbf8d673b4909d8a6a57007ed754dde39342d2373f"
  end

  resource "logger" do
    url "https://rubygems.org/gems/logger-1.6.6.gem"
    sha256 "dd618d24e637715472732e7eed02e33cfbdf56deaad225edd0f1f89d38024017"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-logger-0.2.2.gem"
    sha256 "0e23aa4358eb57607f096f6bfcd0b56ca7629939f3c45f40c8eefaf95c7cb26d"
  end

  resource "parslet" do
    url "https://rubygems.org/gems/parslet-2.0.0.gem"
    sha256 "d45130695d39b43d7e6a91f4d2ec66b388a8d822bae38de9b4de9a5fbde1f606"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-core-1.12.11.gem"
    sha256 "dbb09f3b8f3fc6311f909d00376280269913cd485c240b8e52b557029bfc24dc"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-index-0.2.16.gem"
    sha256 "156ac2c9f0a8ae9acf9398ed01fcaef39b2acc7002796983aa4900e1b1f3993c"
  end

  resource "racc" do
    url "https://rubygems.org/gems/racc-1.8.1.gem"
    sha256 "4a7f6929691dbec8b5209a0b373bc2614882b55fc5d2e447a21aaa691303d62f"
  end

  resource "nokogiri" do
    url "https://rubygems.org/gems/nokogiri-1.18.7.gem"
    sha256 "6b63ff5defe48f30d1d3b3122f65255ca91df2caf5378c6e0482ce73ff46fb31"
  end

  resource "iso639" do
    url "https://rubygems.org/gems/iso639-1.3.3.gem"
    sha256 "ba9ec9df124b250dbc21b8d4dc74266a0d06fc58e25104916b1864b14b8f1eac"
  end

  resource "htmlentities" do
    url "https://rubygems.org/gems/htmlentities-4.3.4.gem"
    sha256 "125a73c6c9f2d1b62100b7c3c401e3624441b663762afa7fe428476435a673da"
  end

  resource "latex" do
    url "https://rubygems.org/gems/latex-decode-0.4.0.gem"
    sha256 "e2606bd0584fc5393f2a4b9ef907ff48573b8bad4013bda9c9f8c2c7ffb0bdf8"
  end

  resource "bibtex" do
    url "https://rubygems.org/gems/bibtex-ruby-6.1.0.gem"
    sha256 "2631c742be185b1a6df6b431206f78ce673be6528116728d0ace90f88214fdbd"
  end

  resource "public_suffix" do
    url "https://rubygems.org/gems/public_suffix-6.0.1.gem"
    sha256 "61d44e1cab5cbbbe5b31068481cf16976dd0dc1b6b07bd95617ef8c5e3e00c6f"
  end

  resource "addressable" do
    url "https://rubygems.org/gems/addressable-2.8.7.gem"
    sha256 "462986537cf3735ab5f3c0f557f14155d778f4b43ea4f485a9deb9c8f7c58232"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-bib-1.20.7.gem"
    sha256 "a54dc40635002c587f12854650a695f7150d0e32c78571d3a2c4edfad6fdf9f4"
  end

  resource "nkf" do
    url "https://rubygems.org/gems/nkf-0.2.0.gem"
    sha256 "fbc151bda025451f627fafdfcb3f4f13d0b22ae11f58c6d3a2939c76c5f5f126"
  end

  resource "base64" do
    url "https://rubygems.org/gems/base64-0.2.0.gem"
    sha256 "0f25e9b21a02a0cc0cea8ef92b2041035d39350946e8789c562b2d1a3da01507"
  end

  resource "rubyntlm" do
    url "https://rubygems.org/gems/rubyntlm-0.6.5.gem"
    sha256 "47013402b99ae29ee93f930af51edaec8c6008556f4be25705a422b4430314f5"
  end

  resource "webrobots" do
    url "https://rubygems.org/gems/webrobots-0.1.2.gem"
    sha256 "ebbcaa2cb4930fa1b83206f432c5cb64746507b2dcf50ea1301569a4d662cda6"
  end

  resource "webrick" do
    url "https://rubygems.org/gems/webrick-1.9.1.gem"
    sha256 "b42d3c94f166f3fb73d87e9b359def9b5836c426fc8beacf38f2184a21b2a989"
  end

  resource "connection_pool" do
    url "https://rubygems.org/gems/connection_pool-2.5.0.gem"
    sha256 "233b92f8d38e038c1349ccea65dd3772727d669d6d2e71f9897c8bf5cd53ebfc"
  end

  resource "net" do
    url "https://rubygems.org/gems/net-http-persistent-4.0.5.gem"
    sha256 "6e42880b347e650ffeaf679ae59c9d5a6ed8a22cda6e1b959d9c270050aefa8e"
  end

  resource "net" do
    url "https://rubygems.org/gems/net-http-digest_auth-1.4.1.gem"
    sha256 "4b8ad50ed8d180a58db5d6c49449b987dd0466fe01e24037945bc007562a08db"
  end

  resource "mime" do
    url "https://rubygems.org/gems/mime-types-data-3.2025.0408.gem"
    sha256 "fbde1ed056e244bc07f492eed2ca5517e9b960fe1c3ef5ac4af50966a8b16f54"
  end

  resource "mime" do
    url "https://rubygems.org/gems/mime-types-3.6.2.gem"
    sha256 "6109148e6a6e656607510b74571deff8ecd9a97ab0dcec9b7431bdd0b74460af"
  end

  resource "domain_name" do
    url "https://rubygems.org/gems/domain_name-0.6.20240107.gem"
    sha256 "5f693b2215708476517479bf2b3802e49068ad82167bcd2286f899536a17d933"
  end

  resource "http" do
    url "https://rubygems.org/gems/http-cookie-1.0.8.gem"
    sha256 "b14fe0445cf24bf9ae098633e9b8d42e4c07c3c1f700672b09fbfe32ffd41aa6"
  end

  resource "mechanize" do
    url "https://rubygems.org/gems/mechanize-2.14.0.gem"
    sha256 "33e76b7639d0181a46eaf1136b05f0e9043dfc5fc4b1a7b9fd8ae8bd437dd5e4"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-xsf-1.20.0.gem"
    sha256 "c37fdea4318731d499b95e6a947af37ff7fe08c0f799ea9ed550f04376932358"
  end

  resource "rexml" do
    url "https://rubygems.org/gems/rexml-3.4.1.gem"
    sha256 "c74527a9a0a04b4ec31dbe0dc4ed6004b960af943d8db42e539edde3a871abca"
  end

  resource "bigdecimal" do
    url "https://rubygems.org/gems/bigdecimal-3.1.9.gem"
    sha256 "2ffc742031521ad69c2dfc815a98e426a230a3d22aeac1995826a75dabfad8cc"
  end

  resource "bcp47_spec" do
    url "https://rubygems.org/gems/bcp47_spec-0.2.1.gem"
    sha256 "3fd62edf96c126bd9624e4319ac74082a966081859d1ee0ef3c3041640a37810"
  end

  resource "link_header" do
    url "https://rubygems.org/gems/link_header-0.0.8.gem"
    sha256 "15c65ce43b29f739b30d05e5f25c22c23797e89cf6f905dbb595fb4c70cb55f9"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-3.3.2.gem"
    sha256 "960eeb22fb4434ec5b6f4dacf65256725db043dac789a4a0dc7cf22057a58ad6"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-xsd-3.3.0.gem"
    sha256 "fab51d27b20344237d9b622ef32e83e4c44940840bfc76a245ce6b6abba44772"
  end

  resource "sparql" do
    url "https://rubygems.org/gems/sparql-client-3.3.0.gem"
    sha256 "71225eefad48dc2baab6b7008df8a9bcfffa833e5f25387dbe87ff52a5cad64e"
  end

  resource "matrix" do
    url "https://rubygems.org/gems/matrix-0.4.2.gem"
    sha256 "71083ccbd67a14a43bfa78d3e4dc0f4b503b9cc18e5b4b1d686dc0f9ef7c4cc0"
  end

  resource "sxp" do
    url "https://rubygems.org/gems/sxp-2.0.0.gem"
    sha256 "79971bbab54a82fe4a861332475eb8c1f33142d70f2b7e830dacbd9082824721"
  end

  resource "builder" do
    url "https://rubygems.org/gems/builder-3.3.0.gem"
    sha256 "497918d2f9dca528fdca4b88d84e4ef4387256d984b8154e9d5d3fe5a9c8835f"
  end

  resource "unicode" do
    url "https://rubygems.org/gems/unicode-types-1.10.0.gem"
    sha256 "918b76a0b57c54244df571887e53903027fc493cfbcec87432eb3acac7362ed6"
  end

  resource "scanf" do
    url "https://rubygems.org/gems/scanf-1.0.0.gem"
    sha256 "533db7f7e5acafea1a145d6c5329cef667a58fbcb7d64379a808ff1199ee1b00"
  end

  resource "ebnf" do
    url "https://rubygems.org/gems/ebnf-2.6.0.gem"
    sha256 "e746a316caa885cc45e243dc33efc194943956760bc9bc13948de1732fbcf63e"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-aggregate-repo-3.3.0.gem"
    sha256 "5693ccabf4dbbec7113c95e9aab028311f19d6022764fdebc6327f9d55a9efdc"
  end

  resource "sparql" do
    url "https://rubygems.org/gems/sparql-3.3.1.gem"
    sha256 "d89549405205ba0e54319ea07247ff27c54096584a6886b4017b1c6c4e278e47"
  end

  resource "csv" do
    url "https://rubygems.org/gems/csv-3.3.4.gem"
    sha256 "e96ecd5a8c3494aa5b596282249daba5c6033203c199248e6146e36d2a78d8cd"
  end

  resource "rack" do
    url "https://rubygems.org/gems/rack-3.1.13.gem"
    sha256 "170c79db621882884d9a28d9cd5bd228c663fddcd367c4dea22c9a1808645792"
  end

  resource "multi_json" do
    url "https://rubygems.org/gems/multi_json-1.15.0.gem"
    sha256 "1fd04138b6e4a90017e8d1b804c039031399866ff3fbabb7822aea367c78615d"
  end

  resource "json" do
    url "https://rubygems.org/gems/json-canonicalization-1.0.0.gem"
    sha256 "d4848a8cca7534455c6721f2d9fc9e5e9adca49486864a898810024f67d59446"
  end

  resource "json" do
    url "https://rubygems.org/gems/json-ld-3.3.2.gem"
    sha256 "b9531893bf5bdc01db428e96953845a23adb1097125ce918ae0f97c4a6e1ab27"
  end

  resource "json" do
    url "https://rubygems.org/gems/json-ld-preloaded-3.3.1.gem"
    sha256 "afd5bf1a3b7d8f8a80dfd407185f41458c69ebe3b2d2e353890f76cd95cc6250"
  end

  resource "shex" do
    url "https://rubygems.org/gems/shex-0.8.1.gem"
    sha256 "d07c0043302f9eed5f9f5af81e9786be74dde5e3065ea7932790f33253bfced6"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-normalize-0.7.0.gem"
    sha256 "92374497dddb61c2910b50bfc12bb0ace33dcf23c8edbd0e0f78fd4acf839ebe"
  end

  resource "date" do
    url "https://rubygems.org/gems/date-3.4.1.gem"
    sha256 "bf268e14ef7158009bfeaec40b5fa3c7271906e88b196d958a89d4b408abe64f"
  end

  resource "stringio" do
    url "https://rubygems.org/gems/stringio-3.1.6.gem"
    sha256 "292c495d1657adfcdf0a32eecf12a60e6691317a500c3112ad3b2e31068274f5"
  end

  resource "psych" do
    url "https://rubygems.org/gems/psych-5.2.3.gem"
    sha256 "84a54bb952d14604fea22d99938348814678782f58b12648fcdfa4d2fce859ee"
  end

  resource "yaml" do
    url "https://rubygems.org/gems/yaml-ld-0.0.3.gem"
    sha256 "2934e06ef651337bf4c5d78e6a22007e0c46f1215c19dc024816c1fa82b971d1"
  end

  resource "shacl" do
    url "https://rubygems.org/gems/shacl-0.4.2.gem"
    sha256 "62237528e1684b0aad435c524697a97d7be1e83423190771e5513ee5027cb6f6"
  end

  resource "ld" do
    url "https://rubygems.org/gems/ld-patch-3.3.1.gem"
    sha256 "e663fca96ef2b7cbe25d2b5fe257d17984d28b64cb475d50943eebbb5c05dc51"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-vocab-3.3.2.gem"
    sha256 "651cabbad302131bc10ded99998827dac3524636528d9123e8912cd1ec15116d"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-turtle-3.3.1.gem"
    sha256 "baf3be89977a2e7abb4f9a088f24918ca6223dcfa1483979991ab7996da73647"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-trix-3.3.0.gem"
    sha256 "9817b4165bcb8d6ebb5acd9f3c495e93fdd455ab488071d50bbce5c7a61f8f4b"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-trig-3.3.0.gem"
    sha256 "3a22bc433f1042ff655c7dbbf95a69a4d85fbc3df386d7e7e52d834a18166c3f"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-tabular-3.3.0.gem"
    sha256 "560fe8248687a6142267f437f1c98df8fb427e47f91c9a7cd430ab5f461b4d23"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-reasoner-0.9.0.gem"
    sha256 "227cca0008ed2e99b0a27e05f919af14b2516dfcac5544f159e10cacc69c1a2b"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-rdfxml-3.3.0.gem"
    sha256 "11647f6111b97b6a9b82413bd9810d4bb5524aa7dd06b3c1330bf58ec3aa6a9a"
  end

  resource "tilt" do
    url "https://rubygems.org/gems/tilt-2.6.0.gem"
    sha256 "263d748466e0d83e510aa1a2e2281eff547937f0ef06be33d3632721e255f76b"
  end

  resource "temple" do
    url "https://rubygems.org/gems/temple-0.10.3.gem"
    sha256 "df3145fe6577af1e25387eb7f7122d32ed51bdb6f2e7bb0f4fbf07b66151913b"
  end

  resource "haml" do
    url "https://rubygems.org/gems/haml-6.3.0.gem"
    sha256 "8e6eb87d869639e348852009e74a2a1663d79663ed7e7dbcb38beb1f12bcdd97"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-rdfa-3.3.0.gem"
    sha256 "5770deb6da628b04b22a097269919897a0092c44250bbf5f22be4fabdc5ef71b"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-ordered-repo-3.3.0.gem"
    sha256 "551b7f22f258e807f329f0071625ed1c22fc3b29080078a1f678be6c2749f93a"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-n3-3.3.1.gem"
    sha256 "3030d185823422ee3249a826aa5b8c96281b4728a36f2061fb8b4f070c738f73"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-microdata-3.3.0.gem"
    sha256 "daaaf3f947ecce1c3e94aa5fed5f5c38ebea4070670d4e9600c156c631c25c3e"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-json-3.3.0.gem"
    sha256 "80050bb97ec06108fc53d7ada777bceec06196ca7f0642ceeaf38b20a9b0addd"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-isomorphic-3.3.0.gem"
    sha256 "1247bbd372f4d10d4fa13a40a23a44867bcb0fa4f7a01927191ea3cadad0af2c"
  end

  resource "concurrent" do
    url "https://rubygems.org/gems/concurrent-ruby-1.3.5.gem"
    sha256 "813b3e37aca6df2a21a3b9f1d497f8cbab24a2b94cab325bffe65ee0f6cbebc6"
  end

  resource "hamster" do
    url "https://rubygems.org/gems/hamster-3.0.0.gem"
    sha256 "5951e3a3ffd15ba854a976ac36ebae9469966f726034ffed0dccdb6d12d434d8"
  end

  resource "rdf" do
    url "https://rubygems.org/gems/rdf-hamster-repo-3.3.0.gem"
    sha256 "8a57d321d0c8bfb1eac7c47fd5b569e9c5fb7bb92bf9b78c102d58125dd1099a"
  end

  resource "linkeddata" do
    url "https://rubygems.org/gems/linkeddata-3.3.1.gem"
    sha256 "a813daba4ce9863dc96e5b647219357f00a14ca52c63fcf118267e44f0e6e4bf"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-w3c-1.20.0.gem"
    sha256 "e541e6cc5f4d49e81add7ab5c634c8485aa7c6fa1b831c86409eeb5893303383"
  end

  resource "ruby2_keywords" do
    url "https://rubygems.org/gems/ruby2_keywords-0.0.5.gem"
    sha256 "ffd13740c573b7301cf7a2e61fc857b2a8e3d3aff32545d6f8300d8bae10e3ef"
  end

  resource "faraday" do
    url "https://rubygems.org/gems/faraday-net_http-3.0.2.gem"
    sha256 "6882929abed8094e1ee30344a3369e856fe34530044630d1f652bf70ebd87e8d"
  end

  resource "faraday" do
    url "https://rubygems.org/gems/faraday-2.7.12.gem"
    sha256 "ed38dcd396d2defcf8a536bbf7ef45e6385392ab815fe087df46777be3a781a7"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-un-1.20.1.gem"
    sha256 "03a773b198525ae1d7b47f53ed38f43acc1b4330e6970bedffc0209bfa17f12d"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-plateau-1.20.0.gem"
    sha256 "3c60bc5a2b116996497fbd9877c3642ae9139b6c0f365517dcfb75d25acd926f"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-omg-1.20.0.gem"
    sha256 "a34ed1edae932b410cf57889023b7757ab508639ba23c4629974ff772a8465b4"
  end

  resource "isoics" do
    url "https://rubygems.org/gems/isoics-0.1.13.gem"
    sha256 "57d3a1e30817e03fe8e2442bf62ec5b17e101bae0eea2c0f507030fe834c7482"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-iso-bib-1.20.0.gem"
    sha256 "5825956384958df4140ec1bda0e46cee6191092e495c5e56b016d4319e1d7f94"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-ogc-1.20.1.gem"
    sha256 "097ba8451fa639c22e770fbc059740216ae8c094b9a82198e358975d6498ad2e"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-oasis-1.20.0.gem"
    sha256 "dc85622caeee2df2bbff6ebb69ff02cd4e28ae101107b1960e9dc42738116f49"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-etsi-0.1.0.gem"
    sha256 "c7feb5c16eb104616ec19d06b1a874522f33f2dd1dcde9ad5817ac5502d14776"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-iso-0.7.8.gem"
    sha256 "9aed4424025e5a64f4ab19c2f2a87b02a77059dffbf17e4336fa072b0490fd2e"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-iec-0.3.2.gem"
    sha256 "dcdc340065eb77f248a7669bf39d6fa1b277321e7f8dea38c34e749622695b12"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-cen-0.2.4.gem"
    sha256 "b8e7e3a9701b022d4751996f17de5464c66448ff58724bafe3c9e9843c7a4468"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-bsi-0.3.4.gem"
    sha256 "f1f70967de3dffc173f9d0156270bc7b464b3a3d14657523402a5a0c9de3047b"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-jis-0.3.2.gem"
    sha256 "b90b88660376c423e7af672aaea984218993743507b7cb7b470b093da4d68269"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-itu-0.1.3.gem"
    sha256 "0797be45d511b4a06f02d08b39a0b8ad709dc0b1e3e64e833df63f4cf5d94372"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-ccsds-0.1.6.gem"
    sha256 "d1917b0aaf310b03147d2cbeead59aae41bac7e30e460cd2fd61b2d32c4de8e1"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-ieee-0.2.2.gem"
    sha256 "f42dfed93126e3a6d593e96583c341e729fefd205aef46f583983351057a235a"
  end

  resource "lightly" do
    url "https://rubygems.org/gems/lightly-0.4.0.gem"
    sha256 "587c142b3eec854300e5500e424909243947b13dd800201803944c5803ed677e"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-nist-0.4.2.gem"
    sha256 "140647a8bc2eb4e98b49441b76325c6444f14dcf489eb6775bce9e763fe93ddd"
  end

  resource "pubid" do
    url "https://rubygems.org/gems/pubid-0.1.2.gem"
    sha256 "3c7e838e792e71d7c203812a0521c28bc2a5d977d24b9ed1decc8a0b328dd663"
  end

  resource "moxml" do
    url "https://rubygems.org/gems/moxml-0.1.3.gem"
    sha256 "30a95ecb3300f0e941a8887a136c247b222d8f5cf51cadcb3d9e1d8c4187a8e8"
  end

  resource "lutaml" do
    url "https://rubygems.org/gems/lutaml-model-0.7.3.gem"
    sha256 "8759ea87b9a85f843d8479950b0ae4adcb7e53dcddc3eeec39d64a653e5ef8ea"
  end

  resource "loc_mods" do
    url "https://rubygems.org/gems/loc_mods-0.2.7.gem"
    sha256 "7c5eaed6f5406ff818ac449e0c5379a57113efd32c20a9c0e99086357d504a5b"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-nist-1.20.0.gem"
    sha256 "6afabe325b07e5fd59fe9aa9f2f18f67396fdef979a76a8bceb32d7f6c79185a"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-jis-1.20.0.gem"
    sha256 "c7cb3e02675efb2347cb36957c11ce575838583404c991c3c99f3489af7cf555"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-itu-1.20.2.gem"
    sha256 "3178dfabc45f3535e153109cc00c664f25eeb47021a2c61543a28ff377e7714d"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-iso-1.20.0.gem"
    sha256 "78556765abde12b85b9680dc3471dabcfdd035b19ff30368cf50ef673666209c"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-isbn-1.20.0.gem"
    sha256 "10a63bc1c3b95c5713c2aaa9973878affff53ce68393c77644c7aee0614ae61b"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-iho-1.20.0.gem"
    sha256 "b6f89aa169ee789c833356e9ad0fa92fe1148100b81f7f4f60d416ac23ce4b05"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-ietf-1.20.0.gem"
    sha256 "b6f5a948032c095e2bd2dec56574d02a2454f345340b18985d7ffbef747a46e0"
  end

  resource "mini_portile2" do
    url "https://rubygems.org/gems/mini_portile2-2.8.8.gem"
    sha256 "8e47136cdac04ce81750bb6c09733b37895bf06962554e4b4056d78168d70a75"
  end

  resource "ieee" do
    url "https://rubygems.org/gems/ieee-idams-0.2.13.gem"
    sha256 "3d0d6fcbabcc5b68fe9cc85466253a637f64ccc07bf7a7c4318afcbf0bf49cf0"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-ieee-1.20.0.gem"
    sha256 "ccd5e04576599896c644a622783324fad28d069e7ac96276cb60549dedacdc57"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-iec-1.20.0.gem"
    sha256 "42b965391977e7dd421c3dd34935a9743ddaff1fcba0616e964ec5c4fb866aba"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-iana-1.20.0.gem"
    sha256 "55b79a44606ebcabfdffd7aebc8facce5abb642a82791db462a5ede105709d0e"
  end

  resource "gb" do
    url "https://rubygems.org/gems/gb-agencies-0.0.7.gem"
    sha256 "6c363d9653fbb03a1e3ea2c3610439e986bee1d53af90ce18f26e8da0b742797"
  end

  resource "cnccs" do
    url "https://rubygems.org/gems/cnccs-0.1.6.gem"
    sha256 "01f47296fb351db9f7b66c330eede6336c5a0a895316ff2153b64c24d2e91344"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-gb-1.20.0.gem"
    sha256 "d8146be8a5cc9670b9039fdf03e18a0ad854cbd3774c9b504f1207f1a98a8d1c"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-etsi-1.20.0.gem"
    sha256 "c40de9e9d5924fe9396ed07dafe9048197dac59d81b0db273b3fe7b723dbf607"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-ecma-1.20.0.gem"
    sha256 "87e5b06d14360ad3a3bd11f4cc361a0d900f696f2065b86e2e7881db675c99b4"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-bipm-1.20.3.gem"
    sha256 "999eaac7508b54d2e4a3aca11a19ae32adac79bafe8f2c97d6ba88011d1dd2ac"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-doi-1.20.0.gem"
    sha256 "cb594b4ad93b0208f5368c5dcaaf72a0b458d6a9f95ce138b68577f47408a086"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-cie-1.20.0.gem"
    sha256 "ff96951030528d8e67791cc78730ea2a2852baeb66dc6d2a21e21b0b2414c75d"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-cen-1.20.1.gem"
    sha256 "9a35ebd62ddca79fe7eab4e755b44a2eb49f345301a9e6f36dada3268ab453de"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-ccsds-1.20.2.gem"
    sha256 "5c61fe4d9391a628e2a5c747c19dd17776249331b55f001dc01240da620c8bf5"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-calconnect-1.20.0.gem"
    sha256 "e64d9ae0bd0639b83345c272e77fc739a65872588426780e28f060fb3c638695"
  end

  resource "fiber" do
    url "https://rubygems.org/gems/fiber-storage-1.0.0.gem"
    sha256 "b80a323f1e0b95e79b11c1d4df7f654dbe517c11a344c90f2a43dec67ba5ab7f"
  end

  resource "graphql" do
    url "https://rubygems.org/gems/graphql-2.5.3.gem"
    sha256 "c94d3ca4a52feeb1f7b2e5c2ffaec8efc98b91d574ef1d321e3e0704bf3058e8"
  end

  resource "benchmark" do
    url "https://rubygems.org/gems/benchmark-0.4.0.gem"
    sha256 "0f12f8c495545e3710c3e4f0480f63f06b4c842cc94cec7f33a956f5180e874a"
  end

  resource "uri" do
    url "https://rubygems.org/gems/uri-1.0.3.gem"
    sha256 "e9f2244608eea2f7bc357d954c65c910ce0399ca5e18a7a29207ac22d8767011"
  end

  resource "securerandom" do
    url "https://rubygems.org/gems/securerandom-0.4.1.gem"
    sha256 "cc5193d414a4341b6e225f0cb4446aceca8e50d5e1888743fac16987638ea0b1"
  end

  resource "drb" do
    url "https://rubygems.org/gems/drb-2.2.1.gem"
    sha256 "e9d472bf785f558b96b25358bae115646da0dbfd45107ad858b0bc0d935cb340"
  end

  resource "minitest" do
    url "https://rubygems.org/gems/minitest-5.25.5.gem"
    sha256 "391b6c6cb43a4802bfb7c93af1ebe2ac66a210293f4a3fb7db36f2fc7dc2c756"
  end

  resource "tzinfo" do
    url "https://rubygems.org/gems/tzinfo-2.0.6.gem"
    sha256 "8daf828cc77bcf7d63b0e3bdb6caa47e2272dcfaf4fbfe46f8c3a9df087a829b"
  end

  resource "i18n" do
    url "https://rubygems.org/gems/i18n-1.14.7.gem"
    sha256 "ceba573f8138ff2c0915427f1fc5bdf4aa3ab8ae88c8ce255eb3ecf0a11a5d0f"
  end

  resource "activesupport" do
    url "https://rubygems.org/gems/activesupport-8.0.2.gem"
    sha256 "8565cddba31b900cdc17682fd66ecd020441e3eef320a9930285394e8c07a45e"
  end

  resource "graphql" do
    url "https://rubygems.org/gems/graphql-client-0.25.0.gem"
    sha256 "9e66c45649bb7d360f1dbdbdb8062198f8cb2d8fdc76818606b6f50172da52f5"
  end

  resource "faraday" do
    url "https://rubygems.org/gems/faraday-net_http_persistent-2.3.0.gem"
    sha256 "33d4948cabe9f8148222c4ca19634c71e1f25595cccf9da2e02ace8d754f1bb1"
  end

  resource "algolia" do
    url "https://rubygems.org/gems/algolia-2.3.4.gem"
    sha256 "9ea5c2c309af01a60b900e3f7b9dc232fa3b018bdd2479bfff7cb8ac1b948c9b"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-bsi-1.20.0.gem"
    sha256 "9398168ca993d205f6a7c6b23f8809e1c7268d7b807fc9085082cd11878ed580"
  end

  resource "time" do
    url "https://rubygems.org/gems/time-0.4.1.gem"
    sha256 "035f360508a4a4dbabcbbcd3886566b9abd432de89136795d2ff7aec5bcdea61"
  end

  resource "timeout" do
    url "https://rubygems.org/gems/timeout-0.4.3.gem"
    sha256 "9509f079b2b55fe4236d79633bd75e34c1c1e7e3fb4b56cb5fda61f80a0fe30e"
  end

  resource "net" do
    url "https://rubygems.org/gems/net-protocol-0.2.2.gem"
    sha256 "aa73e0cba6a125369de9837b8d8ef82a61849360eba0521900e2c3713aa162a8"
  end

  resource "net" do
    url "https://rubygems.org/gems/net-ftp-0.1.4.gem"
    sha256 "454735259262cf5d27dfbdf2a040921bc3070574bb9244b27e503ae749073182"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-3gpp-1.20.0.gem"
    sha256 "8df0c04343c98ef68065c843682e002f171a5b60d1f378e5056961558cf3f1bd"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-1.20.0.gem"
    sha256 "f79b7d06b795b5343ee3fcb394e74b0c4fda7540758996106cd9228ca0e40d2e"
  end

  resource "strscan" do
    url "https://rubygems.org/gems/strscan-3.1.3.gem"
    sha256 "1754786faa9a9bd1c7adb787dfe08d22800989899affbb198d674307d496a17e"
  end

  resource "liquid" do
    url "https://rubygems.org/gems/liquid-5.8.6.gem"
    sha256 "b8f8bdcb250dec7bb57e35eff83d65fa45dc98a77dffb6e9dc9bc02cf1c327d9"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-cli-1.20.1.gem"
    sha256 "46e93e2d7e7e5f947c159a0c5d0670c339d9a5c37a968f15b1697f92468d4cc9"
  end

  resource "mnconvert" do
    url "https://rubygems.org/gems/mnconvert-1.68.0.gem"
    sha256 "e6dc69c4b3673ed79b0485f80001a248b285576294eddabd7f3f2a899344dd8f"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-iev-1.2.0.gem"
    sha256 "5aab2e5092babff6b4223f7434919daf22665fded41c9821ada386d25277eb58"
  end

  resource "rake" do
    url "https://rubygems.org/gems/rake-13.2.1.gem"
    sha256 "46cb38dae65d7d74b6020a4ac9d48afed8eb8149c040eccf0523bec91907059d"
  end

  resource "ffi" do
    url "https://rubygems.org/gems/ffi-1.17.2.gem"
    sha256 "297235842e5947cc3036ebe64077584bff583cd7a4e94e9a02fdec399ef46da6"
  end

  resource "bundler" do
    url "https://rubygems.org/gems/bundler-2.6.6.gem"
    sha256 "832b2ab8d2ad6e3d275138fb640df3d36d4818e142d13b277b44886711b89761"
  end

  resource "pngcheck" do
    url "https://rubygems.org/gems/pngcheck-0.3.1.gem"
    sha256 "d0abd18190ca2b5098ba82862493bb6ef701ce20cb4baa34650a906a066f1e29"
  end

  resource "optout" do
    url "https://rubygems.org/gems/optout-0.0.2.gem"
    sha256 "7846380279d8381add42f3c0c2a288c5aff02877dcc8940ee8c0265f3edb435d"
  end

  resource "ruby" do
    url "https://rubygems.org/gems/ruby-jing-0.0.3.gem"
    sha256 "c7fc7cd8d8ed2335b1516c85e728138d5940e7df9b6b5b9f609146ead9bdd0b3"
  end

  resource "uuidtools" do
    url "https://rubygems.org/gems/uuidtools-3.0.0.gem"
    sha256 "47a3d4d20e728f522c675be8bc4e001252db39864c97deb194dc543b153a4be8"
  end

  resource "sterile" do
    url "https://rubygems.org/gems/sterile-1.0.26.gem"
    sha256 "2fb472c9fe30b29531bbda315ca72b584d9b7ceb2213fffb44ba4bfea7cd9191"
  end

  resource "asciidoctor" do
    url "https://rubygems.org/gems/asciidoctor-2.0.23.gem"
    sha256 "52208807f237dfa0ca29882f8b13d60b820496116ad191cf197ca56f2b7fddf3"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-utils-1.10.3.gem"
    sha256 "585003ba5026e59b3aa1486fd4c6c07842e6e700fcccac63748f4c4b161645c7"
  end

  resource "ogc" do
    url "https://rubygems.org/gems/ogc-gml-1.0.4.gem"
    sha256 "26187114d3d5d0ae61471186c6546c7330942cd19a164ef8c8baf03f807f4a10"
  end

  resource "xmi" do
    url "https://rubygems.org/gems/xmi-0.3.18.gem"
    sha256 "794fb823348290757aadcaf5f308a14accc4ffd518c7d49441f6c3cce5b61641"
  end

  resource "ruby" do
    url "https://rubygems.org/gems/ruby-graphviz-1.2.5.gem"
    sha256 "1c2bb44e3f6da9e2b829f5e7fd8d75a521485fb6b4d1fc66ff0f93f906121504"
  end

  resource "zeitwerk" do
    url "https://rubygems.org/gems/zeitwerk-2.7.2.gem"
    sha256 "842e067cb11eb923d747249badfb5fcdc9652d6f20a1f06453317920fdcd4673"
  end

  resource "lutaml" do
    url "https://rubygems.org/gems/lutaml-xsd-1.0.4.gem"
    sha256 "d614dc3f44d87eaf033a98de14b65c11bc62e706af92cf80f2bae3a9994ed97f"
  end

  resource "lutaml" do
    url "https://rubygems.org/gems/lutaml-path-0.1.0.gem"
    sha256 "3db3a8aae7b814783908ec50dce1071fe2ecb7a05d31e2ad7ffca331900ffecc"
  end

  resource "hashie" do
    url "https://rubygems.org/gems/hashie-4.1.0.gem"
    sha256 "7890dcb9ec18a4b66acec797018c73824b89cef5eb8cda36e8e8501845e87a09"
  end

  resource "benchmark" do
    url "https://rubygems.org/gems/benchmark-ips-2.14.0.gem"
    sha256 "b72bc8a65d525d5906f8cd94270dccf73452ee3257a32b89fbd6684d3e8a9b1d"
  end

  resource "expressir" do
    url "https://rubygems.org/gems/expressir-2.1.17.gem"
    sha256 "d95d3421fd41dbd84086881e368f82f411d8fefaefd53ee354a86d71dd890559"
  end

  resource "lutaml" do
    url "https://rubygems.org/gems/lutaml-0.9.32.gem"
    sha256 "9864f577c4a8937539401999bcc82de52cc3a11c5ead042bda0607bbb86b5f89"
  end

  resource "sys" do
    url "https://rubygems.org/gems/sys-proctable-1.3.0.gem"
    sha256 "31f61ad79aa0d4412155132beadf2b7ca706a6badce4ad2dfeda5d1ca4916e54"
  end

  resource "reverse_markdown" do
    url "https://rubygems.org/gems/reverse_markdown-2.1.1.gem"
    sha256 "b2206466b682ac1177b6b8ec321d00a84fca02d096c5d676a7a0cc5838dc0701"
  end

  resource "css_parser" do
    url "https://rubygems.org/gems/css_parser-1.21.1.gem"
    sha256 "6cfd3ffc0a97333b39d2b1b49c95397b05e0e3b684d68f77ec471ba4ec2ef7c7"
  end

  resource "premailer" do
    url "https://rubygems.org/gems/premailer-1.27.0.gem"
    sha256 "0fe2348cd82738855c482b31c915a06ecb1d3ad004578c19042905196ddbd1e7"
  end

  resource "nokogiri" do
    url "https://rubygems.org/gems/nokogiri-styles-0.1.2.gem"
    sha256 "b2d32391d8db15c5b0ec681f13904c9448f627355c5b3725e460ca9d53a380c9"
  end

  resource "descriptive_statistics" do
    url "https://rubygems.org/gems/descriptive_statistics-2.5.1.gem"
    sha256 "1b8f9a38ca9554bd791d053c265d364ed7abebd10f7aeb7d2b04c8bda0db29fb"
  end

  resource "cliver" do
    url "https://rubygems.org/gems/cliver-0.3.2.gem"
    sha256 "8775445218c612bb57f50c392c4906a1ab5cca067eab093bde3cc77d6426ce24"
  end

  resource "word" do
    url "https://rubygems.org/gems/word-to-markdown-1.1.9.gem"
    sha256 "8a379dbd725a47705d56925046fedae3f179fc4803c391faedb2c8174dc13aee"
  end

  resource "unitsdb" do
    url "https://rubygems.org/gems/unitsdb-1.0.0.gem"
    sha256 "2ce839a6d2a1e200a100c485f6c12e223551317779ba216ac277b067e224f604"
  end

  resource "mml" do
    url "https://rubygems.org/gems/mml-2.0.3.gem"
    sha256 "b2bda59eb6400fda5f586bb477ec517531ca371ad63e21c31512f43a272b3b11"
  end

  resource "unitsml" do
    url "https://rubygems.org/gems/unitsml-0.4.6.gem"
    sha256 "1c2b4dcd432b014f8a337c575abe8c6591b88eb5a4503ae1000599e575c71a13"
  end

  resource "ox" do
    url "https://rubygems.org/gems/ox-2.14.22.gem"
    sha256 "0bbc4a40d109e4b76295c4927b5f2d453070eb5af221e5b05ec0ff58e291c6a9"
  end

  resource "plurimath" do
    url "https://rubygems.org/gems/plurimath-0.9.2.gem"
    sha256 "f00349425de977739e0dedbbf1a7b9295a7debc54833eb3197fdb463362d980f"
  end

  resource "yaml" do
    url "https://rubygems.org/gems/yaml-0.4.0.gem"
    sha256 "240e69d1e6ce3584d6085978719a0faa6218ae426e034d8f9b02fb54d3471942"
  end

  resource "oscal" do
    url "https://rubygems.org/gems/oscal-0.1.1.gem"
    sha256 "c8381f91227eae3709be73f13eea2c36e0c37f9aaba68a0a53fdfbabdda862a6"
  end

  resource "marcel" do
    url "https://rubygems.org/gems/marcel-1.0.4.gem"
    sha256 "0d5649feb64b8f19f3d3468b96c680bae9746335d02194270287868a661516a4"
  end

  resource "coradoc" do
    url "https://rubygems.org/gems/coradoc-1.1.7.gem"
    sha256 "a81c2e99a05c78ee005346644170e148940073b316a5ac070773f4e47b31d964"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-plugin-lutaml-0.7.26.gem"
    sha256 "caa07f5c7a2eec5b502ca332e48795df1a9667d96b4e1b899b1481ac79294c0d"
  end

  resource "glossarist" do
    url "https://rubygems.org/gems/glossarist-2.3.5.gem"
    sha256 "e956947b6d358fcfacc5c9c5e716641d6f9c2a9517fff8cffac5550361142449"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-plugin-glossarist-0.2.3.gem"
    sha256 "14fd7437177ca4bd0c4f8cf28eb6acd635ed78fee92f047bf6a937f68046f34d"
  end

  resource "cldr" do
    url "https://rubygems.org/gems/cldr-plurals-runtime-rb-1.1.0.gem"
    sha256 "2353875af89be9fac049c60891e973825b24a979eeef7274093c9ff5fd56dfa9"
  end

  resource "camertron" do
    url "https://rubygems.org/gems/camertron-eprun-1.1.1.gem"
    sha256 "9a8e337916445e62648f6a4f35d229302fc44c50549cc881bff1e296ccf9ce4b"
  end

  resource "twitter_cldr" do
    url "https://rubygems.org/gems/twitter_cldr-6.14.0.gem"
    sha256 "5d18c23097008bcda542a260535766fdfc49d982d5eedf2486d19f368aa8c7a4"
  end

  resource "thread_safe" do
    url "https://rubygems.org/gems/thread_safe-0.3.6.gem"
    sha256 "9ed7072821b51c57e8d6b7011a8e282e25aeea3a4065eab326e43f66f063b05a"
  end

  resource "rouge" do
    url "https://rubygems.org/gems/rouge-4.5.1.gem"
    sha256 "2ac81c6dee7019bbc6600d4c2d641d730d65c165941400ebd924259067e690dd"
  end

  resource "roman" do
    url "https://rubygems.org/gems/roman-numerals-0.3.0.gem"
    sha256 "76f3d7c4b4da10e2352764d3b7d0da27af60eff1fd4c0b02d2415db82908ca24"
  end

  resource "tzinfo" do
    url "https://rubygems.org/gems/tzinfo-data-1.2025.2.gem"
    sha256 "a92375a1fbb47d38fe88fd514c40a38cc8f97d168da2a6479f15185e86470939"
  end

  resource "isodoc" do
    url "https://rubygems.org/gems/isodoc-i18n-1.3.2.gem"
    sha256 "80c4f545e4cd90cf7a6bb29f39539bddc733016ab820324ade3398ddf232c315"
  end

  resource "relaton" do
    url "https://rubygems.org/gems/relaton-render-0.9.1.gem"
    sha256 "011e8b0685020c579e3b3183c7d2bf7dc8519caee9119cc7ea79b6985c3aa71c"
  end

  resource "mn" do
    url "https://rubygems.org/gems/mn-requirements-0.5.1.gem"
    sha256 "6f7fcb48c82669ec25598fddb676cc9723eae386150f7587f1f43681398897d7"
  end

  resource "mn2pdf" do
    url "https://rubygems.org/gems/mn2pdf-2.20.gem"
    sha256 "acb64814e7b9aec309b3ee777724adb6d849a9665bb22dadde80def4b7974b74"
  end

  resource "image_size" do
    url "https://rubygems.org/gems/image_size-3.4.0.gem"
    sha256 "c6a580513fe74947e25e5d3f0aea1e33add6c20f7d0007efa65504317b7f029a"
  end

  resource "emf2svg" do
    url "https://rubygems.org/gems/emf2svg-1.4.3.gem"
    sha256 "ee549502d3a0863906fe0a0a241667ccc099544e664459c9e75adc4002ec7c51"
  end

  resource "vectory" do
    url "https://rubygems.org/gems/vectory-0.7.7.gem"
    sha256 "e1762ae649cf7715b895e81d1b39b485df0918f8a2d9439f8e6d2e0c8d8114d1"
  end

  resource "plane1converter" do
    url "https://rubygems.org/gems/plane1converter-0.0.1.gem"
    sha256 "86c5dd19ba46c013c0e1780499657702a21d75e05611275714db2dc3773703a9"
  end

  resource "html2doc" do
    url "https://rubygems.org/gems/html2doc-1.9.0.gem"
    sha256 "c0a846dca64c4c9e5748bfc65fca9633b47cfdf544147cf8a90a1453eebd3077"
  end

  resource "isodoc" do
    url "https://rubygems.org/gems/isodoc-3.1.4.gem"
    sha256 "72b352529d0f9e7ecd7d458427249dd0e303d1e1924cc6faa4da71a3564becfa"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-plugin-datastruct-0.3.1.gem"
    sha256 "c9faeee17f896664ee2ad0ef4246866323b31876325a8795cc1f8b4c3fc496f6"
  end

  resource "seven" do
    url "https://rubygems.org/gems/seven-zip-1.4.2.gem"
    sha256 "e7cf287a456bcc5453de9f7199e8c6f34d2dc3288f338121a3e87c5b34a6d281"
  end

  resource "ruby" do
    url "https://rubygems.org/gems/ruby-ole-1.2.13.1.gem"
    sha256 "578d10dd2a797a2b35a1286c6fb2c9525f67c24791346fc8015d39f0ffa3cb72"
  end

  resource "ffi" do
    url "https://rubygems.org/gems/ffi-compiler2-2.3.0.gem"
    sha256 "4d19aac3b98554ec1037fd36cd832c90049d6be9456e4dd3343611c65008271f"
  end

  resource "libmspack" do
    url "https://rubygems.org/gems/libmspack-0.11.0.gem"
    sha256 "6cbed96e956f427fae6cb126d46733f47cc50a3a5ae80ea96547de270be36055"
  end

  resource "ffi" do
    url "https://rubygems.org/gems/ffi-libarchive-1.1.14.gem"
    sha256 "a3e4ca9484ee4ad754ad04fcc14a12686d48d1463c264173d6f8ff0a4df816a6"
  end

  resource "arr" do
    url "https://rubygems.org/gems/arr-pm-0.0.12.gem"
    sha256 "fdff482f75239239201f4d667d93424412639aad0b3b0ad4d827e7c637e0ad39"
  end

  resource "excavate" do
    url "https://rubygems.org/gems/excavate-0.3.7.gem"
    sha256 "e5586b0be06fa4a968f94adf2307e9f7c4f9bea7a5bd738cea9a0a88da4d175b"
  end

  resource "plist" do
    url "https://rubygems.org/gems/plist-3.7.2.gem"
    sha256 "d37a4527cc1116064393df4b40e1dbbc94c65fa9ca2eec52edf9a13616718a42"
  end

  resource "ttfunk" do
    url "https://rubygems.org/gems/ttfunk-1.8.0.gem"
    sha256 "a7cbc7e489cc46e979dde04d34b5b9e4f5c8f1ee5fc6b1a7be39b829919d20ca"
  end

  resource "rchardet" do
    url "https://rubygems.org/gems/rchardet-1.9.0.gem"
    sha256 "26889486cdd83b378652baf7603f71d93e431bb11bc237b4cd8c65151af4a590"
  end

  resource "git" do
    url "https://rubygems.org/gems/git-1.19.1.gem"
    sha256 "b0a422d9f6517353c48a330d6114de4db9e0c82dbe7202964a1d9f1fbc827d70"
  end

  resource "sys" do
    url "https://rubygems.org/gems/sys-uname-1.3.1.gem"
    sha256 "b7b3eb817a9dd4a2f26a8b616a4f150ab1b79f4682d7538ceb992c8b7346f49c"
  end

  resource "json" do
    url "https://rubygems.org/gems/json-2.10.2.gem"
    sha256 "34e0eada93022b2a0a3345bb0b5efddb6e9ff5be7c48e409cfb54ff8a36a8b06"
  end

  resource "fuzzy_match" do
    url "https://rubygems.org/gems/fuzzy_match-2.1.0.gem"
    sha256 "e97e25d0eaee48a5f77ed970d007c7b6ff3c6a6858303fead2d1986859204dfc"
  end

  resource "extract_ttc" do
    url "https://rubygems.org/gems/extract_ttc-0.3.6-x86_64-darwin.gem"
    sha256 "6f3b2b982782adf7692f9adb473e282878f6145da47f622d2c1b896878308081"
  end

  resource "down" do
    url "https://rubygems.org/gems/down-5.4.2.gem"
    sha256 "516e5e01e7a96214a7e2cd155aac6f700593038ae6c857c0f4a05413b1c58acf"
  end

  resource "fontist" do
    url "https://rubygems.org/gems/fontist-1.21.2.gem"
    sha256 "13a4335b7fff805ab075338748cab2c6de51c0878532bdf5929ba4e9b40020d6"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-2.1.7.gem"
    sha256 "15eb648c79b2c5d810e5daf06a60f379b9a65e99ecad97ed47549cfd30f0895c"
  end

  resource "sqlite3" do
    url "https://rubygems.org/gems/sqlite3-1.7.3.gem"
    sha256 "fa77f63c709548f46d4e9b6bb45cda52aa3881aa12cc85991132758e8968701c"
  end

  resource "sequel" do
    url "https://rubygems.org/gems/sequel-5.91.0.gem"
    sha256 "2fb40258af4652ee834da32ea99fc8810fad0eaa203e4d6604b02c0afb89c64d"
  end

  resource "creek" do
    url "https://rubygems.org/gems/creek-2.6.3.gem"
    sha256 "337d9acbabc1a7890a33643fee7b62bd5ca739adbff94a4eb6fd63f7495ebd2c"
  end

  resource "iev" do
    url "https://rubygems.org/gems/iev-0.3.5.gem"
    sha256 "bd758960b2413392ab723ab2def6ca512fb08a0276a0eb479aeca8a674caaf07"
  end

  resource "crass" do
    url "https://rubygems.org/gems/crass-1.0.6.gem"
    sha256 "dc516022a56e7b3b156099abc81b6d2b08ea1ed12676ac7a5657617f012bd45d"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-standoc-3.0.6.gem"
    sha256 "6619b2133f555a3be6889e2a7cb1dc861d65164550b8661eff89e0c9b804fbdb"
  end

  resource "tokenizer" do
    url "https://rubygems.org/gems/tokenizer-0.3.0.gem"
    sha256 "f3fea578e7a2f9a9ae22de432ea1254e22ed1fc2e58e0ee670a0273582f51520"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-iso-3.0.4.gem"
    sha256 "d91c7c2b982f9a9242b0d69ca2211a6255c4f8024ede35d241f9b2bf340abb60"
  end

  resource "japanese_calendar" do
    url "https://rubygems.org/gems/japanese_calendar-0.4.2.gem"
    sha256 "4357d4232215f498f905204d503d0cf4b88999e3be589e5e4e1168ca27e6c11d"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-jis-0.5.4.gem"
    sha256 "24556897a47966949625a8fefff161e8c397560a773b11c5396c313ca1402dc3"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-plateau-1.0.2.gem"
    sha256 "f915c25242fc1dee96d3eb888c6683d82044c8ceaee9cd88aa1a32fa7dbd20c3"
  end

  resource "iso" do
    url "https://rubygems.org/gems/iso-639-0.3.8.gem"
    sha256 "48b8104a4b55367fda347609e36ef8eeb3a0b4d048b36365371c274958be7535"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-ogc-2.7.4.gem"
    sha256 "54201bfda332d09f38dc09bc6139b730037f17d84f123d01327875b455e1fd86"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-itu-2.6.4.gem"
    sha256 "b72f30e420643fc805c3e7aa4d8c442da222826c1903562ac8943ec8359a0c38"
  end

  resource "metanorma" do
    url "https://rubygems.org/gems/metanorma-generic-3.0.2.gem"
    sha256 "51aff2d0307c85e9a9c7df6c6af36b5b49b96e77fbdc63c0ba174315f74d7618"
  end

  resource "metanorma-iho" do
    url "https://rubygems.org/gems/metanorma-iho-1.1.4.gem"
    sha256 "04003c777d782a72a940a5802a28d533aae6f87d651d0893a08cb7f775f80f01"
  end

  resource "metanorma-ietf-data" do
    url "https://rubygems.org/gems/metanorma-ietf-data-0.2.0.gem"
    sha256 "3bae28b99b24212cc8b92dc3def3559dbeaf8868b319da8c21d42bda3f09bbf7"
  end

  resource "metanorma-ietf" do
    url "https://rubygems.org/gems/metanorma-ietf-3.5.4.gem"
    sha256 "a0eb5dfdf022f6e28202fdd0b654ac253f7bcf397ae1c35c772c9957a205798b"
  end

  resource "metanorma-ieee" do
    url "https://rubygems.org/gems/metanorma-ieee-1.4.4.gem"
    sha256 "9b6e90618ec18d70e3d866dfa77bc53a527d12fca6bc5c37eb8fee76df295251"
  end

  resource "metanorma-iec" do
    url "https://rubygems.org/gems/metanorma-iec-2.6.4.gem"
    sha256 "9586c6d21e4608d6c1cbcf33f774041f8e42ea929619906b7a5fc007527d9729"
  end

  resource "metanorma-csa" do
    url "https://rubygems.org/gems/metanorma-csa-2.6.4.gem"
    sha256 "8e4a6202ffd364843a70610f2646c7405ac2834cee969252880c32ea87d2f19d"
  end

  resource "metanorma-cc" do
    url "https://rubygems.org/gems/metanorma-cc-2.6.4.gem"
    sha256 "567ec6c9150da347799dc7c83886dacf7b1e11b5f1c40786133b04cdb2723a4a"
  end

  resource "metanorma-bipm" do
    url "https://rubygems.org/gems/metanorma-bipm-2.6.5.gem"
    sha256 "fea839398dd1efcbc7235a72dc748bb96a27db19ed1e0cd094544eddc05fea33"
  end

  def install
    ENV["GEM_HOME"] = libexec

    resources.each do |r|
      r.fetch
      args = ["--ignore-dependencies", "--no-document", "--install-dir", libexec]
      args += ["--platform=ruby", "--force"] if r.name == "pngcheck" or r.name == "sqlite3"
      system "gem", "install", r.cached_download, *args
      # system "gem", "install", r.cached_download, "--no-document", "--install-dir", libexec, "--ignore-dependencies"
    end

    system "gem", "install", cached_download, "--no-document", "--ignore-dependencies"
    #system "gem", "install", "pngcheck", "--no-document", "--platform=ruby", "--force"
    #system "gem", "install", "sqlite3", "--no-document", "--platform=ruby", "--force"

    bin.install Dir["#{libexec}/bin/metanorma"]
    bin.env_script_all_files(
      libexec/"bin",
      PATH:      [libexec/"bin", "$PATH"].join(":"),
      GEM_HOME:  ENV["GEM_HOME"],
      JAVA_HOME: Language::Java.java_home("1.8+"),
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
    test_doc = <<~ADOC
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
    ADOC

    (testpath / "test-iso.adoc").write(test_doc)
    system bin / "metanorma", "--type", "iso", testpath / "test-iso.adoc",
           "--agree-to-terms"
    assert_path_exists testpath / "test-iso.xml"
    assert_path_exists testpath / "test-iso.html"

    (testpath / "test-csa.adoc").write(test_doc)
    system bin / "metanorma", "--type", "csa", testpath / "test-csa.adoc",
           "--agree-to-terms"
    assert_path_exists testpath / "test-csa.pdf"
    assert_path_exists testpath / "test-csa.html"
  end
end
