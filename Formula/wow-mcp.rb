class WowMcp < Formula
  desc "MCP server for a local WoW install: addons, WTF config and SavedVariables"
  homepage "https://github.com/caboose-ai/wow-mcp"
  # The source repository is private, so it is fetched over git and the installing
  # machine's GitHub credentials apply (gh auth setup-git). Switch to the tarball
  # form with a sha256 if the repository goes public.
  url "https://github.com/caboose-ai/wow-mcp.git",
      tag:      "v0.1.2",
      revision: "3d982d552968867b05486a86d097ba4a2ad2587f"
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
