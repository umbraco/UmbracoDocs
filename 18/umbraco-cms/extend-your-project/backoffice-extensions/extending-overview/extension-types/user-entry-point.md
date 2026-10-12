---
description: >-
  The User Entry Point extension type is used to run JavaScript code when a user session starts and ends.
---

# User Entry Point

{% hint style="info" %}
The User Entry Point is available from Umbraco 18.2.
{% endhint %}

The User Entry Point manifest declares a single JavaScript file that runs when a user session starts. The `onInit` function is only called once the user has been authorized **and** the current user data has been loaded. This means you can rely on the Current User Context being populated. Properties like the allowed sections are never `undefined`.

{% hint style="info" %}
See [Backoffice Entry Point](backoffice-entry-point.md) if your code does not depend on the signed-in user. See [App Entry Point](app-entry-point.md) if it must run before the user is signed in.
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
         "name": "My User Entry Point",
         "js": "/App_Plugins/YourFolder/user.js"
        }
    ]
}
```
{% endcode %}

**Register a User Entry Point in a TypeScript manifest**

If your package loads its manifests through a [Bundle](bundle.md), add the User Entry Point to the exported manifests:

{% code title="manifests.ts" %}
```typescript
export const manifests: Array<UmbExtensionManifest> = [
    {
        type: 'userEntryPoint',
        alias: 'My.UserEntryPoint',
        name: 'My User Entry Point',
        js: () => import('./user.js'),
    },
];
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

## Session lifecycle

`onInit` runs when a user session starts. `onUnload` runs when the session ends, because the user signs out or the session times out. It also runs if the extension is unregistered.

If a user signs in again after a timeout, `onInit` runs again. The new session may belong to a different user.

Each browser tab runs its own copy of the module. Every open tab calls `onInit`, and reloading a tab calls `onInit` again. Closing or reloading a tab does not call `onUnload`. Do not rely on `onUnload` to clean up state on the server. Let that state expire on its own.

{% hint style="warning" %}
When `onUnload` runs, the session has already ended. Do not call Umbraco's APIs from `onUnload`. On sign-out the page navigates away right after `onUnload`. After a timeout, the request fails or waits for the next sign-in. Keep the cleanup synchronous and local, such as closing a connection.
{% endhint %}

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

### Start and stop a service for the signed-in user

Use the session boundaries to set up and clean up anything that belongs to a specific user. Examples are a notification connection or an analytics identity. `onUnload` is not passed the user. If the cleanup needs to know who is leaving, capture the identity in `onInit` and reuse it:

{% code title="user.ts" %}
```typescript
import type { UmbEntryPointOnInit, UmbEntryPointOnUnload } from '@umbraco-cms/backoffice/extension-api';
import { UMB_CURRENT_USER_CONTEXT } from '@umbraco-cms/backoffice/current-user';
// Your own module, not part of Umbraco
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
    sessionUserUnique = undefined;
};
```
{% endcode %}

Keep setup and cleanup symmetrical, so nothing from one user's session leaks into the next. Use the identity captured in `onInit`. Do not read the Current User Context in `onUnload`.

### Register extensions for specific users

Register extensions based on who is signed in, and unregister them again when the session ends. This way the next session starts from a clean slate, even if it belongs to a different user:

{% code title="user.ts" %}
```typescript
import type { UmbEntryPointOnInit, UmbEntryPointOnUnload } from '@umbraco-cms/backoffice/extension-api';
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

const manifest: UmbExtensionManifest = {
    type: 'dashboard',
    alias: 'My.Dashboard.Reports',
    name: 'Reports Dashboard',
    element: () => import('./reports-dashboard.element.js'),
    meta: { label: 'Reports', pathname: 'reports' },
    conditions: [{ alias: 'Umb.Condition.SectionAlias', match: 'Umb.Section.Content' }],
};

export const onInit: UmbEntryPointOnInit = async (host, extensionRegistry) => {
    // Your own endpoint decides, based on the signed-in user, whether they have access
    const { response } = await umbHttpClient.get({
        url: '/umbraco/my-reports/api/v1/access',
        security: [{ scheme: 'bearer', type: 'http' }],
    });
    if (response?.ok) {
        extensionRegistry.register(manifest);
    }
};

export const onUnload: UmbEntryPointOnUnload = (host, extensionRegistry) => {
    extensionRegistry.unregister(manifest.alias);
};
```
{% endcode %}

{% hint style="info" %}
For checks that a built-in condition covers, such as `Umb.Condition.CurrentUser.IsAdmin` or `Umb.Condition.CurrentUser.GroupId`, add the condition to the extension's manifest instead. See [Extension Conditions](condition.md#current-user).
{% endhint %}

### React to changes during the session

`onInit` runs once per session. It does **not** run again when the user's data changes. The Current User Context updates when the user changes their profile or language, or edits their own user or one of their groups. Changes made elsewhere arrive at the next sign-in or reload. Observe the Current User Context for anything long-lived:

{% code title="user.ts" %}
```typescript
import type { UmbEntryPointOnInit, UmbEntryPointOnUnload } from '@umbraco-cms/backoffice/extension-api';
import { UMB_CURRENT_USER_CONTEXT } from '@umbraco-cms/backoffice/current-user';

const ALLOWED_SECTIONS_OBSERVER = 'My.UserEntryPoint.AllowedSections';

export const onInit: UmbEntryPointOnInit = async (host) => {
    const currentUserContext = await host.getContext(UMB_CURRENT_USER_CONTEXT);
    host.observe(currentUserContext?.allowedSections, (allowedSections) => {
        // Runs immediately and again every time the user's allowed sections change
    }, ALLOWED_SECTIONS_OBSERVER);
};

export const onUnload: UmbEntryPointOnUnload = (host) => {
    host.removeUmbControllerByAlias(ALLOWED_SECTIONS_OBSERVER);
};
```
{% endcode %}

The host outlives the session. Remove the observer in `onUnload`, so the observer does not keep running into the next session.

## Type IntelliSense

The examples use the global `UmbExtensionManifest` type. See [Setup Your Development Environment](../../../backoffice-extensions/development-flow/README.md#typescript-setup) to configure the types.

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
