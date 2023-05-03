---
title: Bulk Actions
description: Perform bulk operations on entities in Vendr, the eCommerce solution for Umbraco
---

When extending Vendr, there may come a time when you need the ability to perform a custom action for every entity in a given selection, for example being able to trigger label printing for a series of orders, or printing physical gift cards for specific gift card entities.

To help with this, Vendr allows extending the various table views of entities, adding in your own **Bulk Actions** to the bulk action bar that appears when you select multiple items in the list view. Out of the box all list views contain at minimum a **Delete** bulk action.

## Injecting a Bulk Action

Bulk actions are a client side concept and so additional bulk actions are injected with javascript in an AngularJS configuration module.

To create a configuration module you can create a custom folder in the `App_Plugins` directory and create a javascript file to hold your configuration in.

````bash
App_Plugins\MyPlugin\backoffice\config\vendr-bulk-actions-config.js
````

This file should then be registered in a `package.manifest` file in root plugin folder...

````bash
App_Plugins\MyPlugin\package.manifest
````

With the following contents:

````javascript
{
    "javascript": [
        "~/App_Plugins/MyPlugin/backoffice/config/vendr-bulk-actions-config.js"
    ]
}
````

Inside the `vendr-bulk-actions-config.js` we can then inject a bulk action as follows:


````csharp
angular.module('vendr')
    .config(['vendrActionsProvider', function (vendrActionsProvider) {
        vendrActionsProvider.bulkActions.push(['myResource', function (myResource)
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
    }]):

````

Once created, the bulk action will then be displayed in the bulk actions bar for the configured entities.

![Bulk Action Button](../media/custom_bulk_action.png)

## Bulk Action Options

| Property | Description |
| -------- | ----------- |
| `name` | The name for your bulk action which will be displayed in the bulk action button |
| `icon` | An icon for your bulk action which will be displayed in the bulk action button next to the name |
| `sortOrder` | The order in which to display this action in the bulk actions bar. System bulk actions sort orders are in multiples of `100` in order to allow positioning of items between system bulk actions. |

| Method | Description |
| ------ | ----------- |
| `configure(items)` | A function to run before the bulk operation in order to provide configuration for the bulk action. Returns a Promise that returns an object which is then passed to the item/bulk action methods. |
| `itemAction(item, config)` | An individual action to perform per selected item. A status will be displayed after each processed item showing progress. Returns an Promise. † |
| `bulkAction(items, config)` | A single action to be performed for all selected items in one go. Returns an Promise. † |
| `getConfirmMessage(total)` | A function that can provider a message to display before a bulk action is triggered should confirmation be required for the action to run. Returns an Promise that returns a string. |
| `getStatusMessage(count, total)` | A function used to provider a status message after each item has been processed. Displayed in the bulk actions bar after each `itemAction` has been called. Returns an Promise that returns a string. |
| `getSuccessMessage(total)` | A function to return a success message after all bulk actions have been performed. Returns an Promise that returns a string. |
| `condition(context)` | As all bulk actions are registered globally for all entity types, the `condition` function can be used to filer when, and for which entities a bulk action will actually display. |

† Only a `itemAction` OR a `bulkAction` method should be defined for a bulk action configuration. If both are present, the `bulkAction` will be used and the `itemAction` will be ignored. If processing of items can be done individually, it is better to use the `itemAction` in order to provider user feedback. `bulkAction` should only be used where items need to be processed in a single action.

## Important Notes

* Most methods apart from `itemAction` or `bulkAction` are optional. If methods aren't present, a default implementation will be used, or, where those methods trigger specific functionality such as the `configure` or `getConfirmMessage` methods, that functionality will become disabled.
* It's important to note the array based syntax for registering a bulk action with angular dependencies. Each bulk action is registered as an array, where all dependencies are defined first and then a factory function is defined last which returns the actual bulk action definition.
* Whilst these docs outline how to define a bulk action, you will likely need to register further resources / services that can actually perform the given bulk operation and include these as a dependency for your action. 

## Examples

### A bulk action with dialog configuration step

````csharp
angular.module('vendr')
    .config(['vendrActionsProvider', function (vendrActionsProvider) {
        vendrActionsProvider.bulkActions.push(['$q', 'editorService', 'myResource', function ($q, editorService, myResource)
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
    }]):

````