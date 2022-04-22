require 'formula'

class JottaCliUnstable < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.14.58906"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives-unstable/darwin/amd64/jotta-cli_0.14.58906_darwin_amd64.zip"
      sha256 "803720ec529c80dec0a09368b75780df44e0b853bd72733232221dd728944835"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives-unstable/darwin/arm64/jotta-cli_0.14.58906_darwin_arm64.zip"
      sha256 "7898545518768a09f9d7aa246a2952df75e7a444202c2cbbc979cb18c39b6704"
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
