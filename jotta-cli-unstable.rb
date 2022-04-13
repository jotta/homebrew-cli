require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.14.58487"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives-unstable/darwin/amd64/jotta-cli_0.14.58487_darwin_amd64.zip"
      sha256 "88b370f627cb3ccd52bdd57aa9d7060dee5eed1f37f0e2e32d4ea12dc5713626"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives-unstable/darwin/arm64/jotta-cli_0.14.58487_darwin_arm64.zip"
      sha256 "7dabd39470a52faeb5807c9d783e07f2def658b56b08eb68dddf0a4dac251f4f"
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
