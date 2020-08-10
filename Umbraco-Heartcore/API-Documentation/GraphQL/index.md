---
versionFrom: 8.0.0
meta.Title: "Umbraco Heartcore GraphQL API"
meta.Description: "Documentation for Umbraco Heartcore GraphQL API"
---

# GraphQL API

The GraphQL API accepts POST requests with the content type `application/json`. The body must be JSON and contain a `query` field with the query as a string and an optional `variables` field containing the variables.

```json
{
  "query": "query($url: String) { content(url: $url) { name } }",
  "variables": {
    "url": "/"
  }
}
```

## API Access

In order to access the data for your Umbraco Heartcore project you need to provide a project identifier (Project Alias) via a HTTP Header or a Querystring parameter.

The Project Alias is a HTTP friendly version of the Project Name under your Umbraco Cloud account.

### Access via Umb-Project-Alias header

```http
POST https://graphql.umbraco.io/
Umb-Project-Alias: {project-alias}
```

### Access via Query String parameter

```http
POST https://graphql.umbraco.io/?Umb-Project-Alias={project-alias}
```

## Authorization

By default the GraphQL API is not protected. This can be enabled through the Backoffice, where API keys for each user in the Backoffice is also managed.

To access the GraphQL API the user must have access to the `Content` section and have the `Browse Node` permission.

### Access via an Api-Key header

```http
POST https://graphql.umbraco.io/
Api-Key: {api-key}
```

## [Schema Generation](Schema-Generation/)

Information on how the GraphQL schema is generated, reserved names and built in custom types.

## [Property Editors](Property-Editors/)

A list of all the built-in Umbraco Property Editors and their GraphQL types.
