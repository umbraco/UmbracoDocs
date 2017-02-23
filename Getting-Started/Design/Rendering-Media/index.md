#Rendering media

_Templates can access items in the Media library, to assist in displaying rich content like galleries_

##Rendering a single media item
A media node is not just a file, but a collection of fields, such width, height and the path to the stored file.

A standard image in the media library is based on the Mediatype `image` which provides a number of standard values - if you want to add more, simply edit the media type under **settings**.

    @{
        var mediaItem = Umbraco.Media(1234);
        var height = mediaItem.UmbracoHeight;
        var file = mediaItem.UmbracoFile;
    }

    <img src="@file" height="@height" />

##Rendering media item with Image Cropper
If the Image Cropper is used as the upload field (umbracoFile) on a media type you can get the cropped image by calling the `GetCropUrl` function and referencing a crop alias.


    @{
        var mediaItem = Umbraco.Media(1234);
        var croppedUrl = Url.GetCropUrl(mediaItem, "cropAlias");
    }

    <img src="@croppedUrl" />

If you want the original, uncropped image.

    @{
      var mediaItem = Umbraco.Media(1234);
      var file = mediaItem.umbracoFile.src;
    }

    <img src="@file" />

###More information
- [Media Picker](../../Backoffice/Property-Editors/Built-in-Property-Editors/Media-Picker.md)
- [Image Cropper](../../Backoffice/Property-Editors/Built-in-Property-Editors/Image-Cropper.md)
