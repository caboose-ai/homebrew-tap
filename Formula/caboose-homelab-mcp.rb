class CabooseHomelabMcp < Formula
  desc "MCP server for homelab service operations"
  homepage "https://github.com/caboose-ai/caboose-ai.io"
  url "https://github.com/caboose-ai/caboose-ai.io/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "469055e752960ffc738f00dbb909bdc3ab7b48bf2a51aeea40a742a1d2206fbf"
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
