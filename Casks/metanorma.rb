cask "metanorma" do
  version "1.17.0"
  sha256 "01d7ba7c16a8f37b47788b5712ddd5225e51310e6eb71a0dfba2b6d4a57e3cb5"

  url "https://github.com/metanorma/packed-metanorma/releases/download/v#{version}/metanorma-setup-#{version}-macos-arm64.pkg"
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
