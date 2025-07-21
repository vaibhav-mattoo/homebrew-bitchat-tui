# This is a Homebrew formula, a Ruby script that tells Homebrew
# how to install a piece of software.
class BitchatTui < Formula
  desc "Secure, anonymous, peer-to-peer Bluetooth chat with terminal UI"
  homepage "https://github.com/vaibhav-mattoo/bitchat-tui"
  url "https://github.com/vaibhav-mattoo/bitchat-tui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "626860df233f337ab204de3d64b04fc03aaeccbf9e8d692d53445d24cf5d6bcd"
  license "MIT"
  head "https://github.com/vaibhav-mattoo/bitchat-tui.git", branch: "main"

  depends_on "rust" => :build

  def install
    # This part builds and installs the main binary.
    system "cargo", "install", *std_cargo_args

    # --- FIX ---
    # Only try to install completion files if the 'contrib' directory exists.
    # This makes the installation robust even if the release archive is missing them.
    if File.exist?("contrib")
      bash_completion.install "contrib/completions/bitchat-tui.bash"
      zsh_completion.install "contrib/completions/_bitchat-tui"
      fish_completion.install "contrib/completions/bitchat-tui.fish"
    end

    # Install documentation and license files.
    doc.install "README.md"
    prefix.install "LICENSE"
  end
end
