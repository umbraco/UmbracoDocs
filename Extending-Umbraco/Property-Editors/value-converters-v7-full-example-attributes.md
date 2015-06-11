# Content Picker Value Converter Example using meta attributes #

	namespace MyConverters
	{
	    using Umbraco.Core;
	    using Umbraco.Core.Models;
	    using Umbraco.Core.Models.PublishedContent;
	    using Umbraco.Core.PropertyEditors;
	    using Umbraco.Web;
	
	    [PropertyValueType(typeof(IPublishedContent))]
	    [PropertyValueCache(PropertyCacheValue.Source, PropertyCacheLevel.Content)]
	    [PropertyValueCache(PropertyCacheValue.Object, PropertyCacheLevel.ContentCache)]
	    [PropertyValueCache(PropertyCacheValue.XPath, PropertyCacheLevel.Content)]
	    public class ContentPickerPropertyConverter : IPropertyValueConverter
	    {
	        public bool IsConverter(PublishedPropertyType propertyType)
	        {
	            return propertyType.PropertyEditorAlias.Equals("Umbraco.ContentPickerAlias");
	        }
	
	        public object ConvertDataToSource(PublishedPropertyType propertyType, object source, bool preview)
	        {
	            var attemptConvertInt = source.TryConvertTo<int>();
	            if (attemptConvertInt.Success)
	            {
	                return attemptConvertInt.Result;
	            }
	
	            return null;
	        }
	
	        public object ConvertSourceToObject(PublishedPropertyType propertyType, object source, bool preview)
	        {
	            if (source == null || UmbracoContext.Current == null)
	            {
	                return null;
	            }
	
	            var umbHelper = new UmbracoHelper(UmbracoContext.Current);
	            return umbHelper.TypedContent(source);
	        }
	
	        public object ConvertSourceToXPath(PublishedPropertyType propertyType, object source, bool preview)
	        {
	            return source.ToString();
	        }
	    }
	} 