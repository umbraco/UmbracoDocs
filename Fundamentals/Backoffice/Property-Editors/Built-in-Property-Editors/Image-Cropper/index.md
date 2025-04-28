---
versionFrom: 8.7.0
meta.RedirectLink: "/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/image-cropper"
---

# Image Cropper

`Returns: JSON`

Returns a path to an image, along with information about focal point and available crops

When image Cropper is used on a Media Type the crops are shared between all usages of a Media Item. This is called global crops.

If Image Cropper is used on a Document Type, the file and crops will be local to the Document.

Notice its possible make local crops on shared Media Items via the Media Picker 3 Property Editor.

[Read about the Media Picker 3](../Media-Picker-3/index.md)

## Settings

### Prevalues

You can add, edit & delete crop presets the cropper UI can use.

## Data Type Definition Example

![Image Cropper Data Type Definition](images/imageCropper-v8.png)

## Content Example

Provides a UI to upload an image, set a focal point on the image, and optionally crop and scale the image to predefined crops.
By default, images in the cropper will be shown based on a set focal point, and only use specific crops if they are available.

The cropper comes in 3 modes:

-   Uploading an image
-   Setting a focal point
-   Cropping the image to predefined crops

### Uploading images

The editor exposes a drop area for files. Click it to upload an image.
![Image Cropper Upload](images/imageCropper-upload-v8.png)

### Set focal point

By default, the cropper allows the editor to set a focal point on the uploaded image.
Next to the image, all the preset crops are shown to give the editor a preview of what
the image will look like to the end user.

![Image Cropper Focal point](images/imageCropper-focalpoint-v8.png)

### Crop and resize

If needed, the editor can crop the image to specific crop presets, to ensure the right part and size of the image
is shown for a specific crop.

![Image Cropper Crop](images/imageCropper-crop-v8.png)

## Powered by ImageProcessor

[ImageProcessor](https://imageprocessor.org/) is an amazing project for modifying and processing images in an efficient manner.

We bundle this library in Umbraco 7.1+ and you can therefore take full advantage of all its features out-of-the-box, like sharping, blurring, cropping, rotating and so.

## Sample code

Image Cropper comes with an API to generate crop URLs, or you can access its raw data directly as a
dynamic object.

The Url Helper method can be used to replace the IPublishedContent extension methods. It has a set of extensions for working with URLs.

For rendering a cropped media item, the `.GetCropUrl` is used:

```csharp
@Url.​GetCropUrl​(mediaItem: Model.Image, cropAlias: ​"Grid"​, htmlEncode: true);
```

`HtmlEncode` is by default set to true, which means you only need to define the parameter if you want to disable HTML encoding.

### MVC View Example to output a "banner" crop from a cropper property with the alias "image"

```html
<img src="@(Url.GetCropUrl(Model.Image, "banner"))" />
```

Or, alternatively:

```html
<img src="@(Model.Image.GetCropUrl("banner", Current.ImageUrlGenerator))" />
```

### MVC View Example to output create custom crops - in this case forcing a 300 x 400 px image

```csharp
@if (Model.HasValue("image"))
{
    <img src="@Model.Image.GetCropUrl(height: 300, width: 400, imageUrlGenerator: Current.ImageUrlGenerator)" />
}
```

### CSS background example to output a "banner" crop from a cropper property with alias "image"

Set the `htmlEncode` to false so that the URL is not HTML encoded

```csharp
@{

    if (Model.Image != null)
    {
        var cropUrl = Url.GetCropUrl(Model.Image, "banner", false);
        <style>
            .myCssClass {
                background-image: url("@cropUrl");
            }
        </style>
    }
}
```

### MVC View Example on how to blur a crop

```csharp
<img src="@Url.GetCropUrl(Model.Image, propertyAlias: "image", cropAlias:
"banner", useCropDimensions:true, furtherOptions:
"&blur=11&sigma=1.5&threshold=10")" />
```

Using ImageProcessors built-in [gaussian blur](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/gaussianblur/)

## Upload property replacement

You can replace an upload property with a cropper, existing images will keep returning their current path and work unmodified with the cropper
applied. The old image will even be available in the cropper, so you can modify it if you ever need to.

However, be aware that a cropper returns a dynamic object when saved, so if you perform any sort of string modifications on your upload property value,
you will most likely see some errors in your templates / macros.

## Add values programmatically

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

```csharp
@using Umbraco.Core.PropertyEditors.ValueConverters
@using Newtonsoft.Json
@{
    // Get access to ContentService
    var contentService = Services.ContentService;

    // Create a variable for the GUID of the page you want to update
    var guid = Guid.Parse("32e60db4-1283-4caa-9645-f2153f9888ef");

    // Get the page using the GUID you've defined
    var content = contentService.GetById(guid); // ID of your page

    // Create a variable for the GUID of the media item you want to use
    var mediaKey = Guid.Parse("8835014f-5f21-47b7-9f1a-31613fef447c");

    // Get the desired media file
    var media = Umbraco.Media(mediaKey);

    // Create a variable for the image cropper and set the source
    var cropper = new ImageCropperValue {Src = media.Url()};

    // Serialize the image cropper value
    var cropperValue = JsonConvert.SerializeObject(cropper);

    // Set the value of the property with alias 'cropper'
    content.SetValue("cropper", cropperValue);

    contentService.Save(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    // Get the page using it's id
    var content = contentService.GetById(1234);
}
```

If Modelsbuilder is enabled you can get the alias of the desired property without using a magic string:

```csharp
@{
    // Set the value of the property with alias 'cropper'
    content.SetValue(Home.GetModelPropertyType(x => x.Cropper).Alias, cropperValue);
}
```

## Going further with the image cropper

Umbraco's Image Cropping functionality is based on the opensource library [ImageProcessor.Web](https://imageprocessor.org/imageprocessor-web/) that has lots of additional options for transforming your images via query string parameters.
Using the "GetCropUrl" method, specifying the crop alias:

```html
<img src="@(Model.Image.GetCropUrl("banner"))" />
```

it's possible to retrieve an URL with a series of query string parameters that represents your crop settings, here an example of the returned URL for a specific crop name:

```
https:{your-domain}/{image-name}.jpg?crop=0.10592105263157896,0.0061107012631250292,0.528981977613254,0&cropmode=percentage&width=690&height=719&rnd=132652178928630000
```

## Get all the crop urls for a specific image

You can use the "GetCropUrl" method not only in the view. But for example in a business class method, where you can pass an "IPublishedContent", to iterate all the available crops dynamically, and get all the crop urls for a specific image, below you can find an example. Later, you can manipulate every obtained URL with other query string parameters provided by "ImageProcessor" library.

```csharp
internal Dictionary<string, string> GetCropUrls(IPublishedContent image)
{
    //Instantiate the dictionary that I will return with "Crop alias" and "Cropped URL"
    Dictionary<string, string> cropUrls = new Dictionary<string, string>();

    if (image.HasValue("umbracoFile"))
    {
        var imageCropper = image.Value<ImageCropperValue>("umbracoFile");
        foreach (var crop in imageCropper.Crops)
        {
            //Get the cropped URL and add it to the dictionary that I will return
            cropUrls.Add(crop.Alias, image.GetCropUrl(crop.Alias));
        }
    }

    return cropUrls;
}
```

## MVC view Example on how to set the background color

Below the example to set the background color to white using the ImageProcessor [bgcolor](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/backgroundcolor/) property.

```csharp
<img src="@Url.GetCropUrl(Model.Image, propertyAlias: "image", cropAlias: "banner",
useCropDimensions:true, furtherOptions: "&bgcolor=white")" />
```

## List of the available parameters provided by the "ImageProcessor" library

Only the following essential processors are enabled:

-   AutoRotate
-   BackgroundColor
-   Crop
-   Format
-   Quality
-   Resize
