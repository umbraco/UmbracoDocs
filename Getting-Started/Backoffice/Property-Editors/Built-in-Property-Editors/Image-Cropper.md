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

Image Cropper comes with a simple to use API to generate crop urls, or you can access its raw data directly as a
dynamic object.



####MVC View Example to output a "banner" crop from a cropper property with the alias "image"
    
    //show the crop preset "banner"
    <img src='@CurrentPage.GetCropUrl("image", "banner")' />

    //or from specific node:
    <img src='@Umbraco.Content(1234).GetCropUrl("image", "banner")' />

    //or from typed content:
    <img src='@Model.Content.GetCropUrl("image", "banner")' />


####MVC View Example to output create custom crops - in this case forcing a 300 x 400 px image
            
        @if (CurrentPage.HasValue("image"))
        {
            <img src='@Model.Content.GetCropUrl(propertyAlias: "image", height:300, width:400)'/>
        }

####Media example to output a "banner" crop from a cropper property with alias "umbracoFile"

The cropped URL can also be found for media in a similar way:

    @Umbraco.Media(1234).GetCropUrl("banner")
    @Umbraco.TypedMedia(1234).GetCropUrl("banner")

###Data returned

The cropper returns a dynamic object, based on a json structure like this: 

                            
    {
      "focalPoint": {
        "left": 0.23049645390070922,
        "top": 0.27215189873417722
      },
      "src": "/media/SampleImages/1063/pic01.jpg",
      "crops": [
        {
          "alias": "banner",
          "width": 800,
          "height": 90
        },
        {
          "alias": "highrise",
          "width": 80,
          "height": 400
        },
        {
          "alias": "thumb",
          "width": 90,
          "height": 90
        }
      ]
    }

So you can access each property directly:

    <img src='@CurrentPage.image.src'/>

Or iterate through them:
                       
    @foreach(var crop in CurrentPage.image.crops){
        <img src="@CurrentPage.GetCropUrl("image", crop.alias)">    
    }     


##Powered by ImageProcessor
[ImageProcessor](http://imageprocessor.org/) is an amazing project for modifying and processing images in a simple an efficient manner.

We bundle this library in Umbraco 7.1 and you can therefore take full advantage of all its features out-of-the-box, like sharping, blurring, cropping, rotating and so.

####MVC View Exemple on how to blur a crop

    <img src='@CurrentPage.GetCropUrl("image", "banner")&blur=11,sigma-1.5,threshold-10' />

Using ImageProcessors built-in [gaussianblur](http://imageprocessor.org/imageprocessor-web/imageprocessingmodule/gaussianblur.html)    

##Upload property replacement

You can replace an upload property with a cropper, existing images will keep returning their current path and work unmodified with the cropper 
applied. The old image will even be available in the cropper, so you can modify it if you ever need to. 

However, be aware that a cropper returns a dynamic object when saved, so if you perform any sort of string modifications on your upload property value, 
you will most likely see some errors in your templates / macros.

