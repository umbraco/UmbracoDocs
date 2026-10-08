---
description: >-
  The testing pyramid for Umbraco backoffice extensions, with 7 skills covering
  unit tests, MSW integration, and E2E with Playwright.
---

# Testing Skills

7 skills covering a complete testing pyramid for Umbraco backoffice extensions.

## The Testing Pyramid

```
          ┌─────────────────────────┐
          │        E2E Tests        │  Level 3: Real Umbraco, complete workflows
          └─────────────────────────┘
    ┌─────────────────────────────────────┐
    │       Integration Tests (MSW)       │  Level 2: Mocked APIs
    └─────────────────────────────────────┘
┌─────────────────────────────────────────────────┐
│              Unit/Component Tests                │  Level 1: Fast, isolated
└─────────────────────────────────────────────────┘
```

Start at the bottom. Most of your tests should be unit tests. Move up the pyramid for confidence in integration and real-world behavior.

## All Testing Skills

| Skill                            | Description                                          |
| -------------------------------- | ---------------------------------------------------- |
| `umbraco-testing`                | **Router skill** — Choose the right testing approach |
| `umbraco-unit-testing`           | Unit tests with @open-wc/testing                     |
| `umbraco-msw-testing`            | MSW handlers for API mocking                         |
| `umbraco-e2e-testing`            | E2E tests against real Umbraco                       |
| `umbraco-playwright-testhelpers` | Full `testhelpers` API reference                     |
| `umbraco-test-builders`          | JsonModels.Builders for test data                    |
| `umbraco-example-generator`      | Generate testable extensions                         |

## The Router: `umbraco-testing`

Not sure which testing approach to use? Start here:

```
/umbraco-testing
```

The router skill asks what you want to test and routes you to the right specific skill. It understands the trade-offs between levels and helps you pick the right one.

## Level 1: Unit/Component Tests

**Skill:** `umbraco-unit-testing`

Fast, isolated testing of Lit elements, contexts, and controllers. Uses `@open-wc/testing` with Web Test Runner.

* No Umbraco instance required
* Tests run in milliseconds
* Great for: component rendering, state changes, event handling, utility functions

## Level 2: Integration Tests (MSW)

**Skill:** `umbraco-msw-testing`

Test with mocked backend APIs using MSW (Mock Service Worker). Simulate errors, delays, and edge cases without a real server.

* No Umbraco instance required
* Can test API interaction patterns
* Great for: API error handling, loading states, data transformation

## Level 3: Real Backend E2E Tests

**Skill:** `umbraco-e2e-testing`

Full acceptance tests against a running Umbraco instance using Playwright.

* Requires running an Umbraco instance.
* Tests real API calls and UI interaction.
* Great for: complete workflows, regression testing, acceptance criteria.

### The "Never Raw Playwright" Rule

E2E tests **must** use `@umbraco/playwright-testhelpers` and `@umbraco/json-models-builders`. Never write raw Playwright tests for Umbraco.

These packages provide:

* **`@umbraco/playwright-testhelpers`** — Fixtures, API helpers, and UI helpers purpose-built for the Umbraco backoffice. Handles login, navigation, waiting for elements, and common assertion patterns.
* **`@umbraco/json-models-builders`** (`umbraco-test-builders` skill) — Builder pattern for creating test data (document types, content, media, and so on) through the Umbraco API.

Using raw Playwright selectors against the Umbraco backoffice is fragile and misses the abstractions that make tests maintainable.

## Testing Workflow

1. **Start with unit tests** — Test your components and logic in isolation.
2. **Add MSW tests** for API interactions — Verify your code handles success, errors, and edge cases.
3. **Add E2E tests** for critical user workflows that need to run against real Umbraco.

## Next Steps

* [**Backoffice Skills Overview**](backoffice-skills.md)**:** The extension skills your tests will exercise.
* [**Quickstart**](quickstart.md)**:** Set up a project to start testing.
* [**Tips for Best Results**](tips.md)**:** Get better results from your AI assistant.
