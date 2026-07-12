# Zeus Programming Language Homebrew Formula
#
# This formula is automatically updated by the release workflow.
#
# Installation:
#   brew tap ameerthehacker/zeus https://github.com/ameerthehacker/zeus
#   brew install zeus
#
# Note: Currently only ARM64 (Apple Silicon) builds are available.
# Intel Macs can run the ARM64 binary via Rosetta 2.

class Zeus < Formula
  desc "Zeus programming language compiler"
  homepage "https://github.com/ameerthehacker/zeus"
  version "0.0.23-alpha"
  license "MIT"

  on_macos do
    # ARM64 (Apple Silicon) - primary build
    on_arm do
      url "https://github.com/ameerthehacker/zeus/releases/download/v#{version}/zeus-#{version}-darwin-arm64.tar.gz"
      sha256 "2b0856283ac9ff745a5df89f8eea7f7bd9acef5cf16f1e7bb595640f201a9859"
    end

    # Intel Macs - uses ARM64 binary via Rosetta 2
    on_intel do
      url "https://github.com/ameerthehacker/zeus/releases/download/v#{version}/zeus-#{version}-darwin-arm64.tar.gz"
      sha256 "2b0856283ac9ff745a5df89f8eea7f7bd9acef5cf16f1e7bb595640f201a9859"
    end
  end

  def install
    bin.install "bin/zeus"
    (prefix/"runtime/zig-out").install Dir["runtime/zig-out/*"]
    (prefix/"lib").install Dir["lib/*"]
    (prefix/"third_party/bdwgc/lib").install Dir["third_party/bdwgc/lib/*"]
  end

  def caveats
    <<~EOS
      Zeus has been installed successfully!

      To run a Zeus program:
        zeus run main.zs
    EOS
  end

  test do
    # Create a simple test program
    (testpath/"hello.zs").write <<~EOS
      console.log("Hello, World!")
    EOS

    system "#{bin}/zeus", "build", "hello.zs", "-o", "hello"
    assert_equal "Hello, World!\n", shell_output("./hello")
  end
end

