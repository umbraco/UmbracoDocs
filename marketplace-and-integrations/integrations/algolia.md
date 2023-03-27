---
description: >-
  Details an integration available for Algolia, built and maintained by Umbraco HQ.
---

# Cookiebot Integration

This integration provides a custom dashboard and indexing component for managing search indices in Algolia.

Install from NuGet via:
https://www.nuget.org/packages/Umbraco.Cms.Integrations.Search.Algolia

Source code is at:
https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.Search.Algolia

Available on the Umbraco Marketplace at:
https://marketplace.umbraco.com/package/umbraco.cms.integrations.search.algolia

## Prerequisites

Required minimum versions of Umbraco CMS:
- CMS: 10.3.1
- Algolia.Search: 6.13.0

## How To Use

### Authentication

The communication with Algolia is handled through their [.NET API client](https://www.algolia.com/doc/api-client/getting-started/install/csharp/?client=csharp),
which requires an Application ID and an API key.

They are used to initialize the [`SearchClient`](https://github.com/algolia/algoliasearch-client-csharp/blob/master/src/Algolia.Search/Clients/SearchClient.cs)
which handles indexing and searching operations.

### Configuration

The following configuration is required for working with the Algolia API:

```json
{
  "Umbraco": {
    "CMS": {
      "Integrations": {
        "Search": {
          "Algolia": {
            "Settings": {
              "ApplicationId": "[your_application_id]",
              "AdminApiKey": "[your_admin_api_key]]"
            }
          }
        }
      }
    }
  }
}
```

### Working with the Umbraco CMS - Algolia integration

In the backoffice, go to the _Settings_ section and look for the _Algolia Search Management_ dashboard.

In this view you will be able to create definitions for indices in Algolia. For each you provide a name for the index and select the document types to be indexed.  For each document type, select the fields you want to include.

After creating an index, only the content definition is saved into the _algoliaIndices_ table in Umbraco and an empty
index is created in Algolia.

The actual content payload is pushed to Algolia for indices created in Umbraco on two scenarios:
- From the list of indices, the _Build_ action is triggered, resulting in all content of specific Document Types to be sent as JSON to Algolia.
- Using a _ContentPublishedNotification_ handler which will check the list of indices for the specific Document Type, and will update a matching Algolia object.

From the dashboard you can also perform a search over one selected index, or remove it.

Two additional handlers for _ContentDeletedNotification_ and _ContentUnpublishedNotification_ will remove the matching object from Algolia.

Each Umbraco content item indexed in Algolia is referenced by the content entity's `GUID` Key field.

### Algolia record structure
An indexed Algolia record matching an Umbraco content item is contains a default set of properties. It is augmented by the list of properties defined within the Umbraco dashboard.

Properties that can vary by culture will have a record property corespondent with this naming convention: `[property]-[culture]`.

The list of default properties consists of:
- `ObjectID` - `Guid` from the content item's `Key` property
- `Name` - with culture variants if any
- `CreateDate`
- `UpdateDate`
- `Url` - with culture variants if any

### Extending the Algolia indexing
Indexing the content for Algolia is based on the `IDataEditor.PropertyIndexValueFactory` property from the CMS, the indexed value of the property being retrieved using the `GetIndexValues` method.

The [`ContentBuilder`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Search.Algolia/Builders/ContentRecordBuilder.cs) is responsible for creating the record object that will be pushed to _Algolia_ and the [`AlgoliaSearchPropertyIndexValueFactory`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Search.Algolia/Services/AlgoliaSearchPropertyIndexValueFactory.cs) implementation of `IAlgoliaSearchPropertyIndexValueFactory` will returned the property value.

Current implementation contains a custom converter for the `Umbraco.MediaPicker3` property editor.

If a different implementation is required, you will need to follow these steps:
- Inherit from `AlgoliaSearchPropertyIndexValueFactory`
- Override the `GetValue` method
- Add custom handlers to the [`Converters`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/fe5b17be519fff2c2420966febe73c8ed61c9374/src/Umbraco.Cms.Integrations.Search.Algolia/Services/AlgoliaSearchPropertyIndexValueFactory.cs#L26) dictionary
- Register your implementation in the composer

#### Example

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

#### Extension registration

```csharp
builder.Services.AddScoped<IAlgoliaSearchPropertyIndexValueFactory, ExtendedAlgoliaSearchPropertyIndexValueFactory>();
```
