require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.17.159684"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives-unstable/darwin/amd64/jotta-cli_0.17.159684_darwin_amd64.zip"
      sha256 "5aefafa0d880a905fdc8b0ac198e1dcbd67b0aa56cb1d3f1b2f93b2e1c5ad837"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives-unstable/darwin/arm64/jotta-cli_0.17.159684_darwin_arm64.zip"
      sha256 "ad5df90193a408b2d5e30b54e8e578cbe7530241be6244e157a12cffbfddb6a0"
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
