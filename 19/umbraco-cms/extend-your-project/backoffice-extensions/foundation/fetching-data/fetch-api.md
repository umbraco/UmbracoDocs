---
description: >-
  Use the Fetch API to request data from third-party APIs in the backoffice, and
  learn what it does not handle for requests to Umbraco.
---

# Fetch API

The [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) is the built-in way to make network requests in the browser. Use the Fetch API in the backoffice to request data from third-party APIs.

## Requests to Umbraco

To call the Management API or your own backoffice API controllers, use the [Umbraco HTTP Client](http-client.md). For your own API controllers, a [Custom Generated Client](custom-generated-client.md) also gives you a typed function for each endpoint. The Management API endpoints start with `/umbraco/management/api/`.

The Umbraco HTTP Client handles the following for you, and the Fetch API does not:

* Sends the authentication cookie to the Umbraco server, also when the backoffice runs on another origin.
* Asks the user to log in again after a 401 response, and retries `GET` requests once the user has logged in.
* Counts successful requests as activity for the session timeout.
* Turns error responses into problem details, so `tryExecute` shows the title and detail from the server.
* Shows the notifications that the server sends in the `Umb-Notifications` header.
* Returns the ID from the `Umb-Generated-Resource` header.

## Make a Request

The following example requests data from a third-party API. The Fetch API does not throw for error responses. The function throws an error itself when the response is not successful, so [`tryExecute`](try-execute.md) can show a notification:

{% code title="forecast.ts" %}
```typescript
export async function getForecast(city: string) {
  const response = await fetch(`https://api.example.com/forecast?city=${encodeURIComponent(city)}`);

  if (!response.ok) {
    throw new Error(`Request failed with status ${response.status}`);
  }

  return { data: await response.json() };
}
```
{% endcode %}

## Authenticate Requests to Umbraco

When you cannot use the Umbraco HTTP Client for a request to Umbraco, add the authentication yourself. The backoffice session is an HTTP-only authentication cookie, so there is no token to add to the request headers. Instead, make sure the browser sends the cookie to the Umbraco server:

* Get the URL of the Umbraco server from `getServerUrl()` on the `UMB_SERVER_CONTEXT`. The URL matters when the backoffice runs on a different origin than the server, such as a local dev server.
* Set `credentials: 'include'`, so the browser sends the authentication cookie.

The following function wraps the Fetch API and adds both to every request:

{% code title="make-request.ts" %}
```typescript
import type { UmbClassInterface } from '@umbraco-cms/backoffice/class-api';
import { UmbApiError } from '@umbraco-cms/backoffice/resources';
import type { UmbProblemDetails } from '@umbraco-cms/backoffice/resources';
import { UMB_SERVER_CONTEXT } from '@umbraco-cms/backoffice/server';

export async function makeRequest(host: UmbClassInterface, path: string, method = 'GET', body?: unknown) {
  const serverContext = await host.getContext(UMB_SERVER_CONTEXT);
  if (!serverContext) throw new Error('The server context is not available');

  const response = await fetch(`${serverContext.getServerUrl()}${path}`, {
    method,
    credentials: 'include',
    body: body === undefined ? undefined : JSON.stringify(body),
    headers: {
      'Content-Type': 'application/json',
    },
  });

  if (!response.ok) {
    // Use the problem details from the server, or build them from the status
    const isProblemDetails = response.headers.get('Content-Type')?.includes('application/problem+json');
    const problemDetails: UmbProblemDetails = isProblemDetails
      ? await response.json()
      : { type: 'error', title: `Request failed with status ${response.status}`, status: response.status };
    throw new UmbApiError(problemDetails.title, response.status, null, problemDetails);
  }

  return { data: await response.json() };
}
```
{% endcode %}

The function returns the JSON from the response as `data`. Change how it reads the body for endpoints that return an empty body.

For an unsuccessful response, the function throws an `UmbApiError` with the HTTP status. The error carries the problem details when the server sends them.

When the session has expired, the server answers with a 401 response. The Fetch API does not ask the user to log in again. `tryExecute` shows no notification for the 401 error from `makeRequest()`, so handle that error yourself, or use the Umbraco HTTP Client.

For your own API controllers, the server answers with a 401 response only when the controller has the `[ApiController]` attribute. Without it, the server redirects to the login page. The Fetch API follows the redirect, and the response is the HTML of the login page with status 200. Read more in [Expired sessions in your own controllers](custom-generated-client.md#expired-sessions-in-your-own-controllers).

The backoffice does not count a Fetch API request as activity. The server renews the session, but the backoffice can warn about the session timeout earlier than needed.

The authentication cookie belongs to the current backoffice user, so a request has the permissions of that user. External applications authenticate as an API User instead, as described in the [API Users](../../../../manage-and-publish-content/users-and-members/users/api-users.md) article.

## Other HTTP Libraries

You can use another HTTP library, such as [Axios](https://axios-http.com/), in the same way. Use the URL of the Umbraco server as the base URL, and send the authentication cookie with every request:

{% code title="axios-client.ts" %}
```typescript
import axios from 'axios';
import type { UmbClassInterface } from '@umbraco-cms/backoffice/class-api';
import { UMB_SERVER_CONTEXT } from '@umbraco-cms/backoffice/server';

export async function createAxiosClient(host: UmbClassInterface) {
  const serverContext = await host.getContext(UMB_SERVER_CONTEXT);
  if (!serverContext) throw new Error('The server context is not available');

  return axios.create({
    baseURL: serverContext.getServerUrl(),
    // Send the authentication cookie, also when the backoffice runs on another origin
    withCredentials: true,
  });
}
```
{% endcode %}

{% hint style="info" %}
In Umbraco 17 and 18, `getLatestToken()` and the `token()` function of `getOpenApiConfiguration()` supplied a token for the `Authorization` header. Umbraco 19 removes `getLatestToken()`. The `token()` function returns `undefined` and logs a deprecation warning, so remove the header.
{% endhint %}

Like the Fetch API, another HTTP library does not ask the user to log in again or turn error responses into problem details. The library does not show server notifications or return the ID from the `Umb-Generated-Resource` header either.

## Executing the Request

Wrap the request in `tryExecute`, which shows a notification when the request throws. `tryExecute` returns the value that the request resolves to, or an object with `error` when the request throws. So resolve with the body as `data`, and throw when the response is not successful, as `getForecast()` and `makeRequest()` do.

The error that the request throws decides whether `tryExecute` shows a notification:

* An `UmbApiError` with the HTTP status, like the error from `makeRequest()`, follows the rules for the Umbraco HTTP Client. For example, a 401, 403 or 404 response shows no notification. For all the rules, see [When Notifications Are Shown](try-execute.md#when-notifications-are-shown).
* A plain `Error`, like the error from `getForecast()`, shows a notification with the error message, whatever the status.

The following example wraps `makeRequest()` in `tryExecute`, in an element that extends `UmbLitElement`:

{% code title="my-element.ts" %}
```typescript
import { tryExecute } from '@umbraco-cms/backoffice/resources';
import { makeRequest } from './make-request.js';

const { data, error } = await tryExecute(this, makeRequest(this, '/umbraco/myextension/api/v1/items'));

if (!error) {
  console.log(data); // The JSON from the server
}
```
{% endcode %}

For more information about `tryExecute`, see the [Executing Requests](try-execute.md) article.
