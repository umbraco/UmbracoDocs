---
description: >-
  Learn how to show notifications in the Umbraco backoffice, and which
  notifications the backoffice shows for server responses.
---

# Backoffice Notifications

Notifications are short messages that appear on top of the backoffice. They are also known as toasts. Use them to confirm that an action succeeded, or to tell the user about a problem.

The Notification Context shows the notifications. The context is global, so you can consume it from any element or controller in the backoffice.

{% hint style="info" %}
This article covers notifications in the backoffice UI. To run code on the server when something happens, such as when a document is published, see the [Using Notifications](../../server-side-extensions/notifications/README.md) article.
{% endhint %}

## Show a Notification

Consume the context with the `UMB_NOTIFICATION_CONTEXT` token. Then call `peek()` with a color and an options object. The following element copies a link to the clipboard and shows the result:

{% code title="my-copy-link-button.element.ts" %}
```typescript
import { customElement, html, property } from "@umbraco-cms/backoffice/external/lit";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import { UMB_NOTIFICATION_CONTEXT } from "@umbraco-cms/backoffice/notification";

@customElement("my-copy-link-button")
export class MyCopyLinkButtonElement extends UmbLitElement {
  @property()
  url = "";

  #notificationContext?: typeof UMB_NOTIFICATION_CONTEXT.TYPE;

  constructor() {
    super();
    this.consumeContext(UMB_NOTIFICATION_CONTEXT, (context) => {
      this.#notificationContext = context;
    });
  }

  async #copy() {
    try {
      await navigator.clipboard.writeText(this.url);
      this.#notificationContext?.peek("positive", {
        data: { headline: "Link copied", message: "The link is on your clipboard." },
      });
    } catch {
      this.#notificationContext?.peek("danger", {
        data: { headline: "Link not copied", message: "The browser blocked access to the clipboard." },
      });
    }
  }

  override render() {
    return html`<uui-button look="primary" label="Copy link" @click=${this.#copy}></uui-button>`;
  }
}

declare global {
  interface HTMLElementTagNameMap {
    "my-copy-link-button": MyCopyLinkButtonElement;
  }
}
```
{% endcode %}

To get the context once instead of subscribing to it, see the [Consume a Context](context-api/consume-a-context.md) article.

## Peek and Stay

The context has two methods that show a notification:

* `peek()` shows a notification that closes after six seconds. Set the `duration` option to change the time.
* `stay()` shows a notification that stays open until the user or your code closes it.

Every notification has a close button. Hovering over or focusing a notification pauses the timer.

Use `stay()` for a message that the user must act on. You can also use it to show the progress of a task, and close it from code when the task ends.

Both methods return a handler for the notification. Call `close()` on the handler to close the notification. The following controller shows a notification while an import runs:

{% code title="my-product-import.controller.ts" %}
```typescript
import { UmbControllerBase } from "@umbraco-cms/backoffice/class-api";
import { umbHttpClient } from "@umbraco-cms/backoffice/http-client";
import { UMB_NOTIFICATION_CONTEXT } from "@umbraco-cms/backoffice/notification";
import { tryExecute } from "@umbraco-cms/backoffice/resources";

export class MyProductImportController extends UmbControllerBase {
  async import() {
    const notificationContext = await this.getContext(UMB_NOTIFICATION_CONTEXT);

    // Stays open until the import ends
    const progress = notificationContext?.stay("default", {
      data: { headline: "Product import", message: "Importing products. This can take a few minutes." },
    });

    const { error } = await tryExecute(
      this,
      umbHttpClient.post({
        url: "/umbraco/management/api/v1/my/products/import",
        security: [{ scheme: "bearer", type: "http" }],
      }),
    );

    progress?.close();

    // tryExecute has already shown a notification for the failed request
    if (error) return;

    notificationContext?.peek("positive", {
      data: { headline: "Product import", message: "The products are imported." },
    });
  }
}
```
{% endcode %}

Create the controller with a host, for example `new MyProductImportController(this)` in an element.

## Colors

The first argument of `peek()` and `stay()` sets the color of the notification:

| Color      | Use for                                |
| ---------- | -------------------------------------- |
| `default`  | Neutral information.                   |
| `positive` | An action that succeeded.              |
| `warning`  | Something that the user should check.  |
| `danger`   | An error, or an action that failed.    |

## Options

The options object takes these properties:

* `data`: The content of the notification. See the [Notification Data](#notification-data) section.
* `duration`: The time in milliseconds before a `peek()` notification closes. Set it to `null` to keep the notification open. `stay()` ignores this option.
* `elementName`: The name of a custom element that renders the notification instead of the default layout. The element gets the `data` and `notificationHandler` properties.

### Notification Data

The default layout reads these properties from `data`:

* `headline`: An optional title.
* `message`: The text of the notification. The message renders as plain text, so HTML markup shows as text. Line breaks (`\n`) are kept. Screen readers announce the message.
* `htmlMessage`: An optional message with HTML. See the [Render HTML in a Notification](#render-html-in-a-notification) section.

## Show an Error

The `umbPeekError` function shows a notification for an error. The notification is `danger` unless you set `color`. Besides `headline` and `message`, the function takes these properties:

* `detail`: Text below the message. Text longer than 250 characters moves to a dialog, which the user opens with a button.
* `errors`: Validation errors, keyed by field name. The user opens the errors in a dialog with a button.

The following controller handles the error of a request itself, and shows it with `umbPeekError`:

{% code title="my-product-validation.controller.ts" %}
```typescript
import { UmbControllerBase } from "@umbraco-cms/backoffice/class-api";
import { umbHttpClient } from "@umbraco-cms/backoffice/http-client";
import { umbPeekError } from "@umbraco-cms/backoffice/notification";
import { tryExecute, UmbApiError } from "@umbraco-cms/backoffice/resources";

export class MyProductValidationController extends UmbControllerBase {
  async validate() {
    const { error } = await tryExecute(
      this,
      umbHttpClient.post({
        url: "/umbraco/management/api/v1/my/products/validate",
        security: [{ scheme: "bearer", type: "http" }],
      }),
      { disableNotifications: true },
    );

    if (!error || !UmbApiError.isUmbApiError(error)) return;

    umbPeekError(this, {
      headline: "The products are not valid",
      message: error.problemDetails.title,
      detail: error.problemDetails.detail,
      errors: error.problemDetails.errors,
    });
  }
}
```
{% endcode %}

## Notifications From Server Responses

The backoffice shows notifications for server responses in two cases: when a request fails, and when the server sends event messages.

### Failed Requests

`tryExecute` shows a notification when a request fails. The notification shows the title and detail of the problem details in the response. Some responses show no notification, such as responses with status 401, 403, or 404. For the full rules, see the [Executing Requests](fetching-data/try-execute.md) article.

To handle the error yourself, pass `disableNotifications: true` to `tryExecute`. You can then show your own notification, for example with `umbPeekError`.

### Event Messages

On the server, notification handlers can add event messages, for example when they cancel an operation. For an example, see the [ContentService Notifications](../../server-side-extensions/notifications/contentservice-notifications.md) article.

Controllers that inherit from `ManagementApiControllerBase` return these messages in the `Umb-Notifications` response header. The header is not added to responses for `GET` requests.

The Umbraco HTTP Client shows a notification for each message. The category of the message is the headline, and the type sets the color:

| Event message type  | Color      |
| ------------------- | ---------- |
| `Error`             | `danger`   |
| `Warning`           | `warning`  |
| `Success`           | `positive` |
| `Info` or `Default` | `default`  |

The client shows these notifications for every response, also when `tryExecute` has `disableNotifications` set. A generated client shows them too when you configure it as described in the [Custom Generated Client](fetching-data/custom-generated-client.md) article. A request with the Fetch API does not show them.

An event message can contain HTML, such as a link. The backoffice sanitizes the HTML and renders it. Encode values that users control before you add them to a message, for example with `WebUtility.HtmlEncode()`.

## Render HTML in a Notification

{% hint style="info" %}
`htmlMessage` is available from Umbraco 18.1.
{% endhint %}

The `message` property always renders as plain text. To render HTML, set `htmlMessage` as well. The notification then shows `htmlMessage` instead of `message`.

The `htmlMessage` property takes a string or a Lit `TemplateResult`:

* A string is sanitized before it renders. Sanitizing removes scripts and event handlers.
* A `TemplateResult` renders as is. Lit renders the values in its bindings as text, not as HTML.

Keep `message` set to the same text without markup. Screen readers announce `message`, not `htmlMessage`. `umbPeekError` takes `htmlMessage` as well.

{% code title="my-product-notification.controller.ts" %}
```typescript
import { UmbControllerBase } from "@umbraco-cms/backoffice/class-api";
import { html } from "@umbraco-cms/backoffice/external/lit";
import { UMB_NOTIFICATION_CONTEXT } from "@umbraco-cms/backoffice/notification";

export class MyProductNotificationController extends UmbControllerBase {
  async notifyImported(productName: string) {
    const notificationContext = await this.getContext(UMB_NOTIFICATION_CONTEXT);
    notificationContext?.peek("positive", {
      data: {
        headline: "Product imported",
        message: `${productName} is imported.`,
        // Lit renders productName as text, also when the name contains markup
        htmlMessage: html`<strong>${productName}</strong> is imported.`,
      },
    });
  }

  async notifyImportFinished() {
    const notificationContext = await this.getContext(UMB_NOTIFICATION_CONTEXT);
    notificationContext?.stay("positive", {
      data: {
        headline: "Import finished",
        message: "Publish the products to show them on the website.",
        // A static string that contains no values from users
        htmlMessage: "<strong>Publish the products</strong> to show them on the website.",
      },
    });
  }
}
```
{% endcode %}

{% hint style="warning" %}
Do not add values that users control to an HTML string. Sanitizing removes scripts, but markup in the value, such as a link or an image, still renders. Put the value in a binding in a `TemplateResult` instead.

Lit does not check URLs in bindings. Do not bind a URL that users control to an `href` or `src` attribute.
{% endhint %}

## Further Reading

* [@umbraco-cms/backoffice/notification](https://apidocs.umbraco.com/v18/ui-api/modules/packages_core_notification.html)
* [Executing Requests](fetching-data/try-execute.md)
* [Consume a Context](context-api/consume-a-context.md)
