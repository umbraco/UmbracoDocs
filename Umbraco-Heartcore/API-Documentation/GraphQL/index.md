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
GET https://graphql.umbraco.io/?Umb-Project-Alias={project-alias}
```

## Authorization

By default the GraphQL API is not protected, it can be enabled through the Backoffice, API keys is also managed for each user in the Backoffice.

To access the GraphQL API the user must have access to the `Content` section and have the `Browse Node` permission.

### Access via an Api-Key header

```http
GET https://api.umbraco.io/
Api-Key: {api-key}
```
