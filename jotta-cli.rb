require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.107955"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives/darwin/amd64/jotta-cli_0.15.107955_darwin_amd64.zip"
      sha256 "96c6d863f02bc474df0ab3272ac347d644cb65c2d18037bdcbce07260982392d"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives/darwin/arm64/jotta-cli_0.15.107955_darwin_arm64.zip"
      sha256 "22432f871ffcb61de0f172922fde454954ff19c6cc0e774f12f72d28a2772326"
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
