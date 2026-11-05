---
description: Perform bulk operations on entities in Umbraco Commerce.
---

# Bulk Actions

{% hint style="danger" %}
This feature has changed in v14 and requires updated documentation.
{% endhint %}

You might need to execute a custom action for each entity in a selection while extending Umbraco Commerce. For example, being able to trigger label printing for a series of orders, or printing physical gift cards for specific gift card entities.

Umbraco Commerce allows extending the different table views, adding in **Bulk Actions** to the bulk action bar that appears when you select multiple items. Out of the box all list views contain at minimum a **Delete** bulk action.

## Injecting a Bulk Action

Bulk actions are client-side concepts and so additional bulk actions are injected with JavaScript in an AngularJS configuration module.

To create a configuration module you can create a custom folder in the `App_Plugins` directory and create a JavaScript file to hold your configuration in.

1. Create a custom folder in the `App_Plugins` directory.
2. Create a JavaScript file with this new folder.

```bash
App_Plugins\MyPlugin\backoffice\config\umbraco-commerce-bulk-actions-config.js
```

3. Register the file in a `package.manifest` file within the same folder.

```bash
App_Plugins\MyPlugin\package.manifest
```

4. Add the following JSON to the `package.manifest` file:

```javascript
{
    "javascript": [
        "~/App_Plugins/MyPlugin/backoffice/config/umbraco-commerce-bulk-actions-config.js"
    ]
}
```

5. Inject a bulk action inside the `umbraco-commerce-bulk-actions-config.js` by adding the following:

```csharp
angular.module('umbracoCommerce')
    .config(['umbracoCommerceActionsProvider', function (umbracoCommerceActionsProvider) {
        umbracoCommerceActionsProvider.bulkActions.push(['myResource', function (myResource)
        {
            return {
                name: 'My Action',
                icon: 'icon-box',
                itemAction: function (bulkItem) {
                    return myResource.doAction(bulkItem.id);
                },
                condition: function (ctx) {
                    return ctx.entityType == 'Order'
                },
                sortOrder: 110
            }
        }]);
    }]);

```

Once created, the bulk action will be displayed in the bulk actions bar for the configured entities.

![Bulk Action Button](../media/custom\_bulk\_action.png)

## Bulk Action Options

| Property    | Description                                                                                                                                                                                          |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`      | Name of your bulk action that will be displayed in the bulk action button.                                                                                                                           |
| `icon`      | Icon for your bulk action that will be displayed in the bulk action button next to the name.                                                                                                         |
| `sortOrder` | The order in which to display this action in the bulk actions bar. System bulk actions sort orders are in multiples of `100` in order to allow the positioning of items between system bulk actions. |

| Method                           | Description                                                                                                                                                                                       |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `configure(items)`               | A function to run before the bulk operation in order to provide configuration for the bulk action. Returns a Promise that returns an object which is then passed to the item/bulk action methods. |
| `itemAction(item, config)`       | Individual action to perform per selected item. A status will be displayed after each processed item shows progress. Returns a Promise.                                                           |
| `bulkAction(items, config)`      | Single action to be performed for all selected items in one go. Returns a Promise.                                                                                                                |
| `getConfirmMessage(total)`       | A function that can provide a message to display before a bulk action is triggered should confirmation be required for the action to run. Returns a Promise that returns a string.                |
| `getStatusMessage(count, total)` | Function used to provide a status message after each item has been processed. Displayed in the bulk actions bar after each `itemAction` has been called. Returns a Promise that returns a string. |
| `getSuccessMessage(total)`       | A function to return a success message after all bulk actions have been performed. Returns a Promise that returns a string.                                                                       |
| `condition(context)`             | As all bulk actions are registered globally for all entity types, the `condition` function can be used to filter when, and for which entities a bulk action will display.                         |

Only an `itemAction` or a `bulkAction` method can be defined for a bulk action configuration. If both are present, the `bulkAction` will be used and the `itemAction` will be ignored. If processing of items can be done individually, it is better to use the `itemAction` in order to provide user feedback. The `bulkAction` can only be used where items need to be processed in a single action.

## Important Notes

* Most methods apart from `itemAction` or `bulkAction` are optional. If methods aren't present, a default implementation will be used. Where the methods trigger, specific functionality such as the `configure` or `getConfirmMessage` methods will become disabled.
* The array-based syntax for registering is a bulk action with angular dependencies. Each bulk action is registered as an array, where all dependencies are defined first and then a factory function is defined last which returns the actual bulk action definition.
* Whilst these docs outline how to define a bulk action, you will likely need to register further resources or services that can perform the given bulk operation and include these as a dependency for your action.

## Examples

The following section display an example of a bulk action with dialog configuration step:

```csharp
angular.module('umbracoCommerce')
    .config(['umbracoCommerceActionsProvider', function (umbracoCommerceActionsProvider) {
        umbracoCommerceActionsProvider.bulkActions.push(['$q', 'editorService', 'myResource', function ($q, editorService, myResource)
        {
            return {
                name: 'My Action',
                icon: 'icon-box',
                configure: function (selected) {
                    return $q(function (resolve, reject) {
                        editorService.open({
                            view: '/app_plugins/myplugin/views/dialogs/config.html',
                            size: 'small',
                            config: {
                                items: selected
                            },
                            submit: function (model) {
                                editorService.close();
                                resolve(model);
                            },
                            close: function () {
                                editorService.close();
                                reject();
                            }
                        });
                    });
                },
                bulkAction: function (items) {
                    var ids = items.map(itm => itm.id);
                    return myResource.doAction(ids);
                },
                condition: function (ctx) {
                    return ctx.entityType == 'Order'
                },
                sortOrder: 110
            }
        }]);
    }]);

```
