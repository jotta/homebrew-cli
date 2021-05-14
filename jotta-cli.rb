require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
  version "0.10.44059"

  if Hardware::CPU.is_64_bit?
    url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.10.44059_darwin_amd64.zip"
    sha256 "78a351961726606bbb729a866142cc66f07b6ca8a2695a44861b634d4147b4c2"
  end
  
  conflicts_with "jotta-cli-unstable", :because => "jotta-cli-unstable is installed, brew uninstall jotta-cli-unstable before installing jotta-cli"

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
