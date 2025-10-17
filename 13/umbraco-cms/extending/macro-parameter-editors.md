---
description: A guide to creating macro property editors in Umbraco
---

# Macro Parameter Editors

{% hint style="warning" %}
Macros will be removed in Umbraco 14. Consider using Partial Views or Blocks in Rich Text Editor.
{% endhint %}

Every macro can contain parameters. Options for the Editor to set when they insert the Macro to customise the output. There are some useful default types. For example:

* True/False
* TextBox
* TextArea
* Numeric
* Single/Multiple Media Picker
* Single/Multiple Content Picker
* ... and some 'others'

Consult the [Backoffice documentation](../fundamentals/backoffice/) for general information on Macros.

It is possible to create custom macro parameter types.

## Creating a custom Macro Parameter Type

### isParameterEditor

To create a custom Macro Parameter Type, first create a custom 'Property Editor' (or copy one from the core). See [Property Editors documentation](property-editors/) and in the corresponding [Package Manifest file](package-manifest.md) for the editor, set the `isParameterEditor` property to be true.

```json
{
  "propertyEditors": [
      {
          "alias": "My.ParameterEditorAlias",
          "name": "Parameter Editor Name",
          "isParameterEditor": true,
          "editor": {
              "view": "/App_Plugins/My.ParameterEditor/ParameterEditorView.html"
          }
      }
  ]
}
```

### PreValues/Configuration/DefaultValues

'Parameter Editors', unlike 'Property Editors', cannot contain 'prevalues'. This is because there is no UI to present configuration options in the Macro Parameter tab when a particular type is chosen. However using the `defaultConfig` option enables the passing of 'one off' default set of configuration for the parameter editor to use:

```json
{
  "propertyEditors": [
    {
      "alias": "My.ParameterEditorAlias",
      ...
      "defaultConfig": {
        "startNode": "1234",
        "minItems": 0,
        "maxItems": 6
      }
    }
  ]
}
```

This is only a problem if you have a macro parameter type that needs to be used on lots of different macros. Each instance may require slightly different configurations.

### Example

We'll create an 'Image Position' Macro Parameter type, providing a Radio Button list of options for positioning an image. This image is inserted via an 'Insert Image' Macro into a Rich Text Editor.

#### Package Manifest

```json
{
    "propertyEditors": [
      {
        "alias": "Our.Umbraco.ImagePosition",
        "name": "Image Position",
        "isParameterEditor": true,
        "editor": {
            "view": "/App_Plugins/Our.Umbraco.ImagePosition/ImagePosition.html",
            "valueType": "STRING"
        }
      }
    ],
    "javascript": [
        "/App_Plugins/Our.Umbraco.ImagePosition/ImagePosition.controller.js"
    ]
}
```

#### View

```html
<div ng-controller="Our.Umbraco.ImagePositionController">
    <div class="radio" ng-repeat="position in positions" id="selectstatus-{{position.Name}}">
        <label>
            <input type="radio" name="position" ng-model="model.value" value="{{position.Name}}">{{position.Name}}
        </label>
    </div>
</div>
```

#### Controller

```javascript
angular.module("umbraco").controller("Our.Umbraco.ImagePositionController", function ($scope) {

    if ($scope.model.value == null) {
        $scope.model.value = 'FullWidth';
    }

    // could read positions from defaultConfig
    $scope.positions = [
        {
            Name: 'FullWidth'
        },
        {
            Name: 'Left'
        },
        {
            Name: 'Right'
        },
        {
            Name: 'Center'
        }
    ];
});
```

#### Display

The final custom parameter should look like this:

![Image Position Radio Button Options](images/image-position-v8.png)

#### Using defaultConfig

In this example, moving the radio button options into configuration doesn't really add anything. However, to illustrate the concept of providing defaultConfig, let's do that:

The package manifest becomes:

```json
{
  "propertyEditors": [
    {
      "alias": "Our.Umbraco.ImagePosition",
      "name": "Image Position",
      "isParameterEditor": true,
      "editor": {
        "view": "/App_Plugins/Our.Umbraco.ImagePosition/ImagePosition.html",
        "valueType": "STRING"
      },
      "prevalues": {
        "fields": [
          {
            "label": "Options",
            "description": "Radio Button Options",
            "key": "options",
            "view": "textarea"
          }
        ]
      },
      "defaultConfig": {
        "options": [
          {
            "Name": "FullWidth"
          },
          {
            "Name": "Lefty"
          },
          {
            "Name": "Righty"
          },
          {
            "Name": "Centerish"
          }
        ]
      }
    }
  ],
  "javascript": [
    "/App_Plugins/Our.Umbraco.ImagePosition/ImagePosition.controller.js"
  ]
}
```

In the `ImagePosition.controller.js` we can now read the 'options' values from the `defaultConfig` in the package.manifest configuration:

```javascript
 $scope.positions = $scope.model.config.options;
```

### Reading the parameter value in the Macro Partial View

```csharp
@using Umbraco.Extensions
@inherits Umbraco.Cms.Web.Common.Macros.PartialViewMacroPage
@{
    var imagePosition = Model.MacroParameters["imagePosition"];
    //or if for convenience if you are using Umbraco.Extensions namespace there is a GetParameterValue extension method, which allows a default value to be specified if the parameter is not provided:
    imagePosition = Model.GetParameterValue<string>("imagePosition","full-width");
}
```

### Runtime minification cache busting in Production

If your custom property editor doesn't load when your project is deployed, you may need to modify your [Runtime Minification Settings](../reference/configuration/runtimeminificationsettings.md). The minified bundle cache may need to be "busted" to get your new code to load. For example, to bust the cache whenever the app is restarted, you can use this configuration:

```json
"Umbraco": {
  "CMS": {
    "RuntimeMinification": {
      "CacheBuster": "AppDomain"
    }
  }
}
```
