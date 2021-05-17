---
versionFrom: 8.0.0
versionTo: 8.6.0
---

# Image Cropper

`Returns: JSON`

Returns a path to an image, along with information about focal point and available crops

## Settings

### Prevalues
You can add, edit & delete crop presets the cropper UI can use.

## Data Type Definition Example

![Image Cropper Data Type Definition](images/imageCropper-v8.png)

## Content Example

Provides a UI to upload an image, set a focal point on the image, and optionally crop and scale the image to predefined crops.
By default, images in the cropper will be shown based on a set focal point, and only use specific crops if they are available.

The cropper comes in 3 modes:

- Uploading an image
- Setting a focal point
- Cropping the image to predefined crops

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


## Sample code

Image Cropper comes with an API to generate crop URLs, or you can access its raw data directly as a
dynamic object.

The Url Helper method can be used to replace the IPublishedContent extension methods. It has  a set of extensions for working with URLs. 

For rendering a cropped media item, the `.GetCropUrl` is used:

```csharp
@Url.​GetCropUrl​(mediaItem: Model.Image, cropAlias: ​"Grid"​, htmlEncode: true); 
```

`HtmlEncode` is by default set to true, which means you only need to define the parameter if you wan't to disable HTML encoding.

### MVC View Example to output a "banner" crop from a cropper property with the alias "image"

```html
<img src="@(Url.GetCropUrl(Model.Image, "banner"))" />
```

Or, alternatively:

```html
<img src="@(Model.Image.GetCropUrl("banner"))" />
```

### MVC View Example to output create custom crops - in this case forcing a 300 x 400 px image

```csharp
@if (Model.HasValue("image"))
{
    <img src="@Model.Image.GetCropUrl(height: 300, width: 400)" />
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

## Going further with the image cropper

Umbraco's Image Cropping functionality is based on the opensource library ![ImageProcessor.Web](https://imageprocessor.org/imageprocessor-web/) that has lots of additional options for transforming your images via query string parameters. 
Using the "GetCropUrl" method, specifying the crop alias: 

```html
<img src="@(Model.Image.GetCropUrl("banner"))" />
```

it's possible to retrieve an URL with a series of query string parameters that represents your crop settings, here an example of the returned URL for a specific crop name:

```
https:{your-domain}/{image-name}.jpg?crop=0.10592105263157896,0.0061107012631250292,0.528981977613254,0&cropmode=percentage&width=690&height=719&rnd=132652178928630000
```

You can use the "GetCropUrl" method not only in the view, but also for example in a business class method, where you can pass an "IPublishedContent", to iterate all the available crops dynamically, and get all the crop urls for a specific image, below you can find an example. Later, you can manipulate every obtained URL with other query string parameters provided by "ImageProcessor" library.

```csharp

   private readonly ConfigurationManager configuration;

   //Your ctor
   public MyClassName(ConfigurationManager configuration)
        {
            this.configuration = configuration;
        }

   internal Dictionary<string, string> GetCropUrls(IPublishedContent image)
        {
            //Instantiate the dictionary that I will return with "Crop alias" and "Cropped URL"
            Dictionary<string, string> cropUrls = new Dictionary<string, string>();

            if (image.GetProperty("umbracoFile").HasValue())
            {
                //Dynamically retrieve the ImageCropperValue properties
                ImageCropperValue fileProperties = (ImageCropperValue)image.GetProperty("umbracoFile").GetValue();
                
                //Iterating Crop elements to get every alias defined in the backoffice
                foreach (ImageCropperValue.ImageCropperCrop crop in fileProperties.Crops)
                {
                    //Get the cropped URL and add it to the dictionary that I will return
                    cropUrls.Add(crop.Alias, string.Concat(configuration.BasePath, image.GetCropUrl(crop.Alias)));
                }
            }

            return cropUrls;
        }
```

Below the list of the available query string parameters provided by the "ImageProcessor" library. You can find all the examples in the official ![reference guide](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/#methods): 

- ![Alpha](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/alpha/) Adjusts the alpha transparency of images. Pass the desired percentage value (without the ‘%’) to the processor;
- ![Animation Process Mode](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/animationprocessmode/) Defines whether gif images are processed to preserve animation or processed keeping the first frame only;
- ![AutoRotate](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/autorotate/) Performs auto-rotation to ensure that EXIF defined rotation is reflected in the final image;
- ![BackgroundColor](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/backgroundcolor/) Changes the background color of the current image. This functionality is useful for adding a background when resizing image formats without an alpha channel;
- ![Brightness](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/brightness/) Adjusts the brightness of images. Pass the desired percentage value (without the ‘%’) to the processor;
- ![Contrast](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/contrast/) Adjusts the contrast of images. Pass the desired percentage value (without the ‘%’) to the processor;
- ![Crop](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/crop/) Crops the current image to the given location and size. There are two modes available: Pixel based, Percentage based;
- ![DetectEdges](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/detectedges/) Detects the edges in the current image using various one and two dimensional algorithms. If the greyscale parameter is set to false the detected edges will maintain the pixel colors of the original image;
- ![EntropyCrop](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/entropycrop/)  Crops an image to the area of greatest entropy. This method works best with images containing large areas of a single color or similar colors around the edges;
- ![Filter](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/filter/) Applies a filter to the current image;
- ![Flip](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/flip/) Flips the current image either horizontally, vertically, or both;
- ![Format](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/format/) Sets the output format of the current image to the given value;
- ![GaussianBlur](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/gaussianblur/)  Uses a Gaussian kernel to blur the current image. Pass the desired kenel size to the processor;
- ![GaussianSharpen](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/gaussiansharpen/)  Uses a Gaussian kernel to sharpen the current image. Pass the desired kenel size to the processor;
- ![Hue](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/hue/)  Alters the hue of the current image changing the overall color. The angle can be and value between 0 and 360 degrees;
- ![Mask](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/mask/)  Applies the given image mask to the current image. Any area containing transparency withing the mask will be removed from the original image. If the mask is larger than the image it will be resized to match the images dimensions;
- ![Meta](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/meta/) Toggles preservation of EXIF defined metadata within the image. Overrides the global variable set in the processing.config;
- ![Overlay](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/overlay/)  Adds a image overlay to the current image. If the overlay is larger than the image it will be resized to match the images dimensions;
- ![Pixelate](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/pixelate/) Pixelates an image with the given size;
- ![Quality](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/quality/) Alters the output quality of the current image. This method will only effect the output quality of images that allow lossy processing;
- ![ReplaceColor](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/replacecolor/) Replaces a color within the current image;
- ![Resize](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/resize/) Resizes the current image to the given dimensions;
- ![Rotate](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/rotate/) Rotates the current image by the given angle without clipping;
- ![RoundedCorners](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/roundedcorners/) Adds rounded corners to the current image;
- ![Saturation](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/saturation/)  Adjusts the saturation of images. Pass the desired percentage value (without the '%') to the processor;
- ![Tint](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/tint/) Tints the current image with the given color;
- ![Vignette](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/vignette/) Adds a vignette image effect to the current image;
- ![Watermark](https://imageprocessor.org/imageprocessor-web/imageprocessingmodule/watermark/) Adds a text based watermark to the current image with a wide range of options.

**Attention**: For security reasons **only the following essential processors are enabled by default**:

- AutoRotate
- BackgroundColor
- Crop
- Format
- Quality
- Resize

You can find here ![how to enalble other methods](https://imageprocessor.org/imageprocessor-web/) (see the ![Configuration section](https://imageprocessor.org/imageprocessor-web/configuration/)).

## Upload property replacement

You can replace an upload property with a cropper, existing images will keep returning their current path and work unmodified with the cropper
applied. The old image will even be available in the cropper, so you can modify it if you ever need to.

However, be aware that a cropper returns a dynamic object when saved, so if you perform any sort of string modifications on your upload property value,
you will most likely see some errors in your templates / macros.
