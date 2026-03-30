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

7. **Ask the user about their intent.** Before proceeding, use the `AskUserQuestion` tool to understand how they want the reference used. Present two options:

   - **Copy & adapt**: Replicate the reference's configuration as closely as possible, adapting it to fit the current project's stack, paths, and conventions. Best when the reference is from a similar project or represents the user's established workflow.
   - **Use as inspiration & go further**: Treat the reference as a starting point and source of ideas, but prioritize creating original skills and rules tailored to this project. Best when the reference is from a different kind of project or the user wants a fresh, comprehensive setup.

   The user's choice shapes Steps 4–6: "Copy & adapt" means the reference is the primary source and you fill gaps; "Use as inspiration" means the reference informs your thinking but the project analysis drives the output.

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

---

**The goal of this step is to produce a set of skills that are deeply tailored to THIS project — skills that genuinely improve the developer experience and that no generic template could provide.** The claude-init repository contains a handful of example skills for inspiration, but they are intentionally generic. Your job is to go far beyond them.

---

#### Step A: Study example skills for inspiration (not for copying)

The claude-init repository has a few generic example skills. Fetch them **in a single batch** to understand the general shape and quality bar of a good skill:

```bash
# Fetch the directory listing and all skill files in one pass
SKILLS=$(curl -fsSL https://api.github.com/repos/Flexonze/claude-init/contents/.claude/skills)
echo "$SKILLS" | grep -o '"name": "[^"]*"' | sed 's/"name": "//;s/"//' | while read skill; do
  echo "=== $skill ==="
  curl -fsSL "https://raw.githubusercontent.com/Flexonze/claude-init/main/.claude/skills/$skill/SKILL.md"
  echo -e "\n"
done
```

**How to use these examples:**

- Read them to understand structure, tone, and what a well-written SKILL.md looks like.
- Treat them as **inspiration, not a checklist**. Most of them are generic by design and may not be relevant to this project at all.
- If one happens to be directly useful (e.g., a git workflow skill for a project that uses git), adapt it substantially to fit this project's specific conventions, tooling, and directory structure. Never copy verbatim.
- If none are relevant, that's fine — skip them entirely and focus on creating original skills in Step C.

**Do not feel obligated to include any of these.** A skill that doesn't meaningfully help the developers of _this specific project_ is just clutter.

#### Step B: Apply reference configuration (if loaded)

If a reference configuration was loaded in Step 2, how you use it depends on the user's stated intent:

**If the user chose "Copy & adapt":**

1. Recreate each skill from the reference, adapting it to the current project (update commands, paths, stack-specific details, examples)
2. Preserve the reference's structure, naming, and workflow philosophy as closely as possible
3. Fill any obvious gaps — if the current project has capabilities the reference didn't cover, add skills for those too

**If the user chose "Use as inspiration & go further":**

1. Review each skill from the reference to understand the kinds of workflows the user values
2. Cherry-pick ideas that apply to this project, but rewrite them from scratch to fit this codebase
3. Use the reference as a springboard — let it inform your thinking in Step C, but don't feel bound by it
4. Prioritize creating original skills that address this project's specific needs over porting reference skills

#### Step C: Create original, project-specific skills

This is the most important step. The skills you create here should feel like they were hand-crafted by a senior developer who knows this codebase intimately.

**Think from the developer's perspective:** What tasks in this project are tedious, error-prone, multi-step, or require context that Claude could gather automatically? Those are your best skill candidates.

**Explore the full development lifecycle for opportunities:**

- **Coding**: What repetitive code patterns exist? Are there boilerplate-heavy areas (new API endpoints, new components, new modules) where Claude could scaffold correctly by reading existing examples?
- **Testing**: What testing workflows would benefit from intelligence? (e.g., "write tests for this module by studying how similar modules are tested in this project")
- **Code review**: Could Claude review code against this project's specific conventions? Prepare PR descriptions based on diff analysis?
- **Documentation**: Are there docs that fall out of sync with code? Could Claude regenerate or update them?
- **Debugging**: Are there common failure modes? Could Claude analyze logs or error traces using knowledge of the project's architecture?
- **Deployment**: Are there multi-step deployment processes documented in READMEs or scripts?
- **Database**: Migration generation, seed data creation, schema documentation?
- **Refactoring**: Are there known tech debt patterns that could be systematically addressed?
- **Dependency management**: Upgrade workflows, compatibility checks?
- **Environment setup**: Onboarding workflows for new developers?

**Mine the project itself for clues:**

- Read scripts in `package.json`, `Makefile`, `justfile`, `Taskfile`, or similar — complex multi-step scripts are prime skill candidates
- Check "how to" documentation, CONTRIBUTING.md, or wiki-style docs for manual processes
- Look at CI/CD pipelines — anything the CI does could often be a useful local skill
- Review PR templates or issue templates for recurring workflows
- Look at git history for repeated patterns (e.g., frequent similar commits)

**Include foundational skills, but push well beyond them.**

It's fine to create skills for common tasks like linting, testing, or building — since Claude can invoke skills autonomously, these become useful building blocks (e.g., Claude can run lint after a refactor without being asked). But these basics are table stakes, not the goal. The real value is in skills that go further.

**The best skills leverage Claude's intelligence by doing things like:**

- **Multi-step workflows**: Automate sequences of related actions with decision points
- **Contextual analysis**: Read and understand code/files before acting
- **Intelligent decisions**: Make judgment calls based on project context
- **Content generation**: Create meaningful output (diagrams, descriptions, reports)
- **Orchestration**: Coordinate multiple tools with branching logic
- **Knowledge synthesis**: Combine information from multiple parts of the codebase

**Ask yourself for each skill:** Does this teach Claude something about this project that it wouldn't know otherwise, or does it orchestrate a workflow that would be tedious to explain every time? If yes, it's a good skill.

**Quality over quantity, but don't hold back:** A well-configured project might have 5–15+ skills. Create as many as are genuinely useful — but every single one should pass the "would a developer actually use this?" test.

For each skill, create:

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
- **Code style**: Beyond what linters catch — architectural preferences, abstraction levels
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
