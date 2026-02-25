require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.17.159692"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives/darwin/amd64/jotta-cli_0.17.159692_darwin_amd64.zip"
      sha256 "3044f0fb38bb3ee38a15cce3245cde4d41347a6ee7d36f16405860e08b86b9cb"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives/darwin/arm64/jotta-cli_0.17.159692_darwin_arm64.zip"
      sha256 "3ffbe174a9b99e7c7910fc294598721b77aa67d015bfe27efc83ddb61e1bfa5d"
  end
  
  conflicts_with "jotta-cli-unstable", :because => "jotta-cli-unstable is installed, brew uninstall jotta-cli-unstable before installing jotta-cli"

  depends_on macos: :catalina
  
  def install
    bin.install 'jottad', 'jotta-cli'
  end

  service do
    run [bin/"jottad"]
    keep_alive true
  end

  test do
    system bin/"jotta-cli", "version"
  end
end
