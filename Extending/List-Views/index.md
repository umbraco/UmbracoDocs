#List views
This section describes how to add custom layouts to list views.

##Adding a custom layout
When configuring a list view add custom layouts by clicking *Add Layot* on the *Layouts* property.

For each layout it is possible to set the icon, enter a name and the path for the view file.

**Icon:** Choose an icon using the backoffice icon picker.

**Name:** Name the layout. Will be shown as tooltip when using the layout picker on the list view in the Content section.

**Layout path:** Enter the path to the view that will be used for the list view. Eg. `/app_plugins/mycustomlistview/listview.html`.

##Custom layout components
A custom layout is comprised of an angular controller, a view file (the one referenced in the Layout path) and optionally a package manifest for loading the controller and optionally adding css to the listview. ALl this should be put in the `/App_Plugins/` folder:

    /App_Plugins/customListview/listview.controller.js
    /App_Plugins/customListview/listview.html
    /App_Plugins/customListview/package.manifest

###The controller
The logic for the listview is handled in by an angular controller where the listview helper is injected:

    angular.module("umbraco").controller("my.listviewcontroller", function ($scope, listViewHelper) {

        //Listview logic goes here
    });   

###The view
The view file is were the Html is handled. Remember to add the custom listview controller to the view.

    <div ng-controller="my.listviewcontroller">

      <!-- Loop through them items in the list view-->
      <ul>     
        <li ng-repeat="item in items">

        </li>
      </ul>

    </div>

###Package manifest
Load the controller with a package manifest:

    {
      javascript:[
          "/app_plugins/customListview/listview.controller.js"
      ]
    }

##More Information
[Listview Helper](https://our.umbraco.org/apidocs/ui/#/api/umbraco.services.listViewHelper)
[Angular API documentation](https://our.umbraco.org/apidocs/ui/#/api)
