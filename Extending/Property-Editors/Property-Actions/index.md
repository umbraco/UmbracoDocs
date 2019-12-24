---
versionFrom: 8.4.0
meta.Title: "Umbraco Property Editors - Property Actions"
meta.Description: "Guide on how to impelement Property Actions for Property Editors in Umbraco"
---

# Property Actions

Property Actions is a build-in feature that provides a generic place for secondary functionality for property editors.
Appearing as a small button next to the label of the property, that expands to show the available actions. Those actions are defined and implemented in the Property Editor, making it very open what a Property Action is.

![Example of Property Action on Nested Content Property Editor](example-of-property-actions.jpg)

## Data Structure of Property Actions
Property Editors are an array of objects defining each action. 
An action is defined by the following properties:

```json
{
    labelKey: 'clipboard_labelForRemoveAllEntries',
    labelTokens: [],
    icon: 'trash',
    method: removeAllEntries,
    isDisabled: true
}
```

We use `labelKey` and `labelTokens` to retrieve a localized string that is displayed as the Actions label. [See localization for more info.](../../Extending/Language-Files/)


`isDisabled` is used to disable an Action, which change the visual appearance and prevents interaction. Use this option when an action wouldn't provide any change. In the example above, the action `remove all entries` would not have any impact if there is no entries.

## Implementing a Property Action
The implementation of Property Actions consists of two parts. First a definition of the actions and secondly parsing the lists of actions to `$scope.umbProperty.setPropertyActions().

Note the check if `umbProperty` exists and is not null or undefined
This example builds upon the example of building a property editor.

```js
angular.module("umbraco").controller("My.MarkdownEditorController", function ($scope) {

    function myActionExecutionMethod() {
        alert('My Custom Property Action Clicked');

        // Disable the action so it can not be re-run
        // You may have custom logic to enable or disable the action
        // Based on number of items selected etc...
        myAction.isDisabled = true;
    };

    var myAction = {
        labelKey: 'general_labelForMyAction',
        labelTokens: [],
        icon: 'action',
        method: myActionExecutionMethod,
        isDisabled: false
    }

    var propertyActions = [
        myAction
    ];

    if ($scope.umbProperty) {
        $scope.umbProperty.setPropertyActions(propertyActions);
    }
});
```

In this example the action is defined as a variable on its own. In this way you can refer to it, for switching the `isDisabled` state.
