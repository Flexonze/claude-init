---
argument-hint: [parent-branch]
description: Generate PR title and description
---

# Generate PR Description

Analyze the git diff between the parent branch and the current branch and create a pull request title and description.

**Parent branch:** Use "$1" if provided, otherwise default to "main"

## Instructions

### Parent Branch Detection

**At the start of your response, mention which parent branch was used:**

- If $1 is provided: "Using parent branch: $1"
- If $1 is empty/not provided: "Using parent branch: main (default)"

Use the parent branch in git commands: `git diff <parent-branch>...HEAD` and `git log <parent-branch>..HEAD`

### PR Title Format

Generate a PR title in this format:

```
<ticket-number> - Concise title
```

### PR Description Template

Generate the PR description following this template:

```
### :page_facing_up: Context
-

### :heavy_check_mark: Done
- [x] -

### :tent: Boy Scout Rule
- [ ] -

### :camera_flash: Screenshots
-

### :memo: Notes
-
```

### Guidelines

- PR title should be concise and descriptive. The ticket number is often found in the git branch name. If no ticket number is found in the branch name or commits, omit it from the title
- Keep the Context section to 1-2 lines maximum - be concise
- List concrete accomplishments in Done section with checked boxes [x]
- Boy Scout Rule is for improvements/refactorings not directly related to the main feature
- Always keep Screenshots section (even if empty) so screenshots can be added in GitHub
- Remove any other section entirely if it's not relevant (e.g., if no Boy Scout Rule changes, remove that section completely)
- Notes section is for important information like environment variable updates, deployment notes, etc.
- Be direct and avoid unnecessary words

## Example Output

Print the title and description in code blocks so they can be easily copied.

---

**PR title:**

```
PROJ-123 - Add user notification preferences
```

**PR description:**

```
### :page_facing_up: Context
Users can now configure how and when they receive notifications.

### :heavy_check_mark: Done
- [x] Added notification preferences model and API endpoints
- [x] Created settings UI for users to manage their preferences
- [x] Implemented email digest option (immediate, daily, weekly)

### :tent: Boy Scout Rule
- [x] Refactored notification service for better testability
- [x] Updated outdated dependencies

### :camera_flash: Screenshots
<img alt="notification settings" src="https://example.com/screenshot.png" />

### :memo: Notes
- Requires running database migrations
```

---
