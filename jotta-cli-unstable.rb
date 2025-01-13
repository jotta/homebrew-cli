require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.16.126843"

  if Hardware::CPU.intel?
      url "https://repo.jotta.cloud/archives-unstable/darwin/amd64/jotta-cli_0.16.126843_darwin_amd64.zip"
      sha256 "621743ae9a20b33948976c08c51becdbb5866f11055a194438358e0ceba7cccb"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.cloud/archives-unstable/darwin/arm64/jotta-cli_0.16.126843_darwin_arm64.zip"
      sha256 "712873141e9a82b50446bf5daf6d7df92fd8938c1d170d5a284235a749706413"
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
