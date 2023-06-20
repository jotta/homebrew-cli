require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.84961"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.15.84961_darwin_amd64.zip"
      sha256 "bf444e7b2609cac0b1e58860a6601155d607b2f1902de84d11cd1d57bdfb4872"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives/darwin/arm64/jotta-cli_0.15.84961_darwin_arm64.zip"
      sha256 "3f32562caa510e83d753bf174dfbbd2343e886b03a772131a598097d1981d1a0"
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
