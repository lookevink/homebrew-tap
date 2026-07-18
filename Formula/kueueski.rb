class Kueueski < Formula
  desc "A fast command-line client for BullMQ queues"
  homepage "https://github.com/lookevink/kueueski"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lookevink/kueueski/releases/download/v0.1.0/kueueski-aarch64-apple-darwin.tar.xz"
      sha256 "2a1cebd304988c2c65a50db1faede527730231573f37c1a41dad1c01ddc91567"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lookevink/kueueski/releases/download/v0.1.0/kueueski-x86_64-apple-darwin.tar.xz"
      sha256 "887cce4ca74495bde317157c9a6dad9fe937aa7913243683a7974a5819fe4a62"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/lookevink/kueueski/releases/download/v0.1.0/kueueski-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "308f928f9bd4abfa49b5f1000793655952c428cb640410050bfa917ff49b3c1e"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "kueueski" if OS.mac? && Hardware::CPU.arm?
    bin.install "kueueski" if OS.mac? && Hardware::CPU.intel?
    bin.install "kueueski" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
