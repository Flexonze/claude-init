<div align="center">
<br />
  <strong>Made with ❤️ and ☕ by <a href="https://github.com/Flexonze">Félix</a></strong><br /><br />

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/Made%20for-Claude%20Code-blueviolet)](https://code.claude.com)
[![GitHub stars](https://img.shields.io/github/stars/Flexonze/claude-init)](https://github.com/Flexonze/claude-init)

</div>

# /claude-init

Automatically generate a `.claude/` directory tailored for your project.

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

This will analyze your project and generate a tailored `.claude/` directory with [custom slash commands](https://code.claude.com/docs/en/slash-commands#custom-slash-commands), [CLAUDE.md](https://www.claude.com/blog/using-claude-md-files), and [skills](https://code.claude.com/docs/en/skills#agent-skills).

## Use a reference repository

Optionally, provide a reference repository (URL or path) when generating the config:

```bash
claude /claude-init https://github.com/your-username/your-repo
# or: claude /claude-init ~/path/to/your/project
```

The reference's skills, rules, CLAUDE.md, and other config files will be explored and used as inspiration when generating your config.

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
