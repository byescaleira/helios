---
name: ios-xcodebuild
description: Use when building, testing, cleaning, or introspecting an iOS project via XcodeBuildMCP or xcodebuild.
---

# XcodeBuildMCP Integration

## Purpose
All Xcode operations should go through XcodeBuildMCP when the plugin is active. This provides consistent build, test, and project introspection.

## Tools
Typical XcodeBuildMCP tools (confirm exact names in the installed server):
- `mcp__xcodebuildmcp__build_sim_name_proj`
- `mcp__xcodebuildmcp__test_sim_name_proj`
- `mcp__xcodebuildmcp__clean`
- `mcp__xcodebuildmcp__list_schemes`
- `mcp__xcodebuildmcp__list_devices`

## When to call
- After creating or editing Swift files.
- After changing `Package.swift`, project settings, or entitlements.
- Before declaring a task complete.
- When investigating compiler errors.

## Build strategy
1. List available schemes if unknown.
2. Pick the scheme matching the modified target or the main app scheme.
3. Run a simulator build first (fast feedback).
4. Run relevant unit tests.
5. Escalate failures to `@ios-buildfixer`.

## Test strategy
- Run the narrowest test target affected by changes.
- If narrow tests pass, run the broader suite if time allows.
- Never claim tests pass without actually running them.

## Troubleshooting
- If XcodeBuildMCP is missing, install it: `npm install -g xcodebuild-mcp`.
- If builds are stale, run a `clean` first.
- If the scheme is unknown, list schemes before building.
- DerivedData issues: clean + rebuild.

## Don'ts
- Do not use raw `xcodebuild` CLI when XcodeBuildMCP is available.
- Do not ignore compiler warnings unless explicitly allowed by project convention.
- Do not claim success without build/test confirmation.
