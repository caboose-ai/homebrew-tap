class CabooseHomelabMcp < Formula
  desc "MCP server for homelab service operations"
  homepage "https://github.com/caboose-ai/caboose-ai.io"
  url "https://github.com/caboose-ai/caboose-ai.io/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "cabf7ce5452ad3711c64d3bb7564be4aa07044cbb3bc5972d293f6f75e790666"
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
