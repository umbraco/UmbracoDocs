#Image Cropper datatype
The Image Cropper datatype started out it's life as a [standalone package](http://our.umbraco.org/projects/backoffice-extensions/image-cropper) developed by [Kenneth Solberg](http://our.umbraco.org/member/2637) and was later added to the Umbraco Core in [version 4.5](http://umbraco.codeplex.com/releases/view/47241) which was formerly known as version 4.1. 

The datatype itself is not created as part of the default Umbraco installation but is readily available for you to create your own datatypes using the control.
##Settings
###Property alias

The alias of the MediaType property with the path to the image file. When using the standard Image MediaType use the property 'umbracoFile'.
Save crop images (/media/(imageid)/(filename)_(cropname).jpg):	

Ticking this option causes the crops to be saved in the specified format and when checked will offer the option to alter the output quality of cropped images, the field expects a numeric value between 0 - 100. E.g. 90 = 90% compared to original image quality.

###Show Label

Flag to determine if a label should be shown for the property the datatype is used on.

###Crops

This section allows you to specify the different crops to create for the MediaType, you can create as many as needed and also change the order of them using the up and down buttons provided. Unfortunately what you can't do is edit existing crops at present.

###Name	

The name of the crop, used when referencing crops in your XSLT or Razor macros.

###Target width

The width of the crop to save in pixels. If a value entered is greater than the original width the crop will still be saved and the output file will be scaled up causing loss of quality.

###Target height

The height of the crop to save in pixels. If a value entered is greater than the original height the crop will still be saved and the output file will be scaled up causing loss of quality.

###Default position

The default position of the crop marks when creating crops e.g. you may want to offset the crop so it is taken from the centre of the image.

###Keep aspect

When checked will maintain the aspect ration of the image when creating crops and will crop based on the longest dimension.