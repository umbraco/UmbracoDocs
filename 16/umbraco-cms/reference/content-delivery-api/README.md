---
description: Get started with the Content Delivery API.
---

# Content Delivery API

The Content Delivery API delivers headless capabilities built directly into Umbraco. It allows you to retrieve your content items in a JSON format and use your preferred technology to present them in different channels.

The feature preserves a friendly editing experience in Umbraco while ensuring a performant delivery of content in a headless fashion. With the different extension points, you can tailor the API to fit a broad range of requirements.

## Getting Started

The Delivery API is an opt-in feature in Umbraco. It must be explicitly enabled through configuration before it can be utilized.

### Enable the Content Delivery API

When creating your project, you can enable the Delivery API using the `--use-delivery-api` or `-da` flag. This will automatically add the necessary configuration to your project.

```bash
dotnet new umbraco -n MyProject -da
```

You can also enable the Delivery API at a later point by following these steps:

1. Open your project's `appsettings.json`.
2. Insert the `DeliveryApi` configuration section under `Umbraco:CMS`.
3. Add the `Enabled` key and set its value to `true`.
4. Open `Program.Cs`
5. Add `.AddDeliveryApi()` to `builder.CreateUmbracoBuilder()`

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

{% code title="Program.cs" %}
```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

```
{% endcode %}

Once the Content Delivery API is enabled, the next step is to rebuild the Delivery API content index (_DeliveryApiContentIndex_). This can be done using the **Examine Management** dashboard in the **Settings** section of the Umbraco Backoffice.

1. Access the Umbraco Backoffice.
2. Navigate to the **Settings** section.
3. Open the **Examine Management** dashboard.
4. Click the **DeliveryAPIContentIndex**.

<figure><img src="../../../../17/umbraco-cms/.gitbook/assets/DeliveryAPIContentIndex (1).png" alt=""><figcaption><p>Click the DeliveryAPIContentIndex on the Examine Management dashboard in the Settings section.</p></figcaption></figure>

5. Scroll down and click the **Rebuild index** button.

<figure><img src="../../../../17/umbraco-cms/.gitbook/assets/DeliveryAPIContentIndexRebuild (1).png" alt=""><figcaption><p>Use the "Rebuild index" button in the DeliveryAPIContentIndex under Tools on the Examine Management dashboard in the Settings section.</p></figcaption></figure>

Once the index is rebuilt, the API can serve the latest content from the multiple-items endpoint.

### Additional configuration

When the Delivery API is enabled in your project, all your published content will be made available to the public by default.

A few additional configuration options will allow you to restrict access to the Delivery API endpoints and limit the content returned.

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

Find a description of each of the configuration keys in the table below.

<table><thead><tr><th width="340">Configuration key</th><th>Description</th></tr></thead><tbody><tr><td><code>PublicAccess</code></td><td>Determines whether the enabled Delivery API should be publicly accessible or if access should require an API key.</td></tr><tr><td><code>ApiKey</code></td><td>Specifies the API key needed to authorize access to the API when public access is disabled. This setting is also used to access draft content for preview.</td></tr><tr><td><code>DisallowedContentTypeAliases</code></td><td>Contains the aliases of the content types that should never be exposed through the Delivery API, regardless of any other configurations.</td></tr><tr><td><code>RichTextOutputAsJson</code></td><td>Enable outputting rich text content as JSON rather than the default HTML output. JSON can be a preferred format in many scenarios, not least because it supports the routing of internal links better than HTML does.</td></tr></tbody></table>

{% hint style="info" %}
**Are you using Umbraco Cloud?**

When hosting your Umbraco website on Umbraco Cloud, security should always be prioritized for sensitive information like API keys. Rather than storing it as plain text in the `appsettings.json` file use the Umbraco Cloud's built-in secrets management. This feature lets you store and manage sensitive data, keeping your API key safe from potential exposure or unauthorized access. To learn more about implementing secrets management, read the [Secrets management documentation](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/secrets-management#accepted-prefixes).
{% endhint %}

{% hint style="info" %}
To test the functionality of the API, you need to create some content first.
{% endhint %}

## Concepts

Before exploring the API endpoints detailed below, there are a few concepts to know.

<details>

<summary>Content item JSON structure</summary>

The Delivery API outputs the JSON structure outlined below to represent the retrieved content items, which consist of a range of properties:

* Basic properties for any content item include `name`, `createDate`, `updateDate`, `id` and `contentType`.
* All editorial properties from the content type can be found in the `properties` collection. Depending on the configured property editor, the property output value can be one of the following:
  * String: `"This is a string"`
  * Number: `1234`
  * Boolean expression: `true`
  * Array: `["hello", "world"]`
  * Object: `{myObject}`
  * Empty: _`null`_
* The `route` property provides the `path` to the content item and details about the root node value represented by the `startItem` object. We will discuss the concept of a [`startItem`](./#start-item) in more detail in the next section.
* If the content item varies by culture, the `cultures` property will contain information about all configured cultures for the content node. This includes the culture-variant `path` and `startItem` for each culture.

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

When working headlessly in a multi-site setup, it can be difficult to determine the site context of a particular content item. This is where the **start item** comes into play.

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

The start item can also be helpful through the `Start-Item` request header when obtaining content from the Delivery API. Supplying a root node `id` or `path` as the header value, allows you to specify the starting point for the requested content operation:

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

By default, a content property that allows picking a different content item (for example a content picker) outputs a "shallow" representation of the picked item. This means that the output only includes basic information about the picked item, excluding the item properties.

When property expansion is applied to the content property, the properties of the picked item are included in the output. This functionality applies to media items and block editors, as well.

Property expansion can also be applied to expanded properties, thus obtaining nested property expansion. As a result, the output grows in size, and this is where property limiting comes into the picture.

All content properties (including expanded properties) are part of the output by default. Property limiting allows for limiting which content properties are included. This means we can tailor the output to concrete use cases without over-fetching.

Property expansion and limiting can be used when querying for single and multiple content or media items. You can expand properties by adding an `expand` parameter to the query and limit them using the `fields` query parameter.

Refer to the [Property Expansion and Limiting](property-expansion-and-limiting.md) article for an in-depth explanation of this feature.

</details>

<details>

<summary>Preview</summary>

Similar to the preview concept in Umbraco, the Delivery API allows for requesting unpublished content through its endpoints.

This is done by setting a `Preview` header to `true` in the API request.

Accessing unpublished versions of your content nodes requires authorization via an API key configured in `appsettings.json` file using the `Umbraco:CMS:DeliveryApi:ApiKey` configuration key. To obtain preview data, you must add the `Api-Key` request header containing the configured API key to the appropriate endpoints.

```http
GET /umbraco/delivery/api/v2/content/item/11fb598b-5c51-4d1a-8f2e-0c7594361d15
Preview: true
Api-Key: my-api-key
```

If the API key is not applied using the `Api-Key` request header, the unpublished content will not be included in the JSON response.

</details>

<details>

<summary>Localization</summary>

When your content is available in multiple languages, the Delivery API can resolve localized content. When querying content by `id`, the `Accept-Language` header can be used to request variant content.

```http
GET /umbraco/delivery/api/v2/content/item/11fb598b-5c51-4d1a-8f2e-0c7594361d15
Accept-Language: en-US
```

When querying content by path, the culture is already known and included in the path, making the `Accept-Language` header unnecessary. However, if this header is present in the request, the value of it will take precedence over any other configuration settings. Localization is also supported through the CMS's culture and hostname configuration.

</details>

## Endpoints

The Delivery API output can represent a specific content item or a paged list of multiple items.

{% hint style="info" %}
When referring to a specific content item in your API requests, the `id` parameter always refers to the item’s key (GUID).
{% endhint %}

### Gets a content item by id

<mark style="color:blue;">`GET`</mark> `/umbraco/delivery/api/v2/content/item/{id}`

Returns a single item.

#### Path Parameters

| Name                                 | Type   | Description               |
| ------------------------------------ | ------ | ------------------------- |
| id<mark style="color:red;">\*</mark> | String | GUID of the content item. |

#### Query Parameters

| Name   | Type   | Description                                                                                               |
| ------ | ------ | --------------------------------------------------------------------------------------------------------- |
| expand | String | Which properties to expand and therefore include in the output if they refer to another piece of content. |
| fields | String | Which properties to include in the response. All properties are included by default.                      |

#### Headers

| Name            | Type    | Description                                   |
| --------------- | ------- | --------------------------------------------- |
| Accept-Language | String  | Requested culture.                            |
| Api-Key         | String  | Access token.                                 |
| Preview         | Boolean | Whether draft content is requested.           |
| Start-Item      | String  | URL segment or GUID of the root content item. |

| Response Status       | Description                                     |
| --------------------- | ----------------------------------------------- |
| **200**: OK           | Content item.                                   |
| **401**: Unauthorized | Missing permissions after protection is set up. |
| **404**: Not Found    | Content item not found.                         |

## Gets a content item by route

<mark style="color:blue;">`GET`</mark> `/umbraco/delivery/api/v2/content/item/{path}`

Returns a single item.

#### Path Parameters

| Name                                   | Type   | Description               |
| -------------------------------------- | ------ | ------------------------- |
| path<mark style="color:red;">\*</mark> | String | Path of the content item. |

#### Query Parameters

| Name   | Type   | Description                                                                                               |
| ------ | ------ | --------------------------------------------------------------------------------------------------------- |
| expand | String | Which properties to expand and therefore include in the output if they refer to another piece of content. |
| fields | String | Which properties to include in the response. All properties are included by default.                      |

#### Headers

| Name            | Type    | Description                                   |
| --------------- | ------- | --------------------------------------------- |
| Accept-Language | String  | Requested culture.                            |
| Api-Key         | String  | Access token.                                 |
| Preview         | Boolean | Whether draft content is requested.           |
| Start-Item      | String  | URL segment or GUID of the root content item. |

| Response Status       | Description                                     |
| --------------------- | ----------------------------------------------- |
| **200**: OK           | Content item.                                   |
| **401**: Unauthorized | Missing permissions after protection is set up. |
| **404**: Not Found    | Content item not found.                         |

## Gets content item(s) by id

<mark style="color:blue;">`GET`</mark> `/umbraco/delivery/api/v2/content/items`

Returns single or multiple items by id.

#### Query Parameters

| Name                                 | Type         | Description                                                                          |
| ------------------------------------ | ------------ | ------------------------------------------------------------------------------------ |
| id<mark style="color:red;">\*</mark> | String Array | GUIDs of the content items.                                                          |
| expand                               | String       | Which properties to expand in the response.                                          |
| fields                               | String       | Which properties to include in the response. All properties are included by default. |

#### Headers

| Name            | Type    | Description                                   |
| --------------- | ------- | --------------------------------------------- |
| Accept-Language | String  | Requested culture.                            |
| Api-Key         | String  | Access token.                                 |
| Preview         | Boolean | Whether draft content is requested.           |
| Start-Item      | String  | URL segment or GUID of the root content item. |

| Response Status       | Description                                     |
| --------------------- | ----------------------------------------------- |
| **200**: OK           | Content item.                                   |
| **401**: Unauthorized | Missing permissions after protection is set up. |

## Gets content item(s) from a query

<mark style="color:blue;">`GET`</mark> `/umbraco/delivery/api/v2/content`

Returns single or multiple items.

#### Query Parameters

| Name   | Type         | Description                                                                                               |
| ------ | ------------ | --------------------------------------------------------------------------------------------------------- |
| fetch  | String       | Structural query string option (e.g. `ancestors`, `children`, `descendants`).                             |
| filter | String Array | Filtering query string options (e.g. `contentType`, `name`, `createDate`, `updateDate`).                  |
| sort   | String Array | Sorting query string options (e.g. `createDate`, `level`, `name`, `sortOrder`, `updateDate`).             |
| skip   | Integer      | Amount of items to skip.                                                                                  |
| take   | Integer      | Amount of items to take.                                                                                  |
| expand | String       | Which properties to expand and therefore include in the output if they refer to another piece of content. |
| fields | String       | Which properties to include in the response. All properties are included by default.                      |

#### Headers

| Name            | Type    | Description                                   |
| --------------- | ------- | --------------------------------------------- |
| Accept-Language | String  | Requested culture.                            |
| Api-Key         | String  | Access token.                                 |
| Preview         | Boolean | Whether draft content is requested.           |
| Start-Item      | String  | URL segment or GUID of the root content item. |

| Response Status       | Description                                     |
| --------------------- | ----------------------------------------------- |
| **200**: OK           | Content item.                                   |
| **401**: Unauthorized | Missing permissions after protection is set up. |
| **404**: Not Found    | Content item not found.                         |

All endpoints are documented in a Swagger document at `{yourdomain}/umbraco/swagger`. This document is not available in production mode by default. For more information read the [API versioning and OpenAPI](https://docs.umbraco.com/umbraco-cms/reference/api-versioning-and-openapi) article.

### Query parameters

The Content Delivery API provides query parameters that allow you to customize the content returned by the API. The relevant query parameters for each endpoint are already specified in the corresponding documentation above.

In addition to standard parameters like `skip` and `take`, the API provides different possibilities for the value of the `expand`, `fields`, `fetch`, `filter` and `sort` parameters. Below are the options that are supported out of the box.

{% hint style="info" %}
You can extend the built-in selector, filter, and sorting capabilities of the Delivery API by creating custom query handlers.
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
Includes only the property with the property alias _`alias1`_ in the output. If this property is expanded, only the properties _`nestedAlias1`_ and _`nestedAlias2`_ of the expanded _`alias1`_ property are included.
{% endtab %}

{% tab title="fetch" %}
You can apply a selector option to the `/umbraco/delivery/api/v2/content` endpoint to query content items based on their structure. The selector allows you to fetch different subsets of items based on a GUID or path of a specific content item. The Delivery API will search all available content items if no `fetch` parameter is provided. The following built-in selectors can be used out of the box:

**`?fetch=ancestors:id/path`**\
All ancestors of a content item specified by either its _`id`_ or _`path`_ will be retrieved.

**`?fetch=children:id/path`**\
All immediate children of a content item specified by either its _`id`_ or _`path`_ will be retrieved.

**`?fetch=descendants:id/path`**\
All descendants of a content item specified by either its _`id`_ or _`path`_ will be retrieved.

{% hint style="info" %}
Only one selector option can be applied to a query at a time. You cannot combine multiple fetch parameters in a single query.
{% endhint %}

For example, the following API call will attempt to retrieve all the content items that are directly below an item with the id `dc1f43da-49c6-4d87-b104-a5864eca8152`:

**Request**

```http
GET /umbraco/delivery/api/v2/content?fetch=children:dc1f43da-49c6-4d87-b104-a5864eca8152
```
{% endtab %}

{% tab title="filter" %}
The filter query parameter allows you to specify one or more filters. These filters must match for a content item to be included in the response. The API provides a few built-in filters that you can use right away with the `/umbraco/delivery/api/v2/content` endpoint:

**`?filter=contentType:alias`**\
This filter restricts the results to content items that belong to the specified content type. Replace _`alias`_ with the alias of the content type you want to filter by.

**`?filter=name:nodeName`**\
Only content items whose name matches the specified value will be returned when this filter is applied. Replace _`nodeName`_ with the name of the item that you want to filter by.

{% hint style="info" %}
The `contentType` and `name` filters support negation. You can exclude content items from the result set that match the filter criteria using an exclamation mark before the filter value.

For example, you can fetch all content items that are _not_ of type `article` like this: `?filter=contentType:!article`.
{% endhint %}

**`?filter=createDate>date`**\
Only content items created later than the specified value will be returned when this filter is applied. Replace _`date`_ with the date that you want to filter by.

**`?filter=updateDate>date`**\
Only content items updated later than the specified value will be returned when this filter is applied. Replace _`date`_ with the date that you want to filter by.

{% hint style="info" %}
The `createDate` and `updateDate` filters support both "greater than", "greater than or equal", "less than" and "less than or equal":

* Use > for "greater than" filtering.
* Use >: for "greater than or equal" filtering.
* Use < for "less than" filtering.
* Use <: for "less than or equal" filtering.
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
Specifying how the results should be ordered, can be achieved using the `sort` query option. You can use this parameter to sort the content items by fields, including `create date`, `level`, `name`, `sort order`, and `update date`. For each field, you can specify whether the items should be sorted in ascending (_asc_) or descending (_desc_) order. Without a `sort` query parameter, the order of the results will be determined by the relevance score of the _DeliveryApiContentIndex_ for the search term.

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

The Delivery API has been designed for extensibility, offering multiple extension points that provide greater flexibility and customization options. These extension points allow you to tailor the API's behavior and expand its capabilities to meet your specific requirements.

You can find detailed information about the specific areas of extension in the articles below:

* [Tailor the API's response for custom property editors](custom-property-editors-support.md)
* [Extend the API with custom selecting, filtering, and sorting options](extension-api-for-querying.md)

## Handling deeply nested JSON output

.NET imposes a limit on the depth of object nesting within rendered JSON. This is done to detect cyclic references. Learn more about it in [the official .NET API docs](https://learn.microsoft.com/en-us/dotnet/api/system.text.json.jsonserializeroptions.maxdepth).

If the limit is exceeded, .NET will throw a `JsonException`.

The content models might be so deeply nested that the Delivery API produces JSON that exceeds this limit. If this happens, the `JsonException` will be logged and shown in the [Umbraco log viewer](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/logviewer/).

To handle this we have to change the limit. Since the Delivery API has its own JSON configuration, we can do so without affecting the rest of our site.

1. Add the following `using` statements to `Program.cs`:

{% code title="Program.cs" %}
```csharp
using Umbraco.Cms.Api.Common.DependencyInjection;
using Umbraco.Cms.Core;
```
{% endcode %}

2. Add the following code snippet to the `Program.cs` file:

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

The Delivery API supports protected content and member authentication. This is an opt-in feature. You can read more about it in the [Protected Content in the Delivery API](protected-content-in-the-delivery-api/) article.

If member authentication is _not_ explicitly enabled, protected content is ignored and never exposed by the Delivery API.

As a result, lifting protection from a content item requires an additional step to ensure it becomes accessible through the Delivery API. The recommended way is to publish the content item again. Alternatively, you can manually rebuild the `DeliveryApiContentIndex` to reflect the changes.

### Property editors

Certain limitations are associated with some of the built-in property editors in Umbraco. These limitations are listed below.

#### Rich Text Editor

Internal links may be insufficient in a multi-site setup when outputting the Rich Text Editor content as HTML (_the default format_). There is a possibility that this limitation may be addressed in future updates. However, consider the alternative approach to rendering the Rich Text Editor content as JSON.

#### Member Picker

The Member Picker property editor is not supported in the Delivery API to avoid the risk of leaking member data.

#### Content Picker

The Content Picker property editor is not supported in the Delivery API when configured for Members. This is due to the concern of potentially leaking member data.

### Making changes to `DisallowedContentTypeAliases`

When changing the content type aliases in the `Umbraco:CMS:DeliveryApi:DisallowedContentTypeAliases` configuration setting, `DeliveryApiContentIndex` should be rebuilt. This ensures that disallowed content types are not exposed through the Delivery API.

Alternatively, the relevant content items can be republished. This will ensure that changes are reflected, eliminating the need to rebuild the index.
