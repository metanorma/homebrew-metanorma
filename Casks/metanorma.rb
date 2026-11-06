cask "metanorma" do
  version "1.17.0"
  sha256 "a61d16ea12b59386e04b19241309f4def7148dfcc47995711b2189398112c0fb"

  # The pkg lives at the newest packed-metanorma respin tag for this product
  # version: the plain v1.17.0 tag's pkg bundles a pre-era tebako CLI (2.8.22)
  # that cannot read the current payload registry (the detached seed dies at
  # "fetching registry tfs:github:tebako-packages/metanorma"). The v1.17.0-3
  # respin rebuilt the installer with tebako 2.8.68.
  url "https://github.com/metanorma/packed-metanorma/releases/download/v1.17.0-6/metanorma-setup-#{version}-macos-arm64.pkg"
  name "Metanorma"
  desc "Publishing standards for tomorrow, today"
  homepage "https://www.metanorma.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  pkg "metanorma-setup-#{version}-macos-arm64.pkg"

  uninstall pkgutil: "org.metanorma.metanorma.pkg",
            delete:  [
              "/etc/paths.d/metanorma",
              "/opt/metanorma",
            ]

  # No zap stanza: ~/.tebako is the shared tebako store and may serve
  # other tebako-managed tools on the machine.
end
