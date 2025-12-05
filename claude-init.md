---
description: Generate a customized .claude/ directory for your project
---

# Claude Init

Analyze the current project and generate a customized `.claude/` directory with relevant slash commands.

## Instructions

### 1. Understand the Current Project

Thoroughly explore the project to understand what it is and how it works:

- Read `README.md` and any documentation files
- Explore the directory structure
- Identify the tech stack, frameworks, and languages used
- Understand how the project is run (Docker, native commands, etc.)
- Note any patterns or conventions used (naming, file organization, imports, etc.)
- Understand the purpose of the project (web app, CLI tool, library, etc.)

Create a brief summary of your findings.

### 2. Create Custom Slash Commands

First, read the Claude slash commands documentation to understand how they work:
https://code.claude.com/docs/en/slash-commands

Create the `.claude/commands/` directory if it doesn't exist.

#### Step A: Copy and adapt commands from claude-init repository

Fetch the list of available commands:

```bash
curl -fsSL https://api.github.com/repos/Flexonze/claude-init/contents/.claude/commands
```

For each `.md` file, fetch its raw content:

```bash
curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/.claude/commands/<filename>
```

For each command:
1. Read and understand what it does
2. Determine if it's relevant (framework-specific commands only if the project uses that framework)
3. If relevant, adapt it to fit the project (update examples, adjust commands to match how the project is run)
4. Write the adapted command to `.claude/commands/<command-name>.md`

#### Step B: Create additional project-specific commands

Review the project's README and documentation for patterns that could work well as new slash commands.

**Look for things like:**
- Common development tasks
- Repetitive workflows
- Project-specific operations
- etc.

For each relevant pattern found, create a new custom command using this format:

```markdown
---
argument-hint: [optional-args]
description: Brief description of what this command does
---

# Command Name

Description of what the command does.

## Instructions

Step-by-step guidance for Claude to perform this task.
```

### 3. Create Skills

First, read the Claude skills documentation to understand how they work:
https://code.claude.com/docs/en/skills

Skills teach Claude project-specific workflows. Create the `.claude/skills/` directory if skills are needed.

#### Step A: Copy and adapt skills from claude-init repository

Fetch the list of available skills:

```bash
curl -fsSL https://api.github.com/repos/Flexonze/claude-init/contents/.claude/skills
```

For each `.md` file, fetch its raw content:

```bash
curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/.claude/skills/<filename>
```

For each skill:
1. Read and understand what it does
2. Determine if it's relevant to this project
3. If relevant, adapt it to fit the project
4. Write the adapted skill to `.claude/skills/<skill-name>.md`

#### Step B: Create additional project-specific skills

Review the project's README and documentation for workflows that could become skills.

**Look for things like:**

- Build or compilation steps
- Deployment procedures
- Translation/localization workflows
- Database migration processes
- Testing procedures
- Code generation steps
- Any documented "how to" that's specific to this project
- etc.

For each relevant workflow found, create a new skill using this format:

```markdown
---
name: skill-name
description: Brief description of what this Skill does and when to use it
---

# Skill Name

## Instructions

Step-by-step guidance for Claude to perform this task.

## Examples

Concrete examples of using this skill.
```

### 4. Create CLAUDE.md

Fetch the CLAUDE.md template from the claude-init repository:

```bash
curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/.claude/CLAUDE.md
```

Using the project analysis from step 1, fill in the template:

- **Project name**: The name of the project
- **Project description**: Brief description of what the project does
- **Stack**: Languages, frameworks, databases, tools, etc.
- **Project structure**: A tree of key directories and their purpose
- **Development guidelines**: Conventions, patterns, and practices used in the project

Write the filled-in template to `.claude/CLAUDE.md`

### 5. Report Results

Print a summary:

- What you detected about the project
- Which commands were created
- Which skills were created
- Confirm CLAUDE.md was created
