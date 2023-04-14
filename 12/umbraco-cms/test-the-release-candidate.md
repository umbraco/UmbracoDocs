# Test the Release Candidate

This article will cover in detail how you can try out and test the Release Candidate (RC) of Umbraco 12.

## [Content Delivery API](content-delivery-api.md)

### Overview

With its several extension points, this new API delivers headless capabilities built directly into Umbraco. It allows you to retrieve your content items in a JSON format and lets you preset them in different channels, using your preferred technology stack. This feature preserves the friendly editing experience of Umbraco, while also ensuring a performant delivery of content, even in headless scenarios.&#x20;

### Getting Started

When upgrading an existing project to version 12, you would need to opt-in explicitly for using the Delivery API. Below you will find the steps you need to take in order to configure it for your Umbraco project. If you start with a fresh Umbraco 12 installation, the Delivery API will be enabled by default and therefore you can skip straight to the [Additional configuration](test-the-release-candidate.md#additional-configuration) section.

#### Register the Content Delivery API dependencies

In the `Startup.cs` file, register the API dependencies in the `ConfigureServices` by adding `.AddContentApi()`:

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()             
        .AddWebsite()
        .AddContentApi()
        .AddComposers()
        .Build();
}
```

#### Enable the Content Delivery API

Add the `ContentApi` configuration section in `appsettings.json` and set the value of the `Enabled` key to `true`:

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "CMS": {
            "ContentApi": {
                "Enabled": true
            }
        }
    }
}
```
{% endcode %}

#### Additional configuration

Once the Delivery API has been configured on your project, you need to be aware that all your content will be made available to the public. However, there are a few additional configuration options that you can use to restrict access to the Delivery API endpoints and limit the content that is returned.

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "CMS": {
            "ContentApi": {
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

* `Umbraco.CMS.ContentApi.PublicAccess` determines whether the Delivery API (_if enabled_) should be publicly accessible or if access should require an API key.
* `Umbraco.CMS.ContentApi.ApiKey` specifies what API key to use for authorizing access to the API when public access is disabled. This setting is also used for managing access to draft content.
* `Umbraco.CMS.ContentApi.DisallowedContentTypeAliases` contains the aliases of the content types that would never be exposed through the Delivery API.

To test the functionality of the API, you would need to create some content items first. &#x20;

### Endpoints

The output produced by the Delivery API can either represent a specific content item or a paged list of multiple items. Before exploring the endpoints that API has to offer, there are a few concepts to keep in mind.

#### Concepts

<details>

<summary>Content item JSON Schema</summary>

E_xplain how a content item is represented in the Delivery API; the overall structure_

* _simple props_
* _props referencing another piece of content_

</details>

<details>

<summary>Start item</summary>



</details>

<details>

<summary>Output expansion</summary>



</details>

<details>

<summary>Preview</summary>

Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something Preview is something&#x20;



</details>

<details>

<summary>Localization</summary>



</details>

#### Get by id

{% swagger method="get" path="/content/item/{id}" baseUrl="/umbraco/delivery/api/v1" summary="Gets a content item by id" expanded="false" %}
{% swagger-description %}
Returns a single item
{% endswagger-description %}

{% swagger-parameter in="path" name="id" type="String" required="true" %}
GUID of the content item
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Accept-Language" type="String" %}
Requested culture
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Preview" type="Boolean" %}
Whether draft content is requested
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Start-Item" type="String" %}
URL segment of the root content item
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" %}
Which properties to expand and therefore include in the output if they refer to another piece of content
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Content item" %}

{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Content item not found" %}

{% endswagger-response %}
{% endswagger %}

#### Get by route

{% swagger method="get" path="/content/item/{path}" baseUrl="/umbraco/delivery/api/v1" summary="Gets a content item by route" %}
{% swagger-description %}
Returns a single item
{% endswagger-description %}

{% swagger-parameter in="path" name="path" type="String" required="true" %}
Path of the content item
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Accept-Language" type="String" %}
Requested culture
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Preview" type="Boolean" %}
Whether draft content is requested
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Start-Item" type="String" %}
URL segment of the root content item
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" %}
Which properties to expand and therefore include in the output if they refer to another piece of content
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Content item" %}

{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Content item not found" %}

{% endswagger-response %}
{% endswagger %}

#### Get all

{% swagger method="get" path="/content" baseUrl="/umbraco/delivery/api/v1" summary="Gets content item(s) from query" %}
{% swagger-description %}
Returns a single or multiple items
{% endswagger-description %}

{% swagger-parameter in="query" name="fetch" type="String" %}
Structural query string option
{% endswagger-parameter %}

{% swagger-parameter in="query" name="filter" type="String Array" %}
Filtering query string options
{% endswagger-parameter %}

{% swagger-parameter in="query" name="sort" type="String Array" %}
Sorting query string options
{% endswagger-parameter %}

{% swagger-parameter in="query" name="skip" type="Integer" %}
Amount of items to skip
{% endswagger-parameter %}

{% swagger-parameter in="query" name="take" type="Integer" %}
Amount of items to take
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Accept-Language" type="String" %}
Requested culture
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Api-Key" type="String" %}
Access token
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Preview" type="Boolean" %}
Whether draft content is requested
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Start-Item" type="String" %}
URL segment of the root content item
{% endswagger-parameter %}

{% swagger-parameter in="query" name="expand" type="String" %}
Which properties to expand and therefore include in the output if they refer to another piece of content
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Paginated list of content items" %}

{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid request" %}

{% endswagger-response %}
{% endswagger %}

### Feature Capabilities

* Querying for content item(s)
* Localization support
* Output expansion
* Preview
* Multi-site support
* API authorization
* Denylist of document types
* Custom property editors



### Testing Checklist

