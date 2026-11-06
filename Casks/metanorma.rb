cask "metanorma" do
  version "1.17.0"
  sha256 "0dfbabe053c3680a05557f95de0d1337a4c21a0c440a35ade8a5e2fbdd80f15e"

  # The pkg lives at the newest packed-metanorma respin tag for this product
  # version: the plain v1.17.0 tag's pkg bundles a pre-era tebako CLI (2.8.22)
  # that cannot read the current payload registry (the detached seed dies at
  # "fetching registry tfs:github:tebako-packages/metanorma"). The v1.17.0-3
  # respin rebuilt the installer with tebako 2.8.68.
  url "https://github.com/metanorma/packed-metanorma/releases/download/v1.17.0-5/metanorma-setup-#{version}-macos-arm64.pkg"
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
