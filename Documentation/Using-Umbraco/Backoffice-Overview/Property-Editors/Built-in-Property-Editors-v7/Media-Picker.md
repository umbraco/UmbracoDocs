#Media Picker

`Returns: ID or CSV`

The media picker displays the current selected media and provides the option to open the mediaPicker dialog to select existing or upload new media files.

##Settings

###Pick multiple items
If checked, the picker will allow the user to select multiple media items using the mediaPicker dialog, a property using this editor will return a CSV string of media ids.

##Data Type Definition Example

![Media Picker Data Type Definition](images/Media-Picker-DataType.jpg)

##Content Example 

![Media Picker Content](images/Media-Picker-Content.jpg)

##MVC View Example

###Typed:
In Umbraco v7.0.0 this sample is ideal and will work correctly except in the situation of a selected media item having been deleted, in this situation, an exception will occur, see workaround below.

	@if (Model.Content.HasValue("caseStudyImage"))
	{
	    var caseStudyImagesList = Model.Content.GetPropertyValue<string>("caseStudyImage").Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(int.Parse);
	    var caseStudyImagesCollection = Umbraco.TypedMedia(caseStudyImagesList).Where(x => x != null);
	
	    foreach (var caseStudyImage in caseStudyImagesCollection)
	        {      
	            <img src="@caseStudyImage.Url" />      
	        }                                                               
	}

###Typed Workaround:
	@if (Model.Content.HasValue("caseStudyImage"))
	{
	    var caseStudyImagesList = Model.Content.GetPropertyValue<string>("caseStudyImage").Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(int.Parse);  
	        
	    foreach (var item in caseStudyImagesList)
	    {
	        // Try/Catch workaround for Umbrco.TypedMedia throwing an exception if media item has been deleted. http://issues.umbraco.org/issue/U4-3630        
	        IPublishedContent image;
	        try { image = Umbraco.TypedMedia(item); }
	        catch { image = null; }
	        
	        if (image != null)
	        {
	            <img src="@image.Url" />
	        }
	    }
	}

###Dynamic:                              

TBC