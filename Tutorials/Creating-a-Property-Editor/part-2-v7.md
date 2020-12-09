---
versionFrom: 7.0.0
---


# Adding configuration to a property editor

## Overview

This is step 2 in our guide to building a property editor. This step continues work on the markdown editor we built in [step 1](index.md), but goes further to show you how you can add configuration options to the editor.

## Configuration

An important part of building good property editors is to build something relatively flexible, so you can reuse it many times, for different things. Like the Rich Text Editor in Umbraco, that allows you to choose which buttons and stylesheets you want to use on each instance of the editor.

So an editor can be used several times, with different configurations, and that is what we will be working on now.

## package.manifest

To add configuration options to our markdown editor, open the `package.manifest` file. Right below the editor definition, paste in the prevalues block:

```javascript
...
editor: {
    view: "~/App_Plugins/MarkDownEditor/markdowneditor.html"
}, // Remeber a comma seperator here at the end of the editor block!
prevalues: {
    fields: [
        {
            label: "Preview",
            description: "Display a live preview",
            key: "preview",
            view: "boolean"
        },
        {
            label: "Default value",
            description: "If value is blank, the editor will show this",
            key: "defaultValue",
            view: "textarea"
        }
    ]
}
```

So what did we add? We added a prevalue editor, with a `fields` collection. This collection contains information about the UI we will render on the data type configuration for this editor.

So the first one gets the label "Preview" and uses the view "boolean", so this will allow us to turn preview on/off and will provide the user with a checkbox. The name "boolean" comes from the convention that all preview editors are stored in `/umbraco/views/prevalueeditors/` and then found via `<name>.html`

Same with the next one, only that it will provide the user with a textarea to input a default value for the editor.

Save the manifest, **restart the app pool** and have a look at the markdown data type in Umbraco now. You should now see that you have 2 configuration options:

![An example of how the configuration will look](images/editor-config.png)

## Using the configuration

The next step is to gain access to our new configuration options. For this, open the `markdowneditor.controller.js` file.

Let's first add the default value functionality. When the `$scope.model.value` is empty or *undefined*, we want to use the default value, to do that, we add the following to the very beginning of the controller:

```javascript
if($scope.model.value === null || $scope.model.value === ""){
    $scope.model.value = $scope.model.config.defaultValue;
}
```

You see what's new? - the `$scope.model.config` object is. And the other thing you will notice is that because of our configuration, we now have access to `$scope.model.config.defaultValue` which contains the configuration value for that key. That is how you setup and use configuration values from code.

However, you can also use these values without any JavaScript, so open the `markdowneditor.html` file instead.

Because we can also use the configuration directly in our HTML like here, where we use it to toggle the preview `<div>`, using the `ng-hide` attribute:

```html
<div ng-show="model.config.preview" class="wmd-panel wmd-preview"></div>
```

[Next - Integrating services with a property editor](part-3-v7.md)
