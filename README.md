# Caboose AI Homebrew Tap

```bash
brew tap caboose-ai/tap
brew install caboose-homelab
brew install caboose-homelab-mcp
brew install wow-mcp
```

Formulae are built from tagged releases of
[`caboose-ai/caboose-ai.io`](https://github.com/caboose-ai/caboose-ai.io) and
[`caboose-ai/wow-mcp`](https://github.com/caboose-ai/wow-mcp). `wow-mcp` is a
private repository: the formula clones it over git, so the installing machine
needs GitHub credentials for git (`gh auth login` then `gh auth setup-git`).
