class CabooseHomelab < Formula
  desc "Homelab SSO stack installer and service operator CLI"
  homepage "https://github.com/caboose-ai/caboose-ai.io"
  url "https://github.com/caboose-ai/caboose-ai.io/archive/refs/tags/v0.9.2.tar.gz"
  sha256 "0066a54ed74a8074c104bdf0549e5cc935efc1b7fa51b7b43ad4eab6cdab4c07"
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
