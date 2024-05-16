require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.109708"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives-unstable/darwin/amd64/jotta-cli_0.15.109708_darwin_amd64.zip"
      sha256 "b890d0be6c283513990696839266cef2252ae09deec4c687d81fe792753a6a4c"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives-unstable/darwin/arm64/jotta-cli_0.15.109708_darwin_arm64.zip"
      sha256 "9da802aa3c479f0017672c1a0e29971626db7c58c3c394ded91b7165ee5ce837"
  end

  conflicts_with "jotta-cli", :because => "jotta-cli is installed, brew uninstall jotta-cli before installing jotta-cli-unstable"

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
