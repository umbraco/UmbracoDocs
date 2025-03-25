# UI Property Permissions

The UI Property Permissions are used to restrict access to specific properties in the Backoffice UI.

## Document Property Value User Permissions

Out of the box, Umbraco provides a feature called Document Property Value User Permissions.This feature can restrict access to specific Document property values for certain user groups. By default, all the built-in User Groups have read and write permissions for all properties. However, you can limit a User Group's permissions specific properties through the UI.

If a User Group does not have write access to a property, the property will be read-only for that User Group. If a User Group does not have read access to a property, the property will be hidden from that User Group.

Be aware that the Document Property Value User Permissions are not enforced on the server-side. This means that a user can still access the property value through the API, even if the property is restricted in the UI.

## Extending the Document Property Value User Permission with additional restrictions

In addition to the User Permission logic, it is possible to add further restrictions to properties. This can be achieved through the `propertyReadOnlyState`-Manager available in property based Workspace Context. In the following example, we will make all invariant properties read-only.

## Register a Workspace Context

Register a [Workspace Context](./extending-overview/extension-types/workspaces/workspace-context.md) to append additional restrictions to properties.

**Manifest**

```ts
import { UMB_WORKSPACE_CONDITION_ALIAS } from "@umbraco-cms/backoffice/workspace";
import { UMB_WORKSPACE_CONDITION_ALIAS } from "@umbraco-cms/backoffice/document";

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

## Implement custom logic for Property Value Permissions

Implement custom logic to identify all properties and add a read-only state for each one. To target a property, we use its unique identifier along with the variant ID that corresponds to that property. In the following example, we will focus specifically on the invariant properties.

**Workspace Context**

```ts
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
            this.#observeStructure
        );
    }

    #observeStructure(context: typeof UMB_DOCUMENT_WORKSPACE_CONTEXT.TYPE) {
        if (!context) return;

        // Observe all properties for the Content Type
        this.observe(context.structure.contentTypeProperties, (properties) => {
            if (properties.length === 0) return;

            // Create a new variant ID for the invariant properties
            const invariantId = new UmbVariantId();

            // Create a read-only state for each property
            const states = properties.map((property) => {
                return {
                    unique:
                        "MY_INVARIANT_PROPERTY_RESTRICTION_" + property.unique,
                    message:
                        "The property is read only because of my restriction",
                    propertyType: {
                        unique: property.unique,
                        variantId: invariantId,
                    },
                };
            });

            // Add the read-only states to the property read-only state manager
            context.structure.propertyReadOnlyState.addStates(states);
        });
    }
}

export { MyDocumentPropertyPermissionWorkspaceContext as api };
```

## Custom logic For Property value permissions

It is also possible to implement completely custom UI logic for managing property value permissions. To do this, you first need to remove the default read and write access to properties for the user group. As a result, all properties will be hidden from that user group. Afterward, you can create custom logic to determine whether a specific user group should have access to particular properties.

We follow the same concept as the previous example, but instead of writing to the `propertyReadOnlyState`-Manager, we can use the `propertyViewState`-Manager and the `propertyWriteState`-Manager to control the view- and writability of properties.

In the following example we will hide a specific property based on the propertyAlias.

## Register a workspace context for the Document Workspace

For the manifest we can use the same manifest as the previous example.

## Implement custom logic for Property Value Permissions

Implement custom logic to identify all properties and add a view and write state for each one.

```ts
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
            this.#observeStructure
        );
    }

    #observeStructure(context: typeof UMB_DOCUMENT_WORKSPACE_CONTEXT.TYPE) {
        if (!context) return;

        // Observe all properties for the Content Type
        this.observe(context.structure.contentTypeProperties, (properties) => {
            if (properties.length === 0) return;

            // Filter out the property with the alias "myPropertyAlias"
            const allowedProperties = properties.filter(
                (property) => property.alias !== "myPropertyAlias"
            );

            // Create a new variant ID for the invariant properties
            const invariantId = new UmbVariantId();

            // Create a read-only state for each property
            const states = allowedProperties.map((property) => {
                return {
                    unique:
                        "MY_INVARIANT_PROPERTY_RESTRICTION_" + property.unique,
                    message: "",
                    propertyType: {
                        unique: property.unique,
                        variantId: invariantId,
                    },
                };
            });

            // Add the read-only states to the property read-only state manager
            context.structure.propertyViewState.addStates(states);
            context.structure.propertyWriteState.addStates(states);
        });
    }
}
```
