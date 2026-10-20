---
description: Learn how to request data when extending the Backoffice.
---

# Fetching Data

{% hint style="info" %}
Coming from `$http` in Umbraco 13? The Umbraco HTTP Client replaces `$http`, and `tryExecute` replaces `umbRequestHelper.resourcePromise`. For more AngularJS equivalents, see the [Migrate Backoffice Extensions from AngularJS](../../../../get-started/upgrading-and-migrating/find-your-upgrade-path/migrate-backoffice-extensions-from-angularjs.md) article.
{% endhint %}

## Choose How to Fetch Data

Your extension can request data from Umbraco, from your own API controllers, and from third-party APIs. Choose the option that fits the API you call:

| Option | Use it for | What you get |
| ------ | ---------- | ------------ |
| [Umbraco HTTP Client](http-client.md) | The Management API, and direct calls to your own API controllers. | Authentication, the login prompt when the session expires, error handling, and notifications. |
| [Custom Generated Client](custom-generated-client.md) | Your own API controllers. | A typed function for each endpoint. Configured with `configureClient()`, the client handles authentication and the login prompt like the Umbraco HTTP Client. To show a notification from `tryExecute` when a request fails, also set `throwOnError`. The Umbraco Extension Template configures the client for you. |
| [Fetch API](fetch-api.md) | Third-party APIs. | A plain request. You handle authentication and errors yourself. |

Wrap requests to Umbraco and to your own API in [`tryExecute`](try-execute.md), which shows a notification when a request throws an error.

### [Umbraco HTTP Client](http-client.md)

The Umbraco HTTP Client, `umbHttpClient`, is the client the backoffice uses for its own requests. It sends the authentication cookie of the current user. When the session expires, it asks the user to log in again. The [Umbraco HTTP Client](http-client.md) article lists what it handles.

### [Custom Generated Client](custom-generated-client.md)

A generated client gives you a typed function for each endpoint of your API. The [`@hey-api/openapi-ts`](https://github.com/hey-api/openapi-ts) library generates it from the OpenAPI document of your API. Configure your client with `configureClient()`. Your client then handles authentication and the login prompt like the Umbraco HTTP Client. To show a notification from `tryExecute` when a request fails, also set `throwOnError`.

### [Fetch API](fetch-api.md)

Use the Fetch API for third-party APIs, and when you cannot use the Umbraco HTTP Client. The Umbraco HTTP Client treats a 401 response as an expired backoffice session, so it doesn't suit a third-party API. A request with the Fetch API doesn't get the login prompt, the error handling, or the notifications of the backoffice.

## [Executing Requests](try-execute.md)

The `tryExecute` function runs a request, and shows a notification when the request throws an error. It returns the data or the error, so you don't need a `try...catch` block.

## [Repositories](../repositories/README.md)

Repositories provide a structured way to manage data operations in the Backoffice. They abstract the data access layer, allowing for easier maintenance and scalability.
