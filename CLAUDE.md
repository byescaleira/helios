# helios — Internal Project Guide

This file lives inside the plugin repo and helps the Claude Code plugin-dev agent maintain and extend the plugin.

## What this plugin does

**helios** turns Claude Code into an invisible iOS specialist. When active, every iOS prompt is expanded with project context, best practices, and validation steps. No custom commands are exposed to the user; everything happens through hooks, skills, and agents.

## Repository structure

```
.claude-plugin/
  plugin.json          # Plugin manifest
.mcp.json              # XcodeBuildMCP server config
hooks/
  hooks.json           # Setup, SessionStart, UserPromptExpansion, PostToolUse, Stop
agents/
  ios-expert.md        # Default orchestrator
  ios-buildfixer.md    # Build/test failure specialist
  ios-architect.md     # Architecture and modularization specialist
skills/
  ios-core/            # Master skill
  ios-swiftui/
  ios-concurrency/
  ios-navigation/
  ios-error-handling/
  ios-testing/
  ios-performance/
  ios-modularization/
  ios-xcodebuild/
README.md
LICENSE
```

## Design decisions

1. **No custom commands**: helios should not expose slash commands. The user types naturally; the plugin intercepts and enriches behavior silently.
2. **Mandatory XcodeBuildMCP**: build/test validation is not optional. The plugin installs it on setup.
3. **Multi-agent**: simple tasks stay with `ios-expert`; build failures go to `ios-buildfixer`; architecture calls `ios-architect`.
4. **Auto-detection**: the plugin only applies iOS rules when the project looks like iOS.
5. **English distribution**: all plugin files are in English; user interaction can still be in any language.

## Adding a new skill

1. Create `skills/<name>/SKILL.md`.
2. Add frontmatter `name` and `description`.
3. Register in `.claude-plugin/plugin.json` under `components.skills`.
4. Reinstall the plugin locally to test.

## Adding a new agent

1. Create `agents/<name>.md`.
2. Add frontmatter with `name`, `description`, `model`, `effort`, `maxTurns`, `tools`, `skills`.
3. Register in `.claude-plugin/plugin.json` under `components.agents`.
4. Update `hooks/hooks.json` if the agent should be invoked automatically.

## Testing the plugin

1. `claude plugin install .`
2. `claude`
3. `/plugins` → confirm `iOS Expert` is active
4. `/skills` → confirm iOS skills
5. `/agents` → confirm iOS agents
6. Open an iOS project and type a natural request.

## Release checklist

- [ ] Version bumped in `plugin.json`
- [ ] `README.md` updated
- [ ] All skills registered in `plugin.json`
- [ ] All agents registered in `plugin.json`
- [ ] `hooks.json` is valid JSON
- [ ] `.mcp.json` is valid JSON
- [ ] Tested locally with a real iOS project
- [ ] Git tag created
- [ ] GitHub release published as `helios vX.Y.Z`
