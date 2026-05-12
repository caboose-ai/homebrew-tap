class CabooseHomelab < Formula
  desc "Homelab SSO stack installer and service operator CLI"
  homepage "https://github.com/caboose-ai/caboose-ai.io"
  url "https://github.com/caboose-ai/caboose-ai.io/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "638233dc93365431c07edbb1728aa9cee2fbc489de733173f7ea25ab9aa4fd5c"
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
