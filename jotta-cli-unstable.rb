require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
  version "0.11.45727"

  if Hardware::CPU.intel?
    url "https://repo.jotta.us/archives-unstable/darwin/amd64/jotta-cli_0.11.45727_darwin_amd64.zip"
    sha256 "34b41d7a4f12304b07da7a4c9a3e1e284f332a8914bff4e02329b42e567794d2"
  elsif Hardware::CPU.arm?
    url "https://repo.jotta.us/archives-unstable/darwin/arm64/jotta-cli_0.11.45727_darwin_arm64.zip"
    sha256 ""
  end

  conflicts_with "jotta-cli", :because => "jotta-cli is installed, brew uninstall jotta-cli before installing jotta-cli-unstable"

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
