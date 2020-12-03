require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
  version "0.8.36368"

  if Hardware::CPU.is_64_bit?
    url "https://repo.jotta.us/archives-unstable/darwin/amd64/jotta-cli_0.8.36368_darwin_amd64.zip"
    sha256 "fc9246067c32a32d34003126ab33cd43e44bdb51e3e67253d6bd4642005d06bb"
  end

  conflicts_with "jotta-cli", :because => "jotta-cli is installed, brew uninstall jotta-cli before installing jotta-cli-unstable"

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
