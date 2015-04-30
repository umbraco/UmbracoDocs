#Build your own editor
Create a file in `/app_plugins/yourpackage/editor.html` and add the following to the editor.html file: 

    <textarea rows="1" ng-model="control.value" ng-style="control.config"></textarea>

Save the file and add an editor to the `/app_plugins/yourpackage/package.manifest` file:

    {
        "gridEditors": [
            "name": "Code",
            "alias": "code",
            "view": "/app_plugins/yourpackage/editor.html",
            "icon": "icon-code",
            "config": {
                "color": "red",
                "text-align": "right"
            }
        ]
    }

Add a new file: `/app_plugins/yourpackage/editor.cshtml` - this file will handle rendering the entered data  - this path is done by convention so: 

- view: 'editor' => `views/partials/grid/editors/editor.cshtml`
- view: '/app_plugins/path.html' => `/app_plugins/path.cshtml`

If you wish to use something entirely different you can give the editor a separate `render` value which follow the same conventions
    
    {
        "name": "Code",
        "alias": "code",
        "view": "/app_plugins/yourpackage/editor.html",
        "render": "/app_plugins/yourpackage/custom-render.cshtml"
    }

###Grid editor controller
If you are building something just slightly more complex then a text area, you will need to add a controller to the grid editor view. So first add a ng-controller attribute to the grid editor html - this works just like building a property editor: 

    <div ng-controller="my.custom.grideditorcontroller">
        <textarea>...</textarea>
    </div>

To wire up a controller to this view, create the file `/app_plugins/yourpackage/editor.controller.js` and add a standard angular controller declaration: 

    angular.module("umbraco").controller("my.custom.grideditorcontroller", function($scope){
        $scope.control.value = "my new value";
    });

Finally, we need to tell Umbraco load this JavaScript controller when the Umbraco application boots, this is also just like building a property editor, so add your javascript(and css dependecies) in the `package.manifest` file in the `/yourpackage` folder, and configure it to load your controller file. 

    {
        "gridEditors": [
            "name": "Code",
            "alias": "code",
            "view": "/app_plugins/yourpackage/editor.html",
            "icon": "icon-code",
            "config": {
                "color": "red",
                "text-align": "right"
            }
        ],
        javascript:[
            "/app_plugins/yourpackage/editor.controller.js"
        ]
    }

So to summarize, to create a custom grid editor from scratch, you will need to: 

- Create a grid editor view `.html` file
- Create a grid render `.cshtml` file
- Create a grid editor controller `.js` file
- Create a `package.manifest` file to make Umbraco load needed files
- Register the editor in the `/config/grid.editors.js` file

This process tries to be as close to building property editors as currently possible.


###Rendering grid editor content 
Next add this c# to the .cshtml file: 

    @inherits Umbraco.Web.Mvc.UmbracoViewPage<dynamic>
    <pre>@Model</pre>

When rendering the .cshtml file will receive a dynamic model with the raw data of the editor:

    {
      "value": "What ever value entered into the textarea",
      "editor": {
        "name": "Code",
        "alias": "code",
        "view": "/app_plugins/yourpackage/editor.html",
        "icon": "icon-code",
        "config": {
          "color": "red",
          "text-align": "right"
        }
      }
    }

So you can now use these value to build your razor output like so:

    <div style="color: @Model.config.color">@Model.value</div>
