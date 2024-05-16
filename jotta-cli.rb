require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.109709"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives/darwin/amd64/jotta-cli_0.15.109709_darwin_amd64.zip"
      sha256 "34224b055877d32fcdbbf32e8a0fa2716b2082f63fc933a6a51fc80ce8a2a5ff"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives/darwin/arm64/jotta-cli_0.15.109709_darwin_arm64.zip"
      sha256 "57eae4f9f2e853ffe8d6684c943222acaceb5b21eaac0bebbcfd11ed843d7a8f"
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
