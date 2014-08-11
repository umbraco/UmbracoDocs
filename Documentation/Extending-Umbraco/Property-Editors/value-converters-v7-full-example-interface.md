# Content Picker Value Converter Example using meta interface #

	namespace MyConverters
	{
	    using System;
	
	    using Umbraco.Core;
	    using Umbraco.Core.Models;
	    using Umbraco.Core.Models.PublishedContent;
	    using Umbraco.Core.PropertyEditors;
	    using Umbraco.Web;
	
	    public class ContentPickerPropertyConverter : IPropertyValueConverterMeta
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
	
	        public Type GetPropertyValueType(PublishedPropertyType propertyType)
	        {
	            return typeof(IPublishedContent);
	        }
	
	        public PropertyCacheLevel GetPropertyCacheLevel(PublishedPropertyType propertyType, PropertyCacheValue cacheValue)
	        {
	            PropertyCacheLevel returnLevel;
	            switch (cacheValue)
	            {
	                case PropertyCacheValue.Object:
	                    returnLevel = PropertyCacheLevel.ContentCache;
	                    break;
	                case PropertyCacheValue.Source:
	                    returnLevel = PropertyCacheLevel.Content;
	                    break;
	                case PropertyCacheValue.XPath:
	                    returnLevel = PropertyCacheLevel.Content;
	                    break;
	                default:
	                    returnLevel = PropertyCacheLevel.None;
	                    break;
	            }
	
	            return returnLevel;
	        }
	    }
	}