require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.13.56548"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives-unstable/darwin/amd64/jotta-cli_0.13.56548_darwin_amd64.zip"
      sha256 "2b71ab2f2ca19608139a3bae28a3341c443ac7da72682dc2bfe991f07e00a001"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives-unstable/darwin/arm64/jotta-cli_0.13.56548_darwin_arm64.zip"
      sha256 "5347283ed7efcc39656c9f7ead8bc94560e114343e9f2e41a1f3a64859a0a861"
  end

  conflicts_with "jotta-cli", :because => "jotta-cli is installed, brew uninstall jotta-cli before installing jotta-cli-unstable"

  depends_on macos: :sierra

  def install
    bin.install 'jottad', 'jotta-cli'
  end

  plist_options :manual => "jottad"

  def plist; <<-EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/jottad</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
      </dict>
    </plist>
    EOS
  end

  test do
    system bin/"jotta-cli", "version"
  end
end
