require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.17.148769"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives/darwin/amd64/jotta-cli_0.17.148769_darwin_amd64.zip"
      sha256 "5fdd0b1b573a9b3de44cbddcc90529901e6559eb1bfb3e2f281f44b3c99c962c"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives/darwin/arm64/jotta-cli_0.17.148769_darwin_arm64.zip"
      sha256 "ab0377b5b3af8cf03c1cf41a35ad7edd5a1fd5c2dfcae21333d6e98d2c02be7c"
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
