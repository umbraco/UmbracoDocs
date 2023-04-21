---
description: Get started with the Content Delivery API.
---

# Content Delivery API

## Overview

With its several extension points, this new API delivers headless capabilities built directly into Umbraco. It allows you to retrieve your content items in a JSON format and lets you preset them in different channels, using your preferred technology stack. This feature preserves the friendly editing experience of Umbraco, while also ensuring a performant delivery of content, even in headless scenarios.

## Getting Started

When upgrading an existing project to version 12, you would need to opt-in explicitly for using the Delivery API. Below you will find the steps you need to take in order to configure it for your Umbraco project. If you start with a fresh Umbraco 12 installation, the Delivery API will be enabled by default and therefore you can skip straight to the [Additional configuration](content-delivery-api.md#additional-configuration) section.

### Register the Content Delivery API dependencies

In the `Startup.cs` file, register the API dependencies in the `ConfigureServices` by adding `.AddDeliveryApi()`:

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

Add the `DeliveryApi` configuration section in `appsettings.json` and set the value of the `Enabled` key to `true`:

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

### Additional configuration

Once the Delivery API has been configured on your project, you need to be aware that all your content will be made available to the public. However, there are a few additional configuration options that you can use to restrict access to the Delivery API endpoints and limit the content that is returned.

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "CMS": {
            "DeliveryApi": {
                "Enabled": true,
                "PublicAccess": true,
                "ApiKey": "my-api-key",
                "DisallowedContentTypeAliases": ["alias1", "alias2", "alias3"]
            }
        }
    }
}
```
{% endcode %}

* `Umbraco.CMS.DeliveryApi.PublicAccess` determines whether the Delivery API (_if enabled_) should be publicly accessible or if access should require an API key.
* `Umbraco.CMS.DeliveryApi.ApiKey` specifies what API key to use for authorizing access to the API when public access is disabled. This setting is also used for managing access to draft content.
* `Umbraco.CMS.DeliveryApi.DisallowedContentTypeAliases` contains the aliases of the content types that would never be exposed through the Delivery API.

{% hint style="info" %}
To test the functionality of the API, you would need to create some content items first.
{% endhint %}

## Endpoints

The output produced by the Delivery API can either represent a specific content item or a paged list of multiple items. Before exploring the endpoints that API has to offer, there are a few concepts to keep in mind.

### Concepts

<details>

<summary>Content item JSON Schema</summary>

The Delivery API uses the JSON schema below to represent the retrieved content items, which consist of a range of properties. Basic JSON properties that any item returned by the API will contain include `name`, `id`, and t_ype_ (`contentType` in this case). All properties added to the content item can be found under the `properties` field.  Depending on the used property editor, the value associated with it in the JSON response can be a _string_, _number_, _boolean expression_, _array_, _object_ or _`null`_ (when a picker property is empty). The `route` property provides information about the `path` of the content item, as well as details about the root node value that is represented by the `startItem` object. We will discuss the concept of a `startItem` in more detail in the next section. Finally, if the content item varies by culture, the `cultures` property will contain information about all configured cultures for the content node, including the culture variant `path` and `startItem` for each one.

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
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
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

The start item indicates the root node to which a content item belongs. This concept is particularly useful for omitting the root node URL segment in the output, especially in cases where multiple Umbraco sites are configured under a single domain. The start item is represented by a header and is included in the JSON response of the Delivery API as the `startItem` property. This property contains both the item’s `id` and `path`. Note that the start item path segment will not be included in the value of the `path` JSON property.

In Umbraco, `Umbraco.CMS.Global.HideTopLevelNodeFromPath` setting can be used to enable or disable including the top-level node in the URL of your content items. If the setting is set to `false`, you can still use the root node URL segment in the `path` parameter of the "_Get by route_" endpoint. However, the preferred approach is to make use of the `Start-Item` header to specify the URL segment or `id` of the root content node. This way, you can omit the root node URL segment from the content item path when querying for a content item. The `HideTopLevelNodeFromPath` setting does not affect the output URLs when rendering the content output.

</details>

<details>

<summary>Output expansion</summary>

**Output expansion** is a concept that refers to the ability to retrieve additional data about related content in the JSON output. By default, when a property that allows picking a different content item is used in a content node, for example, through a content picker property editor, the JSON representation of that content node will only contain a shallow representation of the referenced item. That means, only the basic information about the linked item, without the nested properties. However, with output expansion, it is possible to expand all or specific properties of the content, provided they are expandable and referenced at the first level.

This feature can be used when querying for a content item or items through the Delivery API, by adding an `expand` parameter to the query. The value of this parameter can be either `"all"` to expand all properties on the content item, or `"property:alias, alias, alias"` to expand specific ones.



The following snippet demonstrates the output of a "My post" content node without expanding the `linkedItem` content picker property.

{% code title="Shallow output for "linkedItem" property" %}
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



And here is an example of how an expanded representation might look for the `linkedItem` property that references another content item with properties `title` and `description`:

#### Request

```
GET
/umbraco/delivery/api/v1/content/item/9bdac0e9-66d8-4bfd-bba1-e954ed9c780d?expand=property:linkedItem
```

#### Response

{% code title="Expanded output for "linkedItem" property" %}
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



The built-in property editors in Umbraco that allow for output expansion are:  &#x20;

* `Umbraco.ContentPicker`
* `Umbraco.MultiNodeTreePicker`

</details>

<details>

<summary>Preview</summary>

Similar to the preview concept in Umbraco, the Delivery API allows for requesting unpublished content through its endpoints. This can be done by setting a `Preview` header to `true` in the API request. However, accessing draft versions of your content nodes requires authorization via an API key configured in `appsettings.json` file - `Umbraco.CMS.DeliveryApi.ApiKey` setting. To obtain preview data, you must add the `Api-Key` request header containing the configured API key to the appropriate endpoints. Draft content is not going to be included in the JSON response otherwise.

</details>

<details>

<summary>Localization</summary>

If your content is available in multiple languages, the Delivery API can resolve localized content. When querying content by `id`, the `Accept-Language` header can be used to request variant content. When querying content by path, the culture is already known and included in the path, making the `Accept-Language` header unnecessary. However, if the header is present in the request, its value will take precedence over any other configuration settings. Localization is also supported by the means of the CMS's culture and hostname configuration.

</details>

### Get by id

{% swagger method="get" path="/content/item/{id}" baseUrl="/umbraco/delivery/api/v1" summary="Gets a content item by id" %}
{% swagger-description %}
Returns a single item
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

### Get by route

{% swagger method="get" path="/content/item/{path}" baseUrl="/umbraco/delivery/api/v1" summary="Gets a content item by route" %}
{% swagger-description %}
Returns a single item
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

### Get all

{% swagger method="get" path="/content" baseUrl="/umbraco/delivery/api/v1" summary="Gets content item(s) from query" %}
{% swagger-description %}
Returns a single or multiple items
{% endswagger-description %}

{% swagger-parameter in="query" name="fetch" type="String" required="false" %}
Structural query string option
{% endswagger-parameter %}

{% swagger-parameter in="query" name="filter" type="String Array" required="false" %}
Filtering query string options
{% endswagger-parameter %}

{% swagger-parameter in="query" name="sort" type="String Array" required="false" %}
Sorting query string options
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
{% endswagger %}

## Feature Capabilities

* Querying for content item(s)
* Localization support
* Output expansion
* Preview
* Multi-site support
* API authorization
* Denylist of document types
* Custom property editors

## Current Limitations

While the Content Delivery API provides a powerful and flexible way to retrieve content from the Umbraco CMS, there are certain limitations to be aware of. In this section, we'll discuss some of the known limitations of the API, and how to work around them if necessary.

_TBD_
