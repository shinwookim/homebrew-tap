# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://docs.brew.sh/rubydoc/Formula
class Cardo < Formula
  desc "Cardo is a podcast client for desktop, inspired by Android's Antennapod. Cardo can be synchonized with Antennapod and other apps using Nextcloud Gppoder, Gpodder/Opodsync, and goPodderq."
  homepage "https://cardo-podcast.github.io/"

  url "https://github.com/cardo-podcast/cardo"
  head "https://github.com/cardo-podcast/cardo.git", branch: "master"
  version "0.0.0"
  license "GPL-3.0"

  depends_on "node" => :build
  depends_on "pnpm" => :build
  depends_on "rust" => :build
  
  def install
    system "pnpm", "install"
    system "pnpm", "tauri", "build", "--bundles", "app", "--no-sign"
    app = Dir["src-tauri/target/release/bundle/macos/*.app"].first
    odie "Cardo.app not found" if app.nil?

    prefix.install app
    bin.write_exec_script "#{prefix}/#{File.basename(app)}/Contents/MacOS/cardo"
  end
end
