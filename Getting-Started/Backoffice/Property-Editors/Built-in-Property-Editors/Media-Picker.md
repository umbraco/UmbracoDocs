# (Obsolete) Media Picker

`Returns: ID or CSV`

The media picker displays the current selected media and provides the option to open the mediaPicker dialog to select existing or upload new media files.

## Settings

### Pick multiple items
If checked, the picker will allow the user to select multiple media items using the mediaPicker dialog, a property using this editor will return a CSV string of media ids.

## Data Type Definition Example

![Media Picker Data Type Definition](images/Media-Picker-DataType.jpg)

## Content Example 

![Media Picker Content](images/Media-Picker-Content.jpg)

## MVC View Example - value converters enabled

### Typed Example (multiple enabled): ##

```c#
    @{
        var typedMultiMediaPicker = Model.Content.GetPropertyValue<IEnumerable<IPublishedContent>>("caseStudyImages");
        foreach (var item in typedMultiMediaPicker)
        {
            <img src="@item.Url" style="width:200px"/>
        }
    }
```

### Typed Example (multiple disabled): ##

```c#
    @{
        var typedMediaPickerSingle = Model.Content.GetPropertyValue<IPublishedContent>("featuredBanner");
        if (typedMediaPickerSingle != null)
        {
            <p>@typedMediaPickerSingle.Url</p>
            <img src="@typedMediaPickerSingle.Url" style="width:200px" alt="@typedMediaPickerSingle.GetPropertyValue("alt")" />
        }
    }      
```

## MVC View Example - value converters disabled

### Typed (multiple enabled:

	@if (Model.Content.HasValue("caseStudyImages"))
	{
	    var caseStudyImagesList = Model.Content.GetPropertyValue<string>("caseStudyImages").Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(int.Parse);
	    var caseStudyImagesCollection = Umbraco.TypedMedia(caseStudyImagesList).Where(x => x != null);
	
	    foreach (var caseStudyImage in caseStudyImagesCollection)
	        {      
	            <img src="@caseStudyImage.Url" style="width:300px;height:300px" />      
	        }                                                               
	}

### Dynamic (multiple enabled:                              

	@if (CurrentPage.HasValue("caseStudyImages"))
	{
	    var caseStudyImagesList = CurrentPage.CaseStudyImages.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
	    var caseStudyImagesCollection = Umbraco.Media(caseStudyImagesList);
	
	    foreach (var caseStudyImage in caseStudyImagesCollection)
	    {
	        <img src="@caseStudyImage.Url" style="width:300px;height:300px" />
	    }
	}