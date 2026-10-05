---
description: >-
  Map the AngularJS concepts from Umbraco 13 backoffice extensions to Web
  Components, contexts, and the Umbraco HTTP Client in Umbraco 14 and later.
---

# Migrate Backoffice Extensions from AngularJS

{% hint style="info" %}
This article is for developers who built backoffice extensions with AngularJS in Umbraco 13 or earlier. Examples are dashboards, property editors, and Content Apps.
{% endhint %}

Umbraco 14 replaced the AngularJS backoffice with a new backoffice built on Web Components. AngularJS code does not run in the new backoffice, so you rebuild each extension. Most AngularJS concepts have a direct equivalent.

This article maps those concepts and ports a small dashboard as an example. For the server side of your extension, see the [Porting old Umbraco API Controllers](../../../develop-with-umbraco/application-code/backend-and-custom-logic/routing/umbraco-api-controllers/porting-old-umbraco-apis.md) article.

## Quick Reference

| Umbraco 13 (AngularJS)                        | Umbraco 14 and later                                               |
| --------------------------------------------- | ------------------------------------------------------------------ |
| `package.manifest`                            | `umbraco-package.json`                                             |
| `javascript` array in the manifest            | The `element`, `js`, or `api` property of each extension           |
| `css` array in the manifest                   | The `static styles` of each element                                |
| Controller and HTML view                      | A Web Component, usually a Lit element                             |
| `$scope` and `vm` properties                  | Class properties with the `@state()` decorator                     |
| `$scope.$watch`                               | `willUpdate()` with its changed properties, or `this.observe()`    |
| `$scope.$on('$destroy')`                      | `disconnectedCallback()`                                           |
| Injected services                             | Contexts that you consume with `consumeContext()`                  |
| `$http.get` and `$http.post`                  | `umbHttpClient.get` and `umbHttpClient.post`                       |
| `umbRequestHelper.resourcePromise`            | `tryExecute`                                                       |
| `Umbraco.Sys.ServerVariables`                 | A `config` endpoint on your own API controller                     |
| `$q` and `$timeout`                           | `Promise`, `async` and `await`, and `setTimeout`                   |
| `umb-box`, `umb-button`, and other directives | `uui-box`, `uui-button`, and other Umbraco UI Library components   |
| `<localize>` and `localizationService`        | `<umb-localize>` and `this.localize.term()`                        |
| `Lang/*.xml` files                            | `localization` extensions                                          |
| Content Apps                                  | Workspace Views                                                    |
| Content App `show` rules                      | Workspace View `conditions`, such as `Umb.Condition.WorkspaceContentTypeAlias` |
| Tree menu items from `MenuRenderingNotification` | `entityAction` extensions                                       |
| `UmbracoAuthorizedApiController`              | `ManagementApiControllerBase`                                      |

The rest of this article ports a dashboard that lists, adds, and deletes items. It calls the API controller from the [Creating a Backoffice API](../../../extend-your-project/tutorials/creating-a-backoffice-api/README.md) tutorial.

In Umbraco 13, the same API was an `UmbracoAuthorizedApiController` named `MyItemApiController`. Umbraco routed its actions to `/umbraco/backoffice/api/MyItemApi/{action}` by convention.

## Set Up the Project

AngularJS extensions were often plain JavaScript files in `App_Plugins`, without a build step. You can still write plain JavaScript modules.

The [Umbraco Extension Template](../../../extend-your-project/backoffice-extensions/development-flow/umbraco-extension-template.md) sets up TypeScript, a Vite build, and the backoffice types for you. With the `--include-example` option, it also adds an example dashboard and API controller.

## Register the Extension

In Umbraco 13, a `package.manifest` file listed dashboards and the JavaScript files to load:

{% code title="App_Plugins/MyItems/package.manifest" %}
```json
{
  "dashboards": [
    {
      "alias": "myItemsDashboard",
      "view": "/App_Plugins/MyItems/dashboard.html",
      "sections": ["content", "member", "settings"],
      "weight": -10
    }
  ],
  "javascript": ["/App_Plugins/MyItems/dashboard.controller.js"]
}
```
{% endcode %}

A language file next to it held the texts, including the label of the dashboard tab:

{% code title="App_Plugins/MyItems/Lang/en-US.xml" %}
```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language alias="en_us" intName="English (US)" localName="English (US)" lcid="" culture="en-US">
  <area alias="myItems">
    <key alias="headline">My items</key>
    <key alias="newItem">New item</key>
    <key alias="itemAdded">Item added</key>
    <key alias="deleteHeadline">Delete item</key>
    <key alias="deleteConfirm">Are you sure you want to delete %0%?</key>
  </area>
  <area alias="dashboardTabs">
    <key alias="myItemsDashboard">My Items</key>
  </area>
</language>
```
{% endcode %}

In Umbraco 14 and later, an `umbraco-package.json` file lists the extensions. Each extension has a `type` and points to the code it loads.

{% code title="App_Plugins/MyItems/umbraco-package.json" %}
```json
{
  "name": "My Items",
  "version": "1.0.0",
  "extensions": [
    {
      "type": "dashboard",
      "alias": "My.Dashboard.MyItems",
      "name": "My Items Dashboard",
      "element": "/App_Plugins/MyItems/my-items-dashboard.js",
      "weight": -10,
      "meta": {
        "label": "My Items",
        "pathname": "my-items"
      },
      "conditions": [
        {
          "alias": "Umb.Condition.SectionAlias",
          "oneOf": ["Umb.Section.Content", "Umb.Section.Members", "Umb.Section.Settings"]
        }
      ]
    },
    {
      "type": "localization",
      "alias": "My.Localization.En",
      "name": "My Items English",
      "meta": {
        "culture": "en",
        "localizations": {
          "myItems": {
            "headline": "My items",
            "newItem": "New item",
            "itemAdded": "Item added",
            "deleteHeadline": "Delete item",
            "deleteConfirm": "Are you sure you want to delete %0%?",
            "greeting": "Hello %0%"
          }
        }
      }
    }
  ]
}
```
{% endcode %}

The manifest changes in these ways:

* The `sections` array becomes a condition. Section aliases now have the `Umb.Section.` prefix, so `member` becomes `Umb.Section.Members`. To show a dashboard in one section, use `match` with a single alias instead of `oneOf`.
* The dashboard loads a JavaScript module instead of an HTML view and a controller.
* The `Lang/en-US.xml` file becomes a `localization` extension. Each `area` becomes an object with a property for each `key`, so `myItems_headline` keeps working.
* The tab label moves from the `dashboardTabs_myItemsDashboard` key to `meta.label`.
* The `weight` sorts the other way. In Umbraco 13, the lowest weight came first. Now the highest weight comes first, so `-10` moves the dashboard from the first tab to the last.

To show a dashboard first, give it a higher weight than the built-in dashboards of the section. The [Dashboards](../../../extend-your-project/backoffice-extensions/extending-overview/extension-types/dashboard.md) article lists their weights and the section aliases.

{% hint style="info" %}
With the Umbraco Extension Template, you register the same manifest objects in TypeScript instead. The template's example dashboard shows how.
{% endhint %}

## Rebuild the Controller and View as an Element

In Umbraco 13, an AngularJS controller held the state and the logic:

{% code title="App_Plugins/MyItems/dashboard.controller.js" %}
```javascript
angular.module("umbraco").controller("MyItemsDashboardController", function (
    $http, $q, umbRequestHelper, notificationsService, overlayService, localizationService) {

    var vm = this;
    vm.loading = true;
    vm.items = [];
    vm.newValue = "";

    function loadItems() {
        vm.loading = true;
        umbRequestHelper.resourcePromise(
            $http.get("backoffice/api/MyItemApi/GetAllItems?take=20"),
            "Failed to load the items")
            .then(function (data) {
                vm.items = data.Items;
                vm.loading = false;
            });
    }

    vm.addItem = function () {
        umbRequestHelper.resourcePromise(
            $http.post("backoffice/api/MyItemApi/CreateItem?value=" + encodeURIComponent(vm.newValue)),
            "Failed to add the item")
            .then(function () {
                return localizationService.localize("myItems_itemAdded");
            })
            .then(function (headline) {
                notificationsService.success(headline, vm.newValue);
                vm.newValue = "";
                loadItems();
            });
    };

    vm.deleteItem = function (item) {
        $q.all([
            localizationService.localize("myItems_deleteHeadline"),
            localizationService.localize("myItems_deleteConfirm", [item.Value])
        ]).then(function (texts) {
            overlayService.confirmDelete({
                title: texts[0],
                content: texts[1],
                submit: function () {
                    umbRequestHelper.resourcePromise(
                        $http.delete("backoffice/api/MyItemApi/DeleteItem?id=" + item.Id),
                        "Failed to delete the item")
                        .then(loadItems);
                    overlayService.close();
                }
            });
        });
    };

    loadItems();
});
```
{% endcode %}

An HTML view rendered the state:

{% code title="App_Plugins/MyItems/dashboard.html" %}
```html
<div ng-controller="MyItemsDashboardController as vm">
    <umb-box>
        <umb-box-header title-key="myItems_headline"></umb-box-header>
        <umb-box-content>
            <umb-load-indicator ng-if="vm.loading"></umb-load-indicator>
            <ul ng-if="!vm.loading">
                <li ng-repeat="item in vm.items">
                    {{ item.Value }}
                    <umb-button type="button" button-style="danger" label-key="actions_delete"
                        action="vm.deleteItem(item)"></umb-button>
                </li>
            </ul>
            <input type="text" ng-model="vm.newValue" />
            <umb-button type="button" button-style="primary" label-key="general_add"
                action="vm.addItem()" disabled="!vm.newValue"></umb-button>
        </umb-box-content>
    </umb-box>
</div>
```
{% endcode %}

In Umbraco 14 and later, one Web Component holds the state, the logic, and the markup. The following Lit element replaces both files:

{% code title="my-items-dashboard.element.ts" %}
```typescript
import { css, customElement, html, repeat, state } from "@umbraco-cms/backoffice/external/lit";
import type { UUIInputEvent } from "@umbraco-cms/backoffice/external/uui";
import { umbHttpClient } from "@umbraco-cms/backoffice/http-client";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";
import { umbConfirmModal } from "@umbraco-cms/backoffice/modal";
import { UMB_NOTIFICATION_CONTEXT } from "@umbraco-cms/backoffice/notification";
import { tryExecute } from "@umbraco-cms/backoffice/resources";

interface MyItem {
  id: string;
  value: string;
}

interface MyItemPage {
  items: Array<MyItem>;
  total: number;
}

const ITEMS_URL = "/umbraco/management/api/v1/my/item";

@customElement("my-items-dashboard")
export class MyItemsDashboardElement extends UmbLitElement {
  // @state() properties replace the vm properties. Changing one renders the element again.
  @state()
  private _items: Array<MyItem> = [];

  @state()
  private _loading = true;

  @state()
  private _newValue = "";

  #notificationContext?: typeof UMB_NOTIFICATION_CONTEXT.TYPE;

  constructor() {
    super();
    // Replaces injecting notificationsService into the controller
    this.consumeContext(UMB_NOTIFICATION_CONTEXT, (context) => {
      this.#notificationContext = context;
    });
    this.#loadItems();
  }

  async #loadItems() {
    this._loading = true;
    const { data } = await tryExecute(
      this,
      umbHttpClient.get<{ 200: MyItemPage }>({
        url: ITEMS_URL,
        query: { take: 20 },
        security: [{ scheme: "bearer", type: "http" }],
      }),
    );
    this._items = data?.items ?? [];
    this._loading = false;
  }

  async #addItem() {
    const { error } = await tryExecute(
      this,
      umbHttpClient.post({
        url: ITEMS_URL,
        query: { value: this._newValue },
        security: [{ scheme: "bearer", type: "http" }],
      }),
    );
    // tryExecute has already shown a notification for the failed request
    if (error) return;

    this.#notificationContext?.peek("positive", {
      data: {
        headline: this.localize.term("myItems_itemAdded"),
        message: this._newValue,
      },
    });
    this._newValue = "";
    this.#loadItems();
  }

  async #deleteItem(item: MyItem) {
    try {
      await umbConfirmModal(this, {
        headline: this.localize.term("myItems_deleteHeadline"),
        content: this.localize.term("myItems_deleteConfirm", item.value),
        color: "danger",
        confirmLabel: this.localize.term("actions_delete"),
      });
    } catch {
      // The user cancelled the dialog
      return;
    }

    const { error } = await tryExecute(
      this,
      umbHttpClient.delete({
        url: `${ITEMS_URL}/${item.id}`,
        security: [{ scheme: "bearer", type: "http" }],
      }),
    );
    if (!error) this.#loadItems();
  }

  override render() {
    return html`
      <uui-box headline=${this.localize.term("myItems_headline")}>
        ${this._loading
          ? html`<uui-loader></uui-loader>`
          : html`
              <ul>
                ${repeat(
                  this._items,
                  (item) => item.id,
                  (item) => html`
                    <li>
                      ${item.value}
                      <uui-button
                        look="secondary"
                        color="danger"
                        label=${this.localize.term("actions_delete")}
                        @click=${() => this.#deleteItem(item)}></uui-button>
                    </li>
                  `,
                )}
              </ul>
            `}
        <uui-input
          label=${this.localize.term("myItems_newItem")}
          .value=${this._newValue}
          @input=${(event: UUIInputEvent) => (this._newValue = event.target.value.toString())}></uui-input>
        <uui-button
          look="primary"
          label=${this.localize.term("general_add")}
          ?disabled=${!this._newValue}
          @click=${this.#addItem}></uui-button>
      </uui-box>
    `;
  }

  static override styles = css`
    :host {
      display: block;
      padding: var(--uui-size-layout-1);
    }
  `;
}

export default MyItemsDashboardElement;

declare global {
  interface HTMLElementTagNameMap {
    "my-items-dashboard": MyItemsDashboardElement;
  }
}
```
{% endcode %}

Compile the element to `App_Plugins/MyItems/my-items-dashboard.js`, the file that the manifest points to. The Umbraco Extension Template compiles it for you. Without the template, see the [Vite Package Setup](../../../extend-your-project/backoffice-extensions/development-flow/vite-package-setup.md) article.

The element is the default export of the module, so the manifest needs no `elementName`.

Styles live in the element's `static styles`. The element renders into a Shadow DOM, so stylesheets on the page do not reach it.

To build a dashboard step by step, follow the [Creating a Custom Dashboard](../../../extend-your-project/tutorials/creating-a-custom-dashboard/README.md) tutorial.

## Template Syntax

Lit templates are JavaScript template literals. The following table maps the AngularJS directives to Lit:

| AngularJS                    | Lit                                                       |
| ---------------------------- | --------------------------------------------------------- |
| `{{ vm.name }}`              | `${this.name}`                                            |
| `ng-if`                      | A conditional expression, or the `when()` directive       |
| `ng-repeat`                  | The `repeat()` directive, or `Array.map()`                |
| `ng-click="vm.save()"`       | `@click=${this.save}`                                     |
| `ng-model="vm.name"`         | `.value=${this.name}` and an `@input` event listener      |
| `ng-class`                   | The `classMap()` directive                                |
| `ng-show="vm.visible"`       | `?hidden=${!this.visible}`, or a conditional expression   |
| `ng-hide="vm.hidden"`        | `?hidden=${this.hidden}`, or a conditional expression     |
| `ng-disabled`                | `?disabled=${...}`                                        |

The prefix on a binding decides what it sets. A `.` sets a property, a `?` toggles a Boolean attribute, and an `@` adds an event listener. Lit has no two-way binding, so you listen for `input` events and update the state yourself.

Import the directives from `@umbraco-cms/backoffice/external/lit`. For more about expressions, see the [Lit documentation](https://lit.dev/docs/templates/expressions/).

## Replace Services with Contexts

AngularJS injected services into a controller by parameter name. In the new backoffice, an element asks for a context with `consumeContext()`. The callback runs when the context is available.

| Umbraco 13 service                | Umbraco 14 and later                                          |
| --------------------------------- | ------------------------------------------------------------- |
| `notificationsService`            | `UMB_NOTIFICATION_CONTEXT` and its `peek()` method            |
| `userService.getCurrentUser()`    | `UMB_CURRENT_USER_CONTEXT` and its `currentUser` observable   |
| `localizationService.localize()`  | `this.localize.term()` on the element                         |
| `overlayService.confirmDelete()`  | `umbConfirmModal()`                                           |
| `editorService.open()`            | `umbOpenModal()` with a modal token                           |
| `editorService.contentPicker()`   | `umbOpenModal()` with `UMB_DOCUMENT_PICKER_MODAL`             |
| `editorService.mediaPicker()`     | `umbOpenModal()` with `UMB_MEDIA_PICKER_MODAL`                |
| `editorState.current`             | The workspace context, for example `UMB_DOCUMENT_WORKSPACE_CONTEXT` |
| `assetsService.loadJs()`          | An `import` statement                                         |

A few of these work differently:

* `this.localize.term()` returns the text right away. `localizationService.localize()` returned a promise.
* `umbConfirmModal()` returns a promise. The promise resolves when the user confirms, and rejects when the user cancels.
* Many contexts expose observables instead of promises. Use `this.observe()` to read the value when it arrives and each time it changes.

The following element replaces a call to `userService.getCurrentUser()`:

{% code title="my-current-user-greeting.element.ts" %}
```typescript
import { customElement, html, nothing, state } from "@umbraco-cms/backoffice/external/lit";
import { UMB_CURRENT_USER_CONTEXT } from "@umbraco-cms/backoffice/current-user";
import { UmbLitElement } from "@umbraco-cms/backoffice/lit-element";

@customElement("my-current-user-greeting")
export class MyCurrentUserGreetingElement extends UmbLitElement {
  @state()
  private _userName?: string;

  constructor() {
    super();
    this.consumeContext(UMB_CURRENT_USER_CONTEXT, (context) => {
      this.observe(context?.currentUser, (currentUser) => {
        this._userName = currentUser?.name;
      });
    });
  }

  override render() {
    if (!this._userName) return nothing;
    return html`<p>${this.localize.term("myItems_greeting", this._userName)}</p>`;
  }
}

export default MyCurrentUserGreetingElement;
```
{% endcode %}

Observers stop when the element leaves the page. You do not need to clean them up, as you did with `$scope.$on('$destroy')`.

For more about contexts, see the [Context API](../../../extend-your-project/backoffice-extensions/foundation/context-api/README.md) article.

## Call Your API Controller

In Umbraco 13, you called an API controller with `$http`, and `umbRequestHelper.resourcePromise` unwrapped the response:

{% code title="App_Plugins/MyItems/dashboard.controller.js" %}
```javascript
umbRequestHelper.resourcePromise(
    $http.get("backoffice/api/MyItemApi/GetAllItems?take=20"),
    "Failed to load the items")
    .then(function (data) {
        vm.items = data.Items;
    });
```
{% endcode %}

In Umbraco 14 and later, use the Umbraco HTTP Client and wrap the call in `tryExecute`, as the dashboard example does:

{% code title="my-items-dashboard.element.ts" %}
```typescript
const { data } = await tryExecute(
  this,
  umbHttpClient.get<{ 200: MyItemPage }>({
    url: "/umbraco/management/api/v1/my/item",
    query: { take: 20 },
    security: [{ scheme: "bearer", type: "http" }],
  }),
);
```
{% endcode %}

The differences from `$http` are:

* **URLs**: The route of the controller and the HTTP method replace the action name in the URL, and IDs move into the path. Write the full path, starting with `/umbraco`.
* **Property names**: The Management API returns camelCase property names. `UmbracoAuthorizedApiController` returned the C# names, so `data.Items` becomes `data.items`.
* **Authentication**: `$http` sent the backoffice cookie. The Management API uses access tokens instead. The `security` array tells the Umbraco HTTP Client to add the token of the current user.
* **Sessions**: The Umbraco HTTP Client refreshes an expired token. When the session has expired, it asks the user to log in again.
* **Errors**: `resourcePromise` showed a notification only for server errors, and passed other failures to your rejection handler. `tryExecute` returns an object with `data` and `error` instead of a rejected promise. When the request fails, it shows a notification with the title and detail from the problem details in the response.
* **Types**: The type argument maps the status code to the response type, so `data` has the right type.
* **Parameters**: Pass query string parameters in `query`, and a request body in `body`.

Responses with status 401, 403, or 404 do not show a notification. Check the returned `error`, and handle these responses in your code. For the full rules, see the [Executing Requests](../../../extend-your-project/backoffice-extensions/foundation/fetching-data/try-execute.md) article.

If your API has an OpenAPI document, you can generate a typed client instead. The Umbraco Extension Template sets up a generated client for you. For details, see the [Custom Generated Client](../../../extend-your-project/backoffice-extensions/foundation/fetching-data/custom-generated-client.md) article.

{% hint style="info" %}
Use the Fetch API only if you cannot use the Umbraco HTTP Client. With the Fetch API, you add the token and handle errors yourself. See the [Fetch API](../../../extend-your-project/backoffice-extensions/foundation/fetching-data/fetch-api.md) article.
{% endhint %}

### Replace Server Variables

In Umbraco 13, a `ServerVariablesParsingNotification` handler added values to the global `Umbraco.Sys.ServerVariables` object. Server variables do not exist in Umbraco 14 and later. The notification class still exists, but Umbraco no longer publishes it, so a handler for it never runs.

Before you move a value over, check whether your extension needs it. Often the client can work without values from the server.

If your extension needs a value from the server, add a `config` endpoint to your API controller. Call it with the Umbraco HTTP Client, as the dashboard example does. The endpoint returns only the values your extension needs, instead of adding them to a global object on every backoffice page. Only signed-in backoffice users can call it by default, and you can restrict it further with the [Access policies](../../../extend-your-project/tutorials/creating-a-backoffice-api/access-policies.md) of the Management API.

## Promises and Timers

AngularJS wrapped promises and timers in `$q` and `$timeout`, so that the view updated afterward. The new backoffice uses the standard JavaScript APIs:

| AngularJS        | Umbraco 14 and later    |
| ---------------- | ----------------------- |
| `$q.defer()`     | `new Promise()`         |
| `$q.all()`       | `Promise.all()`         |
| `$q.when()`      | `Promise.resolve()`     |
| `$timeout()`     | `setTimeout()`          |
| `.then()` chains | `async` and `await`     |

Lit has no digest cycle. An element renders again when a `@state()` or `@property()` value changes. Lit compares the old and the new value, so changing an item inside an array is not a change. Assign a new array or object to render again.

## Property Editors

Property editors follow the same patterns, with a few additions:

* `$scope.model.value` becomes the `value` property of the element. Dispatch an `UmbChangeEvent` when the value changes.
* `$scope.model.config` becomes the `config` property. Read a setting with `config.getValueByAlias()`.
* The `prevalues` in `package.manifest` become `settings` in the `meta` of the `propertyEditorUi` extension.

Umbraco migrates your existing Data Types when you upgrade. The migration depends on how you registered the property editor. For details, see the [Migrate Custom Property Editors to Umbraco Version 14 and Later](migrate-custom-property-editors-to-umbraco-14.md) article.

To build a property editor step by step, follow the [Creating a Property Editor](../../../extend-your-project/tutorials/creating-a-property-editor/README.md) tutorial.

## Related Articles

* [Umbraco Extension Template](../../../extend-your-project/backoffice-extensions/development-flow/umbraco-extension-template.md)
* [Fetching Data](../../../extend-your-project/backoffice-extensions/foundation/fetching-data/README.md)
* [UI Library](../../../extend-your-project/backoffice-extensions/ui-library.md)
* [Workspace Views](../../../extend-your-project/backoffice-extensions/extending-overview/extension-types/workspaces/workspace-views.md)
* [Porting old Umbraco API Controllers](../../../develop-with-umbraco/application-code/backend-and-custom-logic/routing/umbraco-api-controllers/porting-old-umbraco-apis.md)
