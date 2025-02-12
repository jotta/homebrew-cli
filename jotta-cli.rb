require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.16.129390"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives/darwin/amd64/jotta-cli_0.16.129390_darwin_amd64.zip"
      sha256 "762e15ef95fb0a2b475863efadc89c7109c4c2a1b5511eef873219cc712fd225"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives/darwin/arm64/jotta-cli_0.16.129390_darwin_arm64.zip"
      sha256 "c62ff37be66d45eff166048eedd4c92a0fd1a9ce44c333223946cecb5f8a4e89"
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
