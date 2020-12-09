---
versionFrom: 7.0.0
---


# Integrating services with a property editor

## Overview

This is step 3 in the property editor tutorial. In this part, we will integrate one of the built-in Umbraco services. For this sample, we will use the *dialog service* to hook into the *media picker* and return image data to the markdown editor.

## Injecting the service

First up, we need to get access to the service, this is done in the constructor of the controller, where we add it as a parameter:

```javascript
angular.module("umbraco")
    .controller("My.MarkdownEditorController",
    // inject Umbraco's assetsService and dialog service
    function ($scope, assetsService, dialogService) { ... }
```

this works the same way as with the *assetsService* we added in step 1.

## Hooking into pagedown

The pagedown editor we are using, has a nice event system in place, so we can hook into the events triggered by the media chooser, by adding a hook, after the editor has started:

```javascript
// Start the editor
var converter2 = new Markdown.Converter();
var editor2 = new Markdown.Editor(converter2, "-" + $scope.model.alias);
editor2.run();

// subscribe to the image dialog clicks
editor2.hooks.set("insertImageDialog", function (callback) {
        // here we can intercept our own dialog handling

        return true; // tell the editor that we'll take care of getting the image url
    });
});
```

Notice the callback, this callback is used to return whatever data we want to the editor.

So now that we have access to the editor events, we will trigger a media picker dialog, by using the `dialogService`. You can inject whatever HTML you want with this service, but it also has a number of shorthands for things like a media picker:

```javascript
// the callback is called when the use selects images
dialogService.mediaPicker({callback: function(data){
                        // data.selection contains an array of images
                        $(data.selection).each(function(i, item){
                                // try using $log.log(item) to see what this data contains
                        });
                    }});
```

## Getting to the image data

Because of Umbraco's generic nature, you don't always know where your image is, as a media object's data is an array of properties, so how do you pick the right one? - you cannot always be sure the property is called `umbracoFile` for instance.

For cases like this, a helper service is available: `imageHelper`. This utility has useful methods for getting to images embedded in property data, as well as associated thumbnails. **Remember to** inject this imageHelper in the controller constructor as well (same place as dialogService and assetsService).

So we get the image page from the selected media item, and return it through the callback:

```javascript
var imagePropVal = imageHelper.getImagePropertyValue({ imageModel: item, scope: $scope });
callback(imagePropVal);
```

At this point your controller should look like this:

```javascript
angular.module("umbraco")
    .controller("My.MarkdownEditorController",
        // inject umbracos assetsService
        function ($scope, assetsService, dialogService) {
            if ($scope.model.value === null || $scope.model.value === "") {
                $scope.model.value = $scope.model.config.defaultValue;
            }

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
                    var converter2 = new Markdown.Converter();
                    var editor2 = new Markdown.Editor(converter2, "-" + $scope.model.alias);
                    editor2.run();

                    // subscribe to the image dialog clicks
                    editor2.hooks.set("insertImageDialog", function (callback) {
                        // here we can intercept our own dialog handling

                        // the callback is called when the use selects images
                        dialogService.mediaPicker({
                            callback: function (data) {
                                // data.selection contains an array of images
                                $(data.selection).each(function (item) {
                                    var imagePropVal = imageHelper.getImagePropertyValue({ imageModel: item, scope: $scope });
                                    callback(imagePropVal);
                                });
                            }
                        });
                    });
                });

            // load the separate css for the editor to avoid it blocking our JavaScript loading
            assetsService.loadCss("~/App_Plugins/MarkDownEditor/lib/markdown.editor.less");
        });
```

Now when we run the markdown editor and click the image button, we are presented with a native Umbraco dialog, listing the standard media archive.

Clicking an image and choosing select returns the image to the editor which then renders it as:

![Koala picture][1]

[1]: /media/1005/Koala.jpg

The above is correct markdown code, representing the image, and if preview is turned on, you will see the image below the editor.

## Wrap up

So over the 3 previous steps, we've:

- Created a plugin
- Defined an editor
- Injected our own JavaScript libraries and 3rd party ones
- Made the editor configurable
- Connected the editor with native dialogs and services
- Looked at koala pictures

[Next - Adding server-side data to a property editor](part-4-v7.md)
