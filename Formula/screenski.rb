class Screenski < Formula
  desc "4K HiDPI virtual display for recording, plus DDC brightness control"
  homepage "https://github.com/lookevink/screenski"
  url "https://github.com/lookevink/screenski/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "9263204db02256337893783baa76953838b76ec3e09aac9b040b0b243f5bb84d"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release"
    bin.install ".build/release/screenski"
  end

  test do
    assert_match "usage: screenski", shell_output("#{bin}/screenski --help")
  end
end
