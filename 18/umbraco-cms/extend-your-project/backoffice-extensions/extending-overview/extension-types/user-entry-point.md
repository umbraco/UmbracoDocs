---
description: >-
  The User Entry Point extension type is used to run JavaScript code when a
  user session starts and ends.
---

# User Entry Point

This manifest declares a single JavaScript file that runs when a user session starts. The `onInit` function is only called once the user has been authorized **and** the current user data has been loaded. This means you can rely on the Current User Context being populated. Properties like the allowed sections are never `undefined`.

{% hint style="info" %}
See [Backoffice Entry Point](backoffice-entry-point.md) if your code does not depend on the signed-in user. See [App Entry Point](app-entry-point.md) if it must run before the user is logged in.
{% endhint %}

The `onUnload` function is called when the user session ends: when the user signs out or the session times out. If a user signs in again, `onInit` runs again. Be aware that the new session may belong to a different user than the previous one.

{% hint style="warning" %}
When the user signs out, the browser leaves the page right after `onUnload` is called. Keep the cleanup synchronous. Asynchronous work, such as waiting for a timer or a server response, may not finish. When the session times out, the page stays open and asynchronous work completes.
{% endhint %}

**Register a User Entry Point in the `umbraco-package.json` manifest**

{% code title="umbraco-package.json" %}
```json
{
    "name": "Name of your package",
    "alias": "My.Package",
    "extensions": [
        {
         "type": "userEntryPoint",
         "alias": "My.UserEntryPoint",
         "js": "/App_Plugins/YourFolder/user.js"
        }
    ]
}
```
{% endcode %}

**Base structure of the entry point file**

{% hint style="info" %}
All examples are in TypeScript, but you can use JavaScript as well. Make sure to use a bundler such as [Vite](../../development-flow/vite-package-setup.md) to compile your TypeScript to JavaScript.
{% endhint %}

{% code title="user.ts" %}
```typescript
import type { UmbEntryPointOnInit, UmbEntryPointOnUnload } from '@umbraco-cms/backoffice/extension-api';

/**
 * Runs when a user session starts: the user is authorized and the current user data is loaded.
 */
export const onInit: UmbEntryPointOnInit = (host, extensionRegistry) => {
    // Your initialization logic here
}

/**
 * Runs when the user session ends: the user signs out or the session times out.
 */
export const onUnload: UmbEntryPointOnUnload = (host, extensionRegistry) => {
    // Your cleanup logic here
}
```
{% endcode %}

## Examples

### Read the current user

Consume the Current User Context to read details about the signed-in user:

{% code title="user.ts" %}
```typescript
import type { UmbEntryPointOnInit } from '@umbraco-cms/backoffice/extension-api';
import { UMB_CURRENT_USER_CONTEXT } from '@umbraco-cms/backoffice/current-user';

export const onInit: UmbEntryPointOnInit = async (host) => {
    const currentUserContext = await host.getContext(UMB_CURRENT_USER_CONTEXT);
    console.log('Allowed sections:', currentUserContext?.getAllowedSection());
};
```
{% endcode %}

{% hint style="info" %}
In a `userEntryPoint` the current user data is guaranteed to be loaded when `onInit` runs. In `appEntryPoint` and `backofficeEntryPoint` extensions this is not the case, and reading the current user there requires observing the context until the data arrives.
{% endhint %}

### Start and stop a service for the signed-in user

Use the session boundaries to set up and clean up anything that belongs to a specific user. Examples are a notification connection or an analytics identity. `onUnload` is not passed the user. If the cleanup needs to know who is leaving, capture the identity in `onInit` and reuse it:

{% code title="user.ts" %}
```typescript
import type { UmbEntryPointOnInit, UmbEntryPointOnUnload } from '@umbraco-cms/backoffice/extension-api';
import { UMB_CURRENT_USER_CONTEXT } from '@umbraco-cms/backoffice/current-user';
import { MyNotificationService } from './my-notification-service.js';

const notifications = new MyNotificationService();
let sessionUserUnique: string | undefined;

export const onInit: UmbEntryPointOnInit = async (host) => {
    const currentUserContext = await host.getContext(UMB_CURRENT_USER_CONTEXT);
    sessionUserUnique = currentUserContext?.getUnique();
    if (sessionUserUnique) {
        notifications.connect(sessionUserUnique);
    }
};

export const onUnload: UmbEntryPointOnUnload = () => {
    // sessionUserUnique still identifies the user this session belonged to.
    notifications.disconnect(sessionUserUnique);
};
```
{% endcode %}

{% hint style="info" %}
`onInit` and `onUnload` are called once per session. If the session times out and someone signs in again, the pair runs again, potentially for a different user. Keeping setup and cleanup symmetrical ensures nothing from the previous user's session leaks into the next.
{% endhint %}

{% hint style="info" %}
Capturing the user in `onInit`, as above, is the reliable way to know who a later `onUnload` is for. The captured value belongs to the session that the pair brackets. Reading `UMB_CURRENT_USER_CONTEXT` inside `onUnload` also returns the departing user. That only works because the current user data is not cleared until the next sign-in. Prefer the captured value when the identity matters.
{% endhint %}

### Register extensions for specific users

Register extensions based on who is signed in, and unregister them again when the session ends. This way the next session starts from a clean slate, even if it belongs to a different user:

{% code title="user.ts" %}
```typescript
import type { UmbEntryPointOnInit, UmbEntryPointOnUnload } from '@umbraco-cms/backoffice/extension-api';
import { UMB_CURRENT_USER_CONTEXT } from '@umbraco-cms/backoffice/current-user';

const manifest: UmbExtensionManifest = {
    type: 'dashboard',
    alias: 'My.Dashboard.AdminTools',
    name: 'Admin Tools Dashboard',
    element: () => import('./admin-tools-dashboard.element.js'),
    meta: {
        label: 'Admin Tools',
        pathname: 'admin-tools',
    },
};

export const onInit: UmbEntryPointOnInit = async (host, extensionRegistry) => {
    const currentUserContext = await host.getContext(UMB_CURRENT_USER_CONTEXT);
    if (await currentUserContext?.isCurrentUserAdmin()) {
        extensionRegistry.register(manifest);
    }
};

export const onUnload: UmbEntryPointOnUnload = (host, extensionRegistry) => {
    extensionRegistry.unregister(manifest.alias);
};
```
{% endcode %}

{% hint style="info" %}
If the extension can express its requirement with an [extension condition](../extension-conditions.md), prefer that over registering it in code. Use a `userEntryPoint` when the decision needs custom logic, such as calling your own API.
{% endhint %}

### React to changes during the session

`onInit` runs once per session. It does **not** run again when the user's data changes. If someone edits the user's permissions, or the user changes their language, a value read in `onInit` does not update. Observe the Current User Context for anything long-lived:

{% code title="user.ts" %}
```typescript
import type { UmbEntryPointOnInit } from '@umbraco-cms/backoffice/extension-api';
import { UMB_CURRENT_USER_CONTEXT } from '@umbraco-cms/backoffice/current-user';

export const onInit: UmbEntryPointOnInit = async (host) => {
    const currentUserContext = await host.getContext(UMB_CURRENT_USER_CONTEXT);
    host.observe(currentUserContext?.allowedSections, (allowedSections) => {
        // Runs immediately and again every time the user's allowed sections change
    });
};
```
{% endcode %}

{% hint style="warning" %}
User data can change in the middle of a session. An administrator can edit the user's groups, or the user can change their own profile and language. Only observed values stay current; anything read once stays as it was at sign-in.
{% endhint %}

## Type IntelliSense

It is recommended to make use of the Type intellisense that we provide.

When writing your Manifest in TypeScript, you should use the `UmbExtensionManifest` type. Read the [TypeScript setup](../../../backoffice-extensions/development-flow/README.md#typescript-setup) article to make sure you have Types correctly configured.

## What's next?

See the Extension Types article for more information about all the different extension types available in Umbraco:

{% content-ref url="./" %}
[.](./)
{% endcontent-ref %}

Read about the entry points that are not tied to the user session:

{% content-ref url="backoffice-entry-point.md" %}
[backoffice-entry-point.md](backoffice-entry-point.md)
{% endcontent-ref %}

{% content-ref url="app-entry-point.md" %}
[app-entry-point.md](app-entry-point.md)
{% endcontent-ref %}
