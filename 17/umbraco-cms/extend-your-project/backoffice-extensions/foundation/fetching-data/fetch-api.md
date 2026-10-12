---
description: >-
  Use the Fetch API to request data from third-party APIs in the backoffice, and
  learn what it does not handle for requests to Umbraco.
---

# Fetch API

The [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) is the built-in way to make network requests in the browser. Use it in the backoffice to request data from third-party APIs.

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

  return response.json();
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

export async function makeRequest(host: UmbClassInterface, url: string, method = 'GET', body?: unknown) {
  const authContext = await host.getContext(UMB_AUTH_CONTEXT);
  const token = await authContext?.getLatestToken();

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
    throw new Error(`Request failed with status ${response.status}`);
  }

  return response.json();
}
```
{% endcode %}

The function reads every response body as JSON. Change that for endpoints that return an empty body.

`getLatestToken()` refreshes an expired token before it returns. You only get a 401 response when the session can no longer be refreshed. The Fetch API does not ask the user to log in again, so handle that response yourself.

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

A request made with another HTTP library has the same gaps as a request made with the Fetch API.

## Executing the Request

Wrap the request in `tryExecute`, which shows a notification when the request throws. In an element that extends `UmbLitElement`:

```typescript
import { tryExecute } from '@umbraco-cms/backoffice/resources';
import { makeRequest } from './make-request.js';

const response = await tryExecute(this, makeRequest(this, '/umbraco/management/api/v1/user/current'));

if (!response.error) {
  console.log(response); // The JSON from the server
}
```

For more information about `tryExecute`, see the [Executing Requests](try-execute.md) article.
