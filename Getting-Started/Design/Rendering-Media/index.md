# Rendering media

_Templates (Views) can access items in the [Media library](../../Data/Creating-Media/index.md), to assist in displaying rich content like galleries_

In the following examples we will be looking at rendering an Image, however the same principles  apply to all media items however property aliases may differ.

## Rendering a media item
A media node is not just a file, but like content, it is a collection of fields, such width, height and the path to the stored file. The benefit of this is that accessing media is very similar to accessing a content node.

### Example 1: Accessing an image media item based on its ID
A standard image in the media library is based on the Mediatype `image` which provides a number of standard values - if you want to add more, simply edit the media type under **settings**. In the example we are going to get a image and render out an `img` tag using the URL of the media item and use the Name as the value of the `alt` attribute.

_Assumption: We are going to assume that our media item has an ID of **1234**, and that we are **not using Models Builder**_

    @{
        //We are using the TypedMedia method off of the Umbraco helper to retrieve our media item based on its ID.
        var mediaItem = Umbraco.TypedMedia(1234);        

        //To get the url for your media item, you use the Url property on your media item.
        var url = mediaItem.Url
    }

    <img src="@url" alt="@mediaItem.Name" />

But wait a second, if you are using Umbraco v7.4.0+ it now comes with [ModelsBuilder](../../../Reference/Templating/Modelsbuilder/index.md). This means is that you can use strongly typed models for your media items if ModelsBuilder is enabled (which it is by default).

### Example 2: Accessing a typed image media item based on its ID
As with example one, we are accessing a MediaType `image` using the same ID assumption. 

    @{
        //We can use the OfType extension method to convert the IPublishedContent 
        // returned by TypedMedia to the ModelsBuilder implementation.
        var mediaItem = Umbraco.TypedMedia(1234).OfType<Image>();
    }

    <img src="@mediaItem.Url" height="@mediaItem.UmbracoHeight" />

**Note:** It can be worth doing additional Null checks around your code, just in case the conversion fails or TypedMedia returns null. This makes your code more robust and is generally recommended.

### Other Media Items
Accessing other media items can be performed in the same way, the techniques aren't limited to just the `Image` type, but it is one of the most common use cases.

## Image Cropper
Image Cropper is generally used with `Image` media types so it is useful to consider this as Umbraco uses it as the default upload property on the `Image` media type.

If your media type is for images and it has Image Cropper as the upload field (umbracoFile) the `GetCropUrl` extension method is your friend. Details of the Image Cropper property editor and other examples of using it can be found [here](../../Backoffice/Property-Editors/Built-in-Property-Editors/Image-Cropper.md). The following example is a quick example to help you get started.

### Example of using Image Cropper with the Models Builder strongly typed `Image` model

    @{
        //We can use the OfType extension method to convert the IPublishedContent 
        // returned by TypedMedia to the ModelsBuilder implementation.
        var mediaItem = Umbraco.TypedMedia(1234).OfType<Image>();
    }

    <img src="@mediaItem.GetCropUrl("myCropAlias")" />

This example assumes that you have set up a crop called **myCropAlias** on your Image Cropper data type.        

If you want the original, uncropped image, you can ignore the GetCropUrl extension method and use one of the previously discussed approaches as shown below.

    <img src="@mediaItem.Url" />

### More information
- [Media Picker](../../Backoffice/Property-Editors/Built-in-Property-Editors/Media-Picker2.md)
- [Image Cropper](../../Backoffice/Property-Editors/Built-in-Property-Editors/Image-Cropper.md)
