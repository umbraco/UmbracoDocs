---
description: >-
  Details an integration available for Algolia, built and maintained by Umbraco
  HQ.
---

# Algolia

This integration provides a custom dashboard and indexing component for managing search indices in Algolia.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Search.Algolia)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.Search.Algolia)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.search.algolia)

## Minimum version requirements

To ensure compatibility, check the **Dependencies** tab on NuGet for the required Umbraco CMS version. For example, see [Umbraco.Cms.Integrations.Search.Algolia](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Search.Algolia#dependencies-body-tab).

## Authentication

The communication with Algolia is handled through their [.NET API client](https://www.algolia.com/doc/api-client/getting-started/install/csharp/?client=csharp), which requires an Application ID and an API key.

They are used to initialize the [`SearchClient`](https://github.com/algolia/algoliasearch-client-csharp/blob/master/src/Algolia.Search/Clients/SearchClient.cs) which handles indexing and searching operations.

## Configuration

The following configuration is required for working with the Algolia API:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "CMS": {
      "Integrations": {
        "Search": {
          "Algolia": {
            "Settings": {
              "ApplicationId": "[your_application_id]",
              "AdminApiKey": "[your_admin_api_key]",
              "SearchApiKey": "[your_search_api_key]"
            }
          }
        }
      }
    }
  }
}
```
{% endcode %}

Algolia comes with a set of predefined API keys:

| Name                | Purpose                                                                                  |
| ------------------- | ---------------------------------------------------------------------------------------- |
| Search-Only API key | Public API key used on the front end for performing search queries.                      |
| Admin API key       | Used in the Umbraco backoffice for create-, update- or delete operations on the indices. |

More details on other use cases for the Algolia API keys can be found in [the Algolia Docs](https://www.algolia.com/doc/guides/security/api-keys/#predefined-api-keys).

## Working with the integration

The following details how you can work with the Algolia integration.

1. Go to the _Settings_ section in the Umbraco CMS backoffice.
2. Locate the _Algolia Search Management_ dashboard.

In this view, you will be able to create definitions for indices in Algolia.

3. Provide a name for the index for each indices.
4. Select the Document Types to be indexed.
5. Select the fields you want to include for each Document Type.

After creating an index, only the content definition is saved into the _algoliaIndices_ table in Umbraco, and an empty index is created in Algolia.

The actual content payload is pushed to Algolia for indices created in Umbraco in two scenarios:

* From the list of indices, the _Build_ action is triggered, resulting in all content of specific Document Types being sent as JSON to Algolia.
* Using a custom handler for [CacheRefresher Notifications](https://docs.umbraco.com/umbraco-cms/reference/notifications/cacherefresher-notifications) which will check the list of indices for the specific Document Type, and update a matching Algolia object. The handler will only run for [SchedulingPublisher server or Single server roles](https://docs.umbraco.com/umbraco-cms/reference/scheduling#using-serverroleaccessor).

From the dashboard, you can also perform a search over one selected index, or remove it.

Each Umbraco content item indexed in Algolia is referenced by the content entity's `GUID` Key field.

## Algolia record structure

An indexed Algolia record matching an Umbraco content item contains a default set of properties. It is augmented by the list of properties defined within the Umbraco dashboard.

Properties that can vary by culture will have a record property correspondent with this naming convention: `[property]-[culture]`.

The list of default properties consists of:

* `ObjectID` - GUID`from the content item's`Key\` property
* `Name` - with culture variants if any
* `CreateDate`
* `CreatorName`
* `UpdateDate`
* `WriterName`
* `TemplateId`
* `Level`
* `Path`
* `ContentTypeAlias`
* `Url` - with culture variants if any
* Any registered properties on the Document Type

## Extending the Algolia indexing

Indexing the content for Algolia is based on the `IDataEditor.PropertyIndexValueFactory` property from Umbraco CMS, the indexed value of the property being retrieved using the `GetIndexValues` method.

The integration uses the same conversion process as Umbraco CMS uses for Examine, and apply a custom converter afterwards.

The [`ContentBuilder`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Search.Algolia/Builders/ContentRecordBuilder.cs) is responsible for creating the record object that will be pushed to _Algolia_ and the [`AlgoliaSearchPropertyIndexValueFactory`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Search.Algolia/Services/AlgoliaSearchPropertyIndexValueFactory.cs) implementation of `IAlgoliaSearchPropertyIndexValueFactory` will return the property value.

To customize the returned value from Umbraco CMS you would need to use a custom converter specific to the particular indexed Umbraco property editor.

To extend the behavior, there are available options:

### Version 2.3.0/3.1.0 and up

Starting with versions `2.3.0` and `3.1.0`, Algolia comes with geolocation support for records. This comes following a [community request](https://github.com/umbraco/Umbraco.Cms.Integrations/pull/215).

You can read more about enabling Algolia's geolocation for records in their [official documentation](https://www.algolia.com/doc/guides/managing-results/refine-results/geolocation/#enabling-geo-search-by-adding-geolocation-data-to-records).

By default the integration comes with a `NULL` return value provider, but you can add your own by implementing the `IAlgoliaGeolocationProvider` interface, and register it as singleton:
```csharp
public class UmbracoGeolocationProvider : IAlgoliaGeolocationProvider
{
    public async Task<List<GeolocationEntity>> GetGeolocationAsync(IContent content)
    {
        return new List<GeolocationEntity>
        {
            new GeolocationEntity { Latitude = 55.40638, Longitude = 10.38918 }
        };
    }
}
...
builder.Services.AddSingleton<IAlgoliaGeolocationProvider, UmbracoGeolocationProvider>();
```

### Version 2.1.5 and up

As a resolution for [an issue](https://github.com/umbraco/Umbraco.Cms.Integrations/issues/188) that affects `Umbraco.TinyMCE` property editor in Umbraco 13, the `IProperty` object has been passed to the parse method of the converters.

A custom converter will look like this, allowing developers to add their implementation based on the content property:
```csharp
 public class MyTagsConverter : IAlgoliaIndexValueConverter
 {
     public string Name => Core.Constants.PropertyEditors.Aliases.Tags;

     public object ParseIndexValues(IProperty property, IEnumerable<object> indexValues)
     {
         return new[] { "Umbraco", "is", "awesome" };
     }
 }
```

### Version 2.0.0 to 2.1.5

Starting with version 2.0.0, we provide a collection of converters for the following Umbraco property editors:
- `Umbraco.TrueFalse`
- `Umbraco.Decimal`
- `Umbraco.Integer`
- `Umbraco.MediaPicker3`
- `Umbraco.Tags`

To create a new converter one should implement the `IAlgoliaIndexValueConverter` interface. Then specify the name of the property editor and add the new implementation. The new converter will then need to be added to the `Algolia Converters` collection.

To do so, follow these steps:

1. Create the new converter
```csharp
 public class MyTagsConverter : IAlgoliaIndexValueConverter
 {
     public string Name => Core.Constants.PropertyEditors.Aliases.Tags;

     public object ParseIndexValues(IEnumerable<object> indexValues)
     {
         return new[] { "Umbraco", "is", "awesome" };
     }
 }
```
2. Replace the default converter (if one exists) with the new one
```csharp
public static class MyUmbracoExtensions
{
    public static IUmbracoBuilder AddMyAlgoliaConverters(this IUmbracoBuilder builder)
    {
        builder.AlgoliaConverters()
                .Remove<UmbracoTagsConverter>()
                .Append<MyTagsConverter>();

        return builder;
    }
}
```
3. Inject custom converters
```csharp
services.AddUmbraco(_env, _config)
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddMyAlgoliaConverters()
    .AddComposers()
    .Build();
```

### Up to version 1.5.0

These implementations contain a custom converter for the `Umbraco.MediaPicker3` property editor.

If a different implementation is required, you will need to follow these steps:

1. Inherit from `AlgoliaSearchPropertyIndexValueFactory`
2. Override the `GetValue` method
3. Add custom handlers to the [`Converters`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/fe5b17be519fff2c2420966febe73c8ed61c9374/src/Umbraco.Cms.Integrations.Search.Algolia/Services/AlgoliaSearchPropertyIndexValueFactory.cs#L26) dictionary
4. Register your implementation in the composer

The following code sample demonstrates this approach:

```csharp
 public class ExtendedAlgoliaSearchPropertyIndexValueFactory : AlgoliaSearchPropertyIndexValueFactory
  {
      private readonly IMediaService _mediaService;

      public ExtendedAlgoliaSearchPropertyIndexValueFactory(IDataTypeService dataTypeService, IMediaService mediaService)
          : base(dataTypeService, mediaService)
      {
          _mediaService = mediaService;

          Converters = new Dictionary<string, Func<KeyValuePair<string, IEnumerable<object>>, string>>
          {
              { Core.Constants.PropertyEditors.Aliases.MediaPicker3, ExtendedMediaPickerConverter }
          };
      }

      public override KeyValuePair<string, string> GetValue(IProperty property, string culture)
      {
          return base.GetValue(property, culture);
      }

      private string ExtendedMediaPickerConverter(KeyValuePair<string, IEnumerable<object>> indexValue)
      {
          return "my custom converter for media picker";
      }

  }
```

### Extension registration

```csharp
builder.Services.AddScoped<IAlgoliaSearchPropertyIndexValueFactory, ExtendedAlgoliaSearchPropertyIndexValueFactory>();
```
