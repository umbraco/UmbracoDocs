---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Image Cropper

`Returns: MediaWithCrops`

Returns a path to an image, along with information about focal point and available crops

When image Cropper is used on a Media Type the crops are shared between all usages of a Media Item. This is called global crops.

If Image Cropper is used on a Document Type, the file and crops will be local to the Document.

Notice its possible make local crops on shared Media Items via the Media Picker 3 Property Editor.

[Read about the Media Picker 3](../Media-Picker-3/index.md)

## Settings

### Prevalues

You can add, edit & delete crop presets the cropper UI can use.

## Data Type Definition Example

![Image Cropper Data Type Definition](images/imageCropper-v9.png)

## Content Example

The Image Cropper provides a UI to upload an image, set a focal point on the image, and optionally crop and scale the image to predefined crops.
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

## Powered by ImageSharp.Web

[ImageSharp.Web](https://sixlabors.com/products/imagesharp-web/) is image processing middleware for ASP.NET Core.

We bundle this package with Umbraco 9.0+ and you can therefore take full advantage of all its features for resizing and format changing. Built in processing commands are documented [here](https://docs.sixlabors.com/articles/imagesharp.web/processingcommands.html).

## Sample code

Image Cropper comes with an API to generate crop URLs, or you can access its raw data directly as a
dynamic object.

For rendering a cropped media item, the `.GetCropUrl` is used:

```html
<img src="@Url.GetCropUrl(Model.Photo,"square", true)" />

```

The third parameter is `HtmlEncode` and by default set to true, which means you only need to define the parameter if you want to disable HTML encoding.

### Example to output a "banner" crop from a cropper property with the property alias "customCropper"

```html
<img src="@Url.GetCropUrl(Model.SecondaryPhoto, "customCropper", "banner")" />
```

Or, alternatively using the `MediaWithCrops` extension method:

```html
<img src="@Model.SecondaryPhoto.GetCropUrl("customCropper", "banner")" />
```

### Example to dynamically create a crop using the focal point - in this case 300 x 400px image

```csharp
@if (Model.Photo is not null)
{
    <img src="@Url.GetCropUrl(Model.Photo, height: 300, width: 400)" alt="@Model.Photo.Name" />
}
```

### CSS background example to output a "banner" crop

Set the `htmlEncode` to false so that the URL is not HTML encoded

```csharp
@if (Model.Photo is not null)
{
    var cropUrl = Url.GetCropUrl(Model.Photo, "square", false);
    <style>
        .myCssClass {
            background-image: url("@cropUrl");
            height: 400px;
            width: 400px;
        }
    </style>
    <div class="product-image-container myCssClass"></div>
}
```

## Add values programmatically

:::note
The samples in this section has not been verified against the latest version of Umbraco.
:::

See the example below which is using a API controller to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

```csharp
using System;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.PropertyEditors.ValueConverters;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Web.Common.Controllers;
using Umbraco.Extensions;

namespace Umbraco.Docs.Samples.Web.Property_Editors_Add_Values
{
    public class CreateImageCropperValuesController : UmbracoApiController
    {
        private IContentService _contentService;
        private IMediaService _mediaService;
        private MediaUrlGeneratorCollection _mediaUrlGeneratorCollection;


        public CreateImageCropperValuesController(IContentService contentService, IMediaService mediaService, MediaUrlGeneratorCollection mediaUrlGeneratorCollection)
        {
            _contentService = contentService;
            _mediaService = mediaService;
            _mediaUrlGeneratorCollection = mediaUrlGeneratorCollection;
        }

        // /Umbraco/Api/CreateImageCropperValues/CreateImageCropperValues
        [HttpGet]
        public ActionResult<string> CreateImageCropperValues()
        {
            // Create a variable for the GUID of the page you want to update
            var guid = Guid.Parse("4e96411a-b8e1-435f-9322-2faee30ef5f2");

            // Get the page using the GUID you've defined
            var content = _contentService.GetById(guid); // ID of your page

            // Create a variable for the GUID of the media item you want to use
            var mediaKey = Guid.Parse("cf1ab8dc-ad0f-4a8e-974b-87b84777b0d6");

            // Get the desired media file
            var media = _mediaService.GetById(mediaKey);

            // Create a variable for the image cropper and set the source
            var cropper = new ImageCropperValue {Src = media.GetUrl("umbracoFile", _mediaUrlGeneratorCollection)};

            // Serialize the image cropper value
            var cropperValue = JsonConvert.SerializeObject(cropper);

            // Set the value of the property with alias 'cropper'
            content.SetValue("testCropper", cropperValue, "en-US");

            return _contentService.Save(content).Success.ToString();
        }
    }
}
```

Using Modelsbuilder you can get the alias of the desired property without using a magic string (you'll need to inject `IPublishedSnapshotAccessor`):

```csharp
@{
    // Set the value of the property with alias 'cropper'
    content.SetValue(Product.GetModelPropertyType(_publishedSnapshotAccessor, x => x.TestCropper).Alias, cropperValue, "en-US");
}
```

## Get all the crop urls for a specific image

You can use the "GetCropUrl" method not only in the view. But for example in a business class method, where you can pass an "IPublishedContent", to iterate all the available crops and get all the crop urls for a specific image, below you can find an example. 

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

## Sample on how to change the format of the image

Below the example to output a PNG using ImageSharp.Web [format](https://docs.sixlabors.com/articles/imagesharp.web/processingcommands.html#format) command.

```html
<img src="@Url.GetCropUrl(Model.Photo, 500, 300, furtherOptions: "&format=png")" />
```
