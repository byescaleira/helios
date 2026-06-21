---
name: ios-navigation
description: Use when designing or reviewing navigation, routing, NavigationStack, coordinators, deep links, or app state flow in an iOS SwiftUI project.
---

# Typed Navigation in SwiftUI

## Pattern
Use a typed `NavigationStack` driven by a `Router` or `NavigationStore`.

## Example
```swift
enum Route: Hashable {
    case settings
    case detail(Item)
    case checkout(Cart)
}

@Observable
final class Router {
    var path = NavigationPath()

    func push(_ route: Route) { path.append(route) }
    func pop() { path.removeLast() }
    func reset() { path.removeLast(path.count) }
}

NavigationStack(path: $router.path) {
    ContentView()
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .settings: SettingsView()
            case .detail(let item): DetailView(item: item)
            case .checkout(let cart): CheckoutView(cart: cart)
            }
        }
}
.environment(router)
```

## Rules
- Routes must be `Hashable` and strongly typed.
- Views must not mutate the path directly; use the injected router.
- Deep linking should map URLs to `Route` values.
- Modal presentations (sheets, fullScreenCover) should also be router-driven.
- Avoid global navigation side effects from inside child views.

## Don'ts
- Do not pass closures like `onNext:` down the view tree.
- Do not use `NavigationLink(value:)` without a matching `navigationDestination`.
- Do not mix `NavigationView` and `NavigationStack` in the same app.
- Do not store view-level navigation state in `@State` when it crosses screens.
