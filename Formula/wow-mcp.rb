class WowMcp < Formula
  desc "MCP server for a local WoW install: addons, WTF config and SavedVariables"
  homepage "https://github.com/caboose-ai/wow-mcp"
  url "https://github.com/caboose-ai/wow-mcp/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "9f233baaf26807004fa53bc408359ecf0f05f4e45cce97b02360219fe4a6786d"
  license "MIT"
  head "https://github.com/caboose-ai/wow-mcp.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-buildvcs=false",
           "-ldflags", "-s -w -X main.version=v#{version}",
           "-o", bin/"wow-mcp", "./cmd/wow-mcp"
  end

  def caveats
    <<~EOS
      Register with Claude Code for every project (flavor: retail, classic, classic_era, forever):
        claude mcp add -s user wow-local #{opt_bin}/wow-mcp -e WOW_DEFAULT_FLAVOR=retail
      The install is auto-detected; set WOW_ROOT when it lives somewhere unusual.
      Check what the server sees with: wow-mcp inspect
    EOS
  end

  test do
    assert_match "wow-mcp v#{version}", shell_output("#{bin}/wow-mcp version")
    (testpath/"root/_retail_/Interface/AddOns").mkpath
    (testpath/"root/_retail_/WTF").mkpath
    output = shell_output("#{bin}/wow-mcp -root #{testpath}/root inspect")
    assert_match "\"name\": \"retail\"", output
  end
end
