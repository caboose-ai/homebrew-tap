class CabooseHomelabMcp < Formula
  desc "MCP server for homelab service operations"
  homepage "https://github.com/caboose-ai/caboose-ai.io"
  url "https://github.com/caboose-ai/caboose-ai.io/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "382bd9661ed493a760c1579a5ed139d91e420409d395dda2427e3f9bdd7dac23"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-buildvcs=false", "-ldflags", "-s -w",
           "-o", bin/"homelab-mcp", "./cmd/mcp"
  end

  test do
    output = shell_output("#{bin}/homelab-mcp -help 2>&1")
    assert_match "Path to homelab.yml config file", output
    assert_match "Listen address for HTTP mode", output
  end
end
