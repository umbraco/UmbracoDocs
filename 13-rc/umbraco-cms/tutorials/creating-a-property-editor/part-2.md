# Adding configuration to a property editor

## Overview

This is step 2 in our guide to building a Property Editor. This step continues work on the Suggestion Data Type we built in [step 1](./), but goes further to show how to add configuration options to our editor.

## Configuration

An important part of building good Property Editors is to build something flexible, so we can reuse it many times, for different things. Like the Rich Text Editor in Umbraco, which allow us to choose which buttons and stylesheets we want to use on each instance of the editor.

An editor can be used again and again, with different configurations, and that is what we will be working on now.

There are two ways to add configuration to the Property Editor. If in the previous step you chose to create the property editor using a `package.manifest` file, read the `package.manifest` section below. If you have chosen the `C#` variant, read the `Csharp` part of the article.

## Package.manifest

To add configuration options to our Suggestion Data Type, open the `package.manifest` file. Right below the editor definition, paste in the prevalues block:

```json
...
"editor": {
                "view": "~/App_Plugins/Suggestions/suggestion.html"
            }, // Remember a comma separator here at the end of the editor block!
 "prevalues": {
                "fields": [
                    {
                        "label": "Enabled?",
                        "description": "Provides Suggestions",
                        "key": "isEnabled",
                        "view": "boolean"
                    },
                    {
                        "label": "Default value",
                        "description": "Provide a default value for the property editor",
                        "key": "defaultValue",
                        "view": "textarea"
                    }
                ]
            }
```

So what did we add? We added a prevalue editor, with a `fields` collection. This collection contains information about the UI we will render on the Data Type configuration for this editor.

The label "Enabled?" uses the "boolean" view. This will allow us to turn the suggestions on/off and will provide the user with a toggle button. The name "boolean" comes from the convention that all preview editors are stored in `/umbraco/views/prevalueeditors/` and then found via `boolean.html`.

Same with the "Default value" label, it will provide the user with a textarea. The user can input a default value for the property editor that should be displayed when the property editor is blank.

To hide the property editor label, add the `hideLabel` parameter in the `editor` block:

```json
 "editor": {
        "view": "~/App_Plugins/Suggestions/suggestion.html",
        //Turn the label on or off by using true or false, respectively.
        "hideLabel": true,
        /*Optional: Add 'read-only' support. Available from Umbraco 10.2+*/
        "supportsReadOnly": true
      }
```

Your `package.manifest` file should now look something like this:

```json
{
  // we can define multiple editors
  "propertyEditors": [
    {
      /*this must be a unique alias*/
      "alias": "Suggestions editor",
      /*the name*/
      "name": "Suggestions",
      /*the icon*/
      "icon": "icon-list",
      /*grouping for "Select editor" dialog*/
      "group": "Common",
      /*the HTML file we will load for the editor*/
      "editor": {
        "view": "~/App_Plugins/Suggestions/suggestion.html",
        //Turn the label on or off by using true or false, respectively.
        "hideLabel": true,
        /*Optional: Add 'read-only' support. Available from Umbraco 10.2+*/
        "supportsReadOnly": true
      }, // Remember a comma separator here at the end of the editor block!
      "prevalues": {
        "fields": [
          {
            "label": "Enabled?",
            "description": "Provides Suggestions",
            "key": "isEnabled",
            "view": "boolean"
          },
          {
            "label": "Default value",
            "description": "Provide a default value for the property editor",
            "key": "defaultValue",
            "view": "textarea"
          }
        ]
      }
    }
  ],
  // array of files we want to inject into the application on app_start
  "css": [
    "~/App_Plugins/Suggestions/suggestion.css"
  ],
  "javascript": [
    "~/App_Plugins/Suggestions/suggestion.controller.js"
  ]
}
```

## Csharp

It is also possible to add configuration if you have chosen to create a property editor using C#. Create two new files in the `/App_Code/` folder and update the existing `Suggestion.cs` file to add configuration to the property editor.

First create a `SuggestionConfiguration.cs` file with three configuration options: `Enabled?`, `Default Value`, and `Hide Label?`:

```csharp
namespace Umbraco.Cms.Core.PropertyEditors
{
    public class SuggestionConfiguration
    {
        [ConfigurationField("isEnabled", "Enabled?", "boolean", Description = "Provides Suggestions")]
        public bool Enabled { get; set; }

        [ConfigurationField("defaultValue", "Default Value", "textarea", Description = "Provide a default value for the property")]
        public string? DefaultValue { get; set; }

        [ConfigurationField("hideLabel", "Hide Label?", "boolean", Description = "Hide the property label.")]
        public bool HideLabel { get; set; }
    }
}
```

Then create a `SuggestionConfigurationEditor.cs` file:

```csharp
using Umbraco.Cms.Core.IO;

namespace Umbraco.Cms.Core.PropertyEditors
{
    public class SuggestionConfigurationEditor : ConfigurationEditor<SuggestionConfiguration>
    {
        public SuggestionConfigurationEditor(IIOHelper ioHelper) : base(ioHelper)
        {
        }
    }

}
```

Finally, edit the `Suggestion.cs` file from step one until it looks like the example below:

```csharp
using Umbraco.Cms.Core.IO;

namespace Umbraco.Cms.Core.PropertyEditors
{
    [DataEditor(
        alias: "Suggestions editor",
        name: "Suggestions Editor",
        view: "~/App_Plugins/Suggestions/suggestion.html",
        Group = "Common",
        Icon = "icon-list")]
    public class Suggestions : DataEditor
    {
        private readonly IIOHelper _ioHelper;
        public Suggestions(IDataValueEditorFactory dataValueEditorFactory,
            IIOHelper ioHelper)
            : base(dataValueEditorFactory)

        {
            _ioHelper = ioHelper;
        }
        protected override IConfigurationEditor CreateConfigurationEditor() => new SuggestionConfigurationEditor(_ioHelper);

    }
}
```

Save the file, rebuild the application, and have a look at the Suggestions Data Type. You should see that you have three configuration options.

![An example of how the configuration will look](../../../../10/umbraco-cms/tutorials/creating-a-property-editor/images/suggestion-editor-config\_1.png)

## Using the configuration

The next step is to gain access to our new configuration options. For this, open the `suggestion.controller.js` file.

1.  Let's add the `isEnabled` functionality. Before the closing tag, we will add a `getState` method:

    ```javascript
        // The controller assigns the behavior to scope as defined by the getState method, which is invoked when the user toggles the enable button in the data type settings.
        $scope.getState = function () {
            
            //If the data type is enabled in the Settings the 'Give me Suggestions!' button is enabled
             if (Boolean(Number($scope.model.config.isEnabled))) {
                return false;
            }
            return true;
        }
    ```
2.  Next, we'll add the `defaultValue` functionality. When the `$scope.model.value` is empty or null, we want to use the default value. To do that, we add the following to the start of the controller:

    ```js
    if($scope.model.value === null || $scope.model.value === ""){
        $scope.model.value = $scope.model.config.defaultValue;
    }
    ```

    See what's new? The `$scope.model.config` object. Also, because of this configuration, we now have access to `$scope.model.config.defaultValue` which contains the configuration value for that key.

    Your `suggestion.controller.js` file should now look like:

    ```javascript
    angular.module("umbraco")
        .controller("SuggestionPluginController",
            // Scope object is the main object which is used to pass information from the controller to the view.
            function ($scope) {
                if ($scope.model.value === null || $scope.model.value === "") {
                    $scope.model.value = $scope.model.config.defaultValue;
                }
                // SuggestionPluginController assigns the suggestions list to the aSuggestions property of the scope
                $scope.aSuggestions = ["You should take a break", "I suggest that you visit the Eiffel Tower", "How about starting a book club today or this week?", "Are you hungry?"];

                // The controller assigns the behavior to scope as defined by the getSuggestion method, which is invoked when the user clicks on the 'Give me Suggestions!' button.
                $scope.getSuggestion = function () {

                    // The getSuggestion method reads a random value from an array and provides a Suggestion. 
                    $scope.model.value = $scope.aSuggestions[$scope.aSuggestions.length * Math.random() | 0];

                }
            
                // The controller assigns the behavior to scope as defined by the getState method, which is invoked when the user toggles the enable button in the data type settings.
                $scope.getState = function () {

                    //If the data type is enabled in the Settings the 'Give me Suggestions!' button is enabled
                     if (Boolean(Number($scope.model.config.isEnabled))) {
                        return false;
                    }
                    return true;
                }

            });
    ```
3.  Finally, we'll add the `hideLabel` functionality. For this, we'll open the `Suggestion.cs` file and override the GetValueEditor method with configuration as a parameter.

    ```cs
    public override IDataValueEditor GetValueEditor(object? configuration)
    {

        var editor = base.GetValueEditor(configuration);

        if (editor is DataValueEditor valueEditor && configuration is SuggestionConfiguration config)
        {
            valueEditor.HideLabel = config.HideLabel;
        }

        return editor;

    }
    ```

    Your `Suggestion.cs` file should now look like:

    ```cs
    using Umbraco.Cms.Core.IO;
    using Umbraco.Cms.Core.Models;

    namespace Umbraco.Cms.Core.PropertyEditors
    {
        [DataEditor(
            alias: "Suggestions editor",
            name: "Suggestions Editor",
            view: "~/App_Plugins/Suggestions/suggestion.html",
            Group = "Common",
            Icon = "icon-list")]
        public class Suggestions : DataEditor
        {
            private readonly IIOHelper _ioHelper;
            public Suggestions(IDataValueEditorFactory dataValueEditorFactory,
                IIOHelper ioHelper)
                : base(dataValueEditorFactory)

            {
                _ioHelper = ioHelper;
            }
            protected override IConfigurationEditor CreateConfigurationEditor() => new SuggestionConfigurationEditor(_ioHelper);

            public override IDataValueEditor GetValueEditor(object? configuration)
            {

                var editor = base.GetValueEditor(configuration);

                if (editor is DataValueEditor valueEditor && configuration is SuggestionConfiguration config)
                {
                    valueEditor.HideLabel = config.HideLabel;
                }

                return editor;

            }
        }
    }
    ```

Save the files and rebuild the application. To access the configuration options, enable/disable the `Enabled?` and `Hide Label?` options. Additionally, you can set a default value in the `Default Value` field and see the Suggestions Data Type at play.

![An example of setting the configuration](../../../../10/umbraco-cms/tutorials/creating-a-property-editor/images/suggestion-editor-config\_2.png)

![Backoffice view](../../../../10/umbraco-cms/tutorials/creating-a-property-editor/images/suggestion-editor-backoffice\_1.png)
