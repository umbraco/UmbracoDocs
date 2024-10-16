---
description: "Documentation for Umbraco Heartcore GraphQL API"
---

# GraphQL API

The GraphQL API can be accessed on `https://graphql.umbraco.io`, it accepts POST requests with the content type `application/json`. The body must be JSON and contain a `query` field with the query as a string and an optional `variables` field containing the variables.

```json
{
  "query": "query($url: String) { content(url: $url) { name } }",
  "variables": {
    "url": "/"
  }
}
```

## API Access

In order to access the data for your Umbraco Heartcore project you need to provide a project identifier (Project Alias) via an HTTP Header or a Querystring parameter.

The Project Alias is an HTTP friendly version of the Project Name under your Umbraco Cloud account.

### Access via Umb-Project-Alias header

```http
POST https://graphql.umbraco.io/
Umb-Project-Alias: {project-alias}
```

## Authorization

By default the GraphQL API is not protected. This can be enabled through the Backoffice, where API keys for each user in the Backoffice is also managed.

To access the GraphQL API the user must have access to the `Content` section and have the `Browse Node` permission.

### Access via an Api-Key header

```http
POST https://graphql.umbraco.io/
Api-Key: {api-key}
```

## Preview

The GraphQL API supports fetching draft content, this can be done by passing a `preview` argument to the root query fields.

{% hint style="info" %}
Fetching draft content requires an API Key to be passed with the request.
{% endhint %}

```graphql
query {
  content(preview: true) {
    name
  }
}
```

## Persisted queries

The GraphQL API supports [persisted queries](../graphql/persisted-queries.md), running a persisted query can be done using the following payload in the Graphql request:

```json
{
  "extensions": {
    "persistedQuery": {
      "alias": "{Alias}"
    }
  }
}
```
The persisted queries also support variables

```json
{
  "extensions": {
    "persistedQuery": {
      "alias": "{Alias}"
    }
  },
  "variables": {
    "url": "/"
  }
}
```

{% hint style="info" %}
Persisted queries can be created within the backoffice in the [GraphQL Playground](../../getting-started/graphql-playground.md#persisted-queries)
{% endhint %}


## [Schema Generation](schema-generation.md)

Information on how the GraphQL schema is generated, reserved names and built-in custom types.

## [Property Editors](property-editors.md)

A list of all the built-in Umbraco Property Editors and their GraphQL types.

## [Filtering and Ordering](filtering-and-ordering.md)

Documentation on how to filter and order collections with the GraphQL API.
