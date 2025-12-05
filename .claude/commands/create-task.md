---
argument-hint: [task-name]
description: Create a new task markdown file in .claude/tasks/not_started/ folder
---

Create a new task file in the `.claude/tasks/not_started/` directory based on the provided task name.

## Instructions

1. **Check for task name**: If `$1` is empty, ask the user for the task name before continuing.

2. **Validate task name**:

   - Convert to lowercase with hyphens (kebab-case)
   - Remove any special characters except hyphens
   - Ensure it's descriptive and concise

3. **Check if task already exists**: Check all status folders (not_started, in_progress, completed) for `<task-name>.md`. If it exists, inform the user and ask if they want to overwrite or choose a different name.

4. **Create the task file**: Create `.claude/tasks/not_started/<task-name>.md` with the following template:

```markdown
# [Task Name in Title Case]

**Type:** [Backend | Frontend | UX | DevOps | Documentation | Testing | Bugfix | Research | Other]

## Description

[Brief description of what needs to be done]

## Why

[Why is this task necessary? What problem does it solve?]

## Todo List

- [ ] [Step 1]
- [ ] [Step 2]
- [ ] [Step 3]

## Dependencies

- Blocked by: None
- Blocks: None

## Notes

[Additional context, considerations, or important information]

## Related Files

- `path/to/file1.py`
- `path/to/file2.tsx`

## Acceptance Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] Tests added/updated
- [ ] Documentation updated if needed
- [ ] Code follows CLAUDE.md guidelines
- [ ] Linting and formatting passes
```

5. **Fill in the template**:

   - Convert kebab-case filename to Title Case for the task name header
   - Leave placeholder text in brackets for the user to fill in

6. **Confirm creation**: Tell the user:
   - The task file was created at `.claude/tasks/not_started/<task-name>.md`
   - They should edit it to fill in the details
   - They can use `/work-on-task <task-name>` when ready to implement

## Task Status System

Tasks use a folder-based status system:

- **.claude/tasks/not_started/**: Tasks ready to be worked on (new tasks go here)
- **.claude/tasks/in_progress/**: Tasks currently being worked on
- **.claude/tasks/completed/**: Finished tasks

The `/work-on-task` command automatically moves tasks between folders as work progresses.

## Task Type Values

Tasks can have one or multiple types (comma-separated), including (but not restricted to):

- Backend
- Frontend
- UX
- DevOps
- Documentation
- Testing
- Bugfix
- Research
- Other
- ...

Examples:

- `backend` - Only backend changes
- `frontend, backend` - Full-stack feature
- `Backend, Bugfix` - Debug a specific backend bug

## Example

If user runs `/create-task add-celery-support`, create `.claude/tasks/not_started/add-celery-support.md` with the template above and "Add Celery Support" as the title.
