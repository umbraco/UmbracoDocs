---
description: >-
  The Fetch API is a modern way to make network requests in JavaScript. It
  provides a more powerful and flexible feature set than the older
  XMLHttpRequest.
---

# Fetch API

The [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) is a Promise-based API that allows you to make network requests similar to XMLHttpRequest. It is a modern way to make network requests in JavaScript and provides a more powerful and flexible feature set than the older XMLHttpRequest. It is available in all modern browsers and is the recommended way to make network requests in JavaScript.

## Fetch API in Umbraco

The Fetch API can also be used in Umbraco to make network requests to the server. Since it is built into the browser, you do not need to install any additional libraries or packages to use it. The Fetch API is available in the global scope and can be used directly in your JavaScript code.\
The Fetch API is a great way to make network requests in Umbraco because it provides a lot of flexibility. You can use it to make GET, POST, PUT, DELETE, and other types of requests to the server. You can also use it to handle responses in a variety of formats, including JSON, text, and binary data.

### Example

For this example, we are using the Fetch API to make a GET request to the `/umbraco/MyApiController/GetData` endpoint. The response is then parsed as JSON and logged to the console.

{% hint style="info" %}
The example assumes that you have a controller set up at the `/umbraco/MyApiController/GetData` endpoint that returns JSON data. You can replace this with your own endpoint as needed. Read more about creating a controller in the [Controllers](../../../../develop-with-umbraco/application-code/backend-and-custom-logic/controllers.md) article.
{% endhint %}

If there is an error with the request, it is caught and logged to the console:

```javascript
const data = await fetch('/umbraco/MyApiController/GetData')
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.json();
  })
  .catch(error => {
    console.error('There was a problem with the fetch operation:', error);
  });

if (data) {
  console.log(data); // Do something with the data
}
```

{% hint style="warning" %}
When using the Fetch API, you need to manually handle errors and authentication. For most scenarios, we recommend using the Umbraco HTTP Client, which provides built-in error handling and authentication.
{% endhint %}

## Authentication

The backoffice session is an HTTP-only authentication cookie. Set `credentials: 'include'` on the request so the browser sends the cookie along. Scripts in the browser cannot read the cookie, and there is no token to add to the request headers.

### Example: Making an authenticated request

The following example gets the URL of the Umbraco server from `UMB_SERVER_CONTEXT`. The URL matters when the backoffice runs on a different origin than the server, such as a local dev server.

```javascript
import { UMB_SERVER_CONTEXT } from '@umbraco-cms/backoffice/server';

async function fetchData(host, path) {
  const serverContext = await host.getContext(UMB_SERVER_CONTEXT);
  const serverUrl = serverContext?.getServerUrl() ?? '';

  const response = await fetch(`${serverUrl}${path}`, {
    credentials: 'include',
  });

  if (!response.ok) {
    throw new Error('Failed to fetch data');
  }

  return response.json();
}

// Example usage
const data = await fetchData(this, '/umbraco/management/api/v1/server/status');
console.log(data);
```

{% hint style="warning" %}
Requests made with the Fetch API do not pass through the interceptors of the backoffice:

* A 401 response does not open the login dialog, so handle the response yourself.
* The backoffice does not register the request as activity. The server renews the session, but the backoffice can show the session timeout warning earlier than needed.

Use the [Umbraco HTTP Client](http-client.md) when you need the backoffice to handle these cases.
{% endhint %}

{% hint style="info" %}
The authentication cookie only exists in the backoffice. External applications authenticate with an API user instead. Read more about API users in the [API Users](../../../../manage-and-publish-content/users-and-members/users/api-users.md) article.
{% endhint %}

## Management API Controllers

The Fetch API can also be used to make requests to the Management API controllers. The Management API is a set of REST APIs that allow you to interact with Umbraco programmatically. You can use the Fetch API to make requests to the Management API controllers like you would with any other API. The Management API controllers are located in the `/umbraco/api/management` namespace. You can use the Fetch API to make requests to these controllers like you would with any other API.

### API User

You can create an API user in Umbraco to authenticate requests to the Management API. This is useful for making requests from external applications or services. You can create an API user in the Umbraco backoffice by going to the Users section and creating a new user with the "API" role. Once you have created the API user, you can make requests to the Management API using the API user's credentials. You can find these in the Umbraco backoffice.

You can read more about this concept in the [API Users](../../../../manage-and-publish-content/users-and-members/users/api-users.md) article.

### Current backoffice user

The Fetch API can also call the Management API as the current backoffice user. This is useful for custom components that run in the backoffice. The concept is similar to API Users, but the requests share the access policies of the current user.

Set `credentials: 'include'` on each request so the browser sends the authentication cookie. You can wrap the Fetch API in a custom function to avoid repeating the options on every request:

```typescript
import { UMB_SERVER_CONTEXT } from '@umbraco-cms/backoffice/server';
import type { UmbClassInterface } from '@umbraco-cms/backoffice/class-api';

/**
 * Make a request to any Backoffice API as the current user.
 * @param host A reference to the host element that can request a context.
 * @param path The path to request, relative to the Umbraco server.
 * @param method The HTTP method to use.
 * @param body The body to send with the request (if any).
 * @returns The response from the request as JSON.
 */
async function makeRequest(host: UmbClassInterface, path: string, method = 'GET', body?: unknown) {
  const serverContext = await host.getContext(UMB_SERVER_CONTEXT);
  const response = await fetch(`${serverContext?.getServerUrl() ?? ''}${path}`, {
    method,
    credentials: 'include',
    body: body ? JSON.stringify(body) : undefined,
    headers: {
      'Content-Type': 'application/json',
    },
  });

  if (!response.ok) {
    throw new Error(`Request failed with status ${response.status}`);
  }

  return response.json();
}
```

The function throws an error when the response is not successful, so `tryExecute` can report it. Add any other response handling you need yourself.

## Other HTTP libraries

You can also use another HTTP library, such as [Axios](https://axios-http.com/), instead of the Fetch API. Configure it the same way: use the URL of the Umbraco server as the base URL, and send the authentication cookie with every request. There is no token to add.

The following example creates an Axios instance for the Backoffice:

{% code title="src/api/axios-client.ts" %}
```typescript
import axios from 'axios';
import { UMB_SERVER_CONTEXT } from '@umbraco-cms/backoffice/server';
import type { UmbClassInterface } from '@umbraco-cms/backoffice/class-api';

export async function createAxiosClient(host: UmbClassInterface) {
  const serverContext = await host.getContext(UMB_SERVER_CONTEXT);

  return axios.create({
    baseURL: serverContext?.getServerUrl(),
    // Send the authentication cookie, also when the Backoffice runs on another origin
    withCredentials: true,
  });
}
```
{% endcode %}

{% hint style="info" %}
In Umbraco 17 and 18, `getOpenApiConfiguration()` on the **UMB\_AUTH\_CONTEXT** also supplied a `token()` for the `Authorization` header. In Umbraco 19, `token()` returns `undefined` and logs a deprecation warning, so remove the header.
{% endhint %}

Like Fetch API requests, requests made with another HTTP library do not pass through the interceptors of the Backoffice. Use the [Umbraco HTTP Client](http-client.md) when you need the Backoffice to handle an expired session.

## Executing the request

Regardless of method, you can execute the fetch requests through Umbraco's [tryExecute](https://apidocs.umbraco.com/v18/ui-api/functions/packages_core_resources.tryExecute.html) function. This function handles any errors that occur during the request and shows a notification when a request fails. A Fetch API request does not pass through the interceptors of the backoffice, so `tryExecute` does not open the login dialog for it.

**Example:**

```javascript
import { tryExecute } from '@umbraco-cms/backoffice/resources';

const request = makeRequest(this, '/umbraco/management/api/v1/server/status');
const response = await tryExecute(this, request);

if (response.error) {
    console.error('There was a problem with the fetch operation:', response.error);
} else {
    console.log(response); // Do something with the data
}
```

You can read more about the `tryExecute` function in this article:

{% content-ref url="try-execute.md" %}
[try-execute.md](try-execute.md)
{% endcontent-ref %}

## Conclusion

The Fetch API is a powerful and flexible way to make network requests in JavaScript. It is available in all modern browsers and is the recommended way to make network requests in JavaScript. The Fetch API can be used in Umbraco to make network requests to the server. It can also be used to make requests to the Management API controllers. You can use the Fetch API to make requests to any endpoint in the Management API. You can also use it to handle responses in a variety of formats. This is useful if you only need to make a few requests.

However, if you have a lot of requests to make, you might want to consider an alternative approach. You could use a library like [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started) to generate a TypeScript client. The library requires an OpenAPI definition and allows you to make requests to the Management API without having to manually write the requests yourself. You configure the generated client once, and it handles authentication for every request. This can save you a lot of time and effort when working with the Management API. The Umbraco Backoffice itself is running with this library and even exports its internal HTTP client. You can read more about this in the [HTTP Client](http-client.md) article.
