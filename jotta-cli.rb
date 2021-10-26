require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.12.50392"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.12.50392_darwin_amd64.zip"
      sha256 "4704038e1148c2eb06d5360b64ad3bed0aabc4ccb6d7e426fa2324eae1a90a07"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives/darwin/arm64/jotta-cli_0.12.50392_darwin_arm64.zip"
      sha256 "f1558e8c4099988f40ee606ddc9b398ed604c8d5ba453e6e7eca60b73b93126a"
  end
  
  conflicts_with "jotta-cli-unstable", :because => "jotta-cli-unstable is installed, brew uninstall jotta-cli-unstable before installing jotta-cli"

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
