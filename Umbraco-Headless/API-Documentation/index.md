---
versionFrom: 8.0.0
---

# API Documentation

This page contains documentation for the Umbraco Headless API endpoints divided into two main areas: Content Delivery and Content Mangement

The Content Delivery API is the read-only Content and Media that you would normally retrieve to show the published content in your apps, websites or other media. The API is available on `https://cdn.umbraco.io`

Content Management is where you can Create, Read, Update and Delete Content, Media, Languages, Relations, Members and the associated types using Umbraco Backoffice user credentials or API Keys. The API is available on `https://api.umbraco.io`

## REST API Standard

The Umbraco Headless APIs are based on the HAL Standard, which are explained in greater detail here http://stateless.co/hal_specification.html 
The properties _links and _embedded are both part of the HAL specification and are implemented in the Umbraco Headless API accordingl to the specification linked above.
The rest of the properties in the Umbraco Headless API, which starts with an underscore are "system level properties" meaning that they are standard Umbraco properties, which cannot be changed via the API. So properties like _id, _url, _createDate, _updateDate, _creatorName, _writerName, _level andd _hasChildren. These are all defined by Umbraco when Content is created or updated.

### API Browser

From within the Umbraco Backoffice go to the Settings section and the Headless tree, here you can use the API Browser to interact with both the Content Delivery and Content Management APIs. It is recommended to use this browser to explore the json output for all the different endpoints documented under the Content Delivery and Content Management API sections below.

## APIs

There are two main APIs, one for Content Delivery `https://cdn.umbraco.io` and one for Content Management `https://api.umbraco.io`. Both of these APIs share common points of configuration for access, versioning, culture and authentication/authorization, which are highlighted below.

### API Access

In order to access the data for your Umbraco Headless project you need to provide a project identifier (Project Alias) via a HTTP Header or a Querystring parameter.
The Project Alias is an http friendly version of the Project Name under your Umbraco Cloud account.

Via a Umb-Project-Alias header
```http
Umb-Project-Alias: project-alias
```

Via a Query string parameter
```http
?Umb-Project-Alias=project-alias
```

### Versioning

API versioning is handled by [ASP.NET API Versioning](https://github.com/microsoft/aspnet-api-versioning)

All API requests should specify the API version they target. If no version is specified, the latest version of the API is used, this will break clients when a new version of the API is released.

#### Via an api-version header

```http
GET /cdn/content
api-version: 2
```

#### Via a Query String parameter

```http
GET /cdn/content?api-version=2
```

#### Via Content negotiation

```http
GET /cdn/content
Accept: application/json+hal;v=2
```

### Cultures

To request content in a specific language, a culture parameter can be specified.
If no culture is specified its treated as invariant and the default lanuage will be returned.

#### Via an Accept-Language header

```http
GET /cdn/content
Accept-Language: en-US
```

#### Via a Query String parameter

```http
GET /cdn/content?culture=en-US
```

## Authentication and Authorization


## Content Delivery API

This is the read-only API for delivering published content and media to any app, website, device or whatever you prefer.
It’s worth noting that the json output for both Content and Media vary depending on how a given Content or Media is structured - meaning how the ContentType and MediaType is defined.
