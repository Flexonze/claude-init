---
argument-hint: [skill-name] [description]
description: Create a new skill
---

Create a new skill in `.claude/skills/` based on the user's input.

## Instructions

1. **Check for arguments**: If no arguments are provided (i.e., `$ARGUMENTS` is empty), ask the user for the skill name and description before continuing.

2. **Read the documentation**: Use WebFetch to read https://code.claude.com/docs/en/skills to understand skill structure, frontmatter options, and best practices.

3. **Parse user input**: Extract the skill name and the description of what the skill should do.

4. **Create the skill file**: Create `.claude/skills/<skill-name>.md` with:

   - Required frontmatter (`name` and `description`)
   - Clear title
   - Instructions section with step-by-step guidance
   - Examples section showing how to use the skill

5. **Follow the project style**: Check existing skills in `.claude/skills/` to match the style and structure used in this project.

6. **Confirm creation**: Tell the user the skill was created and how Claude will use it.

## Skill Template

```markdown
---
name: skill-name
description: Brief description of what this Skill does and when to use it
---

# Skill Name

## Instructions

Step-by-step guidance for Claude to perform this task.

## Examples

- "Example prompt that would trigger this skill"
- "Another example usage"
```

## Key Points

- Use kebab-case for filenames (e.g., `my-skill.md`)
- Skills are for teaching Claude project-specific workflows
- Keep instructions clear and actionable
- Include concrete examples of when the skill applies
- Create `.claude/skills/` directory if it doesn't exist
