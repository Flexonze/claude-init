---
argument-hint: [task-name]
description: Read and implement a task from .claude/tasks/ folder
---

Read a task file and implement it following best practices and the guidelines in CLAUDE.md.

## Instructions

1. **Find the task**:

   - If `$1` is empty, list available tasks from `.claude/tasks/not_started/` and `.claude/tasks/in_progress/` and ask the user which one to work on
   - Look for the task file `$1.md` in this order: `.claude/tasks/not_started/`, `.claude/tasks/in_progress/`, `.claude/tasks/completed/`
   - If the file doesn't exist in any folder, inform the user and list available tasks

2. **Handle task status**:

   - If task is in `.claude/tasks/completed/`, ask the user if they want to rework it (move back to in_progress)
   - If task is in `.claude/tasks/not_started/`, move it to `.claude/tasks/in_progress/`
   - If task is already in `.claude/tasks/in_progress/`, continue working on it

3. **Move task to in_progress**:

   - Use `mv .claude/tasks/not_started/$1.md .claude/tasks/in_progress/$1.md` to move the task file
   - Confirm the move to the user

4. **Analyze the task thoroughly**:

   - Read the description, why, todo list, dependencies, notes, and acceptance criteria
   - Identify all related files mentioned
   - Use the Task tool with subagent_type=Explore to understand the codebase context if needed

5. **Create a comprehensive plan**:

   - Use TodoWrite to create a detailed plan based on the task's todo list
   - Break down complex steps into smaller, actionable items
   - Include testing, documentation, and code review steps

6. **Search and understand context**:

   - Use Grep/Glob to find related code
   - Read relevant files to understand current implementation
   - Identify patterns and conventions used in the codebase

7. **Follow TDD when possible**:

   - Write tests first for new functionality
   - Run existing tests to ensure nothing breaks
   - Aim for high test coverage

8. **Implement the task**:

   - Follow all guidelines in `.claude/CLAUDE.md`
   - Write clean, maintainable code
   - Follow the project's naming conventions and code style
   - Use early returns to reduce nesting

9. **Update the task file as you progress**:

   - Check off items in the todo list as completed
   - Add notes about implementation decisions
   - Update related files section if you worked on additional files

10. **Run quality checks**:

    - Run the project's linting and formatting tools
    - Run tests to ensure everything passes
    - Verify acceptance criteria are met

11. **Move task to completed**:

    - Use `mv tasks/in_progress/$1.md tasks/completed/$1.md` to mark the task as done
    - Add a final note to the task file with summary of what was done
    - Ensure all acceptance criteria are checked off

12. **Summary**: Provide a clear summary of:
    - What was implemented
    - Files that were created/modified
    - Any important decisions or tradeoffs made
    - What to test or verify
    - Link to the task file location (tasks/completed/$1.md)

## Key Principles

- **Be thorough**: Don't rush. Understand the full context before coding.
- **Follow conventions**: Match the existing code style and patterns.
- **Test everything**: Write and run tests. Don't skip this.
- **Document decisions**: Update the task file with important notes.
- **Quality over speed**: Take time to write clean, maintainable code.
- **Update as you go**: Check off todos and move files between folders in real-time.

## Folder-Based Status System

Tasks are organized in folders representing their status:

- **.claude/tasks/not_started/**: Tasks ready to be worked on
- **.claude/tasks/in_progress/**: Tasks currently being worked on (move here when starting)
- **.claude/tasks/completed/**: Finished tasks (move here when done)

## Example

If user runs `/work-on-task add-user-export`:

1. Find `add-user-export.md` in tasks/not_started/
2. Move to tasks/in_progress/
3. Create implementation plan
4. Search for existing export patterns in the codebase
5. Implement the feature following project conventions
6. Write tests
7. Update task file with progress notes
8. Run linting and tests
9. Move to tasks/completed/
10. Provide summary
