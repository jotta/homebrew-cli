require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
  version "0.6.21799"

  if Hardware::CPU.is_64_bit?
    url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.6.21799_darwin_amd64.zip"
    sha256 "9a26d1f56e75d174740ffd8a0be5eac90bb779116f276f1c60d535312a928efb"
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
