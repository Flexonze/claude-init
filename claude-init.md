---
description: Generate a customized .claude/ directory for your project
---

# Claude Init

Analyze the current project and generate a customized `.claude/` directory with relevant skills.

## Instructions

### 1. Check Project Readiness

Before generating the `.claude/` configuration, verify the project has enough context to work with.

**Check for:**

- A `README.md` or `README` file
- Source files in the directory
- Project manifest files (package.json, requirements.txt, Cargo.toml, go.mod, etc.)

**If the project appears empty or has no README:**

Inform the user that /claude-init works best with an existing project that has some documentation and suggest creating a `README.md` with minimal information like a project name, description, stack, etc. Don't continue to step 2.

**If a `.claude/` folder already exists:**

Note what's already configured (existing commands, skills, CLAUDE.md). Throughout the following steps, complement rather than duplicate or overwrite the existing setup. Don't replace an existing CLAUDE.md, don't recreate skills that already exist, etc.

> **Note on existing slash commands:** Some projects may have slash commands in `.claude/commands/`. These still work and don't need to be migrated. When creating new functionality, use skills instead.

**If the project has basic documentation:**

Continue to Step 2.

### 2. Understand the Current Project

Thoroughly explore the project to understand what it is and how it works:

- Read `README.md` and any documentation files
- Explore the directory structure
- Identify the tech stack, frameworks, and languages used
- Understand how the project is run (Docker, native commands, etc.)
- Note any patterns or conventions used (naming, file organization, imports, etc.)
- Understand the purpose of the project (web app, CLI tool, library, etc.)

Create a brief summary of your findings.

### 3. Create Skills

First, read the Claude skills documentation to understand how they work:
https://code.claude.com/docs/en/skills

Create the `.claude/skills/` directory if it doesn't exist.

#### Step A: Copy and adapt skills from claude-init repository

Fetch the list of available skills:

```bash
curl -fsSL https://api.github.com/repos/Flexonze/claude-init/contents/.claude/skills
```

For each skill directory, fetch its SKILL.md:

```bash
curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/.claude/skills/<skill-name>/SKILL.md
```

For each skill:

1. Read and understand what it does
2. Determine if it's relevant to this project
3. If relevant, adapt it to fit the project (update examples, adjust to match how the project is run)
4. Create the skill directory and write the adapted SKILL.md to `.claude/skills/<skill-name>/SKILL.md`

#### Step B: Create additional project-specific skills

Review the project's README and documentation for patterns that could work well as new skills.

**Look for things like:**

- Common development tasks
- Repetitive workflows
- Project-specific operations
- Build or compilation steps
- Deployment procedures
- Database migration processes
- Testing procedures
- Code generation steps
- Any documented "how to" that's specific to this project

**IMPORTANT: Avoid creating simple wrapper skills**

Do NOT create skills that just run a single shell command. For example:
- ❌ `/lint` that only runs `npm run lint`
- ❌ `/test` that only runs `npm test`
- ❌ `/build` that only runs `npm run build`

These add no value - the developer could just run the command directly.

**A valuable skill should leverage Claude's intelligence by doing at least one of:**

- **Multi-step workflows**: Automate sequences of related actions with decision points
- **Contextual analysis**: Read and understand code/files before acting
- **Intelligent decisions**: Make judgment calls based on project context
- **Content generation**: Create meaningful output (diagrams, descriptions, reports)
- **Orchestration**: Coordinate multiple tools with branching logic

**Good examples:**
- ✅ `/generate-pr-description` - analyzes git diff, identifies ticket numbers, formats according to conventions
- ✅ `/create-django-model` - 9-step workflow: creates model, migration, tests, factory, admin, runs tests
- ✅ `/refactor-component [name]` - analyzes component, identifies issues, suggests improvements, applies changes
- ✅ `/add-api-endpoint [resource]` - creates route, controller, tests, updates docs, validates against OpenAPI spec
- ✅ `/debug-test [test-name]` - runs test, analyzes failure, reads related code, suggests fix
- ✅ `/sync-translations` - runs the translation extraction command, then fills in missing keys matching existing tone/style

**Ask yourself:** Would running this skill through Claude provide more value than just running the shell command directly? If not, don't create it.

For each relevant pattern found, create a new skill using this format:

```
.claude/skills/<skill-name>/
└── SKILL.md
```

**SKILL.md format:**

```markdown
---
name: skill-name
description: Brief description of what this skill does and when to use it
argument-hint: [optional-args]
disable-model-invocation: true  # Add for action skills (deploy, generate, etc.)
# allowed-tools: Bash(git *)    # Add if skill needs specific tools
---

# Skill Name

Description of what the skill does.

## Instructions

Step-by-step guidance for Claude to perform this task.

1. First step
2. Second step
3. Third step

## Examples

- "Example prompt that would trigger this skill"
- "Another example usage"
```

**Skill type guidelines:**

- **Task skills** (actions with side effects like generating files, deploying, committing): Add `disable-model-invocation: true` so only the user can invoke them
- **Reference skills** (knowledge/conventions Claude applies automatically): Leave invocation enabled (default)

### 4. Create Outputs Directory

Create the `.claude/outputs/` directory with a `.gitkeep` file to track it in git while keeping it empty:

```bash
mkdir -p .claude/outputs && touch .claude/outputs/.gitkeep
```

This folder is used by skills that generate artifacts (diagrams, reports, etc.).

### 5. Create Rules

Create the `.claude/rules/` directory with a `.gitkeep` file:

```bash
mkdir -p .claude/rules && touch .claude/rules/.gitkeep
```

Analyze the codebase for patterns that would make good rules. Rules are project-specific guidelines that Claude should follow when working on this codebase.

**Look for patterns like:**

- Naming conventions (files, variables, functions, classes)
- Import ordering and organization
- Error handling patterns
- Testing conventions and patterns
- Code style preferences
- Architecture patterns (where to put certain types of code)
- API design patterns
- Documentation conventions

**For each significant pattern found:**

1. Create a rule file in `.claude/rules/` with a descriptive name (e.g., `naming-conventions.md`, `error-handling.md`)
2. Document the pattern clearly with examples from the codebase
3. Explain when and how to apply the pattern

**Rule file format:**

```markdown
# Rule Name

Brief description of the rule.

## Pattern

Describe the pattern or convention.

## Examples

Show examples from the codebase demonstrating the pattern.

## When to Apply

Explain when this rule should be followed.
```

**Guidelines for creating rules:**

- Only create rules for patterns that are consistently applied in the codebase
- Focus on patterns that would be non-obvious to someone new to the project
- Keep rules concise and actionable
- Include real examples from the codebase when possible

### 6. Create CLAUDE.md

Fetch the CLAUDE.md template from the claude-init repository:

```bash
curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/.claude/CLAUDE.md
```

Using the project analysis from step 2, fill in the template:

- **Project name**: The name of the project
- **Project description**: Brief description of what the project does
- **Stack**: Languages, frameworks, databases, tools, etc.
- **Project structure**: A tree of key directories and their purpose
- **Development guidelines**: Conventions, patterns, and practices used in the project

Write the filled-in template in CLAUDE.md in the project root.

### 7. Report Results

Print a summary:

- What you detected about the project
- Which skills were created
- Which rules were created (if any)
- Note any existing slash commands found (no migration needed)
- Confirm `.claude/outputs/` directory was created
- Confirm `.claude/rules/` directory was created
- Confirm CLAUDE.md was created
