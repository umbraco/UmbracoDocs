---
description: Learn more about working with the Umbraco HTTP Client.
---

# Umbraco HTTP Client

The Umbraco HTTP Client, `umbHttpClient`, is the HTTP client the backoffice uses for its own requests. Use it to call the Management API and your own API controllers. Import it from the `@umbraco-cms/backoffice/http-client` package.

The client is generated with `@hey-api/openapi-ts` and wraps the Fetch API.

## Make a Request

Wrap the request in `tryExecute`. The following element lists the items from the API in the [Creating a Backoffice API](../../../tutorials/creating-a-backoffice-api/README.md) tutorial:

{% code title="my-items.element.ts" %}
```typescript
import { customElement, html, state } from "@umbraco-cms/backoffice/external/lit";
import { umbHttpClient } from "@umbraco-cms/backoffice/http-client";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import { tryExecute } from "@umbraco-cms/backoffice/resources";

interface MyItem {
  id: string;
  value: string;
}

interface MyItemPage {
  items: Array<MyItem>;
  total: number;
}

@customElement("my-items")
export class MyItemsElement extends UmbLitElement {
  @state()
  private _items: Array<MyItem> = [];

  constructor() {
    super();
    this.#loadItems();
  }

  async #loadItems() {
    const { data, error } = await tryExecute(
      this,
      umbHttpClient.get<{ 200: MyItemPage }>({
        url: "/umbraco/management/api/v1/my/item",
        query: { skip: 0, take: 10 },
        security: [{ scheme: "bearer", type: "http" }],
      }),
    );
    if (error || !data) return;
    this._items = data.items;
  }

  override render() {
    return html`<ul>
      ${this._items.map((item) => html`<li>${item.value}</li>`)}
    </ul>`;
  }
}

export default MyItemsElement;
```
{% endcode %}

The request takes these options:

* `url`: the path of the endpoint, starting with `/umbraco`.
* `query`: the query string parameters.
* `security`: tells the client to add the access token of the current user. Generated SDK functions include this metadata. Direct calls, like the one above, must pass it.

The type argument maps the status code to the type of `data`, so `data.items` has the right type.

`tryExecute` returns `data` when the request succeeds, and `error` when it fails. It also shows a notification for most failed requests. For the details, see the [Executing Requests](try-execute.md) article.

## Send Data

To send data, pass it as `body`. The client serializes the body as JSON and sets the `Content-Type` header:

{% code title="my-items.element.ts" %}
```typescript
const { error } = await tryExecute(
  this,
  umbHttpClient.post({
    url: "/umbraco/myextension/api/v1/items",
    body: { name: "My item" },
    security: [{ scheme: "bearer", type: "http" }],
  }),
);
```
{% endcode %}

The `put`, `patch`, and `delete` methods take the same options.

## Get the ID of a Created Item

When a Management API controller creates an item with `CreatedAtId()`, the response has an empty body. The ID of the new item is in the `Umb-Generated-Resource` header. The Umbraco HTTP Client returns that ID as `data`:

{% code title="my-items.element.ts" %}
```typescript
const { data: id, error } = await tryExecute(
  this,
  umbHttpClient.post<{ 201: string }>({
    url: "/umbraco/management/api/v1/my/item",
    query: { value: "New item" },
    security: [{ scheme: "bearer", type: "http" }],
  }),
);
```
{% endcode %}

## What the Client Handles

The Umbraco HTTP Client handles these responses for you:

* **Expired session**: A 401 response asks the user to log in again. After the user logs in, the client retries `GET` requests. For other requests, it shows a notification that asks the user to try again.
* **Errors**: The client turns an error response into an error with the problem details from the server. `tryExecute` shows the title and detail in a notification.
* **Server notifications**: The client shows the notifications that the server sends in the `Umb-Notifications` header.
* **Created items**: The client returns the ID from the `Umb-Generated-Resource` header as `data`.

{% hint style="info" %}
A generated client handles the same responses when you configure it with `configureClient()`. You can also pass `umbHttpClient` as the `client` option of a generated SDK function. See the [Custom Generated Client](custom-generated-client.md) article.
{% endhint %}

## Further reading

* [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started)
* [@umbraco-cms/backoffice/http-client](https://apidocs.umbraco.com/v17/ui-api/modules/packages_core_http-client.html)
* [Using the Fetch API](fetch-api.md)
* [Creating a Backoffice Entry Point](../../extending-overview/extension-types/backoffice-entry-point.md)
