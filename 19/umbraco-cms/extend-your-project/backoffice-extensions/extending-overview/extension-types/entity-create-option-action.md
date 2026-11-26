# Entity Create Option Action

An "Entity Create Option Action" is an additional option that can be added when creating an entity. For example, options like "Create Document Type" or "Create Document Type with Template" can be available when a Document Type is being created.

These options will be displayed in a create options dialog when the "Create"-entity action is selected. The dialog will show the available options and allow the user to select one of them.

To enable a "Create"-entity action to show the options dialog, use the 'create'-kind in the manifest when setting up the "Create"-entity action. This will display the options dialog if multiple options are available, or it will automatically execute the first option if only one is available.

By using the "create"-kind for your create entity actions, you can ensure that your options are extendable by other developers. This also applies when you only have one option available

The following code shows you to register a "Create"-entity action that can display a dialog with options:

```typescript
const manifest = {
    type: "entityAction",
    kind: "create",
    alias: "My.EntityAction",
    name: "My Create Entity Action",
    forEntityTypes: ["my-entity"],
};
```

The following code demonstrates how to register an Entity Create Option Action. If only one option is available, it will be executed immediately.

```typescript
const manifest = {
    type: "entityCreateOptionAction",
    alias: "My.EntityCreateOptionAction",
    name: "My Create Option Action",
    weight: 100,
    api: () => import("./path-to-file.js"),
    forEntityTypes: ["my-entity"],
    meta: {
        icon: "icon-unplug",
        label: "My Create Option Action",
        additionalOptions: false,
    },
};
```

The following code shows how to implement the Create Action Option.

```typescript
import {
    UmbEntityCreateOptionActionBase,
    type MetaEntityCreateOptionAction,
    type UmbEntityCreateOptionActionArgs,
} from "@umbraco-cms/backoffice/entity-create-option-action";
import type { UmbControllerHostElement } from "@umbraco-cms/backoffice/controller-api";

export class MyEntityCreateActionOption extends UmbEntityCreateOptionActionBase {
    constructor(
        host: UmbControllerHostElement,
        args: UmbEntityCreateOptionActionArgs<MetaEntityCreateOptionAction>
    ) {
        super(host, args);
    }

    override async execute() {
        alert("My Create Option Action executed!");
    }
}
```

We currently support Create Options for the following entity types:

- User
