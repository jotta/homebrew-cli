require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
  version "0.8.36055"

  if Hardware::CPU.is_64_bit?
    url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.8.36055_darwin_amd64.zip"
    sha256 "6b020207501643e55fd9200df224fa35fcd882f1373ad5922a7401f3e570f155"
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
