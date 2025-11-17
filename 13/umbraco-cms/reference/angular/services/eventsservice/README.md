# Events Service

The events service allows different components in Umbraco to broadcast and listen for global events.

## Using the events service in your custom code

### Broadcasting an event

To broadcast an event, you can use the `emit` function. It takes two arguments, where the first is the name of the event - eg. `featured.updated`, and the second argument is an object or similar describing the event.

The second argument is optional, so if your use case doesn't need this, feel free to skip this argument.

The illustrate this function, you could have a controller with an `updated` function that is triggered by the view. In this dummy example, the function will increment the value of a property editor, and then use the events service to broadcast that the value was updated:

```javascript
angular.module("umbraco").controller("MyController", function($scope, eventsService) {

    $scope.updated = function() {
        $scope.model.value++;
        eventsService.emit("feature.updated", { value: $scope.model.value });
    };

});
```

### Listening for an event

Another controller could then listen for broadcasts of your `feature.updated` event via the events service's `on` function, which takes the name of the event as the first argument, and a callback function as the second argument.

Then in the callback function, the first argument is the event it self, and the second argument is the object we pass on to the `emit` function when we're broadcasting:

```javascript
angular.module("umbraco").controller("MyOtherController", function($scope, eventsService) {

    $scope.count = 0;

    // Subscribe to the event
    var unsubscribe = eventsService.on("feature.updated", function(event, args) {
        $scope.count = args.value;
    });

    // When the scope is destroyed we need to unsubscribe
    $scope.$on("$destroy", function () {
        unsubscribe();
    });

});
```

#### Listening for events globally

Controllers are typically used by a specific component, so the controller will only be executed when such a component is inserted into the DOM. The controller will be executed for each component, so you may end of with multiple instances listening for the same event.

If you need to listen for events on a more global level, you can hook into the application startup using `app.run(...)`:

```javascript
app.run(function (eventsService) {

    $scope.count = 0;

    // Subscribe to the event
    var unsubscribe = eventsService.on("feature.updated", function(event, args) {
        $scope.count = args.value;
    });

});
```

### Unsubscribing from an event

Notice how the result of the `on` function is saved in an `unsubscribe` variable. When we add a listener via the `on` function, it's important to clean up after our selves when our component (here a controller) no longer exists - eg. when removed from the DOM.

In Angular, we can listen for the `$destroy` event in the current scope, and then unsubscribe from the events service by calling the `unsubscribe` variable as a function.

Alternatively, we could replace `unsubscribe()` with `eventsService.unsubscribe(unsubscribe)`, but it does the same thing - so calling the variable as a function directly may be preferred as it's shorter.

## Events in Umbraco

Below you'll find a list of events broadcasted by the Umbraco codebase. The list may not be complete, so kindly help updating the list should you find an event that isn't listed.

### Umbraco application

#### Init

**When the Umbraco application is ready**

```javascript
eventsService.emit("app.ready", data);
```

#### Security interceptor

When Umbraco our your custom code makes a request to the server via the `$http` service, Umbraco listens for the `x-umb-user-modified` header in the response. In can be used to tell the Umbraco backoffice that the current user has been modified, in which case Umbraco knows that it should refetch the user data.

```javascript
if (headers["x-umb-user-modified"]) {
    eventsService.emit("app.userRefresh");
}
```

### Services

#### Clipboard service

**When the clipboard in local storage is updated**

```js
eventsService.emit("clipboardService.storageUpdate");
```

#### Editor service

**When an editor is opened**

```javascript
var args = {
    editors: editors,
    editor: editor
};

eventsService.emit("appState.editors.open", args);
```

**When an editor is closed**

```javascript
var args = {
    editors: editors,
    editor: closedEditor
};

// emit event to let components know an editor has been removed
eventsService.emit("appState.editors.close", args);
```

**When all editors are closed**

```javascript
var args = {
    editors: editors,
    editor: null
};

eventsService.emit("appState.editors.close", args);
```

#### Editor State service

```javascript
eventsService.emit("editorState.changed", { entity: entity });
```

#### Localization service

**When the language resource file is loaded from the server**

```javascript
eventsService.emit("localizationService.updated", response.data);
```

#### Overlay service

**When an overlay is opened**

```javascript
eventsService.emit("appState.overlay", overlay);
```

**When an overlay is closed**

```javascript
eventsService.emit("appState.overlay", null);
```

#### TinyMCE service

**When upload of a file starts**

```javascript
eventsService.emit("rte.file.uploading");
```

**When upload of a file ends**

```js
eventsService.emit("rte.file.uploaded");
```

**When the user presses CTRL + S**

```js
eventsService.emit("rte.shortcut.save");
```

#### Tours

**When tours are loaded**

```javascript
eventsService.emit("appState.tour.updatedTours", tours);
```

**When user starts a tour**

```javascript
eventsService.emit("appState.tour.start", tour);
```

**When user ends a tour**

```javascript
eventsService.emit("appState.tour.end", tour);
```

**When a tour is disabled**

```javascript
eventsService.emit("appState.tour.end", tour);
```

**When user completes a tour**

```javascript
eventsService.emit("appState.tour.complete", tour);
```

#### Tree service

**When loading a tree node fails**

```javascript
eventsService.emit("treeService.treeNodeLoadError", { error: reason });
```

**When a tree node is removed**

```javascript
eventsService.emit("treeService.removeNode", { node: treeNode });
```

#### User service

**When the user is logged out**

```javascript
const args = { isTimedOut: isTimedOut };
eventsService.emit("app.notAuthenticated", args);
```

**When user is trying to log in, but have not start nodes**

```javascript
var result = { errorMsg: errorMsg, user: data, authenticated: false, lastUserId: lastUserId, loginType: "credentials" };
eventsService.emit("app.notAuthenticated", result);
```

**When user is successfully authenticated**

```javascript
var result = { user: data, authenticated: true, lastUserId: lastUserId, loginType: "credentials" };
eventsService.emit("app.authenticated", result);
```

**When user data is refetched from the server**

```javascript
if (args && args.broadcastEvent) {
    //broadcast a global event, will inform listening controllers to load in the user specific data
    eventsService.emit("app.authenticated", result);
}
```

#### Util service

**When the app is initialized**

```javascript
eventsService.emit("app.reInitialize");
```

### Directives

#### Toggle directive

**When the toggle is initialized**

```javascript
eventsService.emit("toggleValue", { value: scope.checked });
```

**When the toggle is clicked**

```javascript
eventsService.emit("toggleValue", { value: !scope.checked });
```

### Controllers

#### Grid controller

**When a new row is added**

```javascript
eventsService.emit("grid.rowAdded", { scope: $scope, element: $element, row: row });
```

**When a new control is added**

```javascript
eventsService.emit("grid.itemAdded", { scope: $scope, element: $element, cell: cell, item: newControl });
```

**When the grid is initializing**

```javascript
eventsService.emit("grid.initializing", { scope: $scope, element: $element });
```

**When the grid is initialized**

```javascript
eventsService.emit("grid.initialized", { scope: $scope, element: $element });
```

#### Languages overview controller

**When a language is deleted**

```
eventsService.emit("editors.languages.languageDeleted", args);
```

### Other

**Setting the page title**

Available from 8.4.0

```
$scope.$emit("$changeTitle", title);
```

For more information see [Change title](changetitle.md)
