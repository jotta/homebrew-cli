require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
  version "0.5.14050"

  if Hardware::CPU.is_64_bit?
    url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.5.14050_darwin_amd64.zip"
    sha256 "04943e83a670244961b5831e45e38d1a750e14aafb11a214888376f05e172e6e"
  end

  depends_on :arch => :intel

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
