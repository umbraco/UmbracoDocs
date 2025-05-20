---
description: The Fetch API is a modern way to make network requests in JavaScript. It provides a more powerful and flexible feature set than the older XMLHttpRequest.
---

# Fetch API

The [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) is a Promise-based API that allows you to make network requests similar to XMLHttpRequest. It is a modern way to make network requests in JavaScript and provides a more powerful and flexible feature set than the older XMLHttpRequest. It is available in all modern browsers and is the recommended way to make network requests in JavaScript.

## Fetch API in Umbraco

The Fetch API can also be used in Umbraco to make network requests to the server. Since it is built into the browser, you do not need to install any additional libraries or packages to use it. The Fetch API is available in the global scope and can be used directly in your JavaScript code.
The Fetch API is a great way to make network requests in Umbraco because it provides a lot of flexibility. You can use it to make GET, POST, PUT, DELETE, and other types of requests to the server. You can also use it to handle responses in a variety of formats, including JSON, text, and binary data.

### Example

For this example, we are using the Fetch API to make a GET request to the `/umbraco/MyApiController/GetData` endpoint. The response is then parsed as JSON and logged to the console. 

{% hint style="info" %}
The example assumes that you have a controller set up at the `/umbraco/MyApiController/GetData` endpoint that returns JSON data. You can replace this with your own endpoint as needed. Read more about creating a controller in the [Controllers](../../../implementation/controllers.md) article.
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

When making requests to the Umbraco API controllers, you may need to include an authorization token in the request headers. This is especially important when making requests to endpoints that require authentication.

The Fetch API does not automatically include authentication tokens in requests. You need to manually add the authentication token to the request headers. While you can manage tokens manually, the recommended approach in the Backoffice is to use the **UMB_AUTH_CONTEXT**. This context provides tools to manage authentication tokens and ensures that your requests are properly authenticated.

### Example: Using `UMB_AUTH_CONTEXT` for Authentication

{% hint style="info" %}
The example assumes that you have a valid authentication token. You can replace this with your own token as needed. Read more about authentication in the [Security](../../../implementation/security.md) article.
{% endhint %}

The following example demonstrates how to use `UMB_AUTH_CONTEXT` to retrieve the latest token and make an authenticated request:

```javascript
import { UMB_AUTH_CONTEXT } from '@umbraco-cms/backoffice/auth';

async function fetchData(host, endpoint) {
  const authContext = await host.getContext(UMB_AUTH_CONTEXT);
  const token = await authContext?.getLatestToken();

  const response = await fetch(endpoint, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
    },
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
When using the Fetch API with `UMB_AUTH_CONTEXT`, you need to handle token expiration errors manually. If the token is expired, the request will return a 401 error. You will need to refresh the token or prompt the user to log in again.
{% endhint %}

Why Use **UMB_AUTH_CONTEXT**?

- Simplifies Token Management: Automatically retrieves and refreshes tokens when needed.
- Aligns with Best Practices: Ensures your requests are authenticated in a way that integrates seamlessly with the Backoffice.
- Reduces Errors: Avoids common pitfalls like expired tokens or incorrect headers.

{% hint style="info" %}
The **UMB_AUTH_CONTEXT** is only available in the Backoffice. For external applications, you will need to manage tokens manually or use an API user. Read more about API users in the [API Users](../../../fundamentals/data/users/api-users.md) article.
{% endhint %}

## Management API Controllers

The Fetch API can also be used to make requests to the Management API controllers. The Management API is a set of RESTful APIs that allow you to interact with Umbraco programmatically. You can use the Fetch API to make requests to the Management API controllers like you would with any other API. The Management API controllers are located in the `/umbraco/api/management` namespace. You can use the Fetch API to make requests to these controllers like you would with any other API.

### API User

You can create an API user in Umbraco to authenticate requests to the Management API. This is useful for making requests from external applications or services. You can create an API user in the Umbraco backoffice by going to the Users section and creating a new user with the "API" role. Once you have created the API user, you can make requests to the Management API using the API user's credentials. You can find these in the Umbraco backoffice.

You can read more about this concept in the [API Users](../../../fundamentals/data/users/api-users.md) article.

### Backoffice Token

The Fetch API can also be used to make requests to the Management API using a Backoffice token. This is useful for making requests from custom components that are running in the Backoffice. The concept is similar to the API Users, but the Backoffice token represents the current user in the Backoffice. You will share the access policies of the current user, so you can use the token to make requests on behalf of the current user.

To use the Backoffice access token, you will have to consume the **UMB_AUTH_CONTEXT** context. This context is only available in the Backoffice and includes tools to hook on to the authentication process. You can use the [getOpenApiConfiguration](https://apidocs.umbraco.com/v16/ui-api/classes/packages_core_auth.UmbAuthContext.html#getopenapiconfiguration) method to get a configuration object that includes a few useful properties:

- `base`: The base URL of the Management API.
- `credentials`: The credentials to use for the request.
- `token()`: A function that returns the current access token.

Read more about this in the [UmbOpenApiConfiguration](https://apidocs.umbraco.com/v16/ui-api/interfaces/packages_core_auth.UmbOpenApiConfiguration.html) interface.

It is rather tiresome to manually add the token to each request. Therefore, you can wrap the Fetch API in a custom function that automatically adds the token to the request headers. This way, you can use the Fetch API without worrying about adding the token manually:

```typescript
import { UMB_AUTH_CONTEXT } from '@umbraco-cms/backoffice/auth';
import type { UmbClassInterface } from '@umbraco-cms/backoffice/class-api';

/**
 * Make an authorized request to any Backoffice API.
 * @param host A reference to the host element that can request a context.
 * @param url The URL to request.
 * @param method The HTTP method to use.
 * @param body The body to send with the request (if any).
 * @returns The response from the request as JSON.
 */
async function makeRequest(host: UmbClassInterface, url: string, method = 'GET', body?: any) {
  const authContext = await host.getContext(UMB_AUTH_CONTEXT);
  const token = await authContext?.getLatestToken();
  const response = await fetch(url, {
    method,
    body: body ? JSON.stringify(body) : undefined,
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
    },
  });
  return response.json();
}
```

The above example illustrates the process of making a request to the Management API. You can use this function to make requests to any endpoint in the Management API. The function does not handle errors or responses, so you will need to add that logic yourself, nor does it handle the authentication process. If the token is timed out, you will get a 401 error back, if the `getLatestToken` method failed to refresh the token.

## Executing the request

Regardless of method, you can execute the fetch requests through Umbraco's [tryExecute](https://apidocs.umbraco.com/v16/ui-api/classes/packages_core_auth.UmbAuthContext.html#tryexecute) function. This function will handle any errors that occur during the request and will automatically refresh the token if it is expired. If the session is expired, the function will also make sure the user logs in again.

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

However, if you have a lot of requests to make, you might want to consider an alternative approach. You could use a library like [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started) to generate a TypeScript client. The library requires an OpenAPI definition and allows you to make requests to the Management API without having to manually write the requests yourself. The generated client will only need the token once. This can save you a lot of time and effort when working with the Management API. The Umbraco Backoffice itself is running with this library and even exports its internal HTTP client. You can read more about this in the [HTTP Client](http-client.md) article.
