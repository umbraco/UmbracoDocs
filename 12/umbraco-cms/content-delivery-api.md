---
description: Get started with the Content Delivery API.
---

# Content Delivery API

The Content Delivery API delivers headless capabilities built directly into Umbraco. It allows you to retrieve your content items in a JSON format and lets you preset them in different channels, using your preferred technology stack. This feature preserves the friendly editing experience of Umbraco, while also ensuring a performant delivery of content in a headless fashion. And with its different extension points, you can tailor this API to fit a broad range of requirements.

## Getting Started

When upgrading an existing project to Umbraco 12, you will need to opt-in explicitly for using the Delivery API. Below you will find the steps you need to take in order to configure it for your Umbraco project.

When you start with a fresh Umbraco 12 installation, the Delivery API will also be disabled by default. To enable it, you can proceed directly to the [Enable the Content Delivery API](content-delivery-api.md#enable-the-content-delivery-api) section, as the step below is already complete in this case.

### Register the Content Delivery API dependencies

1. Open your project's `Startup.cs` file.
2. Register the API dependencies in the `ConfigureServices` method by adding `.AddDeliveryApi()`:

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

Once the Content Delivery API is enabled, you will need to manually build the Delivery API content index (**DeliveryApiContentIndex**). It can be found in the "Examine Management" dashboard under the "Settings" section. This ensures that the data in the index is up-to-date and that the API is able to serve the latest content items.

### Additional configuration

Once the Delivery API has been configured on your project, all your published content will be made available to the public by default. However, a few additional configuration options will allow you to restrict access to the Delivery API endpoints and limit the content that is returned.

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

* Basic properties for any content item include `name`, `id` and `contentType`.
* All editorial properties from the content type can be found in the `properties` collection. Depending on the configured property editor, the property output value can be a _string_, _number_, _boolean expression_, _array_, _object_ or _`null`_.
* The `route` property provides the `path` of the content item, as well as details about the root node value that is represented by the `startItem` object. We will discuss the concept of a `startItem` in more detail in the next section.
* If the content item varies by culture, the `cultures` property will contain information about all configured cultures for the content node, including the culture variant `path` and `startItem` for each one.

```json
{
  "name": "string",
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
GET /umbraco/delivery/api/v1/content/item/articles/2023/getting-started
Start-Item: docs-portal
```

</details>

<details>

<summary>Output expansion</summary>

**Output expansion** allows you to retrieve additional data about related content or media in the API output for a given content item.

By default, a content property that allows picking a different content item (like a content picker property) outputs a shallow representation of the item. That means, only the basic information about the picked item, without the item properties. However, with output expansion, it is possible to include the properties of the picked item in the API output. Similar shallow representation applies to media items, as well.

This feature can be used when querying for both single and multiple content items, by adding a `expand` parameter to the query. The value of this parameter can be either `"all"` to expand all properties of the requested content item or `"property:alias, alias, alias"` to expand specific ones.

The following JSON snippet demonstrates the default output of a content item (without expanding any properties).

**Request**

```http
GET /umbraco/delivery/api/v1/content/item/9bdac0e9-66d8-4bfd-bba1-e954ed9c780d
```

**Response**

{% code title="Shallow output for " %}
```json
{
    "name": "My post",
    "route": {...
    },
    "id": "9bdac0e9-66d8-4bfd-bba1-e954ed9c780d",
    "contentType": "blogpost1",
    "properties": {
        "title": "My post page",
        "blogPostNumber": 11,
        "bodyContent": "Congue, sollicitudin? Est fames maiores, sociis suspendisse et aliquet tristique excepturi, aliquam, nihil illum pretium penatibus exercitationem lacinia! Dolorem tempus convallis, nulla! Eius scelerisque voluptatum penatibus, dignissimos molestiae, soluta eum. Voluptatibus quod? Temporibus potenti voluptates dictumst? Cillum metus, nec asperiores? Impedit sit! Eum tellus cillum facilisis ullamco tempor? Sint nostrum luctus? Neque dictumst diam, minus? Itaque, minus, etiam dignissimos debitis occaecat aptent tempus! Praesent molestiae duis nihil recusandae, eius imperdiet aspernatur natus. Tempus mattis at architecto, augue, consequuntur ultricies eligendi, litora morbi ante nesciunt pretium laoreet quidem recusandae voluptates dapibus, iure sagittis donec ipsum mollit? Blanditiis! Laborum sit assumenda beatae.",
        "linkedItem": {
            "name": "Demo blog",
            "route": {
                "path": "/demo-blog/",
                "startItem": {
                    "id": "5d5ae914-9885-4ee0-a14b-0ab57f501a55",
                    "path": "demo-blog"
                }
            },
            "id": "5d5ae914-9885-4ee0-a14b-0ab57f501a55",
            "contentType": "blog",
            "properties": {}
        }
    },
    "cultures": {}
}
```
{% endcode %}

Below is an example of how an expanded representation might look for the `linkedItem` property that references another content item with properties `title` and `description`:

**Request**

```http
GET /umbraco/delivery/api/v1/content/item/9bdac0e9-66d8-4bfd-bba1-e954ed9c780d?expand=property:linkedItem
```

**Response**

{% code title="Expanded output for " %}
```json
{
    "name": "My post",
    "route": {
        "path": "/my-post/",
        "startItem": {
            "id": "5d5ae914-9885-4ee0-a14b-0ab57f501a55",
            "path": "demo-blog"
        }
    },
    "id": "9bdac0e9-66d8-4bfd-bba1-e954ed9c780d",
    "contentType": "blogpost1",
    "properties": {
        "title": "My post page",
        "blogPostNumber": 11,
        "bodyContent": "Congue, sollicitudin? Est fames maiores, sociis suspendisse et aliquet tristique excepturi, aliquam, nihil illum pretium penatibus exercitationem lacinia! Dolorem tempus convallis, nulla! Eius scelerisque voluptatum penatibus, dignissimos molestiae, soluta eum. Voluptatibus quod? Temporibus potenti voluptates dictumst? Cillum metus, nec asperiores? Impedit sit! Eum tellus cillum facilisis ullamco tempor? Sint nostrum luctus? Neque dictumst diam, minus? Itaque, minus, etiam dignissimos debitis occaecat aptent tempus! Praesent molestiae duis nihil recusandae, eius imperdiet aspernatur natus. Tempus mattis at architecto, augue, consequuntur ultricies eligendi, litora morbi ante nesciunt pretium laoreet quidem recusandae voluptates dapibus, iure sagittis donec ipsum mollit? Blanditiis! Laborum sit assumenda beatae.",
        "linkedItem": {
            "name": "Demo blog",
            "route": {
                "path": "/demo-blog/",
                "startItem": {
                    "id": "5d5ae914-9885-4ee0-a14b-0ab57f501a55",
                    "path": "demo-blog"
                }
            },
            "id": "5d5ae914-9885-4ee0-a14b-0ab57f501a55",
            "contentType": "blog",
            "properties": {
                "title": "My demo blog",
                "description": "Nihil incididunt dolores adipisicing placeat quisque imperdiet interdum autem, dolorem fusce rhoncus sunt leo inventore dictumst quisque, voluptatem, magni justo nostrud deserunt! Natus ipsam commodi dignissimos, sodales ab.\n"
            }
        }
    },
    "cultures": {}
}
```
{% endcode %}

The built-in property editors in Umbraco that allow for output expansion are:

* `Umbraco.ContentPicker`
* `Umbraco.MediaPicker`
* `Umbraco.MediaPicker3`
* `Umbraco.MultiNodeTreePicker`

</details>

<details>

<summary>Preview</summary>

Similar to the preview concept in Umbraco, the Delivery API allows for requesting unpublished content through its endpoints. This can be done by setting a `Preview` header to `true` in the API request. However, accessing draft versions of your content nodes requires authorization via an API key configured in `appsettings.json` file - `Umbraco:CMS:DeliveryApi:ApiKey` setting. To obtain preview data, you must add the `Api-Key` request header containing the configured API key to the appropriate endpoints, like:

```http
GET /umbraco/delivery/api/v1/content/item/11fb598b-5c51-4d1a-8f2e-0c7594361d15
Preview: true
Api-Key: my-api-key
```

Draft content is not going to be included in the JSON response otherwise.

</details>

<details>

<summary>Localization</summary>

If your content is available in multiple languages, the Delivery API can resolve localized content. When querying content by `id`, the `Accept-Language` header can be used to request variant content.

```http
GET /umbraco/delivery/api/v1/content/item/11fb598b-5c51-4d1a-8f2e-0c7594361d15
Accept-Language: en-US
```

When querying content by path, the culture is already known and included in the path, making the `Accept-Language` header unnecessary. However, if the header is present in the request, its value will take precedence over any other configuration settings. Localization is also supported by the means of the CMS's culture and hostname configuration.

</details>

## Endpoints

The output produced by the Delivery API can either represent a specific content item or a paged list of multiple items.

{% swagger method="get" path="/content/item/{id}" baseUrl="/umbraco/delivery/api/v1" summary="Gets a content item by id" %}
{% swagger-description %}
Returns a single item.
{% endswagger-description %}

{% swagger-parameter in="path" name="id" type="String" required="true" %}
GUID of the content item
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Accept-Language" type="String" required="false" %}
Requested culture
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" required="false" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Preview" type="Boolean" required="false" %}
Whether draft content is requested
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Start-Item" type="String" required="false" %}
URL segment or GUID of the root content item
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" required="false" %}
Which properties to expand and therefore include in the output if they refer to another piece of content
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Content item" %}

{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Content item not found" %}

{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/content/item/{path}" baseUrl="/umbraco/delivery/api/v1" summary="Gets a content item by route" %}
{% swagger-description %}
Returns a single item.
{% endswagger-description %}

{% swagger-parameter in="path" name="path" type="String" required="true" %}
Path of the content item
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Accept-Language" type="String" required="false" %}
Requested culture
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" required="false" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Preview" type="Boolean" required="false" %}
Whether draft content is requested
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Start-Item" type="String" required="false" %}
URL segment or GUID of the root content item
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" required="false" %}
Which properties to expand and therefore include in the output if they refer to another piece of content
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Content item" %}

{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Content item not found" %}

{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/content" baseUrl="/umbraco/delivery/api/v1" summary="Gets content item(s) from a query" %}
{% swagger-description %}
Returns single or multiple items.
{% endswagger-description %}

{% swagger-parameter in="query" name="fetch" type="String" required="false" %}
Structural query string option (e.g. "ancestors", "children", "descendants")
{% endswagger-parameter %}

{% swagger-parameter in="query" name="filter" type="String Array" required="false" %}
Filtering query string options (e.g. "contentType", "name")
{% endswagger-parameter %}

{% swagger-parameter in="query" name="sort" type="String Array" required="false" %}
Sorting query string options (e.g. "createDate", "level", "name", "sortOrder", "updateDate")
{% endswagger-parameter %}

{% swagger-parameter in="query" name="skip" type="Integer" required="false" %}
Amount of items to skip
{% endswagger-parameter %}

{% swagger-parameter in="query" name="take" type="Integer" required="false" %}
Amount of items to take
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Accept-Language" type="String" required="false" %}
Requested culture
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" required="false" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Preview" type="Boolean" required="false" %}
Whether draft content is requested
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Start-Item" type="String" required="false" %}
URL segment or GUID of the root content item
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" required="false" %}
Which properties to expand and therefore include in the output if they refer to another piece of content
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Paginated list of content items" %}

{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid request" %}

{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Start-Item not found" %}

{% endswagger-response %}
{% endswagger %}

### Query parameters

The Content Delivery API provides a number of query parameters that allow you to customize the content returned by the API to fit your needs. For each endpoint, the relevant query parameters are already specified within their corresponding documentation above. In addition to standard parameters like `skip` and `take`, the API provides several possibilities for the value of `expand`, `fetch`, `filter` and `sort` parameters. Below are the options supported out-of-the-box.

{% hint style="info" %}
You can extend the built-in selectors, filters, and sorting capabilities of the Delivery API by creating your own custom selector, filter or sort query handlers.
{% endhint %}

{% tabs %}
{% tab title="expand" %}
{% hint style="info" %}
Refer to the [Output expansion](content-delivery-api.md#output-expansion) concept for more information about the benefits of this parameter.
{% endhint %}

`?expand=all`\
_All expandable properties on the retrieved content item will be expanded._

`?expand=property:`_`{alias1}`_\
_A specific expandable property with the property alias `alias1` will be expanded._

`?expand=property:`_`{alias1,alias2,alias3}`_\
_Several expandable properties with the specified property aliases will be expanded._
{% endtab %}

{% tab title="fetch" %}
To query content items based on their structure, you can apply a selector option to the `/umbraco/delivery/api/v1/content` endpoint. The selector allows you to fetch different subsets of items based on a GUID or path of a content item. If no `fetch` parameter is provided, the Delivery API will search across all available content items. The following built-in selectors can be used out-of-the-box:

`?fetch=ancestors:`_`{id / path}`_\
_All ancestors of a specific content item will be retrieved._

`?fetch=children:`_`{id / path}`_\
_All immediate children of a specific content item will be retrieved._

`?fetch=descendants:`_`{id / path}`_\
_All descendants of a specific content item will be retrieved._

{% hint style="info" %}
Only one selector option can be applied to a query at a time. This means that you can't combine multiple fetch parameters in a single query.
{% endhint %}



For example, the following API call will attempt to retrieve all the content items that are directly below an item with the id `dc1f43da-49c6-4d87-b104-a5864eca8152`:

**Request**

```http
GET /umbraco/delivery/api/v1/content?fetch=children:dc1f43da-49c6-4d87-b104-a5864eca8152
```
{% endtab %}

{% tab title="filter" %}
The `filter` query parameter allows you to specify one or more filters that must match in order for a content item to be included in the response. The API provides two built-in filters that you can use right away with the `/umbraco/delivery/api/v1/content` endpoint:

`?filter=contentType:`_`{alias}`_\
_This filter restricts the results to only include content items that belong to the specified content type. Replace `{alias}` with the alias of the content type you want to filter by._

`?filter=name:`_`{name}`_\
_When this filter is applied, only content items whose name matches the specified value will be returned. Replace `{name}` with the name of the item that you want to filter by._



Multiple filters can be applied to the same request in addition to other query parameters:

**Request**

```http
GET /umbraco/delivery/api/v1/content?filter=contentType:article&filter=name:guide&skip=0&take=10
```
{% endtab %}

{% tab title="sort" %}
Specifying how the results should be ordered, can be achieved using the `sort` query option. You can use this parameter to sort the content items by various fields, including create date, level, name, sort order, and update date. For each field, you can specify whether the items should be sorted in ascending (_asc_) or descending (_desc_) order. Without a `sort` query parameter, the order of the results will be determined by the relevance score of the **DeliveryApiContentIndex** for the given search term.

`?sort=createDate:`_`{asc / desc}`_\
_An option to sort the results based on the creation date of the content item._

`?sort=level:`_`{asc / desc}`_\
_An option to sort the results based on the level of the content item in the content tree._

`?sort=name:`_`{asc / desc}`_\
_An option to sort the results based on the name of the content item._

`?sort=sortOrder:`_`{asc / desc}`_\
_An option to sort the results based on the sort order of the content item._

`?sort=updateDate:`_`{asc / desc}`_\
_An option to sort the results based on the last update date of the content item._



Several sorting options can be combined for the `/umbraco/delivery/api/v1/content` endpoint, allowing for more advanced sorting functionality. Here is an example:

**Request**

```http
GET /umbraco/delivery/api/v1/content?sort=name:asc&sort=createDate:asc
```
{% endtab %}
{% endtabs %}

## Current Limitations

The Content Delivery API provides a powerful and flexible way to retrieve content from the Umbraco CMS. There are, however, certain limitations to be aware of.

In this section, we will discuss some of the known limitations of the API, and how to work around them if necessary.

_TBD_
