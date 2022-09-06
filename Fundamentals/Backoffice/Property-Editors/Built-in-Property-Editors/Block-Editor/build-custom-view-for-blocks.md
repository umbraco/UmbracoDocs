---
versionFrom: 9.0.0
versionTo: 10.0.0
---

## Build a Custom View for a Block

You can choose to customize your editing experience by implementing a custom view for each Block Type of a Block Editor.

By picking a custom view you overwrite the backoffice UI for the given block with your own. This enables you to define how a block should be presented, but can also include interactive elements and be a full custom solution to how data is manipulated. Notice: In the Block List Editor the Inline Editing Mode must be disabled for custom backoffice views to appear.

### Write Your Own HTML View

Currently you can only pick HTML files for a custom view. These views are powered by AngularJS and therefore you can write any AngularJS logic.

Your HTML can be anything, but if you like to use it as a representation of the content then you would also want the full view to be clickable, which then opens the default editor for editing of your content.

The following example displays the property with the alias `headline` together with the `description` inside a button to edit your block.

```html
<button type="button" ng-click="block.edit()">
  <h2 ng-bind="block.data.headline"></h2>
  <p ng-bind="block.data.description"></p>
</button>
```

If you'd like to display properties of `settings`, you can access these by `block.settingsData.myPropertyAlias`.

### Adding custom implementation to your View

To achieve this you need to add a custom angularJS controller to your custom view, using the ng-controller attribute:
```html
<button  type="button" ng-controller="customBlockController" ng-click="api.editBlock(block, block.hideContentInOverlay, index, parentForm)"  class="btn-reset umb-outline blockelement-labelblock-editor blockelement__draggable-element ng-scope ui-sortable-handle" >
    <h2 ng-bind="block.data.headline"></h2>
    <p ng-bind="block.data.description"></p>
</button>
```

:::note
The class declaration is necessary to allow the block to behave like the default blocks (i.e. drag-to-sort etc.)
:::

Create a folder inside the App_Plugins folder called 'CustomBlockView' or something more meaningful for your implementation.

Inside this folder create two files,. The first file should be called package.manifest that contain the following:
```json
{
  "javascript": [
    "~/App_Plugins/CustomBlockView/customBlock.controller.js"    
  ]  
}
```
Umbraco will parse all package.manifest files and load any resources they reference into the backoffice during startup.

The second file should be a javascript file called

**customBlock.controller.js**

(to match the file referenced in your package.manifest file)

This file then should register your 'customBlockController' mentioned in your view ng-controller attribute with Umbraco's angular module's controllers

```javascript
angular.module("umbraco").controller("customBlockController", function ($scope) {
// you can do your custom functionality here!
});
```

#### Example: Displaying an image from a Media Picker

Your block may enable you to 'pick' an image for use as the background for a particular block or to display as part of the block layout. If you try to display this image directly in the view from the property `block.data.image` you'll see the unique id and not the image.

We'll need to use the Id in our custom angularJS controller to get the ImageUrl to display in our Backoffice Block Editor View.

With the setup of files above, we would amend our customBlock.controller.js file, injecting the mediaResource to retrieve the image from the id:

```javascript
angular.module("umbraco").controller("customBlockController", function ($scope, mediaResource) {

    //your property is called image so the following will contain the udi:
        var imageUdi = $scope.block.data.image;
    //the mediaResource has a getById method:
        mediaResource.getById(imageUdi)
            .then(function (media) {
                console.log(media);
                //set a property on the 'scope' called imageUrl for the returned media object's mediaLink
                $scope.imageUrl = media.mediaLink;
    });    
});
```

Update the View to use the 'imageUrl' property to display the image:

```html
<div ng-controller="customBlockController" ng-click="block.edit()">
    <h2 ng-bind="block.data.headline"></h2>
    <img src="{{imageUrl}}" />
    <p ng-bind="block.data.description"></p>
</div>
```

If you need to use a specific crop, you can inject the `imageUrlGeneratorResource` resource, which has a `getCropUrl(mediaPath, width, height, imageCropMode, animationProcessMode)` method:

```javascript
angular.module("umbraco").controller("customBlockController", function ($scope, mediaResource,imageUrlGeneratorResource) {

    //your property is called image so the following will contain the udi:
        var imageUdi = $scope.block.data.image;
    //the mediaResource has a getById method:
        mediaResource.getById(imageUdi)
            .then(function (media) {
                imageUrlGeneratorResource.getCropUrl(media.mediaLink, 150, 150).then(function (cropUrl) {
                console.log(cropUrl);
                $scope.imageUrl = cropUrl;
            });
    });    
});
```
