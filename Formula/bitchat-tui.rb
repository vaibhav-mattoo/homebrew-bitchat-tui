# This is a Homebrew formula, a Ruby script that tells Homebrew
# how to install a piece of software.
class BitchatTui < Formula
  desc "Secure, anonymous, peer-to-peer Bluetooth chat with terminal UI"
  homepage "https://github.com/vaibhav-mattoo/bitchat-tui"
  url "https://github.com/vaibhav-mattoo/bitchat-tui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1005f2b8004f114c0a520e5c8e2b8519d1e56b461f36531535798939634e9e04"
  license "MIT"
  head "https://github.com/vaibhav-mattoo/bitchat-tui.git", branch: "main"

  # Build-time dependency on the Rust toolchain
  depends_on "rust" => :build

  # On macOS, the `btleplug` crate uses the native CoreBluetooth framework.
  # The `dbus` dependency is specific to Linux and not needed here.
  def install
    # Build and install the application using Cargo.
    # `std_cargo_args` provides standard arguments like `--release` and `--root`
    # to ensure the binary is compiled in release mode and installed correctly.
    system "cargo", "install", *std_cargo_args

    # Install shell completion files for a better user experience.
    bash_completion.install "contrib/completions/bitchat-tui.bash"
    zsh_completion.install "contrib/completions/_bitchat-tui"
    fish_completion.install "contrib/completions/bitchat-tui.fish"

    # Install documentation and license files.
    doc.install "README.md"
    prefix.install "LICENSE"
  end

end
