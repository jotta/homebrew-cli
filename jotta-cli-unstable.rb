require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.93224"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives-unstable/darwin/amd64/jotta-cli_0.15.93224_darwin_amd64.zip"
      sha256 "1cfd06bcb814c3a576f8bf5f8072e65e253ff9d1dc41e65e1fd9a4fc9a83cb02"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives-unstable/darwin/arm64/jotta-cli_0.15.93224_darwin_arm64.zip"
      sha256 "9246272a142259369307c9a6075898bd3520f7469e10c68388737d4ce99a6a3f"
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
