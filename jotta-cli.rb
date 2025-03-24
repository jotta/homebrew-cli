require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.17.132497"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives/darwin/amd64/jotta-cli_0.17.132497_darwin_amd64.zip"
      sha256 "9b4a12f9b0af56b6f0fb8b584b766d5e8e9abaa756955e96af9476cf9846356a"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives/darwin/arm64/jotta-cli_0.17.132497_darwin_arm64.zip"
      sha256 "c2f7aadc1a4a95ba9cf8a0568f56a08bcdbbc7d8d1ed63ba071ef0f82f94d7b2"
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
