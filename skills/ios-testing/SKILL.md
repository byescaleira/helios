---
name: ios-testing
description: Use when writing, reviewing, or planning tests for iOS code, including unit tests, integration tests, UI tests, and Swift Testing.
---

# iOS Testing Standards

## What to test
- ViewModels: all public states and side effects.
- UseCases: business rules and error paths.
- Repositories: mapping and data-source coordination.
- Services: public contracts and failure modes.
- Helpers/pure functions: edge cases.

## Naming
```text
test_<method>_<condition>_<expectedResult>
```
Example: `test_login_withInvalidCredentials_setsError()`

## Dependencies
- Inject fakes/mocks for network, database, and platform APIs.
- Never hit real network or disk in unit tests.
- Use protocol-based abstractions for testability.

## Swift Testing (preferred)
```swift
import Testing

@Test
func loginWithInvalidCredentialsSetsError() async {
    let service = FakeAuthService(error: .invalidCredentials)
    let viewModel = LoginViewModel(authService: service)

    await viewModel.login()

    #expect(viewModel.error == .invalidCredentials)
    #expect(!viewModel.isLoading)
}
```

## XCTest (legacy)
Use when the project already uses XCTest or supports iOS versions before Swift Testing availability.

## Coverage
- Target ≥80% coverage for business logic.
- Do not chase coverage for trivial getters/setters.
- Cover error paths and cancellation paths explicitly.

## UI tests
- Write UI tests only for critical user flows.
- Keep UI tests independent and deterministic.
- Do not write UI tests during scaffolding.

## Don'ts
- Do not test implementation details.
- Do not share mutable state between tests.
- Do not depend on external services in unit tests.
- Do not leave disabled/flaky tests in the suite.
