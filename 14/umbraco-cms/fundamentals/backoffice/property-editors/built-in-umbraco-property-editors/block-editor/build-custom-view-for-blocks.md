# Build a Custom View for a Block

{% hint style="warning" %}
This article is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

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

A custom view of Block List Editor needs to have the 'blockelement\_\_draggable-element' class presented to define which part of the Block is draggable.

Example:

```html
<button type="button" class="blockelement__draggable-element" ng-click="block.edit()">
  <h2 ng-bind="block.data.headline"></h2>
  <p ng-bind="block.data.description"></p>
</button>
```

{% hint style="info" %}
This is not relevant for the Block Grid Editor where all Blocks are draggable by default..
{% endhint %}

## Add the Areas for Block Grid Editor

Blocks of the Block Grid Editor can have Areas. These Blocks require their Custom View to define where the Areas should be inserted.

This enables you to wrap and place the Areas as you need.

The Areas is inserted through [Web Component Slots](https://developer.mozilla.org/en-US/docs/Web/Web\_Components/Using\_templates\_and\_slots). A slot is a native HTML tag.

These Area slots can be generated automatically via this AngularJS Directive:

```html
<umb-block-grid-render-area-slots></umb-block-grid-render-area-slots>
```

Example of a Custom View wrapping the Areas within a green border:

```html
<div style="border:green 1px solid; padding: 20px;">
    <slot name="area-container" part="area-container"></slot>
    <umb-block-grid-render-area-slots></umb-block-grid-render-area-slots>
</div>
```

You can also define where each Area should be inserted. This is relevant if you like the Areas to appear differently than the provided grid setup of Areas.

As a reference here is an example of the HTML output of the `umb-block-grid-render-area-slots` AngularJS Directive:

```html
    <div part="area-container">
        <slot name="myAreasAlias1"></slot>
        <slot name="myAreasAlias2"></slot>
    </div>
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

Your block may enable you to 'pick' an image to use as the background for a particular block. If you try to display this image directly in the view using `block.data.image`, you will see the unique ID and not the image.

There are two approaches to displaying the actual image in your custom block view. Either use a filter in your custom view or retrieve the image through the AngularJS controller.

#### 1. Retrieve the image using a filter directly in your custom view

By using the AngularJS filter called `mediaItemResolver`, it is possible to retrieve the image directly from your custom view file. You will need to create a variable that then uses the `mediaItemResolver` filter on the Media Picker property. This variable is then used to retrieve the image URL in an `<img>` HTML tag.

In the following example, a `mediaItem` variable is defined and used to set the `ng-src` value on the image tag. This will retrieve the image into your custom view.

```html
<div ng-click="block.edit()">
    <h2 ng-bind="block.data.headline"></h2>

    <!-- Use the 'mediaItemResolver' on the block.data.image -->
    {{mediaItem = (block.data.image[0].mediaKey | mediaItemResolver); “”}}

    <!-- Use the variable defined above to retrieve the mediaLink representing the image -->
    <img ng-src=“{{mediaItem.mediaLink}}“/>
    <p ng-bind="block.data.description"></p>
</div>
```

#### 2. Retrieve the image using an AngularJS controller

It is also possible to get the `ImageUrl` by using the unique ID in an AngularJS controller.

Amend the `customBlock.controller.js` file, by injecting the `mediaResource` to retrieve the image from the ID:

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

The Custom View should then be updated to use the `imageUrl` property to display the image:

```html
<div ng-controller="customBlockController" ng-click="block.edit()">
    <h2 ng-bind="block.data.headline"></h2>
    <img src="{{imageUrl}}" />
    <p ng-bind="block.data.description"></p>
</div>
```

If you need to use a specific crop, you can inject the `imageUrlGeneratorResource` resource. This has a `getCropUrl(mediaPath, width, height, imageCropMode, animationProcessMode)` method:

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
