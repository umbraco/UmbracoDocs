#Image Cropper

`Returns: JSON`

Returns a path to an image, along with information about focal point and available crops

##Settings

###Prevalues
You can add, edit & delete crop presets the cropper UI can use.

##Data Type Definition Example

![Image Cropper Data Type Definition](images/Image-Cropper/datatype.png)

##Content Example 

Provides a UI to upload an image, set a focal point on the image, and optionally crop and scale the image to predefined crops.
So by default, images in the cropper will be shown based on a set focal point, and only use specific crops if they are available.

The cropper comes in 3 modes:

- Uploading an image
- Setting a focal point
- Cropping the image to predefined crops

###Uploading images
The editor exposes a simple drop area for files. Click it to upload an image.
![Image Croppper Upload](images/Image-Cropper/upload.png)

###Set focal point
By default, the cropper allows the editor to set a focal point on the uploaded image.
Below the image, all the preset crops are shown to give the editor a preview of what
the image will look like to the end user. 

![Image Croppper Focal point](images/Image-Cropper/focalpoint.png)

###Crop and resize
If needed, the editor can crop the image to specific crop presets, to ensure the right part and size of the image
is shown for a specific crop.

![Image Croppper Crop](images/Image-Cropper/crop.png)


##Sample code

###MVC View Example to output a "banner" crop from a cropper property with the alias "image"
    
    //show the crop preset "banner"
    <img src='@CurrentPage.GetCropUrl("image", "banner")' />

    //or from specific node:
    <img src='@Umbraco.Content(1234).GetCropUrl("image", "banner")' />

    //or from typed content:
    <img src='@Model.Content.GetCropUrl("image", "banner")' />

###MVC View Example to output the raw image url from a cropper property with the alias "image"
        
    @if (CurrentPage.HasValue("image"))
    {
        <img src='@CurrentPage.image.src'/>
    }       


###MVC View Example to output create custom crops - in this case forcing a 300 x 400 px image
            
        @if (CurrentPage.HasValue("image"))
        {
            <img src='@Model.Content.GetCropUrl(propertyAlias: "image", height:300, width:400)'/>
        }       


##Powered by ImageProcessor
[ImageProcessor](http://jimbobsquarepants.github.io/ImageProcessor/) is an amazing project for modifying and processing images in a simple an efficient manner.

We bundle this library in Umbraco 7.1 and you can therefore take full advantage of all its features out-of-the-box, like sharping, blurring, cropping, rotating and so.

###MVC View Exemple on how to blur a crop

    <img src='@CurrentPage.GetCropUrl("image", "banner")&blur=11,sigma-1.5,threshold-10' />

Using ImageProcessors built-in [gaussianblur](http://jimbobsquarepants.github.io/ImageProcessor/imageprocessor-web/gaussianblur.html)    


