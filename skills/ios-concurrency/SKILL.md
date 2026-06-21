---
name: ios-concurrency
description: Use when code involves async/await, Task, TaskGroup, actor, MainActor, AsyncSequence, or any Swift Concurrency topic in an iOS project.
---

# Swift Concurrency Best Practices

## Core rule
Prefer structured concurrency. Every asynchronous operation should have a clear scope and cancellation path.

## async/await
- Replace completion handlers with `async throws` functions.
- Use `await` at the point where the result is needed.
- Propagate errors explicitly; do not swallow them.

## Task lifecycle
- Use `.task(id:)` in SwiftUI for view-scoped async work.
- Use `Task { ... }` only in controllers or short-lived scopes.
- Always provide cancellation for long-lived tasks.
- Never store a bare `Task` in `@State` without managing cancellation.

## MainActor
- Annotate ViewModels and UI-bound services with `@MainActor`.
- Use `await MainActor.run { ... }` only at bridge points, not as default pattern.
- Avoid `@MainActor` on pure business-logic types.

## Actors
- Encapsulate shared mutable state in `actor`.
- Use nonisolated methods only for pure functions.
- Be careful with actor re-entrancy; prefer atomic state updates.

## Sendable
- Prefer value types (structs, enums) which are implicitly Sendable.
- Mark reference types as `Sendable` or `@unchecked Sendable` only when safe.
- Do not ignore Swift 6 Sendable diagnostics.

## AsyncSequence
- Use `AsyncStream`/`AsyncSequence` for event streams.
- Avoid bridging delegates manually unless necessary.

## Don'ts
- Do not use `DispatchQueue` unless bridging legacy code.
- Do not use `Task.detached` without strong justification.
- Do not call `async` code from synchronous contexts without a controlled bridge.
- Do not ignore `Sendable` warnings with broad suppression.
