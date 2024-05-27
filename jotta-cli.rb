require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.110283"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives/darwin/amd64/jotta-cli_0.15.110283_darwin_amd64.zip"
      sha256 "9e2d2acfc0f41bd2f0f7a14193b5fef31f6ab6e19a044bee9ca976a9672dc76f"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives/darwin/arm64/jotta-cli_0.15.110283_darwin_arm64.zip"
      sha256 "cc66392e13f57d0ebcf08410673e0e9ca241c91b4e39c961d43f5fbb92786010"
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
