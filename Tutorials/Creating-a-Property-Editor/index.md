---
versionFrom: 8.0.0
meta.Title: "Creating a property editor"
meta.Description: "A guide to creating a property editor in Umbraco"
versionTo: 9.0.0
verified-against: 9.0.0
---

# Creating a property editor

_This tutorial was last tested on **Umbraco 9.0.0**_

## Overview

This guide explains how to set up a property editor, how to hook it into Umbraco's Data Types, how to hook it into AngularJS' modules and its injector, and finally how we can test our property editor.

To create a property editor, follow these steps:

- [Setting up a plugin](#setting-up-a-plugin)
- [Write some basic "Hello World" HTML + JavaScript](#writing-some-basic-html-and-javascript)
- [Register the data type in Umbraco](#register-the-data-type-in-umbraco)
- [Add external dependencies](#add-external-dependencies)

## Prerequisites

Since we are using AngularJS with Umbraco, you can take a look at some of the resources available here:

- [Egghead.io](https://egghead.io/courses/angularjs-fundamentals)
- [Angularjs.org/tutorial](https://docs.angularjs.org/tutorial)
- [Pluralsight](https://www.pluralsight.com/paths/angular-js)

## The end result

By the end of this tutorial, we will have a markdown editor running inside of Umbraco registered as a Data Type in the backoffice, assigned to a Document Type, and the editor can
create and modify data.

:::note
This tutorial is an example of how to create your own property editor from start to finish. However, we recommend using Umbraco's built-in [Markdown editor](https://our.umbraco.com/Documentation/Getting-Started/Backoffice/Property-Editors/Built-in-Property-Editors/#markdown-editor) option for markdown syntax editing.
:::

## Setting up a plugin

To setup a plugin:

1. Create a new folder inside the **/App_Plugins** folder. We will call it _MarkDownEditor_.
2. Create a manifest file called **package.manifest** inside `/App_Plugins/MarkDownEditor/` to describe what this plugin does. This manifest will tell Umbraco about our new property editor and allows us to inject any needed files into the application. For more information on the manifest file, see the [Package Manifest](../../Extending/Property-Editors/package-manifest.md) article.
3. Add the following code inside the **package.manifest** file to describe the property editor. Have a look at the inline comments in the JSON below for details on each bit:

    ```javascript
    {
        // we can define multiple editors
        propertyEditors: [
            {
                /*this must be a unique alias*/
                alias: "My.MarkdownEditor",
                /*the name*/
                name: "My markdown editor",
                /*the icon*/
                icon: "icon-code",
                /*grouping for "Select editor" dialog*/
                group: "Rich Content",
                /*the HTML file we will load for the editor*/
                editor: {
                    view: "~/App_Plugins/MarkDownEditor/markdowneditor.html"
                }
            }
        ]
        ,
        // array of files we want to inject into the application on app_start
        javascript: [
            '~/App_Plugins/MarkDownEditor/markdowneditor.controller.js'
        ]
    }
    ```

## Setting up a property editor with C\#

To create a property editor with C#:

1. Create a **MarkdownEditor.cs** file in **/App_Code/** to register the editor.
2. Add the following code inside the **MarkdownEditor.cs** file.

    ```csharp
    using Umbraco.Core.Logging;
    using Umbraco.Core.PropertyEditors;

    namespace Umbraco.Web.UI
    {
        [DataEditor(
            alias:"My.MarkdownEditor",
            name:"My markdown editor",
            view:"~/App_Plugins/MarkDownEditor/markdowneditor.html",
            Group = "Rich Content",
            Icon = "icon-code")]
        public class MarkdownEditor : DataEditor
        {
            public MarkdownEditor(ILogger logger)
                : base(logger)
            { }

        }
    }
    ```

3. Since the `C#` code is adding the Property Editor, the `package.manifest` file can be simplified like this:

    ```json
    {
        // array of files we want to inject into the application on app_start
        "javascript": [
            "~/App_Plugins/MarkDownEditor/markdowneditor.controller.js"
        ]
    }
    ```

## Writing some basic HTML and JavaScript

1. Add 2 files to the **/App_Plugins/markdowneditor/** folder:
    - `markdowneditor.html`
    - `markdowneditor.controller.js`

    These will be our main files for the editor, with the .html file handling the view and the .js part handling the functionality.
2. In the **markdowneditor.controller.j**s file, add a basic AngularJS controller declaration:

    ```javascript
    angular.module("umbraco")
        .controller("My.MarkdownEditorController",
        function () {
            alert("The controller has landed");
        });
    ```

3. In the **markdowneditor.html** file, add the following code:

    ```html
    <div ng-controller="My.MarkdownEditorController">
        <textarea ng-model="model.value"></textarea>
    </div>
    ```

4. Our basic parts of the editor are ready, namely:

    - The package manifest, telling Umbraco what to load.
    - The HTML view for the editor.
    - The controller for wiring up the editor with angular.

## Register the Data Type in Umbraco

1. Restart your application.
2. Navigate to a Document Type where you want to add the new Data Type.
3. Select the newly added property editor **My markdown editor** and add it to the Document Type.
4. Go to the **Content** section and open the content item of that Document type.
5. You will be greeted with an alert message saying `The controller has landed` - which means everything is working as expected.

We can now edit the assigned property's value with our new property editor.

## Add external dependencies

Let's go a bit further, and load in a markdown editor JavaScript library. In this example we're using files from the [pagedown project](https://github.com/samwillis/pagedown-bootstrap), but this is optional.

1. Let's add some external files to our package folder, in **/App_Plugins/markdowneditor/lib**. These files are taken from the [Pagedown-bootstrap project](https://github.com/samwillis/pagedown-bootstrap) on github.com.

2. Open the **markdowneditor.controller.js** file and edit it so it looks like this:

    ```javascript
    angular.module("umbraco")
    .controller("My.MarkdownEditorController",
    // inject umbracos assetsService
        function ($scope,assetsService,$timeout) {

        // tell the assetsService to load the markdown.editor libs from the markdown editors
        // plugin folder
        assetsService
            .load([
                "~/App_Plugins/MarkDownEditor/lib/markdown.converter.js",
                "~/App_Plugins/MarkDownEditor/lib/markdown.sanitizer.js",
                "~/App_Plugins/MarkDownEditor/lib/markdown.editor.js"
            ])
            .then(function () {
                // this function will execute when all dependencies have loaded
                $timeout(function(){
                alert("editor dependencies loaded");
                });
            });

        // load the separate css for the editor to avoid it blocking our JavaScript loading
        assetsService.loadCss("~/App_Plugins/MarkDownEditor/lib/markdown.editor.less");
    });
    ```

    This loads in our external dependency, but only when it's needed by the editor.

    :::note
    Visit the [Property Editors page](https://our.umbraco.com/documentation/Extending/Property-Editors/) for more details about extending this service.
    :::

3. Let's replace that `alert()` with some code that can instantiate the pagedown editor:

    ```javascript
    var converter2 = new Markdown.Converter();
    var editor2 = new Markdown.Editor(converter2, "-" + $scope.model.alias);
    editor2.run();
    ```

4. Add the id to the textarea in the HTML. For more info on the HTML structure, see the [pagedown demo](https://github.com/samwillis/pagedown-bootstrap/blob/master/demo/browser/demo.html):

    ```html
    <div ng-controller="My.MarkdownEditorController" class="wmd-panel">
        <div id="wmd-button-bar-{{model.alias}}"></div>

        <textarea ng-model="model.value" class="wmd-input" id="wmd-input-{{model.alias}}">
            <!-- our content will be loaded here -->
        </textarea>

        <div id="wmd-preview-{{model.alias}}" class="wmd-panel wmd-preview"></div>
    </div>
    ```

5. Now, clear the cache, reload the document, and see the pagedown editor running:

    ![Example of the markdown editor running](images/markdown-editor-backoffice.png)

6. When we save or publish, the value of the editor is automatically synced to the current content object and sent to the server, all through the power of angular and the `ng-model` attribute.

7. Learn more about extending this service by visiting the [Property Editors page](https://our.umbraco.com/documentation/Extending/Property-Editors/).

---

Next: [Adding configuration to a property editor](../Adding-configuration-to-a-property-editor/index.md)
