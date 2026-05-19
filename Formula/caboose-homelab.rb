class CabooseHomelab < Formula
  desc "Homelab SSO stack installer and service operator CLI"
  homepage "https://github.com/caboose-ai/caboose-ai.io"
  url "https://github.com/caboose-ai/caboose-ai.io/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "e6302f4fd3941285af20a44f5179712be19fa603d6e8a8824afe8bf95e2fa9c5"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-buildvcs=false", "-ldflags", "-s -w",
           "-o", bin/"homelab", "./cmd/homelab"
  end

  test do
    output = shell_output("#{bin}/homelab 2>&1", 1)
    assert_match "Usage: homelab <command> [flags]", output
    assert_match "Bootstrap the homelab SSO stack", output
  end
end
