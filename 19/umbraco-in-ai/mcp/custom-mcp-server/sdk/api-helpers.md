---
description: API call helpers, HTTP client setup, and ProblemDetails error handling in the MCP Server SDK.
---

# API Helpers

The SDK provides helper functions for executing Umbraco Management API calls with standardized error handling and response formatting. These helpers handle the repetitive parts of API communication so your tool handlers stay concise.

## When to Use Helpers

Use the built-in helpers for standard CRUD operations (roughly 80% of tools):

| Helper | Use Case |
|---|---|
| `executeGetApiCall` | GET single item |
| `executeGetItemsApiCall` | GET collections or arrays |
| `executeVoidApiCall` | DELETE, PUT, or POST without response body |
| `executeVoidApiCallWithOptions` | Same as above with custom success message or extra status codes |

Go manual when you need:

- UUID generation for entity creation
- Response transformation or custom output
- Custom status handling (for example, 202 Accepted)
- Complex request building

## How Helpers Work

Each helper follows the same five steps:

1. Gets the configured API client via `getApiClient()`.
2. Executes your API call function, passing the client.
3. Validates the response is an `AxiosResponse` (warns if not).
4. Checks the HTTP status code: 200-299 is success, anything else is an error.
5. Returns an MCP-formatted `CallToolResult` with structured content on success, or throws `UmbracoApiError` on failure.

## CAPTURE_RAW_HTTP_RESPONSE

You **must** pass this constant to every API call when using the helper functions.

```typescript
export const CAPTURE_RAW_HTTP_RESPONSE = {
  returnFullResponse: true,
  validateStatus: () => true,
} as const;
```

{% hint style="warning" %}
Without `CAPTURE_RAW_HTTP_RESPONSE`, Axios throws on 400+ errors instead of returning them. The helpers need the full `AxiosResponse` object to check status codes and extract ProblemDetails.
{% endhint %}

```typescript
// Correct - helpers receive AxiosResponse with status code
client.deleteDataTypeById(id, CAPTURE_RAW_HTTP_RESPONSE)

// Wrong - helpers receive undefined/void, status checking fails
client.deleteDataTypeById(id)
```

## Error Handling

API errors follow the RFC 7807 Problem Details format. The SDK provides two error classes:

- **`UmbracoApiError`** — wraps a ProblemDetails object for API-level errors (404, 409, and so on)
- **`ToolValidationError`** — for input validation failures before the API call is made

The `withErrorHandling` decorator catches both error types automatically and converts them to tool error results — you don't need to handle them yourself.

```typescript
import { UmbracoApiError, ToolValidationError } from "@umbraco-cms/mcp-server-sdk";

// API error — returned as a structured error to the LLM
throw new UmbracoApiError({
  status: 404,
  title: "Not Found",
  detail: "The data type was not found",
});

// Validation error — returned before making an API call
throw new ToolValidationError("The name field is required");
```

## HTTP Client

The SDK provides two HTTP client implementations depending on the transport:

* **Stdio transport** — Uses an Axios-based client (`UmbracoAxios`) with OAuth client credentials authentication, automatic token refresh, and self-signed certificate support. The API user credentials from your `.env` file are used.
* **Hosted transport** — Uses a fetch-based client provided by the [`@umbraco-cms/mcp-hosted`](../hosted-mcp/README.md) package. The authenticated backoffice user's token is used.

The project template configures both transports for you. The API call helpers work with either client through the `configureApiClient` provider — your tool handlers do not need to know which transport is in use.
