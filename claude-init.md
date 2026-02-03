---
description: Generate a customized .claude/ directory for your project
argument-hint: [reference-repository]
---

# Claude Init

Analyze the current project and generate a comprehensive `.claude/` directory with skills, rules, and configuration that genuinely improves the developer workflow.

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

### 2. Load Reference Configuration (Optional)

**If `$1` is provided:**

The reference argument can be:

- A URL to a git repository (GitHub, GitLab, Bitbucket, or any git hosting platform)
- A local file path to a project on the user's computer

**Instructions:**

1. Determine if the argument is a URL or a local path
2. If it's a URL:
   - Fetch or clone the repository contents
   - If the request fails (404, private repo, network error), inform the user: "Could not access the reference repository. Please provide a valid public repository URL or a local path."
   - Ask the user to provide a different reference or confirm they want to continue without one
   - Do not proceed until a valid reference is accessible or the user chooses to skip
3. If it's a local path:
   - Read the contents directly from the filesystem
   - If the path doesn't exist or is inaccessible, ask the user to provide a valid path or skip
4. Explore the reference's `.claude/` directory and `CLAUDE.md` (if they exist)
5. Read and understand:
   - CLAUDE.md structure, sections, and content style
   - Skills in `.claude/skills/` (read each SKILL.md to understand the user's preferred workflows)
   - Rules in `.claude/rules/`
   - Any other configuration patterns (hooks, agents, slash commands, etc.)
6. Keep these findings as "reference configuration" to inform the rest of the process

**If `$1` is not provided:**

Skip to Step 3.

### 3. Understand the Current Project

Thoroughly explore the project to understand what it is and how it works. Be comprehensive in your analysis:

**Core understanding:**

- Read `README.md` and any documentation files
- Explore the directory structure
- Identify the tech stack, frameworks, and languages used
- Understand how the project is run (Docker, native commands, etc.)
- Note any patterns or conventions used (naming, file organization, imports, etc.)
- Understand the purpose of the project (web app, CLI tool, library, etc.)

**Deep dive into patterns:**

- Analyze testing patterns: How are tests structured? What testing frameworks are used? Are there fixtures, factories, or mocks?
- Check CI/CD configuration: Look at `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, etc.
- Review linting/formatting: Check for `.eslintrc`, `.prettierrc`, `ruff.toml`, `.editorconfig`, etc.
- Analyze containerization: Look at `Dockerfile`, `docker-compose.yml`, Kubernetes configs
- Check for API patterns: REST endpoints, GraphQL schemas, OpenAPI specs
- Identify database patterns: ORM usage, migrations, seed data
- Look at authentication/authorization: Auth middleware, permission systems
- Analyze logging and error handling: How are errors structured? What logging library is used?
- Check environment configuration: `.env.example`, config files, environment-specific settings

Create a brief summary of your findings.

### 4. Create Skills

First, read the Claude skills documentation to understand how they work:
https://code.claude.com/docs/en/skills

Then, create the `.claude/skills/` directory if it doesn't exist.

#### Step A: Copy and adapt skills from /claude-init repository

The /claude-init repository provides a few example skills that are generic enough and provide a good base for this new skills folder. Fetch the list of available skills:

```bash
curl -fsSL https://api.github.com/repos/Flexonze/claude-init/contents/.claude/skills
```

For each skill directory, fetch its SKILL.md:

```bash
curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/.claude/skills/<skill-name>/SKILL.md
```

For each skill:

1. Read and understand what it does
2. Check if a similar skill already exists (from reference or existing setup) - avoid duplicates
3. Determine if it's relevant to this project
4. If relevant, adapt it to fit the project (update examples, adjust to match how the project is run, etc.)
5. Create the skill directory and write the adapted SKILL.md to `.claude/skills/<skill-name>/SKILL.md`

#### Step B: Import skills from reference configuration (if loaded)

If a reference configuration was loaded in Step 2:

1. For each skill from the reference, evaluate if it's applicable to the current project's tech stack
2. Adapt applicable skills to fit the current project (update commands, paths, examples)
3. Prioritize the user's preferred workflow patterns from their reference
4. Create the adapted skills in `.claude/skills/<skill-name>/SKILL.md`

#### Step C: Create additional project-specific skills

Be creative and thorough in identifying automation opportunities. The goal is to create a comprehensive set of skills that genuinely save developers time and effort.

**Think about the full development lifecycle:**

- Coding: What repetitive code patterns could be automated?
- Testing: What testing workflows would benefit from Claude's intelligence?
- Code review: How could Claude help review code or prepare PRs?
- Documentation: What documentation tasks could be streamlined?
- Debugging: How could Claude help diagnose and fix issues?
- Deployment: What deployment-related workflows exist?
- Database: Are there migration, seeding, or schema tasks?
- Refactoring: What common refactoring patterns exist in this codebase?
- Etc. Be creative!

**Look for project-specific opportunities:**

- Review the project's README and documentation for documented workflows
- Look at scripts in `package.json`, `Makefile`, or similar for complex multi-step processes
- Check for any "how to" documentation that describes manual processes
- Identify pain points that developers likely face repeatedly

**IMPORTANT: Avoid creating simple wrapper skills**

Do NOT create skills that just run a single shell command. For example:

- `/lint` that only runs `npm run lint`
- `/test` that only runs `npm test`
- `/build` that only runs `npm run build`

These add no value - the developer could just run the command directly.

**A valuable skill should leverage Claude's intelligence by doing at least one of:**

- **Multi-step workflows**: Automate sequences of related actions with decision points
- **Contextual analysis**: Read and understand code/files before acting
- **Intelligent decisions**: Make judgment calls based on project context
- **Content generation**: Create meaningful output (diagrams, descriptions, reports)
- **Orchestration**: Coordinate multiple tools with branching logic

**Ask yourself:** Would running this skill through Claude provide more value than just running the shell command directly? If not, don't create it.

**Aim for comprehensiveness:** Create a significant number of meaningful skills. A well-configured project might have 5-15+ skills that cover various aspects of the development workflow.

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
disable-model-invocation: true # Add for command-only skills (deploy, generate, etc.)
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

### 5. Create Outputs Directory

Create the `.claude/outputs/` directory with a `.gitkeep` file to track it in git while keeping it empty:

```bash
mkdir -p .claude/outputs && touch .claude/outputs/.gitkeep
```

This folder is used by skills that generate artifacts (diagrams, reports, etc.).

### 6. Create Rules

Create the `.claude/rules/` directory with a `.gitkeep` file:

```bash
mkdir -p .claude/rules && touch .claude/rules/.gitkeep
```

#### Import rules from reference configuration (if loaded)

If a reference configuration was loaded in Step 2:

1. Review each rule from the reference
2. Import and adapt rules that apply to this project
3. Merge with project-specific patterns discovered in Step 3

#### Analyze the codebase for patterns

Rules are project-specific guidelines that Claude should follow when working on this codebase. Be thorough in identifying patterns.

**Look for patterns in these areas:**

- **Code organization**: File/folder structure conventions, module boundaries
- **Naming conventions**: Files, variables, functions, classes, database tables
- **Import/export patterns**: Ordering, grouping, absolute vs relative paths
- **Error handling**: How errors are structured, logged, and propagated
- **Testing conventions**: Test file naming, structure, assertion styles, mocking patterns
- **Code style**: Beyond what linters catch - architectural preferences, abstraction levels
- **Git workflow**: Branch naming, commit message format, PR conventions
- **Security patterns**: Input validation, authentication checks, sensitive data handling
- **Performance guidelines**: Caching patterns, query optimization conventions
- **API design**: Endpoint naming, response formats, versioning
- **State management**: How state is organized and updated
- **Component/module structure**: Standard patterns for new components

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
- Aim to create multiple meaningful rules if the codebase has clear patterns

### 7. Create CLAUDE.md

Fetch the CLAUDE.md template from the claude-init repository:

```bash
curl -fsSL https://raw.githubusercontent.com/Flexonze/claude-init/main/.claude/CLAUDE.md
```

#### If a reference configuration was loaded:

Use the reference CLAUDE.md structure as inspiration. Incorporate relevant sections and formatting from the user's preferred style.

#### Fill in the template comprehensively:

Using the project analysis from Step 3, create a thorough CLAUDE.md that includes:

**Required sections:**

- **Project name**: The name of the project
- **Project description**: Brief description of what the project does
- **Stack**: Languages, frameworks, databases, tools, etc.
- **Project structure**: A tree of key directories and their purpose
- **Development guidelines**: Conventions, patterns, and practices used in the project

**Additional sections to include (if applicable):**

- **Testing strategy**: How to run tests, testing conventions, what frameworks are used
- **Environment setup**: Required environment variables, local setup steps, dependencies
- **Common tasks**: Quick reference for frequent operations (starting the server, running migrations, etc.)
- **Architecture overview**: Brief description of key architectural decisions and patterns
- **Key conventions**: Most important coding conventions at a glance
- **Troubleshooting**: Common issues and solutions (if discoverable from docs or config)

Write the filled-in CLAUDE.md in the project root.

### 8. Report Results

Print a clean, structured summary:

```
✓ Claude Code configuration complete!

---

Thanks for using /claude-init! Please consider giving it a ⭐ on GitHub:
https://github.com/Flexonze/claude-init

---

  Skills:        {count} created
  Rules:         {count} created
  CLAUDE.md:     ./CLAUDE.md
  Outputs:       ./.claude/outputs/
  {any other items created}

```
