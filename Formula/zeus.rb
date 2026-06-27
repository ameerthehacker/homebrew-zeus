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
  version "0.0.13-alpha"
  license "MIT"

  on_macos do
    # ARM64 (Apple Silicon) - primary build
    on_arm do
      url "https://github.com/ameerthehacker/zeus/releases/download/v#{version}/zeus-#{version}-darwin-arm64.tar.gz"
      sha256 "fb792712961c9bebd3b704a0dd4ef4f6cab31e541b4582ae0401421dc2b0a3c3"
    end

    # Intel Macs - uses ARM64 binary via Rosetta 2
    on_intel do
      url "https://github.com/ameerthehacker/zeus/releases/download/v#{version}/zeus-#{version}-darwin-arm64.tar.gz"
      sha256 "fb792712961c9bebd3b704a0dd4ef4f6cab31e541b4582ae0401421dc2b0a3c3"
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

      The Zeus compiler can now find its runtime and standard library automatically.
      No additional configuration is needed.

      To compile a Zeus program:
        zeus build your_program.zs -o your_program

      To run it:
        ./your_program
    EOS
  end

  test do
    # Create a simple test program
    (testpath/"hello.zs").write <<~EOS
      fn main() {
        print("Hello, World!")
      }
    EOS

    # Test that the compiler can compile a simple program
    system "#{bin}/zeus", "build", "hello.zs", "-o", "hello"
  end
end

