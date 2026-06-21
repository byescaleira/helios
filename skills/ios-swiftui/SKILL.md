---
name: ios-swiftui
description: Use when writing, reviewing, or refactoring SwiftUI code, views, view modifiers, state management, or navigation in an iOS project.
---

# SwiftUI Best Practices

## State management
- Prefer `@Observable` (iOS 17+) over `ObservableObject`/`@ObservedObject`.
- Use `@State` for purely local view state.
- Use `@Bindable` to bind properties of an `@Observable` object.
- Inject shared state via initializer or `@Environment`, never access singletons.

## View body
- Keep `body` declarative and under 100 lines.
- Extract subviews, property builders, and helper methods.
- Avoid heavy computation inside `body`; cache or compute in ViewModel.

## Lifecycle and async work
- Use `.task(id:)` for async work tied to view identity.
- Cancel tasks on disappear; never store uncontrolled `Task` in `@State`.
- Use `.task` rather than `.onAppear { Task { ... } }` when possible.

## Navigation
- Use `NavigationStack(path:)` with typed routes.
- Keep navigation state in a dedicated `Router`/`NavigationStore`.
- Avoid deep navigation links inside view bodies.

## Previews
- Every nontrivial view must have `#Preview`.
- Previews must cover loading, empty, error, and content states.
- Use preview macros and mock dependencies for isolated previews.

## Modifiers and accessibility
- Apply modifiers in consistent order (frame → padding → background → clipShape).
- Add `.accessibilityLabel` and `.accessibilityHint` where meaningful.
- Avoid magic numbers; use design system tokens or constants.

## Animations
- Use explicit `.animation(.default, value: ...)` on value changes.
- Avoid global `.animation(.default)` without a value trigger.
- Respect `prefersReducedMotion` for accessibility-sensitive motion.

## Don'ts
- Do not use `AnyView` unless there is no other solution.
- Do not nest `NavigationStack` inside `NavigationStack`.
- Do not store `Task` in `@State` without cancellation.
- Do not use `DispatchQueue.main.async` for UI updates; use `@MainActor` or `.task`.
