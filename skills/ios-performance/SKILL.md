---
name: ios-performance
description: Use when reviewing or optimizing iOS performance, memory usage, scrolling, image handling, or runtime behavior.
---

# iOS Performance Best Practices

## Lists and lazy loading
- Use `LazyVStack` / `LazyHStack` for long lists.
- Avoid `ScrollView { VStack { ForEach(...) } }` for hundreds of items.
- Use `List` when diffing and native cell behavior are needed.

## Images and media
- Cache decoded images; use appropriate `Image` resampling modes.
- Load images asynchronously with cancellation.
- Avoid loading large assets on the main thread.

## State and re-renders
- Keep observable state granular; avoid huge `@Observable` objects.
- Do not emit `@Published`/observable changes from inside `body`.
- Debounce rapid user input when triggering heavy work.

## Memory
- Avoid retain cycles with closures; use `[weak self]` where needed.
- Cancel subscriptions and tasks on deinit/disappear.
- Use Instruments to verify memory leaks, not just intuition.

## Profiling
- Profile with Instruments before optimizing.
- Distinguish CPU, memory, network, and GPU bottlenecks.
- Measure before and after any optimization.

## Don'ts
- Do not prematurely optimize without profiling.
- Do not block the main thread with synchronous I/O.
- Do not hold strong references in view closures without `[weak self]`.
- Do not ignore memory warnings for image-heavy screens.
