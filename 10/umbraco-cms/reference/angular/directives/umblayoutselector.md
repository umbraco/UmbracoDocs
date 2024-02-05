# umbLayoutSelector

When you have a list of items, you can use the `umb-layout-selector` directive to let users toggle between different layouts. For instance, in Umbraco's media archive, users can select between a grid-based layout (thumbnails) and a list-based layout (table).

![Example of the layout selector](images/umbLayoutSelector.png)

The directive has three attributes:

* `layouts` is used to indicate the available layouts that the user should be able to select.
* `active-layout` is a reference to the layout currently being used.
* `on-layout-select` is a callback function triggered when the user chooses another layout.

For a view utilizing this directive:

*   The HTML could look something like this:

    ```html
    <div ng-controller="myController">
        <umb-layout-selector layouts="layouts"
                            active-layout="activeLayout"
                            on-layout-select="selectLayout(layout)">
        </umb-layout-selector>
    </div>
    ```
*   You'd also need a controller for initializing the different values to be used for the directive:

    ```js
    angular.module("umbraco").controller("myController", function ($scope) {

        // Declare the available layouts
        $scope.layouts = [
            {
                name: "Grid",
                icon: "icon-thumbnails-small",
                path: "gridpath",
                selected : true
            },
            {
                name: "List",
                icon: "icon-list",
                path: "listpath",
                selected: true
            }
        ];

        // Declare the function called by the directive when user chooses another layout
        $scope.selectLayout = function(layout) {
            $scope.activeLayout = layout;
            $scope.layouts.forEach(element => element.active = false);
            layout.active = true;
        };

        // Select the first layout
        $scope.selectLayout($scope.layouts[0]);

    });
    ```

For each layout:

* `name` property indicates the visual name of the layout (eg. used when hovering over the layout in the selector)
* `icon` is the CSS selector for the icon of the layout.
* `path` attribute indicates a sort of alias, and is used internally for comparing the layouts.
* Each layout should also have a `selected` property indicating whether a particular layout is enabled, and thereby visible in the selector.
