<div align="center">
<br />
  <strong>Made with ❤️ and ☕ by <a href="https://github.com/Flexonze">Félix</a></strong><br /><br />

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Made for Claude Code](https://img.shields.io/badge/Made%20for-Claude%20Code-blueviolet)](https://code.claude.com)
[![GitHub forks](https://img.shields.io/github/forks/Flexonze/claude-init)](https://github.com/Flexonze/claude-init/fork)

</div>

# /claude-init

Automatically generate a `.claude/` directory tailored for your project.

## Usage

Install the `/claude-init` command (first time only, Mac/Linux):

```bash
mkdir -p ~/.claude/commands && curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/claude-init.md -o ~/.claude/commands/claude-init.md
```

In your project directory:

```bash
claude /claude-init
```

Or, if you like living on the edge (not recommended):

```bash
claude --dangerously-skip-permissions /claude-init
```

This will analyze your project and generate a tailored `.claude/` directory with [custom slash commands](https://code.claude.com/docs/en/slash-commands#custom-slash-commands), [CLAUDE.md](https://www.claude.com/blog/using-claude-md-files), and [skills](https://code.claude.com/docs/en/skills#agent-skills).

## Note

The commands and skills in this repo are opinionated and fit my own workflow. While `/claude-init` tries to adapt them to any project, feel free to [fork this project](https://github.com/Flexonze/claude-init/fork) and make it your own.

## License

[MIT](LICENSE)

## How does it work?

Magic.
