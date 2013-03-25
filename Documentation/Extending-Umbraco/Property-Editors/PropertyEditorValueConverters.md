# Property Editor Value Converter

**Applies to Umbraco 4.10 and newer**

A property editor value converter converts a property editors stored value to another type to be returned in a MVC View and accessed in Razor. For example as standard the core "Content Picker" returns a `String` containing the node id of the selected node. If you implement a converter it might return a `IPublishedContent` object.

All samples in this document will require the following usings:

	using Umbraco.Core;
	using Umbraco.Core.PropertyEditors;
	using Umbraco.Core.Models;
	using Umbraco.Web;

## Implementing the interface

Implement `IPropertyEditorValueConverter` on your class

## Methods

### `IsConverterFor(Guid propertyEditorId, string docTypeAlias, string propertyTypeAlias)`

### `Attempt<object> ConvertPropertyValue(object value)`

## Content picker example

Converts the string node id to `IPublishedContent`

	using Umbraco.Core;
	using Umbraco.Core.PropertyEditors;
	using Umbraco.Core.Models;
	using Umbraco.Web;
	namespace MyConverters
	{
	    public class ContentPickerPropertyEditorValueConverter : IPropertyEditorValueConverter
	    {	
	        public bool IsConverterFor(Guid propertyEditorId, string docTypeAlias, string propertyTypeAlias)
	        {
	            return Guid.Parse("158aa029-24ed-4948-939e-c3da209e5fba").Equals(propertyEditorId);
	        }
	        public Attempt<object> ConvertPropertyValue(object value)
	        {
	            if (UmbracoContext.Current != null)
	            {                
	                var umbHelper = new UmbracoHelper(UmbracoContext.Current);
	                IPublishedContent contentPickerContent = null;	               
	                contentPickerContent = umbHelper.TypedContent(value.ToString());                    	               
	                return new Attempt<object>(true, contentPickerContent);
	            }
	            else
	            {
	                return Attempt<object>.False;
	            }
	        }
	    }
	}

## Using the converted property editor in Razor ##

### Typed: ###

    @{
        IPublishedContent typedContentPicker = Model.Content.GetPropertyValue<IPublishedContent>("contentPicker");
        if (typedContentPicker != null)
        {
            <p>@typedContentPicker.Name</p>                                                
        } 
    }

### Dynamic: ###

    @{
        var dynamicContentPicker = CurrentPage.contentPicker;
        if (dynamicContentPicker != null)
        {
            <p>@dynamicContentPicker.Name</p>                                                
        } 
    }