---
name: ios-error-handling
description: Use when designing or reviewing error handling, throws, Result, error enums, error presentation, or retry logic in an iOS project.
---

# Typed Error Handling in Swift

## Use LocalizedError
Define domain-specific errors that conform to `LocalizedError`.

```swift
enum AuthenticationError: LocalizedError {
    case invalidCredentials
    case networkError(underlying: Error)
    case accountLocked

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Email or password is incorrect."
        case .networkError(let error):
            return error.localizedDescription
        case .accountLocked:
            return "Your account has been locked. Contact support."
        }
    }
}
```

## Rules
- Never expose raw `Error` to the UI layer without mapping.
- Never use `try!` or force-cast errors without justification.
- Distinguish between recoverable and non-recoverable errors.
- Provide user-facing messages, retry actions, and logging context.
- Use `Result` only when synchronous composition is clearer than `throws`.

## ViewModel pattern
```swift
@MainActor
@Observable
final class LoginViewModel {
    private(set) var error: AuthenticationError?
    private(set) var isLoading = false

    func login() async {
        isLoading = true
        error = nil
        defer { isLoading = false }
        do {
            try await service.login()
        } catch let authError as AuthenticationError {
            error = authError
        } catch {
            error = .networkError(underlying: error)
        }
    }
}
```

## Don'ts
- Do not present `error.localizedDescription` directly from unknown errors.
- Do not swallow errors with empty `catch` blocks.
- Do not use `fatalError` for expected failure modes.
