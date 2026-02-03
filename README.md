<div align="center">
<br />
  <strong>Made with ❤️ and ☕ by <a href="https://github.com/Flexonze">Félix</a></strong><br /><br />

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/Made%20for-Claude%20Code-blueviolet)](https://code.claude.com)
[![GitHub stars](https://img.shields.io/github/stars/Flexonze/claude-init)](https://github.com/Flexonze/claude-init)

</div>

# /claude-init

Automatically generate Claude Code configs tailored for your project.

## Installation

### Mac / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/Flexonze/claude-init/main/install.ps1 | iex
```

## Usage

In your project directory:

```bash
claude /claude-init
```

Or, if you don't want to approve each step:

```bash
claude --dangerously-skip-permissions /claude-init
```

This will analyze your project and generate a `.claude/` directory with a [CLAUDE.md](https://docs.anthropic.com/en/docs/claude-code/memory#claudemd), some [skills](https://docs.anthropic.com/en/docs/claude-code/skills), [rules](https://docs.anthropic.com/en/docs/claude-code/memory#rules), etc.

### Optionally, use a reference repository

If you provide a reference repository, relevant Claude Code config files (skills, rules, CLAUDE.md, etc.) will be read and adapted to generate your project’s config. This is especially useful if you have your own workflows, custom skills, or coding conventions that you want to carry across projects.

```bash
claude /claude-init https://github.com/your-username/your-repo
# or: claude /claude-init ~/path/to/your/project
```

For example, you could provide [my personal collection of Claude Code configs](https://github.com/Flexonze/.claude) as reference.

```bash
claude /claude-init https://github.com/Flexonze/.claude
```

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

## License

[MIT](LICENSE)

## How does it work?

Magic.
