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

### Umbraco CMS

| Major      | Minor/Patch |
| ---------- | ----------- |
| Version 10 | 103.1       |
| Version 11 | 11.0.0      |

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
              "AdminApiKey": "[your_admin_api_key]]"
            }
          }
        }
      }
    }
  }
}
```
{% endcode %}

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
* Using a _ContentPublishedNotification_ handler which will check the list of indices for the specific Document Type, and will update a matching Algolia object.

From the dashboard, you can also perform a search over one selected index, or remove it.

Two additional handlers for _ContentDeletedNotification_ and _ContentUnpublishedNotification_ will remove the matching object from Algolia.

Each Umbraco content item indexed in Algolia is referenced by the content entity's `GUID` Key field.

## Algolia record structure

An indexed Algolia record matching an Umbraco content item contains a default set of properties. It is augmented by the list of properties defined within the Umbraco dashboard.

Properties that can vary by culture will have a record property correspondent with this naming convention: `[property]-[culture]`.

The list of default properties consists of:

* `ObjectID` - GUID`from the content item's`Key\` property
* `Name` - with culture variants if any
* `CreateDate`
* `UpdateDate`
* `Url` - with culture variants if any

## Extending the Algolia indexing

Indexing the content for Algolia is based on the `IDataEditor.PropertyIndexValueFactory` property from Umbraco CMS, the indexed value of the property being retrieved using the `GetIndexValues` method.

The [`ContentBuilder`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Search.Algolia/Builders/ContentRecordBuilder.cs) is responsible for creating the record object that will be pushed to _Algolia_ and the [`AlgoliaSearchPropertyIndexValueFactory`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Search.Algolia/Services/AlgoliaSearchPropertyIndexValueFactory.cs) implementation of `IAlgoliaSearchPropertyIndexValueFactory` will return the property value.

The current implementation contains a custom converter for the `Umbraco.MediaPicker3` property editor.

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
