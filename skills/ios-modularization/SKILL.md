---
name: ios-modularization
description: Use when designing or reviewing Swift Package Manager structure, local packages, module boundaries, dependencies, or feature modularization.
---

# SPM and Modularization

## Folder structure
```
MyApp/
├── App/
├── Packages/
│   ├── Core/
│   ├── DesignSystem/
│   ├── Infrastructure/
│   ├── FeatureLogin/
│   └── FeaturePayments/
└── Tests/
```

## Dependency direction
```
Features → Core, DesignSystem, Infrastructure
Infrastructure → Core
Core → none (foundation only)
DesignSystem → Core (optional)
```
No circular dependencies. No feature-to-feature direct imports unless explicitly allowed.

## Package.swift per module
Use a local package per module when the project is medium-to-large. Each package declares its own products, targets, and dependencies.

## Rules
- Feature modules are independently testable.
- Public API is intentional; internal details stay internal.
- External dependencies are wrapped or centralized.
- No global mutable state; dependency injection crosses module boundaries via protocols.
- Avoid `@_exported import` unless explicitly desired.

## Migration path
When extracting a feature from a monolith:
1. Define the public interface (protocols + models).
2. Create the new package and move files.
3. Update imports in the app.
4. Move tests.
5. Build and validate.
6. Remove dead code from the original module.

## Don'ts
- Do not create bidirectional package dependencies.
- Do not import App code from a Feature package.
- Do not put business logic in the App target.
- Do not expose implementation types as public.
