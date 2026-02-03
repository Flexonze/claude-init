---
name: create-task
description: Create a new task markdown file in .claude/tasks/not_started/ folder
argument-hint: [task-name]
disable-model-invocation: true
---

# Create Task

Create a new task file in the `.claude/tasks/not_started/` directory based on the provided task name.

## Resources

- [Task template](templates/task.md) - Template for new task files

## Instructions

1. **Check for task name**: If `$1` is empty, ask the user for the task name before continuing.

2. **Validate task name**:
   - Convert to lowercase with hyphens (kebab-case)
   - Remove any special characters except hyphens
   - Ensure it's descriptive and concise

3. **Check if task already exists**: Check all status folders (not_started, in_progress, completed) for `<task-name>.md`. If it exists, inform the user and ask if they want to overwrite or choose a different name.

4. **Create the task file**: Create `.claude/tasks/not_started/<task-name>.md` using the [task template](templates/task.md).

5. **Fill in the template**:
   - Convert kebab-case filename to Title Case for the task name header
   - Leave placeholder text in brackets for the user to fill in

6. **Confirm creation**: Tell the user:
   - The task file was created at `.claude/tasks/not_started/<task-name>.md`
   - They should edit it to fill in the details

## Task Status System

Tasks use a folder-based status system:

- **.claude/tasks/not_started/**: Tasks ready to be worked on (new tasks go here)
- **.claude/tasks/in_progress/**: Tasks currently being worked on
- **.claude/tasks/completed/**: Finished tasks

## Task Type Values

Tasks can have one or multiple types (comma-separated):

- Backend
- Frontend
- UX
- DevOps
- Documentation
- Testing
- Bugfix
- Research
- Other

Examples:
- `backend` - Only backend changes
- `frontend, backend` - Full-stack feature
- `Backend, Bugfix` - Debug a specific backend bug
