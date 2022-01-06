require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.13.53591"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.13.53591_darwin_amd64.zip"
      sha256 "f3850df828e416195801cf85efbb7e66234cfdd9e343a44d2fc5c326e56e98b0"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives/darwin/arm64/jotta-cli_0.13.53591_darwin_arm64.zip"
      sha256 "bc4f4a1ff415ad71512886b0f8f5fcb7ff0c323b5a899f9394bbae0ac515770b"
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
