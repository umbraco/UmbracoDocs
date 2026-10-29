---
description: Using the Media Delivery API.
---

# Media Delivery API

The Media Delivery API allows for accessing the Umbraco media items in a headless manner. This API applies many of the same concepts as its content counterpart, although with fewer options. If you haven't already, familiarize yourself with the [Content Delivery API](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api) before reading this article.

{% hint style="info" %}
The Media Delivery API specification is created to mimic that of the Content Delivery API. However, the default implementation of this specification is limited and does not support the entire specification.

Unlike the Content Delivery API, the Media Delivery API does not feature an extension model for querying.

The reasoning behind is that third-party media systems might support a complete implementation of the specification. If the demand rises, the default implementation might eventually cover the entire specification.
{% endhint %}

## Getting Started

To use the Media Delivery API you must first enable it. Even if the Content Delivery API is enabled, the Media Delivery API remains disabled by default.

The Media Delivery API is enabled by adding the `Media` section to the `DeliveryApi` configuration in `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "CMS": {
            "DeliveryApi": {
                "Enabled": true,
                "PublicAccess": true,
                "Media": {
                    "Enabled": true,
                    "PublicAccess": false
                }
            }
        }
    }
}
```

{% endcode %}

As this configuration sample illustrates, it is possible to restrict public access to media independently from content. As with the Content Delivery API, media is publicly accessible by default when the Media Delivery API is enabled.

{% hint style="info" %}
The `Media` configuration can only become more restrictive than the `DeliveryApi` configuration:

* If `DeliveryApi:Enabled` is `false`, the `DeliveryApi:Media:Enabled` configuration option has no effect. The Media Delivery API cannot be enabled on its own.
* If `DeliveryApi:PublicAccess` is `false`, the `DeliveryApi:Media:PublicAccess` configuration option has no effect. The Media Delivery API cannot be publicly available if the Content Delivery API is not.
{% endhint %}

## Endpoints

The Media Delivery API can either be queried for a specific media item or a paged list of multiple items.

{% hint style="info" %}
In the Media Delivery API, `id` parameters always refer to media item keys (`Guid`), not node ids (`integer`).
{% endhint %}

{% swagger method="get" path="/media/item/{id}" baseUrl="/umbraco/delivery/api/v2" summary="Gets a media item by id" %}
{% swagger-description %}
Returns a single item.
{% endswagger-description %}

{% swagger-parameter in="path" name="id" type="String" required="true" %}
GUID of the media item
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" required="false" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" required="false" %}
Which properties to expand in the response
{% endswagger-parameter %}

{% swagger-parameter in="query" name="fields" type="String" required="false" %}
Which properties to include in the response (_by default all properties are included_)
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Media item" %}

{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="Missing permissions after protection is set up" %}

{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Media item not found" %}

{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/media/item/{path}" baseUrl="/umbraco/delivery/api/v2" summary="Gets a media item by path" %}
{% swagger-description %}
Returns a single item.
{% endswagger-description %}

{% swagger-parameter in="path" name="path" type="String" required="true" %}
Path of the media item. The path is composed by the names of any ancestor folders and the name of the media item itself, separated by

`/`

.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" required="false" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" required="false" %}
Which properties to expand in the response
{% endswagger-parameter %}

{% swagger-parameter in="query" name="fields" type="String" required="false" %}
Which properties to include in the response (_by default all properties are included_)
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Media item" %}

{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="Missing permissions after protection is set up" %}

{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Media item not found" %}

{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/media/items" baseUrl="/umbraco/delivery/api/v2" summary="Gets media item(s) by id" %}
{% swagger-description %}
Returns single or multiple items by id.
{% endswagger-description %}

{% swagger-parameter in="query" name="id" type="String Array" required="true" %}
GUIDs of the media items
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" required="false" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" required="false" %}
Which properties to expand in the response
{% endswagger-parameter %}

{% swagger-parameter in="query" name="fields" type="String" required="false" %}
Which properties to include in the response (_by default all properties are included_)
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="List of media items" %}

{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="Missing permissions after protection is set up" %}

{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/media" baseUrl="/umbraco/delivery/api/v2" summary="Gets media item(s) from a query" %}
{% swagger-description %}
Returns single or multiple items.
{% endswagger-description %}

{% swagger-parameter in="query" name="fetch" type="String" required="true" %}
Structural query string option (e.g. `ancestors`, `children`, `descendants`).

**Note:** The default API implementation only supports `children`.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="filter" type="String Array" required="false" %}
Filtering query string options (e.g. `mediaType`, `name`)
{% endswagger-parameter %}

{% swagger-parameter in="query" name="sort" type="String Array" required="false" %}
Sorting query string options (e.g. `createDate`, `name`, `sortOrder`, `updateDate`)
{% endswagger-parameter %}

{% swagger-parameter in="query" name="skip" type="Integer" required="false" %}
Amount of items to skip
{% endswagger-parameter %}

{% swagger-parameter in="query" name="take" type="Integer" required="false" %}
Amount of items to take. Type: Integer. Default: 10. Limits: No limits. Accepts 0.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" required="false" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" required="false" %}
Which properties to expand in the response
{% endswagger-parameter %}

{% swagger-parameter in="query" name="fields" type="String" required="false" %}
Which properties to include in the response (_by default all properties are included_)
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Paginated list of media items" %}

{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid request" %}

{% endswagger-response %}
{% endswagger %}

### Request samples

Fetch a media item by its ID:

```http
GET /umbraco/delivery/api/v2/media/item/3fa85f64-5717-4562-b3fc-2c963f66afa6
```

Fetch a media item inside a folder structure by its full path, and expand its `author` property:

```http
GET /umbraco/delivery/api/v2/media/item/root level folder/child folder/media item name/&expand=property:author
```

Fetch two media items by their ids:

```http
GET /umbraco/delivery/api/v2/media/item?id=11178b4f-f8e2-4686-9697-6d990851a081&id=7cd00706-de93-4db8-8fc2-4b20e8419c30
```

Fetch the first 10 media items of type `Image` at root level. Return the found items sorted by name ascending:

```http
GET /umbraco/delivery/api/v2/media?fetch=children:/&filter=mediaType:Image&sort=name:asc&skip=0&take=10
```

Fetch the first 5 media items inside a folder structure. Return only items of type `Image` whose item names contain "size".

```http
GET /umbraco/delivery/api/v2/media?fetch=children:/root level folder/child folder/&filter=mediaType:Image&filter=name:size&skip=0&take=5
```

## Media item JSON structure

The Media Delivery API outputs the JSON structure outlined below to represent media items:

* Item `path`, `createDate`, `updateDate`, `id`, `name`, and `mediaType` are always included in the response.
* `url`, `extension` and the size in `bytes` are included for all files (not for folders).
* `width` and `height` (in pixels) are included for most images.
* Depending on Umbraco Data Type configuration, `focalPoint` and `crops` are included for most images.
* Additional editorial properties from the media type can be found in the `properties` collection.

```json
{
    "path": "string",
    "createDate": "2023-08-22T08:13:57.510Z",
    "updateDate": "2023-08-22T08:13:57.510Z",
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "name": "string",
    "mediaType": "string",
    "url": "string",
    "extension": "string",
    "width": 0,
    "height": 0,
    "bytes": 0,
    "properties": {
        "property1Alias": "string",
        "property2Alias": 0,
        "property3Alias": true,
        "property4Alias": [],
        "property5Alias": {},
        "property6Alias": null
    },
    "focalPoint": {
        "left": 0,
        "top": 0
    },
    "crops": [
        {
            "alias": "string",
            "width": 0,
            "height": 0,
            "coordinates": {
                "x1": 0,
                "y1": 0,
                "x2": 0,
                "y2": 0
            }
        }
    ]
}
```
