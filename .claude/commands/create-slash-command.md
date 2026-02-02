---
argument-hint: [command-name] [description]
description: Create a new slash command
---

Create a new slash command in `.claude/commands/` based on the user's input.

## Instructions

1. **Check for arguments**: If no arguments are provided (i.e., `$ARGUMENTS` is empty), ask the user for the command name and description before continuing.

2. **Read the documentation**: Use WebFetch to read https://docs.claude.com/en/docs/claude-code/slash-commands to understand slash command structure, frontmatter options, and best practices.

3. **Parse user input**: Extract the command name (remove leading `/` if present) and the description of what the command should do.

4. **Create the command file**: Create `.claude/commands/<command-name>.md` with:

   - Appropriate frontmatter (if needed)
   - Clear, actionable instructions
   - Use `$1`, `$2` for arguments or `$ARGUMENTS` for all arguments
   - Follow best practices from the documentation

5. **Follow the project style**: Check existing commands in `.claude/commands/` to match the style and structure used in this project.

6. **Confirm creation**: Tell the user the command was created and how to invoke it.

## Key Points

- Use kebab-case for filenames (e.g., `my-command.md`)
- Keep instructions clear and focused
- Use frontmatter for `argument-hint` and `description` when relevant
- If the command generates artifacts (diagrams, reports, markdown files, etc.):
  - Output files should be saved to `.claude/outputs/` directory
  - Create the directory with a .gitkeep if it doesn't exist: `mkdir -p .claude/outputs && touch .claude/outputs/.gitkeep`
  - Use descriptive filenames (e.g., `<command-name>-<context>.png`)

