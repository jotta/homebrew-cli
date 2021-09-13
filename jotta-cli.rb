require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
  version "0.11.44593"

  if Hardware::CPU.intel?
    url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.11.44593_darwin_amd64.zip"
    sha256 "9457d3f36d826074cc5bdf2848a7b70bf6aae8d272ac1c75589a8f0ef4e4753c"
  elsif Hardware::CPU.arm?
    url "https://repo.jotta.us/archives/darwin/arm64/jotta-cli_0.11.44593_darwin_arm64.zip"
    sha256 ""
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
