require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.109063"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives-unstable/darwin/amd64/jotta-cli_0.15.109063_darwin_amd64.zip"
      sha256 "0426d2b9ef554449969b36de0eaf5b8d47019eee6fe9e71d3b92618d26a8c6dc"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives-unstable/darwin/arm64/jotta-cli_0.15.109063_darwin_arm64.zip"
      sha256 "4db7adafbb6631985e453ced60caf1ed56751c164c3585314c6a1f88a855f22e"
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
