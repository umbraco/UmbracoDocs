---
description: >-
  Reference for the actions contributed by the Umbraco.UIBuilder.Automate
  add-on.
---

# Actions

The UI Builder add-on contributes the following actions.

| Display Name  | Alias                          | Purpose                                                  |
| -------------- | -------------------------------- | ----------------------------------------------------------- |
| Create Entity  | `umbracoUIBuilder.createEntity`  | Create a new entity in a named collection from a JSON payload. |
| Delete Entity  | `umbracoUIBuilder.deleteEntity`  | Delete an entity from a named collection by ID.               |

{% hint style="info" %}
Open the step in the canvas to see each action's settings and output fields. Both actions support bindings, so the collection alias, entity JSON, and entity ID can all come from an upstream trigger or step.
{% endhint %}
