# Build a Custom View for a Block

You can choose to customize your editing experience by implementing a custom view for each Block Type of a Block Editor.

By picking a custom view you overwrite the backoffice UI for the given block with your own. This enables you to define how a block should be presented. It can, however, also include interactive elements and be a full custom solution to how data is manipulated. In the Block List Editor the Inline Editing Mode must be disabled for custom backoffice views to appear.

## Write your own HTML view

Currently you can only pick HTML files for a custom view. These views are powered by AngularJS and you can write any AngularJS logic.

Your HTML can be anything. If you use it as a representation of the content you would also want the full view to be clickable. This would then open the default editor for editing of your content.

The following example displays the property with the alias `headline` together with the `description` inside a button to edit your block.

```html
<button type="button" ng-click="block.edit()">
  <h2 ng-bind="block.data.headline"></h2>
  <p ng-bind="block.data.description"></p>
</button>
```

If you would like to display properties of `settings`, you can access these by using `block.settingsData.myPropertyAlias`.

## Make Block List Editor custom view draggable

A custom view of Block List Editor needs to have the 'blockelement\_\_draggable-element' class presented to define which part of the Block that is draggable.

Example:

```html
<button type="button" class="blockelement__draggable-element" ng-click="block.edit()">
  <h2 ng-bind="block.data.headline"></h2>
  <p ng-bind="block.data.description"></p>
</button>
```

## Adding custom implementation to your View

To achieve this you need to add a custom AngularJS controller to your custom view, using the `ng-controller` attribute:

```html
<div ng-controller="customBlockController">
    <button type="button" ng-click="block.edit()" >
        <h2 ng-bind="block.data.headline"></h2>
        <p ng-bind="block.data.description"></p>
    </button>
</div>
```

Create a folder inside the `App_Plugins` folder called 'CustomBlockView'.

Create two files within the CustomBlockView file: `package.manifest` and `customBlock.controller.js`.

Add the following JSON to the `package.manifest` file:

```json
{
  "javascript": [
    "~/App_Plugins/CustomBlockView/customBlock.controller.js"    
  ]  
}
```

{% hint style="info" %}
Umbraco will parse all `package.manifest` files and load any resources they reference into the backoffice during startup.
{% endhint %}

The second file, `customBlock.controller.js`, will be used to register the 'customBlockController' defined using the `ng-controller` attribute in your custom view.

To register the controller, add the following lines of code:

```javascript
angular.module("umbraco").controller("customBlockController", function ($scope) {
    // you can do your custom functionality here!
});
```

### Example: Displaying an image from a Media Picker

Your block may enable you to 'pick' an image for use as the background for a particular block. If you try to display this image directly in the view using `block.data.image`, you will see the unique ID and not the image.

You will need to use the ID in our custom AngularJS controller in order to get the `ImageUrl` to display in our backoffice Block Editor View.

With the setup of files above, you need to amend the `customBlock.controller.js` file, by injecting the `mediaResource` to retrieve the image from the ID:

```javascript
angular.module("umbraco").controller("customBlockController", function ($scope, mediaResource) {

    //your property is called image so the following will contain the udi:
    var imageUdi = $scope.block.data.image[0].mediaKey;
    //the mediaResource has a getById method:
    mediaResource.getById(imageUdi).then(function (media) {
        console.log(media);
        //set a property on the 'scope' called imageUrl for the returned media object's mediaLink
        $scope.imageUrl = media.mediaLink;
    });
});
```

Update the Custom View to use the `imageUrl` property to display the image:

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
    var imageUdi = $scope.block.data.image[0].mediaKey;
    //the mediaResource has a getById method:
    mediaResource.getById(imageUdi).then(function (media) {
        imageUrlGeneratorResource.getCropUrl(media.mediaLink, 150, 150).then(function (cropUrl) {
            console.log(cropUrl);
            $scope.imageUrl = cropUrl;
        });
    });    
});
```
