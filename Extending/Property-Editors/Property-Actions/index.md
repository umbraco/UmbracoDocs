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

```js
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

## Implement Property Actions
The implementation of Property Actions vary depending on wether your Property Editor is impemented with a Controller or as a Component.

### Controller Implementation

If your Property Editor is implemented with a Controller, you can use the following approach.

See the following example for implementation of Property Actions in a Controller.

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
	
	this.$onInit = function () {
	    if ($scope.umbProperty) {
	        $scope.umbProperty.setPropertyActions(propertyActions);
	    }
	};
	
	
});
```

### Component Implementation

Follow this guide if your Property Editor is implemented as a Component.
The Component must be configured to retrieve an optional reference to `umbProperty`. The requirement must be optional because property-editors are implemented in scenarios where it's not presented.

See the following example:

```js
angular.module('umbraco').component('myPropertyEditor', {
    controller: MyController,
    controllerAs: 'vm',
    require: {
        umbProperty: '?^umbProperty'
    }
    …
});
```

See the following example for implementation of Property Actions in a Controller, parsing actions to `this.umbProperty.setPropertyActions`.

```js
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

this.$onInit = function () {
    if (this.umbProperty) {
        this.umbProperty.setPropertyActions(propertyActions);
    }
};
```
