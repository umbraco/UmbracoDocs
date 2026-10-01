---
description: Learn how to execute requests in the Backoffice.
---

# Executing Requests

Requests can be made using the Fetch API or the Umbraco HTTP client. The Backoffice also provides a `tryExecute` function that you can use to execute requests. This function handles any errors that occur during the request and shows a notification when a request fails. If the session has expired, the Umbraco HTTP Client opens the login dialog.

{% hint style="info" %}
You can read the technical documentation for the `tryExecute` function in the [UI API Documentation](https://apidocs.umbraco.com/v18/ui-api/functions/packages_core_resources.tryExecute.html) class.
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

The `tryExecute` function takes the context of the current class or element as the first argument and the request as the second argument. Therefore, the above example can be used in any class or element that extends from either the [UmbController](https://apidocs.umbraco.com/v18/ui-api/interfaces/libs_controller-api.UmbController.html) or [UmbLitElement](https://apidocs.umbraco.com/v18/ui-api/classes/packages_core_lit-element.UmbLitElement.html) classes.

{% hint style="info" %}
The above example requires a host element illustrated by the use of `this`. This is typically a custom element that extends the `UmbLitElement` class.
{% endhint %}

It is recommended to always use the `tryExecute` function to wrap HTTP requests. It simplifies error handling and ensures a consistent user experience in the Backoffice.

### When Notifications Are Shown

The `tryExecute` function shows a notification when the request throws an error:

* The Umbraco HTTP Client throws for error responses.
* A client you generate yourself returns error responses in an `error` property instead. Pass `throwOnError: true` to its SDK functions, as described in the [Custom Generated Client](custom-generated-client.md) article.
* A Fetch API request does not throw for error responses, so throw an error yourself when the response is not successful. The [Fetch API](fetch-api.md) article shows how.

Error responses with status 401, 403 or 404 from the Umbraco HTTP Client or a generated client do not show a notification. Check the returned `error`, and handle these responses in your code.

Cancelled requests do not show a notification either. Neither do error responses with the `CancelledByNotification` operation status, because the server sends its own notification for those.

The notification shows the `title` and `detail` of the problem details in the response body. The body must contain `type`, `title` and `status`, or the notification shows a generic message instead. In a controller, `Problem()` returns such a body.

### Disabling Notifications

The `tryExecute` function shows a notification when a request fails. There may be valid cases where you want to handle errors yourself. This could, for instance, be if you want to show a custom error message. You can disable the notifications by passing the `disableNotifications` option to the `tryExecute` function:

```javascript
const request = umbHttpClient.get({
    url: '/umbraco/management/api/v1/server/status'
});

const { data, error } = await tryExecute(this, request, {
    disableNotifications: true,
});
```

### Cancelling Requests

Cancelling a request is useful when it takes too long, or when the user navigates away from the page before it completes. You can cancel a request by using the [AbortController API](https://developer.mozilla.org/en-US/docs/Web/API/AbortController). The `AbortController` API is a built-in API in modern browsers that allows you to cancel requests. Pass its signal to the request, and `tryExecute` returns the cancellation as an error:

```javascript
const abortController = new AbortController();

const request = umbHttpClient.get({
    url: '/umbraco/management/api/v1/server/status',
    signal: abortController.signal,
});

// Cancel the request for illustration purposes
abortController.abort();

const { error } = await tryExecute(this, request, {
    disableNotifications: true,
});
```

{% hint style="info" %}
The `abortSignal` option of `tryExecute` only cancels a request whose promise has a `cancel()` method. Requests made with the Umbraco HTTP Client or the Fetch API do not have one, so pass the signal to the request itself.
{% endhint %}
