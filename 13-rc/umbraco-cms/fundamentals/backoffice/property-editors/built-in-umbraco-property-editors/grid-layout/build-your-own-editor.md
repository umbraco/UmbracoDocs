# Build your own editor

{% hint style="info" %}
The samples in this section have not been verified against the latest version of Umbraco.

A new Property Editor called the **Block based Grid editor** will soon be available as a substitute for the existing Grid Layout editor. For more information, see the [Block based Grid editor for Umbraco CMS](https://umbraco.com/products/roadmap/) in the Umbraco Roadmap.
{% endhint %}

Create a file in `/App_Plugins/yourpackage/editor.html` and add the following to the editor.html file:

```html
<textarea rows="1" umb-auto-resize ng-model="control.value" ng-style="control.editor.config"></textarea>
```

Save the file and add an editor to the `/App_Plugins/yourpackage/package.manifest` file:

```json
{
    "gridEditors": [
        {
            "name": "Code",
            "alias": "code",
            "view": "/App_Plugins/yourpackage/editor.html",
            "icon": "icon-code",
            "config": {
                "color": "red",
                "text-align": "right"
            }
        }
    ]
}
```

Add a new file: `/App_Plugins/yourpackage/editor.cshtml` - this file will handle rendering the entered data  - this path is done by convention so:

- view: 'editor' => `views/partials/grid/editors/editor.cshtml`
- view: '/App_Plugins/path.html' => `/App_Plugins/path.cshtml`

If you wish to use something entirely different you can give the editor a separate `render` value which follow the same conventions.

```json
{
    "name": "Code",
    "alias": "code",
    "view": "/App_Plugins/yourpackage/editor.html",
    "render": "/App_Plugins/yourpackage/custom-render.cshtml"
}
```

## Grid editor controller

If you are building something slightly more complex then a text area, you will need to add a controller to the grid editor view. So first add a ng-controller attribute to the grid editor html - this works like building a property editor:

```html
<div ng-controller="my.custom.grideditorcontroller">
    <textarea>...</textarea>
</div>
```

To wire up a controller to this view, create the file `/App_Plugins/yourpackage/editor.controller.js` and add a standard angular controller declaration:

```js
angular.module("umbraco").controller("my.custom.grideditorcontroller", function ($scope) {
    $scope.control.value = "my new value";
});
```

Finally, we need to tell Umbraco to load this JavaScript controller when the Umbraco application boots. This is like building a property editor. Add your JavaScript (and css dependencies) in the `package.manifest` file in the `/yourpackage` folder, and configure it to load your controller file.

```json
{
    "gridEditors": [
        {
            "name": "Code",
            "alias": "code",
            "view": "/App_Plugins/yourpackage/editor.html",
            "icon": "icon-code",
            "config": {
                "color": "red",
                "text-align": "right"
            }
        }
    ],
    javascript:[
        "/App_Plugins/yourpackage/editor.controller.js"
    ]
}
```

So to summarize, to create a custom grid editor from scratch, you will need to:

- Create a grid editor view `.html` file
- Create a grid render `.cshtml` file
- Create a grid editor controller `.js` file
- Create a `package.manifest` to register the editor and make Umbraco load needed files

This process tries to be as close to building property editors as currently possible.

### Rendering grid editor content

Next add this c# to the .cshtml file:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage<dynamic>
<pre>@Model</pre>
```

When rendering the .cshtml file will receive a dynamic model with the raw data of the editor:

```json
{
    "value": "What ever value entered into the textarea",
    "editor": {
        "name": "Code",
        "alias": "code",
        "view": "/App_Plugins/yourpackage/editor.html",
        "icon": "icon-code",
        "config": {
                "color": "red",
                "text-align": "right"
            }
    }
}
```

So you can now use these value to build your razor output like so:

```html
<div style="color: @Model.config.color">@Model.value</div>
```
