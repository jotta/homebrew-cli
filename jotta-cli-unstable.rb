require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
  version "0.9.41304"

  if Hardware::CPU.is_64_bit?
    url "https://repo.jotta.us/archives-unstable/darwin/amd64/jotta-cli_0.9.41304_darwin_amd64.zip"
    sha256 "e96b5a391337f3ce151f71fd9757ce374565443c7d36dba3a9e288d80fe9c325"
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
