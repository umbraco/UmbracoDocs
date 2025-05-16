---
description:: Learn how to execute requests in the Backoffice.
---

# Executing Requests

Requests can be made using the Fetch API or the Umbraco HTTP client. The Backoffice also provides a `tryExecute` function that you can use to execute requests. This function handles any errors that occur during the request and automatically refreshes the token if it has expired. If the session has expired, it prompts the user to log in again.

{% hint style="info" %}
You can read the technical documentation for the `tryExecute` function in the [UI API Documentation](https://apidocs.umbraco.com/v16/ui-api/functions/packages_core_resources.tryExecute.html) class.
{% endhint %}

## Using the Umbraco HTTP Client

Here is an example of how to use the `tryExecute` function with the Umbraco HTTP client:

```javascript
import { tryExecute } from '@umbraco-cms/backoffice/resources';
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

const { data, error } = await tryExecute(this, umbHttpClient.get({
    url: '/umbraco/management/api/v1/server/status'
}));

if (error) {
    console.error('There was a problem with the fetch operation:', error);
} else {
    console.log(data); // Do something with the data
}
```

The `tryExecute` function takes the context of the current class or element as the first argument and the request as the second argument. Therefore, the above example can be used in any class or element that extends from either the [UmbController](https://apidocs.umbraco.com/v16/ui-api/interfaces/libs_controller-api.UmbController.html) or [UmbLitElement](https://apidocs.umbraco.com/v16/ui-api/classes/packages_core_lit-element.UmbLitElement.html) classes.

{% hint style="info" %}
The above example requires a host element illustrated by the use of `this`. This is typically a custom element that extends the `UmbLitElement` class.
{% endhint %}

It is recommended to always use the `tryExecute` function to wrap HTTP requests. It simplifies error handling, manages token expiration, and ensures a consistent user experience in the Backoffice.

### Disabling Notifications

The `tryExecute` function will automatically show error bubbles if a request fails. There may be valid cases where you want handle errors yourself. This could for instance be if you want to show a custom error message. You can disable the notifications by passing the `disableNotifications` option to the `tryExecute` function:

```javascript
tryExecute(this, request, {
    disableNotifications: true,
});
```

### Cancelling Requests

The `tryExecute` function also supports cancelling requests. This is useful in scenarios where a request is taking too long, or the user navigates away from the page before the request completes. You can cancel a request by using the [AbortController API](https://developer.mozilla.org/en-US/docs/Web/API/AbortController). The `AbortController` API is a built-in API in modern browsers that allows you to cancel requests. You can use it directly with tryExecute:

```javascript
const abortController = new AbortController();

// Cancel the request before starting it for illustration purposes
abortController.abort();

tryExecute(this, request, {
    disableNotifications: true,
    abortSignal: abortController.signal,
});
```
