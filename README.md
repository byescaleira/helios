# helios

Invisible iOS specialist for Claude Code. Auto-detects iOS projects, silently enforces best practices, and validates every change with build, tests, lint and format via XcodeBuildMCP.

## Features

- **Auto-detection**: activates when it sees `.swift`, `.xcodeproj`, `Package.swift`, or iOS mentions in `CLAUDE.md`.
- **Silent prompt expansion**: every iOS prompt is internally enriched with project context and rules.
- **Multi-agent orchestration**: `@ios-expert`, `@ios-buildfixer`, `@ios-architect`.
- **Mandatory XcodeBuildMCP**: auto-installed on plugin setup; used for all build/test operations.
- **Auto-validation**: SwiftLint, SwiftFormat, build and tests run after relevant edits.
- **Modern Swift**: Swift 6 strict concurrency, `@Observable`, typed navigation, typed errors.
- **Tests by default**: unit tests for ViewModels, UseCases, Repositories and Services.

## Installation

### From source (development)

```bash
git clone https://github.com/byescaleira/helios.git
cd helios
claude plugin install .
```

### From GitHub

```bash
claude plugin install byescaleira/helios
```

## Requirements

- Claude Code CLI 2.x
- Node.js and npm (for XcodeBuildMCP auto-install)
- macOS with Xcode (for building iOS projects)
- SwiftLint and SwiftFormat (optional, hooks fall back gracefully)

## Quick start

After installing the plugin, open any iOS project with Claude Code:

```bash
cd MyAwesomeApp
claude
```

Then just type naturally:

```text
create the login screen
```

The plugin will:
1. Detect the iOS project.
2. Read `CLAUDE.md` and docs.
3. Create the feature with SwiftUI, ViewModel, typed errors, tests.
4. Run lint and format.
5. Build and test via XcodeBuildMCP.

## Architecture

The plugin is called **helios**. It works through three layers:

| Agent | Role |
|-------|------|
| `ios-expert` | Default orchestrator for all iOS work |
| `ios-buildfixer` | Diagnoses and fixes build/test failures |
| `ios-architect` | Handles architecture, modularization, cross-boundary decisions |

### Skills

| Skill | Scope |
|-------|-------|
| `ios-core` | Universal rules applied to every iOS task |
| `ios-swiftui` | Views, state, lifecycle, navigation presentation |
| `ios-concurrency` | async/await, Task, actors, MainActor, Sendable |
| `ios-navigation` | Typed NavigationStack, Router pattern |
| `ios-error-handling` | Typed LocalizedError patterns |
| `ios-testing` | Unit tests, Swift Testing, coverage |
| `ios-performance` | Memory, lazy loading, re-renders, profiling |
| `ios-modularization` | SPM, local packages, dependency direction |
| `ios-xcodebuild` | XcodeBuildMCP integration |

### Hooks

| Hook | Behavior |
|------|----------|
| `Setup` | Installs XcodeBuildMCP globally if missing |
| `SessionStart` | Injects iOS Expert identity and project detection rules |
| `UserPromptExpansion` | Silently expands iOS-related prompts |
| `PostToolUse` | Runs SwiftLint, SwiftFormat, build and tests |
| `Stop` | Final compliance check before responding |

### MCP

- `xcodebuild` server from `xcodebuild-mcp` package.
- Auto-configured by the plugin.
- Required for automatic build/test validation.

## How it works

```text
User: create the login screen
        │
        ▼
UserPromptExpansion hook
        │
        ▼
Internal prompt enriched with iOS context
        │
        ▼
iOS skills activate (core, swiftui, testing)
        │
        ▼
Claude reads CLAUDE.md and docs/PRD.md
        │
        ▼
ios-expert agent plans and edits
        │
        ▼
PostToolUse: SwiftLint, SwiftFormat, build, tests
        │
        ▼
Result delivered with validation summary
```

## Project conventions enforced

- Swift 6 strict concurrency
- `@Observable` MVVM
- Typed `NavigationStack`
- Typed `LocalizedError`
- Dependency injection
- Modular SPM structure
- Unit tests for ViewModels
- No singletons
- No force unwrap without justification
- No UI tests during scaffolding

## Development

### Validate locally

```bash
claude plugin install .
claude
```

Then inside Claude Code:

```text
/plugins
/skills
/agents
```

### Update the plugin

After editing files, reinstall:

```bash
claude plugin install .
```

## License

MIT

## Author

Rafael Santos
