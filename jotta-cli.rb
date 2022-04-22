require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.14.58899"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.14.58899_darwin_amd64.zip"
      sha256 "ac38d9dfa5221c1656d6c4563abba7d7dbb2b269f10858484f31fad760bbddc6"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives/darwin/arm64/jotta-cli_0.14.58899_darwin_arm64.zip"
      sha256 "9a9cb9dc8571164f8ce191976a8a468b0fe3902607e101b3a0d2db0b6b3e422c"
  end
  
  conflicts_with "jotta-cli-unstable", :because => "jotta-cli-unstable is installed, brew uninstall jotta-cli-unstable before installing jotta-cli"

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
