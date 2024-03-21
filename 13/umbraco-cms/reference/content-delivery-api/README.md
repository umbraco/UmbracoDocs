---
description: Get started with the Content Delivery API.
---

# Content Delivery API

The Content Delivery API delivers headless capabilities built directly into Umbraco. It allows you to retrieve your content items in a JSON format and lets you preset them in different channels, using your preferred technology stack. This feature preserves the friendly editing experience of Umbraco, while also ensuring a performant delivery of content in a headless fashion. And with its different extension points, you can tailor this API to fit a broad range of requirements.

## Getting Started

The Delivery API is an opt-in feature of Umbraco. It must be explicitly enabled through configuration before it can be utilized.

{% embed url="https://www.youtube.com/watch?v=sh_AF-ZKJ28" %}
Video tutorial
{% endembed %}

<details>

<summary>Register the Content Delivery API dependencies - <mark style="color:red;"><strong>Only for Version 12 or below</strong></mark></summary>

Umbraco projects started on version 11 or below also need to opt-in through code to use the Content Delivery API. Follow the steps below to see how to opt-in through code:

1. Open your project's `Startup.cs` file and locate the `ConfigureServices` method.
2. Register the API dependencies by adding `.AddDeliveryApi()`:

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        // Register all Delivery API dependencies
        .AddDeliveryApi()
        .AddComposers()
        .Build();
}
```

From version 13 and above, the Content Delivery API is added by default in `Program.cs`.

The next step is to enable the Content Delivery API in `appsettings.json`. Follow the next section [Enable the Content Delivery API](./#enable-the-content-delivery-api) for this.

</details>

### Enable the Content Delivery API

1. Open your project's `appsettings.json`.
2. Insert the `DeliveryApi` configuration section under `Umbraco:CMS`.
3. Add the `Enabled` key and set its value to `true`:

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "CMS": {
            "DeliveryApi": {
                "Enabled": true
            }
        }
    }
}
```
{% endcode %}

Once the Content Delivery API is enabled, you will need to manually rebuild the Delivery API content index (_DeliveryApiContentIndex_). This can be done using the "Examine Management" dashboard in the "Settings" section. Once the index is rebuilt, the API will be able to serve the latest content from the multiple-items endpoint.

### Additional configuration

When the Delivery API is enabled in your project, all your published content will be made available to the public by default. However, a few additional configuration options will allow you to restrict access to the Delivery API endpoints and limit the content that is returned.

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "CMS": {
            "DeliveryApi": {
                "Enabled": true,
                "PublicAccess": true,
                "ApiKey": "my-api-key",
                "DisallowedContentTypeAliases": ["alias1", "alias2", "alias3"],
                "RichTextOutputAsJson": false
            }
        }
    }
}
```
{% endcode %}

* `Umbraco:CMS:DeliveryApi:PublicAccess` determines whether the Delivery API (_if enabled_) should be publicly accessible or if access should require an API key.
* `Umbraco:CMS:DeliveryApi:ApiKey` specifies the API key to use for authorizing access to the API when public access is disabled. This setting is also used for accessing draft content for preview.

{% hint style="info" %}
**Are you using Umbraco Cloud?**

When hosting your Umbraco website on Umbraco Cloud, security should always be prioritized for sensitive information like API keys. Rather than storing it as plain text in the `appsettings.json` file, it is strongly encouraged to use Umbraco Cloud's built-in secrets management. This feature allows you to securely store and manage sensitive data, keeping your API key safe from potential exposure or unauthorized access. To learn more about implementing Secrets management, read the [Secrets management documentation](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/secrets-management#accepted-prefixes).
{% endhint %}

* `Umbraco:CMS:DeliveryApi:DisallowedContentTypeAliases` contains the aliases of the content types that should never be exposed through the Delivery API, regardless of any other configurations.

Another valuable configuration option to consider when working with the Delivery API is `RichTextOutputAsJson`:

* `Umbraco:CMS:DeliveryApi:RichTextOutputAsJson` enables outputting rich text content as JSON rather than the default HTML output. JSON can be a preferred format in many scenarios, not least because it supports the routing of internal links better than HTML does.

{% hint style="info" %}
To test the functionality of the API, you need to create some content first.
{% endhint %}

## Concepts

Before exploring the API endpoints detailed below, there are a few concepts to keep in mind.

<details>

<summary>Content item JSON structure</summary>

The Delivery API outputs the JSON structure outlined below to represent the retrieved content items, which consist of a range of properties:

* Basic properties for any content item include `name`, `createDate`, `updateDate`, `id` and `contentType`.
* All editorial properties from the content type can be found in the `properties` collection. Depending on the configured property editor, the property output value can be a _string_, _number_, _boolean expression_, _array_, _object_ or _`null`_.
* The `route` property provides the `path` of the content item, as well as details about the root node value that is represented by the `startItem` object. We will discuss the concept of a `startItem` in more detail in the next section.
* If the content item varies by culture, the `cultures` property will contain information about all configured cultures for the content node, including the culture variant `path` and `startItem` for each one.

```json
{
  "name": "string",
  "createDate": "2023-06-23T11:31:07.281Z",
  "updateDate": "2023-06-23T11:31:07.281Z",
  "route": {
    "path": "string",
    "startItem": {
      "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "path": "string"
    }
  },
  "id": "11fb598b-5c51-4d1a-8f2e-0c7594361d15",
  "contentType": "string",
  "properties": {
    "property1Alias": "string",
    "property2Alias": 0,
    "property3Alias": true,
    "property4Alias": [],
    "property5Alias": {},
    "property6Alias": null
  },
  "cultures": {
    "cultureIsoCode1": {
      "path": "string",
      "startItem": {
        "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "path": "string"
      }
    },
    "cultureIsoCode2": {
      "path": "string",
      "startItem": {
        "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "path": "string"
      }
    }
  }
}
```

</details>

<details>

<summary>Start item</summary>

When working headlessly in a multi-site setup, sometimes it can be difficult to determine the site context of a particular content item. This is where the _start item_ comes into play.

The start item represents the root of a content item and is commonly returned from the API in conjunction with a content path. For instance:

```json
{
  "route": {
    "path": "/articles/2023/getting-started",
    "startItem": {
      "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "path": "docs-portal"
    }
  }
}
```

This means that the content item resides under the `docs-portal` root node and can be retrieved using the path `/articles/2023/getting-started`.

The start item can also be helpful through the `Start-Item` request header when obtaining content from the Delivery API. Supplying a root node `id` or `path` as the header value, allows you to specify which is the starting point for the requested content operation:

```http
GET /umbraco/delivery/api/v2/content/item/articles/2023/getting-started
Start-Item: docs-portal
```

</details>

<details>

<summary>Property expansion and limiting</summary>

Property expansion and limiting allows you to:

* Include properties from related content or media in the API output for a given content item.
* Limit the content properties in the API output.

By default, a content property that allows picking a different content item (for example a content picker) outputs a "shallow" representation of the picked item. This means that the output only includes basic information about the picked item, without the item properties.

If we apply property expansion to the content property, the properties of the picked item are included in the output. This functionality applies to media items and block editors, as well.

Property expansion can be applied to expanded properties too, thus obtaining nested property expansion. As a consequence, the output grows in size, and this is where property limiting comes into the picture.

By default, all content properties (including expanded properties) are included in the output. Property limiting allows us to specify exactly which content properties to include in the output. This means we can tailor the output specifically to concrete use cases without over-fetching.

Property expansion and limiting can be used when querying for both single and multiple content or media items. You can expand properties by adding an `expand` parameter to the query and limit them by the `fields` query parameter.

Please refer to [this article](property-expansion-and-limiting/) for an in-depth explanation of this feature.

</details>

<details>

<summary>Preview</summary>

Similar to the preview concept in Umbraco, the Delivery API allows for requesting unpublished content through its endpoints. This can be done by setting a `Preview` header to `true` in the API request. However, accessing draft versions of your content nodes requires authorization via an API key configured in `appsettings.json` file - `Umbraco:CMS:DeliveryApi:ApiKey` setting. To obtain preview data, you must add the `Api-Key` request header containing the configured API key to the appropriate endpoints, like:

```http
GET /umbraco/delivery/api/v2/content/item/11fb598b-5c51-4d1a-8f2e-0c7594361d15
Preview: true
Api-Key: my-api-key
```

Draft content is not going to be included in the JSON response otherwise.

</details>

<details>

<summary>Localization</summary>

If your content is available in multiple languages, the Delivery API can resolve localized content. When querying content by `id`, the `Accept-Language` header can be used to request variant content.

```http
GET /umbraco/delivery/api/v2/content/item/11fb598b-5c51-4d1a-8f2e-0c7594361d15
Accept-Language: en-US
```

When querying content by path, the culture is already known and included in the path, making the `Accept-Language` header unnecessary. However, if the header is present in the request, its value will take precedence over any other configuration settings. Localization is also supported by the means of the CMS's culture and hostname configuration.

</details>

## Endpoints

The output produced by the Delivery API can either represent a specific content item or a paged list of multiple items.

{% hint style="info" %}
When referring to a specific content item in your API requests, the `id` parameter always refers to the item’s key (GUID) and not its integer node id.
{% endhint %}

## Gets a content item by id

<mark style="color:blue;">`GET`</mark> `/umbraco/delivery/api/v2/content/item/{id}`

Returns a single item.

#### Path Parameters

| Name                                 | Type   | Description              |
| ------------------------------------ | ------ | ------------------------ |
| id<mark style="color:red;">\*</mark> | String | GUID of the content item |

#### Query Parameters

| Name   | Type   | Description                                                                                              |
| ------ | ------ | -------------------------------------------------------------------------------------------------------- |
| expand | String | Which properties to expand and therefore include in the output if they refer to another piece of content |
| fields | String | Which properties to include in the response (_by default all properties are included_)                   |

#### Headers

| Name            | Type    | Description                                  |
| --------------- | ------- | -------------------------------------------- |
| Accept-Language | String  | Requested culture                            |
| Api-Key         | String  | Access token                                 |
| Preview         | Boolean | Whether draft content is requested           |
| Start-Item      | String  | URL segment or GUID of the root content item |

{% tabs %}
{% tab title="200: OK Content item" %}

{% endtab %}

{% tab title="401: Unauthorized Missing permissions after protection is set up" %}

{% endtab %}

{% tab title="404: Not Found Content item not found" %}

{% endtab %}
{% endtabs %}

## Gets a content item by route

<mark style="color:blue;">`GET`</mark> `/umbraco/delivery/api/v2/content/item/{path}`

Returns a single item.

#### Path Parameters

| Name                                   | Type   | Description              |
| -------------------------------------- | ------ | ------------------------ |
| path<mark style="color:red;">\*</mark> | String | Path of the content item |

#### Query Parameters

| Name   | Type   | Description                                                                                              |
| ------ | ------ | -------------------------------------------------------------------------------------------------------- |
| expand | String | Which properties to expand and therefore include in the output if they refer to another piece of content |
| fields | String | Which properties to include in the response (_by default all properties are included_)                   |

#### Headers

| Name            | Type    | Description                                  |
| --------------- | ------- | -------------------------------------------- |
| Accept-Language | String  | Requested culture                            |
| Api-Key         | String  | Access token                                 |
| Preview         | Boolean | Whether draft content is requested           |
| Start-Item      | String  | URL segment or GUID of the root content item |

{% tabs %}
{% tab title="200: OK Content item" %}

{% endtab %}

{% tab title="401: Unauthorized Missing permissions after protection is set up" %}

{% endtab %}

{% tab title="404: Not Found Content item not found" %}

{% endtab %}
{% endtabs %}

## Gets content item(s) by id

<mark style="color:blue;">`GET`</mark> `/umbraco/delivery/api/v2/content/items`

Returns single or multiple items by id.

#### Query Parameters

| Name                                 | Type         | Description                                                                            |
| ------------------------------------ | ------------ | -------------------------------------------------------------------------------------- |
| id<mark style="color:red;">\*</mark> | String Array | GUIDs of the content items                                                             |
| expand                               | String       | Which properties to expand in the response                                             |
| fields                               | String       | Which properties to include in the response (_by default all properties are included_) |

#### Headers

| Name            | Type    | Description                                  |
| --------------- | ------- | -------------------------------------------- |
| Accept-Language | String  | Requested culture                            |
| Api-Key         | String  | Access token                                 |
| Preview         | Boolean | Whether draft content is requested           |
| Start-Item      | String  | URL segment or GUID of the root content item |

{% tabs %}
{% tab title="200: OK List of content items" %}

{% endtab %}

{% tab title="401: Unauthorized Missing permissions after protection is set up" %}

{% endtab %}
{% endtabs %}

## Gets content item(s) from a query

<mark style="color:blue;">`GET`</mark> `/umbraco/delivery/api/v2/content`

Returns single or multiple items.

#### Query Parameters

| Name   | Type         | Description                                                                                              |
| ------ | ------------ | -------------------------------------------------------------------------------------------------------- |
| fetch  | String       | Structural query string option (e.g. `ancestors`, `children`, `descendants`)                             |
| filter | String Array | Filtering query string options (e.g. `contentType`, `name`, `createDate`, `updateDate`)                  |
| sort   | String Array | Sorting query string options (e.g. `createDate`, `level`, `name`, `sortOrder`, `updateDate`)             |
| skip   | Integer      | Amount of items to skip                                                                                  |
| take   | Integer      | Amount of items to take                                                                                  |
| expand | String       | Which properties to expand and therefore include in the output if they refer to another piece of content |
| fields | String       | Which properties to include in the response (_by default all properties are included_)                   |

#### Headers

| Name            | Type    | Description                                  |
| --------------- | ------- | -------------------------------------------- |
| Accept-Language | String  | Requested culture                            |
| Api-Key         | String  | Access token                                 |
| Preview         | Boolean | Whether draft content is requested           |
| Start-Item      | String  | URL segment or GUID of the root content item |

{% tabs %}
{% tab title="200: OK Paginated list of content items" %}

{% endtab %}

{% tab title="400: Bad Request Invalid request" %}

{% endtab %}

{% tab title="404: Not Found Start-Item not found" %}

{% endtab %}
{% endtabs %}

All endpoints are documented in a Swagger document at `{yourdomain}/umbraco/swagger`. Keep in mind that this document is not available in production mode by default. For more information check the [API versioning and OpenAPI](https://docs.umbraco.com/umbraco-cms/reference/api-versioning-and-openapi) article.

### Query parameters

The Content Delivery API provides a number of query parameters that allow you to customize the content returned by the API to fit your needs. For each endpoint, the relevant query parameters are already specified within their corresponding documentation above. In addition to standard parameters like `skip` and `take`, the API provides different possibilities for the value of `expand`, `fields`, `fetch`, `filter` and `sort` parameters. Below are the options supported out of the box.

{% hint style="info" %}
You can extend the built-in selector, filter, and sorting capabilities of the Delivery API by creating your own custom query handlers.
{% endhint %}

{% tabs %}
{% tab title="expand" %}
{% hint style="info" %}
Refer to the [Property expansion and limiting](./#property-expansion-and-limiting) concept for more information about this parameter.
{% endhint %}

**`?expand=properties[$all]`**\
All expandable properties on the retrieved content item will be expanded.

**`?expand=properties[alias1]`**\
A specific expandable property with the property alias _`alias1`_ will be expanded.

**`?expand=properties[alias1,alias2,alias3]`**\
Multiple expandable properties with the specified property aliases will be expanded.

**`?expand=properties[alias1[properties[nestedAlias1,nestedAlias2]]]`**\
The property with the property alias _`alias1`_ will be expanded, and likewise the properties _`nestedAlias1`_ and _`nestedAlias2`_ of the expanded _`alias1`_ property.
{% endtab %}

{% tab title="fields" %}
{% hint style="info" %}
Refer to the [Property expansion and limiting](./#property-expansion-and-limiting) concept for more information about this parameter.
{% endhint %}

**`?fields=properties[$all]`**\
Includes all properties of the retrieved content item in the output.

**`?fields=properties[alias1]`**\
Includes only the property with the property alias _`alias1`_ in the output.

**`?fields=properties[alias1,alias2,alias3]`**\
Includes only the properties with the specified property aliases in the output.

**`?fields=properties[alias1[properties[nestedAlias1,nestedAlias2]]]`**\
Includes only the property with the property alias _`alias1`_ in the output. If this property is expanded, only the properties _`nestedAlias1`_ and _`nestedAlias2`_ of the expanded _`alias1`_ property are included in the output.
{% endtab %}

{% tab title="fetch" %}
To query content items based on their structure, you can apply a selector option to the `/umbraco/delivery/api/v2/content` endpoint. The selector allows you to fetch different subsets of items based on a GUID or path of a specific content item. If no `fetch` parameter is provided, the Delivery API will search across all available content items. The following built-in selectors can be used out-of-the-box:

**`?fetch=ancestors:id/path`**\
All ancestors of a content item specified by either its _`id`_ or _`path`_ will be retrieved.

**`?fetch=children:id/path`**\
All immediate children of a content item specified by either its _`id`_ or _`path`_ will be retrieved.

**`?fetch=descendants:id/path`**\
All descendants of a content item specified by either its _`id`_ or _`path`_ will be retrieved.

{% hint style="info" %}
Only one selector option can be applied to a query at a time. This means that you can't combine multiple fetch parameters in a single query.
{% endhint %}

For example, the following API call will attempt to retrieve all the content items that are directly below an item with the id `dc1f43da-49c6-4d87-b104-a5864eca8152`:

**Request**

```http
GET /umbraco/delivery/api/v2/content?fetch=children:dc1f43da-49c6-4d87-b104-a5864eca8152
```
{% endtab %}

{% tab title="filter" %}
The `filter` query parameter allows you to specify one or more filters that must match in order for a content item to be included in the response. The API provides a few built-in filters that you can use right away with the `/umbraco/delivery/api/v2/content` endpoint:

**`?filter=contentType:alias`**\
This filter restricts the results to only include content items that belong to the specified content type. Replace _`alias`_ with the alias of the content type you want to filter by.

**`?filter=name:nodeName`**\
When this filter is applied, only content items whose name matches the specified value will be returned. Replace _`nodeName`_ with the name of the item that you want to filter by.

{% hint style="info" %}
The `contentType` and `name` filters support negation. By using an exclamation mark (`!`) before the filter value, you can exclude content items from the result set that match the filter criteria.

For example, you can fetch all content items that are _not_ of type `article` like this: `?filter=contentType:!article`.
{% endhint %}

**`?filter=createDate>date`**\
When this filter is applied, only content items that were created later than the specified value will be returned. Replace _`date`_ with the date that you want to filter by.

**`?filter=updateDate>date`**\
When this filter is applied, only content items that were updated later than the specified value will be returned. Replace _`date`_ with the date that you want to filter by.

{% hint style="info" %}
The `createDate` and `updateDate` filters support both "greater than", "greater than or equal", "less than" and "less than or equal":

* Use `>` for "greater than" filtering.
* Use `>:` for "greater than or equal" filtering.
* Use `<` for "less than" filtering.
* Use `<:` for "less than or equal" filtering.
{% endhint %}

Multiple filters can be applied to the same request in addition to other query parameters:

**Request**

```http
GET /umbraco/delivery/api/v2/content?filter=contentType:article&filter=name:guide&skip=0&take=10
```

This technique can also be used to perform range filtering. For example, fetch articles created in 2023:

**Request**

```http
GET /umbraco/delivery/api/v2/content?filter=contentType:article&filter=createDate>:2023-01-01&filter=createDate<2024-01-01&skip=0&take=10
```
{% endtab %}

{% tab title="sort" %}
Specifying how the results should be ordered, can be achieved using the `sort` query option. You can use this parameter to sort the content items by different fields, including create date, level, name, sort order, and update date. For each field, you can specify whether the items should be sorted in ascending (_asc_) or descending (_desc_) order. Without a `sort` query parameter, the order of the results will be determined by the relevance score of the _DeliveryApiContentIndex_ for the given search term.

**`?sort=createDate:asc/desc`**\
An option to sort the results based on the creation date of the content item in either _`asc`_ or _`desc`_ order.

**`?sort=level:asc/desc`**\
An option to sort the results based on the level of the content item in the content tree in either _`asc`_ or _`desc`_ order.

**`?sort=name:asc/desc`**\
An option to sort the results based on the name of the content item in either _`asc`_ or _`desc`_ order.

**`?sort=sortOrder:asc/desc`**\
An option to sort the results based on the sort order of the content item in either _`asc`_ or _`desc`_ order.

**`?sort=updateDate:asc/desc`**\
An option to sort the results based on the last update date of the content item in either _`asc`_ or _`desc`_ order.

Different sorting options can be combined for the `/umbraco/delivery/api/v2/content` endpoint, allowing for more advanced sorting functionality. Here is an example:

**Request**

```http
GET /umbraco/delivery/api/v2/content?sort=name:asc&sort=createDate:asc
```
{% endtab %}
{% endtabs %}

## Extension points

The Delivery API has been designed with extensibility in mind, offering multiple extension points that provide greater flexibility and customization options. These extension points allow you to tailor the API's behaviour and expand its capabilities to meet your specific requirements.

You'll find detailed information about the specific areas of extension in the articles below:

* [Tailor the API's response for custom property editors](custom-property-editors-support.md)
* [Extend the API with custom selecting, filtering, and sorting options](extension-api-for-querying.md)

## Handling deeply nested JSON output

.NET imposes a limit on the depth of object nesting within rendered JSON. This is done in an effort to detect cyclic references. Learn more about it in [the official .NET API docs](https://learn.microsoft.com/en-us/dotnet/api/system.text.json.jsonserializeroptions.maxdepth).

If the limit is exceeded, .NET will throw a `JsonException`.

In some cases the content models might be so deeply nested that the Delivery API produces JSON that exceeds this limit. If this happens, the `JsonException` will be logged and shown in the [Umbraco log viewer](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/logviewer/).

To handle this we have to change the limit. Since the Delivery API has its own JSON configuration, we can do so without affecting the rest of our site.

First, we have to add these `using` statements to `Program.cs`:

{% code title="Program.cs" %}
```csharp
using Umbraco.Cms.Api.Common.DependencyInjection;
using Umbraco.Cms.Core;
```
{% endcode %}

Now we can add the following code snippet to the `Program.cs` file:

{% code title="Program.cs" %}
```csharp
builder.Services.AddControllers().AddJsonOptions(
    Constants.JsonOptionsNames.DeliveryApi,
    options =>
    {
        // set the maximum allowed depth of
        options.JsonSerializerOptions.MaxDepth = {desired max depth}
    });
```
{% endcode %}

## Current Limitations

The Content Delivery API provides a powerful and flexible way to retrieve content from the Umbraco CMS. There are, however, certain limitations to be aware of.

In this section, we will discuss some of the known limitations of the API, and how to work around them if necessary.

### Protected content

The Delivery API supports protected content and member authentication. This is however an opt-in feature. You can read more about it in the [Protected Content in the Delivery API](protected-content-in-the-delivery-api.md) article.

If member authentication is _not_ explicitly enabled, protected content is ignored and never exposed by the Delivery API.

As a result, lifting protection from a content item requires an additional step to ensure it becomes accessible through the Delivery API. The recommended way is to publish the content item again. Alternatively, you can manually rebuild the _DeliveryApiContentIndex_ to reflect the changes.

### Property editors

There are certain limitations associated with some of the built-in property editors in Umbraco. Let's go through these below:

#### Grid Layout (legacy)

The Legacy Grid in Umbraco is supported to a certain extent. However, keep in mind that it may not be suitable for headless content scenarios. Instead, we recommend using the Block Grid property editor.

#### Rich Text Editor

The Delivery API is not going to support the rendering of Macros within the Rich Text Editor. Therefore, any Macros included in the content will not be executed or output when retrieving content through the API.

When outputting the Rich Text Editor content as HTML (_the default format_), be aware that internal links may be insufficient in a multi-site setup. There is a possibility that this limitation may be addressed in future updates. However, consider the alternative approach to rendering the Rich Text Editor content as JSON.

#### Member Picker

The Member Picker property editor is not supported in the Delivery API to avoid the risk of leaking member data.

#### Multinode Treepicker

The Multinode Treepicker property editor, when configured for members, is also unsupported in the Delivery API. This is due to the same concern of potentially leaking member data.

### Making changes to `DisallowedContentTypeAliases`

When changing the content type aliases in the `Umbraco:CMS:DeliveryApi:DisallowedContentTypeAliases` configuration setting, the _DeliveryApiContentIndex_ should be rebuilt. This ensures that the disallowed content types are not exposed through the Delivery API.

Alternatively the relevant content items can be republished. This will ensure that the changes are reflected, eliminating the need to rebuild the index.
