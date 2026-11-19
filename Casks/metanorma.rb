cask "metanorma" do
  version "1.18.6"
  sha256 "58c6780b34b22475e02381d9fa4f2308a4c53e546e01a35a45e0afc06b4ecfda"

  # The pkg comes from the packed-metanorma v1.18.6 release.
  url "https://github.com/metanorma/packed-metanorma/releases/download/v1.18.6-3/metanorma-setup-#{version}-macos-arm64.pkg"
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
