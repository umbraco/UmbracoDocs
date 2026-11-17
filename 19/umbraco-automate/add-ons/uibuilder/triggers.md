---
description: >-
  Reference for the triggers contributed by the Umbraco.UIBuilder.Automate
  add-on.
---

# Triggers

The UI Builder add-on contributes the following triggers.

| Display Name   | Alias                            |
| --------------- | ---------------------------------- |
| Entity Saved    | `umbracoUIBuilder.entitySaved`     |
| Entity Created  | `umbracoUIBuilder.entityCreated`   |
| Entity Deleted  | `umbracoUIBuilder.entityDeleted`   |

**Entity Saved** fires whenever an entity is created or updated in any registered collection. **Entity Created** fires only the first time an entity is created, not on later updates. Each trigger has an optional **Collection Alias** setting to filter to a single collection; leave it blank to fire for every collection.

{% hint style="info" %}
Trigger output includes the collection alias, the entity ID, and the entity serialized as JSON. Properties configured as encrypted on the collection are omitted from the JSON, so decrypted secrets are never exposed to an automation. Inspect a real run in the **Runs** view to see the exact field names, then use the binding picker to reference them in downstream steps.
{% endhint %}

## Entity Deleted on EF Core

UI Builder 19 uses EF Core by default. With EF Core, **Entity Deleted** behaves differently from earlier versions:

* **Entity Deleted** also fires for soft deletes.
* The entity JSON carries scalar properties only, because EF Core doesn't include navigation properties.

UI Builder sometimes raises a delete for a row that is already gone. **Entity Deleted** skips that delete and doesn't fire.
