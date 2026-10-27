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

* Adds the access token of the current user.
* Asks the user to log in again after a 401 response, and retries `GET` requests once the user has logged in.
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

When you cannot use the Umbraco HTTP Client for a request to Umbraco, add the authentication yourself:

* Get the token from `getLatestToken()` on the `UMB_AUTH_CONTEXT`, and send it in the `Authorization: Bearer <token>` header.
* Set `credentials: 'include'`, so the browser sends the authentication cookies.

The following function wraps the Fetch API and adds both to every request:

{% code title="make-request.ts" %}
```typescript
import { UMB_AUTH_CONTEXT } from '@umbraco-cms/backoffice/auth';
import type { UmbClassInterface } from '@umbraco-cms/backoffice/class-api';
import { UmbApiError } from '@umbraco-cms/backoffice/resources';
import type { UmbProblemDetails } from '@umbraco-cms/backoffice/resources';

export async function makeRequest(host: UmbClassInterface, url: string, method = 'GET', body?: unknown) {
  const authContext = await host.getContext(UMB_AUTH_CONTEXT);
  if (!authContext) throw new Error('The auth context is not available');

  const token = await authContext.getLatestToken();

  const response = await fetch(url, {
    method,
    credentials: 'include',
    body: body === undefined ? undefined : JSON.stringify(body),
    headers: {
      Authorization: `Bearer ${token}`,
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

`getLatestToken()` refreshes an expired token before it returns. You only get a 401 response when the session can no longer be refreshed. The Fetch API does not ask the user to log in again. `tryExecute` shows no notification for the 401 error from `makeRequest()`, so handle that error yourself, or use the Umbraco HTTP Client.

The token belongs to the current backoffice user, so a request has the permissions of that user. External applications authenticate as an API User instead, as described in the [API Users](../../../../manage-and-publish-content/users-and-members/users/api-users.md) article.

## Other HTTP Libraries

You can use another HTTP library, such as [Axios](https://axios-http.com/), in the same way. The `getOpenApiConfiguration()` method on the `UMB_AUTH_CONTEXT` returns the server URL as `base`, `credentials: 'include'`, and a `token()` function:

{% code title="axios-client.ts" %}
```typescript
import axios from 'axios';
import { UMB_AUTH_CONTEXT } from '@umbraco-cms/backoffice/auth';
import type { UmbClassInterface } from '@umbraco-cms/backoffice/class-api';

export async function createAxiosClient(host: UmbClassInterface) {
  const authContext = await host.getContext(UMB_AUTH_CONTEXT);
  if (!authContext) throw new Error('The auth context is not available');

  const config = authContext.getOpenApiConfiguration();
  const client = axios.create({
    baseURL: config.base,
    withCredentials: config.credentials === 'include',
  });

  // Add the latest token to every request
  client.interceptors.request.use(async (request) => {
    const token = await config.token();
    if (token) request.headers.Authorization = `Bearer ${token}`;
    return request;
  });

  return client;
}
```
{% endcode %}

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
