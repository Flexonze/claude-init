# Changelog

All notable changes to this project will be documented in this file.

## [2026-02-03]

### Added

- Reference repository support: users can now provide a reference repo (URL or local path) to use as inspiration when generating configs
- New `explain` skill for code explanation
- New `generate-commit-message` skill
- PR description template file for consistent formatting

### Changed

- Refactored `generate-pr-description` skill with improved structure
- Updated README with reference repository usage examples
- Removed `create-task` skill (too project-specific)
- Moved all skills/commands that are too project-specific into my own personal claude configs repository: https://github.com/Flexonze/.claude

## [2026-02-02]

### Added

- Install scripts for Mac/Linux (`install.sh`) and Windows (`install.ps1`)
- `.claude/outputs/` directory for command artifacts
- `.claude/rules/` directory for project-specific guidelines
- Self-improving Claude setup: instructions for Claude to add coding patterns and preferences to CLAUDE.md automatically
- Handling for empty/new projects without existing code

### Changed

- **Major refactor**: Converted slash commands to skills architecture
  - `create-skill` now a skill with reference documentation and templates
  - `create-task` converted to skill format
  - `generate-db-diagram` converted to skill format
  - `generate-pr-description` converted to skill format
  - `generate-sequence-diagram` converted to skill format
  - `prime` converted to skill format
  - `update-changelog` converted to skill format
- Improved instructions for avoiding single-command slash commands
- Updated artifact output paths to use `.claude/outputs/`

### Removed

- `create-django-model` command (too framework-specific)
- `create-slash-command` command (replaced by `create-skill`)
- `work-on-task` command (too project-specific)

## [2026-01-13]

### Added

- `/prime` slash command for getting a general understanding of the codebase

### Changed

- Improved example in one of the command
- Updated instructions for command artifact outputs

## [2025-12-04]

### Added

- Initial release
- Core `claude-init.md` prompt for generating `.claude/` directories
- CLAUDE.md template with project structure placeholders
- Initial slash commands
- MIT License
- README with basic usage instructions
