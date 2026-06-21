---
name: ios-core
description: Master iOS skill. Activate for any iOS, Swift, SwiftUI, Xcode, iOS build, iOS test, iOS refactor, iOS review, ViewModel, feature, module, or architecture task.
---

# iOS Expert Core Rules

This skill applies to every iOS task handled by the plugin.

## Project detection
Treat a project as iOS if it contains any of:
- `.swift` source files
- `.xcodeproj` / `.xcworkspace`
- `Package.swift`
- `CLAUDE.md` / `AGENTS.md` mentioning iOS, Swift, SwiftUI, or Xcode

## Required first steps
1. Read `CLAUDE.md` if present.
2. Read `AGENTS.md` if present.
3. Read `docs/PRD.md` and `docs/ARCHITECTURE.md` if present.
4. Identify project structure, architecture, iOS minimum version, Swift version, and package manager.
5. Confirm XcodeBuildMCP availability.

## Universal iOS rules
1. Swift 6 strict concurrency; never ignore Sendable warnings.
2. Prefer `@Observable` over `ObservableObject` when targeting iOS 17+.
3. Views are state reflections; side effects belong to ViewModels/UseCases/Services.
4. Use typed `NavigationStack` with a dedicated router.
5. Use typed `LocalizedError` for domain errors.
6. Inject dependencies; no singletons; no global mutable state.
7. Prefer value types; use `actor` for shared mutable state.
8. Extract any view body over 100 lines.
9. Never use force unwrap `!` without explicit justification.
10. Avoid deprecated APIs when a SwiftUI/native API exists.
11. Write unit tests for ViewModels, UseCases, Repositories, and Services.
12. Validate changes with lint, format, build, and tests when possible.

## When to escalate
- Build/test failure → `@ios-buildfixer`
- Architectural or cross-module decision → `@ios-architect`
- Complex multi-file refactor → `@ios-expert` with `ultrathink`

## Validation loop
After code changes:
1. SwiftLint on modified files.
2. SwiftFormat on modified files.
3. Targeted build with XcodeBuildMCP.
4. Affected tests with XcodeBuildMCP.
5. Report results and remaining follow-ups.
