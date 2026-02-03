# Skills Reference

## Frontmatter Options

All fields are optional. Only `description` is recommended.

| Field                      | Description                                                                                     |
| :------------------------- | :---------------------------------------------------------------------------------------------- |
| `name`                     | Display name (defaults to directory name). Lowercase, numbers, hyphens only (max 64 chars).     |
| `description`              | What the skill does and when to use it. Claude uses this to decide when to auto-invoke.         |
| `argument-hint`            | Hint for autocomplete. Example: `[issue-number]` or `[filename] [format]`.                      |
| `disable-model-invocation` | Set `true` to prevent Claude from auto-invoking. Use for actions with side effects.             |
| `user-invocable`           | Set `false` to hide from `/` menu. Use for background knowledge.                                |
| `allowed-tools`            | Tools Claude can use without permission. Example: `Read, Grep, Glob` or `Bash(python *)`.       |
| `model`                    | Model to use when skill is active.                                                              |
| `context`                  | Set `fork` to run in isolated subagent context.                                                 |
| `agent`                    | Subagent type when `context: fork`. Options: `Explore`, `Plan`, `general-purpose`, or custom.   |

## String Substitutions

| Variable               | Description                                              |
| :--------------------- | :------------------------------------------------------- |
| `$ARGUMENTS`           | All arguments passed when invoking the skill.            |
| `$ARGUMENTS[N]`        | Specific argument by 0-based index.                      |
| `$N`                   | Shorthand for `$ARGUMENTS[N]` (e.g., `$0`, `$1`).        |
| `${CLAUDE_SESSION_ID}` | Current session ID.                                      |

## Dynamic Context Injection

Use `!`command`` to run shell commands before the skill is sent to Claude:

```yaml
## Current branch
!`git branch --show-current`

## Recent commits
!`git log --oneline -5`
```

The command output replaces the placeholder.

## Skill Types

**Reference skills** - Add knowledge Claude applies to current work (conventions, patterns, domain knowledge). Run inline with conversation context.

```yaml
---
name: api-conventions
description: API design patterns for this codebase
---

When writing API endpoints:
- Use RESTful naming conventions
- Return consistent error formats
```

**Task skills** - Step-by-step instructions for specific actions. Often user-invoked only.

```yaml
---
name: deploy
description: Deploy to production
disable-model-invocation: true
---

Deploy the application:
1. Run tests
2. Build
3. Push to deployment target
```

## Invocation Control

| Frontmatter                      | User invokes | Claude invokes |
| :------------------------------- | :----------- | :------------- |
| (default)                        | Yes          | Yes            |
| `disable-model-invocation: true` | Yes          | No             |
| `user-invocable: false`          | No           | Yes            |

## Supporting Files

Skills can include multiple files:

```
my-skill/
├── SKILL.md           # Main instructions (required)
├── templates/         # Templates for Claude to fill in
├── examples/          # Example outputs
├── reference.md       # Detailed docs (loaded on demand)
└── scripts/           # Executable utilities
```

Reference from SKILL.md with markdown links:
```markdown
- For the template, see [template.md](templates/template.md)
- For examples, see [examples.md](examples.md)
```

**Tip:** Keep SKILL.md under 500 lines. Move detailed content to supporting files.
