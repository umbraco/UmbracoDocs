#Creating a Custom List view
This tutorial will describe how to create a custom list view and use it in the backoffice.


##Setup
Start out by creating a folder for the list view files:

`/app_plugins/mycustomlistview/`

In the folder create a package manifest file, the html view and a file for the angular controller.

    /app_plugins/mycustomlistview/package.manifest
    /app_plugins/mycustomlistview/listview.html
    /app_plugins/mycustomlistview/listview.controller.js

You can name the controller and view files whatever you want. You can have several list views in one folder or add a folder per list view. As a rule of thumb it preferable to have your list views in separate folders.

####Package manifest
All we're going to use the package manifest for is loading the Angular controller for the view.

    {
        javascript:[
            "/app_plugins/mycustomlistview/listview.controller.js"
        ]
    }

####The HTML View

    <div ng-controller="my.customlistviewcontroller">
        <ul class="thumbnails">     
            <li ng-repeat="item in items">
                <div class="twitter-username thumbnail" ng-click="toggleItem(item)" style="width: 220px">

                    <img ng-src="https://twitter.com/{{item.twitterHandle}}/profile_image?size=original" class="img-circle"
                         ng-class="{'selected': item.selected}">

                    <h5><a href ng-click="gotoItem(item)">{{item.name}}</a></h5>
                    @{{item.twitterHandle}}
                </div>
            </li>
       </ul>
    </div>

####The Angular Controller

    angular.module("umbraco").controller("my.customlistviewcontroller", function ($scope, $location, listViewHelper) {

        $scope.toggleItem = function (item) {
            if (item.selected) {
                listViewHelper.deselectItem(item, $scope.selection);
            } else {
                listViewHelper.selectItem(item, $scope.selection);
            }
        }


        $scope.gotoItem = function (item) {
            $location.url(item.editPath);
        }
    })

##Adding the List View to Umbracos Backoffice
To add your custom list view as a layout, simply

##Conclusion
Creating a custom list view in Umbraco is easy!
