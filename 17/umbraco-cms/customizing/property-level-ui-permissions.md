---
description: >-
  Use the UI Property Permissions to restrict access to specific properties in
  the Backoffice UI.
---

# Property Level UI Permissions

## Document Property Value User Permissions

Umbraco provides a feature called Document Property Value User Permissions. This feature can restrict access to specific Document property values for certain user groups. By default, all the built-in User Groups have read and write permissions for all properties. However, you can limit a User Group's permissions for specific properties through the UI.

If a User Group doesn't have write access to a property, the property will be read-only for that User Group. If a User Group doesn't have read access to a property, the property will be hidden from that User Group.

{% hint style="info" %}
The Document Property Value User Permissions are not enforced on the server side. This means a user can still access the property value through the API, even if the property is restricted in the UI.
{% endhint %}

## Write custom Property Level Permissions

It is possible to manipulate the permissions via code. This can be achieved through the Guard Managers available on all Content-Type-based Workspace Contexts.

These are the available guards:

* `propertyViewGuard`  - Manages rules for the visibility of properties.
* `propertyWriteGuard` - Manages rules for the writability of properties.
* `readOnlyGuard` (This will be removed in the future. Use `propertyWriteGuard` instead)

The following guide demonstrates how to implement custom rules from a Workspace Context that appends rules to the Guard Managers.

### Register a Workspace Context

Register a [Workspace Context](https://github.com/madsrasmussen/UmbracoDocs/blob/180d6e9eb7ab722a24b7b209c71de03cbe811e00/15/umbraco-cms/customizing/extending-overview/extension-types/workspaces/workspace-context.md) to enable appending code to run when a workspace is initialized.

**Manifest**

{% code title="manifest.ts" %}
```typescript
import { UMB_WORKSPACE_CONDITION_ALIAS } from "@umbraco-cms/backoffice/workspace";
import { UMB_DOCUMENT_WORKSPACE_ALIAS } from "@umbraco-cms/backoffice/document";

const manifest: UmbExtensionManifest = {
    type: "workspaceContext",
    name: "My Document Property Permission Workspace Context",
    alias: "My.WorkspaceContext.DocumentPropertyPermission",
    api: () => import("./my-document-property-permission.workspace-context.js"),
    conditions: [
        {
            alias: UMB_WORKSPACE_CONDITION_ALIAS,
            match: UMB_DOCUMENT_WORKSPACE_ALIAS,
        },
    ],
};
```
{% endcode %}

### Write a general rule

The following example adds code for the Workspace Context to set up a single rule preventing writing to all properties.

**Workspace Context**

{% code title="WorkspaceContext.ts" %}
```typescript
import { UmbControllerBase } from "@umbraco-cms/backoffice/class-api";
import type { UmbControllerHost } from "@umbraco-cms/backoffice/controller-api";
import { UMB_DOCUMENT_WORKSPACE_CONTEXT } from "@umbraco-cms/backoffice/document";
import { UmbVariantId } from "@umbraco-cms/backoffice/variant";

export class MyDocumentPropertyPermissionWorkspaceContext extends UmbControllerBase {
    constructor(host: UmbControllerHost) {
        super(host);

        // Consume the document workspace context
        this.consumeContext(
            UMB_DOCUMENT_WORKSPACE_CONTEXT,
            (context) => {
            
                // Create a rule:
                const rule = {
                    unique: 'myCustomRuleIdentifier',
                    permitted: false,
                    message: "None of these properties are writable because of my custom restriction.",
                }
                // Add the rule to the write guard
                context?.propertyWriteGuard.addRule(rule);
            }
        );
    }
}

export { MyDocumentPropertyPermissionWorkspaceContext as api };
```
{% endcode %}

This showed how to append a general rule to all properties or variants. This can be made more specific. Therefore, the following example shows how to make a rule that applies to a specific property.

### Write a rule for a specific property

The following example adds code to retrieve the `unique` value for a given property. This is then used to create a rule that only prevents writing to that property.

**Workspace Context**

{% code title="WorkspaceContext.ts" %}
```typescript
import { UmbControllerBase } from "@umbraco-cms/backoffice/class-api";
import type { UmbControllerHost } from "@umbraco-cms/backoffice/controller-api";
import { UMB_DOCUMENT_WORKSPACE_CONTEXT } from "@umbraco-cms/backoffice/document";
import { UmbVariantId } from "@umbraco-cms/backoffice/variant";

export class MyDocumentPropertyPermissionWorkspaceContext extends UmbControllerBase {
    constructor(host: UmbControllerHost) {
        super(host);

        // Consume the document workspace context
        this.consumeContext(
            UMB_DOCUMENT_WORKSPACE_CONTEXT,
            async (context) => {
            
                // Observe the specific property of the Content Type, to retrieve the unique.
                this.observe(await context?.structure.propertyStructureByAlias('myNoneWritableProperty'), (property) => {
                    if(property) {
                        // Create a guard rule:
                        const rule = {
                            unique: 'myCustomRuleIdentifier',
                            permitted: false,
                            message: "The property is not writable because of my custom restriction.",
                            propertyType: {
                                unique: property.unique
                            }
                        }
                        // Add the rule to the write guard
                        context.propertyWriteGuard.addRule(rule);
                    }
                });
            }
        );
    }
}

export { MyDocumentPropertyPermissionWorkspaceContext as api };
```
{% endcode %}

The next example will adjust the rule so it only prevents writing on a specific culture.

### Write a rule for a specific property or a specific variant

The following example shows how you can make your rule very specific by targeting a property and a `VariantID`.

**Adjusting the rule for the Workspace Context:**

{% code title="WorkspaceContext.ts" %}
```typescript
import type { UmbVariantId } from '@umbraco-cms/backoffice/variant';

...

        // Create a guard rule:
        const rule = {
            unique: 'myCustomRuleIdentifier',
            permitted: false,
            message: "The property is not writable because of my custom restriction.",
            propertyType: {
                unique: property.unique
            }
            variantId: UmbVariantId.CreateFromPartial({culture: 'en-US'});
            
...
```
{% endcode %}

You are in charge of the combination, from targeting everything to targeting a specific property on a specific variant. The last combination purely targets a variant. This means that all properties with values of that variant is also available.
