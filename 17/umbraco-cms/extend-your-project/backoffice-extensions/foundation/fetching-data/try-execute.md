---
description: Learn how to execute requests in the Backoffice.
---

# Executing Requests

Requests can be made using the Fetch API or the Umbraco HTTP client. The Backoffice also provides a `tryExecute` function that you can use to execute requests. This function handles any errors that occur during the request and shows a notification when a request fails. The Umbraco HTTP Client refreshes an expired token, and prompts the user to log in again when the session has expired.

{% hint style="info" %}
You can read the technical documentation for the `tryExecute` function in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/functions/packages_core_resources.tryExecute.html) class.
{% endhint %}

## Using the Umbraco HTTP Client

Here is an example of how to use the `tryExecute` function with the Umbraco HTTP client:

{% code title="my-element.ts" %}
```typescript
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
{% endcode %}

The `tryExecute` function takes the context of the current class or element as the first argument and the request as the second argument. Therefore, the above example can be used in any class or element that extends from either the [UmbController](https://apidocs.umbraco.com/v17/ui-api/interfaces/libs_controller-api.UmbController.html) or [UmbLitElement](https://apidocs.umbraco.com/v17/ui-api/classes/packages_core_lit-element.UmbLitElement.html) classes.

{% hint style="info" %}
The above example requires a host element illustrated by the use of `this`. This is typically a custom element that extends the `UmbLitElement` class.
{% endhint %}

It is recommended to always use the `tryExecute` function to wrap HTTP requests. It simplifies error handling and ensures a consistent user experience in the Backoffice.

### When Notifications Are Shown

The `tryExecute` function shows a notification when the request throws an error:

* The Umbraco HTTP Client throws for error responses.
* A client you generate yourself returns error responses in an `error` property instead. Make it throw with the `throwOnError` option, as described in the [Custom Generated Client](custom-generated-client.md) article.
* A Fetch API request does not throw for error responses, so throw an error yourself when the response is not successful. The [Fetch API](fetch-api.md) article shows how.

Error responses with status 401, 403 or 404 from the Umbraco HTTP Client or a generated client do not show a notification. Check the returned `error`, and handle these responses in your code.

Requests that you cancel with the `abortSignal` option, as described in [Cancelling Requests](#cancelling-requests), do not show a notification either. Neither do error responses with the `CancelledByNotification` operation status. The server usually sends its own notification for those.

The notification shows the `title` and `detail` of the problem details in the response body. The body must contain `type`, `title` and `status`, or the notification shows a generic message instead. In a controller, `Problem()` returns such a body.

### Disabling Notifications

The `tryExecute` function shows a notification when a request fails. There may be valid cases where you want to handle errors yourself. This could, for instance, be if you want to show a custom error message. You can disable the notifications by passing the `disableNotifications` option to the `tryExecute` function:

{% code title="my-element.ts" %}
```typescript
const request = umbHttpClient.get({
    url: '/umbraco/management/api/v1/server/status'
});

const { data, error } = await tryExecute(this, request, {
    disableNotifications: true,
});
```
{% endcode %}

### Cancelling Requests

{% hint style="info" %}
Cancelling requests with `abortSignal` is available from Umbraco 17.8. In earlier 17.x releases, pass the signal to the request only and set `disableNotifications: true`. The returned `error` is then an `UmbApiError`, so check `signal.aborted` to tell a cancellation apart.
{% endhint %}

Cancel a request when you no longer need its result, for example when the user navigates away or the request takes too long.

Create an [AbortController](https://developer.mozilla.org/en-US/docs/Web/API/AbortController) and pass its signal to both the request and the `abortSignal` option of `tryExecute`. The signal on the request stops the network request. The `abortSignal` option makes `tryExecute` return straight away with an `UmbCancelError`:

{% code title="my-element.ts" %}
```typescript
import { tryExecute, UmbCancelError } from '@umbraco-cms/backoffice/resources';
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

const abortController = new AbortController();
const signal = abortController.signal;

const execution = tryExecute(this, umbHttpClient.get({
    url: '/umbraco/management/api/v1/server/status',
    signal,
}), { abortSignal: signal });

// Cancel the request, for example when the user navigates away
abortController.abort();

const { data, error } = await execution;

if (!error) {
    console.log(data); // Do something with the data
} else if (UmbCancelError.isUmbCancelError(error)) {
    // The request was cancelled, so there is nothing to handle
} else {
    console.error('There was a problem with the fetch operation:', error);
}
```
{% endcode %}

When the signal aborts before the request completes, the returned `error` is an `UmbCancelError`, and `tryExecute` does not show a notification. When `error` is set, use `UmbCancelError.isUmbCancelError()` to tell a cancellation apart from a failed request.

To cancel a request that takes too long, create the signal with [AbortSignal.timeout()](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal/timeout_static). The signal aborts after the given number of milliseconds:

{% code title="my-element.ts" %}
```typescript
const signal = AbortSignal.timeout(5000);

const { data, error } = await tryExecute(this, umbHttpClient.get({
    url: '/umbraco/management/api/v1/server/status',
    signal,
}), { abortSignal: signal });
```
{% endcode %}

Pass the signal to the `abortSignal` option here too, so a timeout returns an `UmbCancelError` like any other cancellation.
