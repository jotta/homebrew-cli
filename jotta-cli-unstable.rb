require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.75985"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives-unstable/darwin/amd64/jotta-cli_0.15.75985_darwin_amd64.zip"
      sha256 "0b7cdb308450e2ddb952f5cd8de0bccac2578eca5def79b5dde699587e2d3802"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives-unstable/darwin/arm64/jotta-cli_0.15.75985_darwin_arm64.zip"
      sha256 "beb0b75cfb47845ac811768731a5529c1c875d59e3a60d8e909a6776831b7e72"
  end

  conflicts_with "jotta-cli", :because => "jotta-cli is installed, brew uninstall jotta-cli before installing jotta-cli-unstable"

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
