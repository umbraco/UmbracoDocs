# Rendering media

_Templates can access items in the [Media library](../../Data/Creating-Media/index.md), to assist in displaying rich content like galleries_

In the following examples we will be looking at rendering out an Image, however the core principles do apply to all media items but property aliases may differ.

## Rendering a media item
A media node is not just a file, but like content, it is a collection of fields, such width, height and the path to the stored file. The benefit of this is that accessing media is very similar to accessing a content node.

### Example 1: Accessing an image media item based on its ID
A standard image in the media library is based on the Mediatype `image` which provides a number of standard values - if you want to add more, simply edit the media type under **settings**.

_Assumption: We are going to assume that our media item has an ID of **1234**, and that we are **not using Models Builder**_

    @{
        var mediaItem = Umbraco.TypedMedia(1234);
        var height = mediaItem.GetPropertyValue<string>("umbracoHeight");

        //There are two ways to get your media item url, this is one way.
        var file = mediaItem.GetPropertyValue<string>("umbracoFile");

        //This is the other
        var url = mediaItem.Url
    }

    <img src="@file" height="@height" />

But wait a second, why do we have to access properties in the old IPublishedContent approach when Umbraco now comes with [ModelsBuilder](../../../Reference/Templating/Modelsbuilder/index.md) you may be asking yourself. Well, if you are using Umbraco version 7.4.0 or newer, you don't. You can happily use a nicely TypedModel for your media item if ModelsBuilder is enabled.

### Example 2: Accessing a typed image media item based on its ID
As with example one, we are accessing a MediaType `image` using the same ID assumption. 

    @{
        //We can use the OfType extension method to convert the IPublishedContent 
        // returned by TypedMedia to the ModelsBuilder implementation.
        var mediaItem = Umbraco.TypedMedia(1234).OfType<Image>();
    }

    <img src="@mediaItem.Url" height="@mediaItem.UmbracoHeight" />

**Note:** It can be worth doing additional Null checks around your code, just incase the conversion fails or TypedMedia returns null. This makes your code more robust and is generally recommended.

### Other Media Items
Accessing other media items can be performed in the same way, the techniques aren't limited to just the Image type, but it is one of the most common use cases.



## Image Cropper
Although not used on most media items, Image Cropper is generally used with Images. So it is useful to consider this as Umbraco uses it as the default upload property on the Image media type.

If your media type is for images, and it has Image Cropper as the upload field (umbracoFile) the `GetCropUrl` extension method is your friend. Details of the Image Cropper property editor and other examples of using it can be found [here](../../Backoffice/Property-Editors/Built-in-Property-Editors/Image-Cropper.md), be the following example is a quick example to help you get started.

### Example of using Image Cropper with your strongly typed Image model

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
