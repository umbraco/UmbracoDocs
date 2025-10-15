---

needsV9Update: "true"
---

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

Below you'll find a list of events broadcasted by the Umbraco codebase. The list may not be complete, so please help updating the list should you find an event that isn't listed.

### Umbraco application

#### Init

**When the Umbraco application is ready**

```javascript
eventsService.emit("app.ready", data);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/init.js#L65 -->

#### Security interceptor

When Umbraco our your custom code makes a request to the server via the `$http` service, Umbraco listens for the `x-umb-user-modified` header in the response. In can be used to tell the Umbraco backoffice that the current user has been modified, in which case Umbraco knows that it should refetch the user data.

```javascript
if (headers["x-umb-user-modified"]) {
    eventsService.emit("app.userRefresh");
}
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/interceptors/security.interceptor.js#L31 -->


### Services

#### Clipboard service

**When the clipboard in local storage is updated**

```js
eventsService.emit("clipboardService.storageUpdate");
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/clipboard.service.js#L49 -->

#### Editor service

**When an editor is opened**

```javascript
var args = {
    editors: editors,
    editor: editor
};

eventsService.emit("appState.editors.open", args);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/editor.service.js#L274 -->

**When an editor is closed**

```javascript
var args = {
    editors: editors,
    editor: closedEditor
};

// emit event to let components know an editor has been removed
eventsService.emit("appState.editors.close", args);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/editor.service.js#L297 -->

**When all editors are closed**

```javascript
var args = {
    editors: editors,
    editor: null
};

eventsService.emit("appState.editors.close", args);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/editor.service.js#L325 -->

#### Editor State service

```javascript
eventsService.emit("editorState.changed", { entity: entity });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/editorstate.service.js#L33 -->

#### Localization service

**When the language resource file is loaded from the server**

````javascript
eventsService.emit("localizationService.updated", response.data);
````

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/localization.service.js#L95 -->

#### Overlay service

**When an overlay is opened**

```javascript
eventsService.emit("appState.overlay", overlay);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/overlay.service.js#L48 -->

**When an overlay is closed**

```javascript
eventsService.emit("appState.overlay", null);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/overlay.service.js#L54 -->

#### TinyMCE service

**When upload of a file starts**

```javascript
eventsService.emit("rte.file.uploading");
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tinymce.service.js#L172 -->

**When upload of a file ends**

```js
eventsService.emit("rte.file.uploaded");
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.0/src/Umbraco.Web.UI.Client/src/common/services/tinymce.service.js#L178 -->

**When the user presses CTRL + S**

```js
eventsService.emit("rte.shortcut.save");
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tinymce.service.js#L1155 -->

#### Tours

**When tours are loaded**

```javascript
eventsService.emit("appState.tour.updatedTours", tours);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tour.service.js#L29 -->

**When user starts a tour**

```javascript
eventsService.emit("appState.tour.start", tour);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tour.service.js#L51 -->

**When user ends a tour**

```javascript
eventsService.emit("appState.tour.end", tour);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tour.service.js#L64 -->

**When a tour is disabled**

```javascript
eventsService.emit("appState.tour.end", tour);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tour.service.js#L78 -->

**When user completes a tour**

```javascript
eventsService.emit("appState.tour.complete", tour);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tour.service.js#L100 -->

#### Tree service

**When loading a tree node fails**

```javascript
eventsService.emit("treeService.treeNodeLoadError", { error: reason });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tree.service.js#L328 -->

**When a tree node is removed**

```javascript
eventsService.emit("treeService.removeNode", { node: treeNode });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/tree.service.js#L366 -->

#### User service

**When the user is logged out**

```javascript
const args = { isTimedOut: isTimedOut };
eventsService.emit("app.notAuthenticated", args);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/user.service.js#L13,L14 -->

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

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/user.service.js#L195,L198 -->

**When user data is refetched from the server**

```javascript
if (args && args.broadcastEvent) {
    //broadcast a global event, will inform listening controllers to load in the user specific data
    eventsService.emit("app.authenticated", result);
}
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/user.service.js#L243,L246 -->

#### Util service

**When the app is initialized**

```javascript
eventsService.emit("app.reInitialize");
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/services/util.service.js#L137 -->








### Directives

#### Toggle directive

**When the toggle is initialized**

```javascript
eventsService.emit("toggleValue", { value: scope.checked });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/directives/components/buttons/umbtoggle.directive.js#L84 -->

**When the toggle is clicked**

```javascript
eventsService.emit("toggleValue", { value: !scope.checked });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/directives/components/buttons/umbtoggle.directive.js#L112 -->

<!--
#### Other directives

https://github.com/umbraco/Umbraco-CMS/blob/b81bd6645634e8fc99eb6ced403b7de3dac73108/src/Umbraco.Web.UI.Client/src/common/directives/components/tabs/umbtabsnav.directive.js

https://github.com/umbraco/Umbraco-CMS/blob/11e82f26000ffe10c7cca260503e5d05f734bfd2/src/Umbraco.Web.UI.Client/src/common/directives/validation/valformmanager.directive.js#L210

https://github.com/umbraco/Umbraco-CMS/blob/5541d130207b8a32dfb361bc4d7143c85143c645/src/Umbraco.Web.UI.Client/src/common/directives/components/editor/umbeditorheader.directive.js#L343

https://github.com/umbraco/Umbraco-CMS/blob/34749ec2339731fb3d81101a9720cbcc1dbd04b2/src/Umbraco.Web.UI.Client/src/common/directives/components/umbgroupsbuilder.directive.js#L381

https://github.com/umbraco/Umbraco-CMS/blob/34749ec2339731fb3d81101a9720cbcc1dbd04b2/src/Umbraco.Web.UI.Client/src/common/directives/components/umbgroupsbuilder.directive.js#L637

https://github.com/umbraco/Umbraco-CMS/blob/34749ec2339731fb3d81101a9720cbcc1dbd04b2/src/Umbraco.Web.UI.Client/src/common/directives/components/umbgroupsbuilder.directive.js#L725

https://github.com/umbraco/Umbraco-CMS/blob/99a3dec4bac7d98ab9424ad6a70019fd5f62d56a/src/Umbraco.Web.UI.Client/src/common/directives/components/content/umbvariantcontenteditors.directive.js#L113

https://github.com/umbraco/Umbraco-CMS/blob/7634b376769b1965f5425129f3f3865bab23d301/src/Umbraco.Web.UI.Client/src/common/directives/components/content/umbcontentnodeinfo.directive.js#L191
-->





















### Controllers

#### Grid controller

**When a new row is added**

```javascript
eventsService.emit("grid.rowAdded", { scope: $scope, element: $element, row: row });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/views/propertyeditors/grid/grid.controller.js#L403 -->

**When a new control is added**

```javascript
eventsService.emit("grid.itemAdded", { scope: $scope, element: $element, cell: cell, item: newControl });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/views/propertyeditors/grid/grid.controller.js#L663 -->

**When the grid is initializing**

```javascript
eventsService.emit("grid.initializing", { scope: $scope, element: $element });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/views/propertyeditors/grid/grid.controller.js#L971 -->

**When the grid is initialized**

```javascript
eventsService.emit("grid.initialized", { scope: $scope, element: $element });
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/views/propertyeditors/grid/grid.controller.js#L975 -->

#### Languages overview controller

**When a language is deleted**

```c#
eventsService.emit("editors.languages.languageDeleted", args);
```

<!-- https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/views/languages/overview.controller.js#L99 -->

<!-- 
#### content - edit.controller.js

https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/directives/components/content/edit.controller.js#L235

https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/directives/components/content/edit.controller.js#L259

https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/directives/components/content/edit.controller.js#L440

https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/directives/components/content/edit.controller.js#L459

https://github.com/umbraco/Umbraco-CMS/blob/release-8.6.3/src/Umbraco.Web.UI.Client/src/common/directives/components/content/edit.controller.js#L571

#### Other controllers

https://github.com/umbraco/Umbraco-CMS/blob/bd26cb36ecce2bbe86f11b61dd1a01c314378c89/src/Umbraco.Web.UI.Client/src/views/languages/edit.controller.js#L158

https://github.com/umbraco/Umbraco-CMS/blob/227a0ec0d8fef6c5ae528935cf887df6cce97329/src/Umbraco.Web.UI.Client/src/views/dashboard/content/redirecturls.controller.js#L149

https://github.com/umbraco/Umbraco-CMS/blob/ecb6f93e54de1f37e83f4c85bffe81d32c86d917/src/Umbraco.Web.UI.Client/src/views/prevalueeditors/treesource.controller.js#L71

https://github.com/umbraco/Umbraco-CMS/blob/b55fdd60e5397f3b9d95160d78d2a34a85ba2a7f/src/Umbraco.Web.UI.Client/src/views/media/media.sort.controller.js#L53

https://github.com/umbraco/Umbraco-CMS/blob/463128734c3fda8c7ed740332688c7356153fd0b/src/Umbraco.Web.UI.Client/src/views/content/content.sort.controller.js#L55

https://github.com/umbraco/Umbraco-CMS/blob/0bd9e3ca9955844389556ce512fa0aab181703fb/src/Umbraco.Web.UI.Client/src/views/membertypes/edit.controller.js#L260

https://github.com/umbraco/Umbraco-CMS/blob/fdfcb75a7198b2267a230663ff62c7bdac67d5ef/src/Umbraco.Web.UI.Client/src/views/common/infiniteeditors/datatypesettings/datatypesettings.controller.js#L116

https://github.com/umbraco/Umbraco-CMS/blob/41d1e33fc452c955ebfbdd3d85931dad8b06da42/src/Umbraco.Web.UI.Client/src/views/common/infiniteeditors/userpicker/userpicker.controller.js#L71

https://github.com/umbraco/Umbraco-CMS/blob/0bd9e3ca9955844389556ce512fa0aab181703fb/src/Umbraco.Web.UI.Client/src/views/mediatypes/edit.controller.js#L340

https://github.com/umbraco/Umbraco-CMS/blob/591575b47de87ce64c963ac85066ed6572660171/src/Umbraco.Web.UI.Client/src/views/documenttypes/edit.controller.js#L356

https://github.com/umbraco/Umbraco-CMS/blob/bd26cb36ecce2bbe86f11b61dd1a01c314378c89/src/Umbraco.Web.UI.Client/src/views/common/infiniteeditors/linkpicker/linkpicker.controller.js#L127

https://github.com/umbraco/Umbraco-CMS/blob/7634b376769b1965f5425129f3f3865bab23d301/src/Umbraco.Web.UI.Client/src/navigation.controller.js#L434

https://github.com/umbraco/Umbraco-CMS/blob/1347b973f1c8617d372592236eab101507dd4179/src/Umbraco.Web.UI.Client/src/common/directives/components/application/umblogin.directive.js#L464

https://github.com/umbraco/Umbraco-CMS/blob/dc39faeb5ecc51992eeb1dcdf901b7ffc11be486/src/Umbraco.Web.UI.Client/src/views/common/infiniteeditors/treepicker/treepicker.controller.js#L344

https://github.com/umbraco/Umbraco-CMS/blob/e8bb3b01aacc50fc096d726a83d3bd6a914749bd/src/Umbraco.Web.UI.Client/src/views/common/infiniteeditors/mediapicker/mediapicker.controller.js#L287

-->


### Other

**Setting the page title**

Available from 8.4.0

```
$scope.$emit("$changeTitle", title);
```

For more information see [Change title](changetitle.md)
