require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.17.158306"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives-unstable/darwin/amd64/jotta-cli_0.17.158306_darwin_amd64.zip"
      sha256 "b514e0b2d7305169edb0304bce07191c3ce261d8a7c91c4f3b03033ce8bd725e"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives-unstable/darwin/arm64/jotta-cli_0.17.158306_darwin_arm64.zip"
      sha256 "122a2329d608576d957490c20d64a449b4f4be217bbc123a6c64af6340896479"
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
