---
description: "Documentation for Umbraco Heartcore REST APIs"
---

# API Documentation

This page contains documentation for the available API endpoints for Umbraco Heartcore. It includes endpoints for the GraphQL API as well as for the REST API which is divided into two main areas: Content Delivery and Content Management.

[The GraphQL API](graphql/README.md) can be used to query the read-only Content that you would normally retrieve to show the published content in your apps, websites, or other platforms. The API is available on `https://graphql.umbraco.io`. This API is available on Trial projects as well as Starter and Professional Plans.

[The Content Delivery API](content-delivery/README.md) is a read-only Content and Media API that you would normally retrieve to show the published content in your apps, websites or other platforms. The API is available on `https://cdn.umbraco.io`.

[The Content Management API](content-management/README.md) can be used to Create, Read, Update and Delete Content, Media, Languages, Relations, Members, and the associated types using Umbraco Backoffice user credentials or API Keys. The API is available on `https://api.umbraco.io`.

The Preview API is the read-only Content and Media that you would retrieve to show the draft content in your apps, websites, or other platforms. The API is available on `https://preview.umbraco.io`. The Preview API is always protected and requires an `Api-Key`. The endpoints are the same as the Content Delivery API.

## REST API Standard

The REST APIs are based on the [HAL Standard](https://weierophinney.github.io/hal/hal/).

### System level properties

The properties in the REST API, which starts with an underscore, are **system level properties**. That means that they are standard Umbraco properties, which cannot be changed via the API. This includes properties like `_id`, `_url`, `_createDate`, `_updateDate`, `_creatorName`, `_writerName`, `_level` and `_hasChildren`. These are all defined by Umbraco when Content is created or updated.

The properties `_links` and `_embedded` are both part of the HAL specification and are implemented in the REST API accordingly.

### API Browser

In the Settings section in the Umbraco Backoffice, there is a Headless tree. From there you can use the API Browser to interact with both the Content Delivery and Content Management APIs.

It is recommended to use this browser to explore the JSON output for all the different endpoints documented under the Content Delivery and Content Management API sections.

## Common API Features

Both the Content Delivery and the Content Management APIs share common points of configuration for access, versioning, culture and authentication/authorization, which are highlighted below.

### API Access

In order to access the data for your Umbraco Heartcore project you need to provide a project identifier (Project Alias) via a HTTP Header or a Querystring parameter.

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

{% hint style="info" %}
This feature is currently not available when using [External Login Providers.](../../umbraco-cloud/set-up/external-login-providers.md)
{% endhint %}

The endpoints implement OAuth 2.0.

A bearer token can be created by posting to `https://api.umbraco.io/oauth/token` and supplying a username and password for a backoffice user.
This corresponds to a user logging into the backoffice and is thus only meant to be used for the Content Management API.

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

## Member authentication

A member login can be used to access the Content Delivery API if it's protected. Members will only have access to Content Delivery Network (CDN) endpoints and cannot be used to access the Content Management API.

Content can be restricted further by using the Public Access feature in Umbraco to only allow access for specific Members or Member Groups.

{% hint style="info" %}
Do note that you will need an API key header if the Content Delivery API `cdn.umbraco.io` is set to protected via the backoffice.
{% endhint %}

### Member Bearer token

The endpoints implements OAuth 2.0.

A bearer token can be created by posting to `https://cdn.umbraco.io/member/oauth/token` and supplying a username and password for a member.

```http
POST https://cdn.umbraco.io/member/oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=password&username={username}&password={password}
```

It can be used by passing it to the `Authorization` header.

```http
GET https://cdn.umbraco.io/
Authorization: Bearer {token}
```
