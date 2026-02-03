---
name: create-skill
description: Create a new skill
argument-hint: [skill-name] [description]
disable-model-invocation: true
---

# Create Skill

Create a new skill in `.claude/skills/` based on the user's input.

## Resources

- [Skill template](templates/skill.md) - Base template for new skills
- [Skills reference](reference.md) - Frontmatter options, substitutions, and patterns

## Instructions

1. **Check for arguments**: If `$ARGUMENTS` is empty, ask the user for the skill name and a brief description.

2. **Determine skill type**: Ask the user (if not clear from context):
   - **Task skill**: Actions with side effects (deploy, commit, generate). Add `disable-model-invocation: true`.
   - **Reference skill**: Knowledge/conventions Claude applies automatically. Leave invocation enabled.

3. **Check if skill needs arguments**: If the skill operates on user input (file names, issue numbers, etc.), add `argument-hint` to frontmatter.

4. **Create the skill**:
   - Create directory `.claude/skills/<skill-name>/`
   - Create `SKILL.md` using the [template](templates/skill.md)
   - Fill in frontmatter based on skill type
   - Write clear, actionable instructions

5. **Consider supporting files**: For complex skills, suggest adding:
   - `templates/` - for output templates Claude should follow
   - `reference.md` - for detailed documentation
   - `examples/` - for sample outputs

6. **Follow project conventions**: Check existing skills in `.claude/skills/` to match style.

7. **Confirm creation**: Tell the user:
   - Where the skill was created
   - How to invoke it (`/skill-name` or automatic)
   - Suggest testing it

## Quick Reference

**Frontmatter for task skills (user-invoked actions):**
```yaml
---
name: my-task
description: What this does
argument-hint: [required-arg]
disable-model-invocation: true
---
```

**Frontmatter for reference skills (auto-invoked knowledge):**
```yaml
---
name: my-conventions
description: When Claude should apply these conventions
---
```

**String substitutions:**
- `$ARGUMENTS` - all arguments
- `$0`, `$1`, `$2` - individual arguments
- `${CLAUDE_SESSION_ID}` - session ID

See [reference.md](reference.md) for complete documentation.
