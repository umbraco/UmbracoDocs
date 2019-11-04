---
versionFrom: 8.0.0
---

# API Documentation

This page contains documentation for the Umbraco Headless API endpoints divided into two main areas: Content Delivery and Content Mangement.

The [Content Delivery API](#content-delivery-api) is the read-only Content and Media that you would normally retrieve to show the published content in your apps, websites or other platforms. The API is available on `https://cdn.umbraco.io`.

[The Content Management API](#content-management-api) can be used to Create, Read, Update and Delete Content, Media, Languages, Relations, Members and the associated types using Umbraco Backoffice user credentials or API Keys. The API is available on `https://api.umbraco.io`.

## REST API Standard

The Umbraco Headless APIs are based on the [HAL Standard](https://weierophinney.github.io/hal/hal/).

### System level properties

The properties in the Umbraco Headless API, which starts with an underscore, are **system level properties**. That means that they are standard Umbraco properties, which cannot be changed via the API. This includes properties like `_id`, `_url`, `_createDate`, `_updateDate`, `_creatorName`, `_writerName`, `_level` and `_hasChildren`. These are all defined by Umbraco when Content is created or updated.

The properties `_links` and `_embedded` are both part of the HAL specification and are implemented in the Umbraco Headless API accordingly.

### API Browser

In the Settings section in the Umbraco Backoffice, there is a Headless tree. From there you can use the API Browser to interact with both the Content Delivery and Content Management APIs. 

It is recommended to use this browser to explore the JSON output for all the different endpoints documented under the Content Delivery and Content Management API sections.

## Common API Features

// Removed the URLs, as it is already mentioned at the top of the article.

Both the Content Delivery and the Content Management APIs share common points of configuration for access, versioning, culture and authentication/authorization, which are highlighted below.

### API Access

In order to access the data for your Umbraco Headless project you need to provide a project identifier (Project Alias) via a HTTP Header or a Querystring parameter.

The Project Alias is a HTTP friendly version of the Project Name under your Umbraco Cloud account.

#### Access via Umb-Project-Alias header

```http
GET https://cdn.umbraco.io/content
Umb-Project-Alias: project-alias
```

#### Access via Query String parameter

```http
GET https://cdn.umbraco.io/content?Umb-Project-Alias=project-alias
```

### Versioning

API versioning is handled by [ASP.NET API Versioning](https://github.com/microsoft/aspnet-api-versioning).

All API requests need to specify the API version they target. If no version is specified, the latest version of the API is used, which will break clients when a new version of the API is released.

#### Access via an api-version header

```http
GET https://cdn.umbraco.io/content
api-version: 2
```

#### Access via Query String parameter

```http
GET https://cdn.umbraco.io/content?api-version=2
```

#### Access via Content negotiation

```http
GET https://cdn.umbraco.io/content
Accept: application/json+hal;v=2
```

## Authentication and Authorization

By default the Content Delivery API is not protected, it can be enabled through the backoffice. The Content Management API is always protected and requires either an API key or a bearer token.

Since both API keys and bearer tokens are created for a specific user their permissions can be set on that user in the backoffice.

### API Keys

API keys can be managed for a user through the backoffice.

#### Access via the Authorization header

When using the `Authorization` header the API key must be passed in as the username and the password must be left empty. The value must be base64 encoded e.g. `base64(api-key:)`

```http
GET https://api.umbraco.io/
Authorization: Basic {base64-encoded-string}
```

#### Access via an Api-Key header

```http
GET https://api.umbraco.io/
Api-Key: {api-key}
```

### Bearer token

The endpoints implements OAuth 2.0.

A bearer token can be created by posting to `https://api.umbraco.io/oauth/token` and supplying a username and password for a backoffice user.

```http
POST https://api.umbraco.io/oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=password&username={username}&password={password}
```

It can be used by passing it to the `Authorization` header.

```http
GET https://api.umbraco.io/
Authorization: Bearer {token}
```

## Content Delivery API

This is the read-only API for delivering published content and media to any app, website, device or platform.

It’s worth noting that the JSON output for both Content and Media vary depending on how a given ContentType or MediaType is defined.

### Cultures

Specific to Content in the Content Delivery API.

To request content in a specific language, a culture parameter can be specified. When no culture is specified its treated as invariant and the default lanuage will be returned.

#### Access via an Accept-Language header

```http
GET https://cdn.umbraco.io/content
Accept-Language: en-US
```

#### Acces via a Query String parameter

```http
GET https://cdn.umbraco.io/content?culture=en-US
```

### [Content endpoints](cdn/content/)

Content endpoints for retrieving specific content by ID or URL. It is also possible to retrieve children, descendants and anscestors structured according to the Content tree structure.

### [Media endpoints](cdn/media/)

Media endpoints for retrieving specific media by id. It is also possible getting children of a media folder structured according to the Media tree structure.

## Content Management API

This is the management API for creating, updating and deleting content, media, languages, relations, members and member groups. It also allows you to retrieve content drafts as well as Content Types, Media Types and Member Types.

Common for the Content Management API is that you must be authenticated and authorized when performing any action against the endpoints listed below. This means that you must supply a Bearer Token via an Authorization header or an API Key via an Authorization or Api-Key header.

### [Content endpoints](api/content/)

Content endpoints for retrieving, creating, updating and deleting.

### [Content Type endpoints](api/content/type/)

Content Type endpoints for retrieving all available and specific content types. We also expose endpoints for publishing and unpublishing content.

### [Media endpoints](api/media/)

Media endpoints for retrieving, creating, updating and deleting.

### [Media Type endpoints](api/media/type/)

Media Type endpoints for retrieving all available and specific media types.

### [Language endpoints](api/language/)

Language endpoints for retrieving, creating, updating and deleting.

### [Member endpoints](api/member/)

Member endpoints for retrieving, creating, updating and deleting. We also expose endpoints for adding a member to member group and removing a member group from a member.

### [Member Group endpoints](api/member/group/)

Member Group endpoints for retrieving, creating and deleting.

### [Member Type endpoints](api/member/type/)

Member Type endpoints for retrieving all available and specific member types.

### [Relation endpoints](api/relation/)

Relation endpoints for retrieving, creating and deleting.

### [Relation Type endpoints](api/relation/type/)

Relation Type endpoint for retrieving specific relation types.
