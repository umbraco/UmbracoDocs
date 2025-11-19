---
description: Bulk Entity Actions perform an action on a selection of items.
---

# Entity Bulk Actions

Extension authors can register an entity bulk action to appear in the collection selection toolbar.

<figure><img src="../../../../../15/umbraco-cms/.gitbook/assets/entity-bulk-action-collection-menu (1).svg" alt=""><figcaption><p>Entity Bulk Collection</p></figcaption></figure>

## Registering an Entity Bulk Action <a href="#registering-an-entity-bulk-action" id="registering-an-entity-bulk-action"></a>

Entity Bulk Action extensions can be included by importing a subclass of `UmbEntityBulkActionBase` to the `api` property. Placement within the backoffice can be controlled using the conditions property.

```typescript
import { umbExtensionsRegistry } from '@umbraco-cms/backoffice/extension-registry';
import { MyEntityBulkAction } from './entity-bulk-action';

const manifest = {
 type: 'entityBulkAction',
 alias: 'My.EntityBulkAction',
 name: 'My Entity Bulk Action',
 weight: 10,
 api: MyEntityBulkAction,
 meta: {
  icon: 'icon-add',
  label: 'My Entity Bulk Action',
 },
 conditions: [
  {
   alias: 'Umb.Condition.CollectionAlias',
   match: 'my-collection-alias',
  },
 ],
};

umbExtensionsRegistry.register(manifest);
```

## The Entity Bulk Action Class <a href="#the-entity-bulk-action-class" id="the-entity-bulk-action-class"></a>

Entity Bulk Action extensions inherit from `UmbEntityBulkActionBase`, which expects the extension author to provide an implementation of `execute()`. The `UmbEntityBulkActionBase` class provides `this.selection` as a property, which contains a list of uniques from the content nodes that were selected by the user.

When the action is completed, an event on the host element will be dispatched to notify any surrounding elements.

{% hint style="info" %}
This code sample demonstrates overriding the constructor, which could be helpful in certain circumstances, such as consuming contexts. Extension authors can safely omit the constructor if no such need exists.
{% endhint %}

```typescript
import {
    UmbEntityBulkActionBase,
    UmbEntityBulkActionArgs,
} from "@umbraco-cms/backoffice/entity-bulk-action";
import { UmbControllerHostElement } from "@umbraco-cms/backoffice/controller-api";

export class MyBulkEntityAction extends UmbEntityBulkActionBase<never> {
    constructor(
        host: UmbControllerHostElement,
        args: UmbEntityBulkActionArgs<never>,
    ) {
        // this constructor is optional, override only if necessary
        super(host, args);
    }

    async execute() {
        // perform a network request
        // await Promise.all(
        //     this.selection.map(async (x) => {
        //         const res = await fetch(`my-server-api-endpoint/${x}`);
        //         return res.json() as never;
        //     })
        // );

        // or fetch repository
        // const repository = ...
        // await repository.processItems(this.selection);
        
        console.log(this.selection);
    }
}
```
