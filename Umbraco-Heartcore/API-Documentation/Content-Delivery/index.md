---
versionFrom: 8.0.0
meta.Title: "Umbraco Heartcore Content Delivery"
meta.Description: "Documentation for Heartcore Content Delivery APIs"
---

# Content Delivery API

This is the read-only API for delivering published content and media to any app, website, device or platform.

It’s worth noting that the JSON output for both Content and Media vary depending on how a given ContentType or MediaType is defined.

## Cultures

Specific to Content in the Content Delivery API.

To request content in a specific language, a culture parameter can be specified. When no culture is specified its treated as invariant and the default language will be returned.

### Access via an Accept-Language header

```http
GET https://cdn.umbraco.io/content
Accept-Language: en-US
```

### Acces via a Query String parameter

```http
GET https://cdn.umbraco.io/content?culture=en-US
```

## [Content endpoints](content/)

Content endpoints for retrieving specific content by ID or URL. It is also possible to retrieve children, descendants and ancestors structured according to the Content tree structure.

## [Media endpoints](media/)

Media endpoints for retrieving specific media by id. It is also possible getting children of a media folder structured according to the Media tree structure.
