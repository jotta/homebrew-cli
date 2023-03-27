require 'formula'

class JottaCli < Formula
  desc "Jottacloud CLI"
  homepage "https://www.jottacloud.com/"
    version "0.15.78571"

  if Hardware::CPU.intel?
      url "https://repo.jotta.us/archives/darwin/amd64/jotta-cli_0.15.78571_darwin_amd64.zip"
      sha256 "e3365dbcff59a741506fcb1851aceb03244617a1eb75adf41b256d4020a6a5fd"
  elsif Hardware::CPU.arm?
      url "https://repo.jotta.us/archives/darwin/arm64/jotta-cli_0.15.78571_darwin_arm64.zip"
      sha256 "93990d054050f7e287322ef5a4b33b59af04d006162332c9f7af980ae9b8bad1"
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
