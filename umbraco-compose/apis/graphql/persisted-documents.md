---
description: >-
  This article explains how to create, manage, and invoke persisted GraphQL
  documents in Umbraco Compose using aliases for improved performance and
  maintainability.
---

# Persisted Documents

Persisted Documents let you pre-register GraphQL queries with Umbraco Compose and execute them using an alias instead of sending the full query text. This concept is currently being standardized by GraphQL. You can read more about persisted documents in the [GraphQL Documentation](https://graphql.org/learn/serving-over-http/) and the [related Request for Comments (RFC)](https://github.com/graphql/graphql-over-http/pull/264).

This feature is similar to the Persisted Queries feature in [Umbraco Heartcore](https://docs.umbraco.com/umbraco-heartcore/api-documentation/graphql/persisted-queries) and [Apollo GraphQL](https://www.apollographql.com/docs/kotlin/advanced/persisted-queries).

A persisted document must include at least one **query** in order to be invokable. Fragments can be included and referenced by queries in the same document. They cannot be referenced from other documents.

## Benefits

Persisted Documents provide the following advantages:

* **Performance** - Reduced payload size since only an alias is sent instead of the full query text.
* **Separation of concerns** - Develop and refine your queries separately from your application, allowing updates without redeployment.

## Creating a Persisted Document

Create and manage persisted documents using the [`*/graphqlpersisteddocuments* endpoints`](https://apidocs.umbracocompose.com/#tag/graphqlpersisteddocuments) in the Management API.

The following configuration options are available:

* **Persisted Document Alias** - Alias to uniquely identify the persisted document.
* **Description** - Description of the persisted document.
* **Document** - The GraphQL query to persist.

```http
POST /v1/projects/{projectAlias}/environments/{environmentAlias}/graphql/persisted-documents HTTP/1.1
Host: management.umbracocompose.com
Content-Type: application/json

{
    "persistedDocumentAlias": "my-software-names",
    "description": "Gets the names of software items",
    "document": "query Software {
      content {
        items {
          ... on Software {
            name
          }
        }
      }
    }"
}
```

A persisted document can contain multiple named queries. When invoking such a document, you must specify which query to run using the `operationName` parameter.

```http
POST /v1/projects/{projectAlias}/environments/{environmentAlias}/graphql/persisted-documents HTTP/1.1
Host: management.umbracocompose.com
Content-Type: application/json

{
    "persistedDocumentAlias": "my-software-names",
    "description": "Gets the names of software items",
    "document": "query AllSoftware {
      content {
        items {
          ... on Software {
            name
          }
        }
      }
    }

    query EnglishVariantSoftware {
      content(where: { variant: \"en-GB\" }) {
        items {
          ... on Software {
            name
          }
        }
      }
    }"
}
```

### Parameters

| Parameter                | Description                                                      |
| ------------------------ | ---------------------------------------------------------------- |
| `projectAlias`           | The alias of your Umbraco Compose project                        |
| `environmentAlias`       | The alias of the environment to create the persisted document in |
| `persistedDocumentAlias` | Alias to uniquely identify the persisted document                |
| `description`            | Description of the persisted document                            |
| `document`               | The GraphQL query to persist                                     |

## Invoking a Persisted Document

To invoke a persisted document, send a POST request to the Delivery API with your project and environment aliases in the URL path. Instead of providing a `query` field, use the `documentId` field with your persisted document alias.

```http
POST /{projectAlias}/{environmentAlias} HTTP/1.1
Host: umbracocompose.com
Content-Type: application/json

{
    "documentId": "x-alias:{persistedDocumentAlias}",
    "variables": {}
}
```

### Parameters

| Parameter                | Description                                                        |
| ------------------------ | ------------------------------------------------------------------ |
| `projectAlias`           | The alias of your Umbraco Compose project                          |
| `environmentAlias`       | The alias of the environment to query                              |
| `persistedDocumentAlias` | The alias you assigned when creating the persisted document        |
| `variables`              | An optional object containing any variables required by your query |

### Example

If you have a persisted document with the alias `get-products` that accepts a `category` variable, invoke it like this:

```http
POST /v1/{your-project}/{your-environment} HTTP/1.1
Host: graphql.germanywestcentral.umbracocompose.com
Content-Type: application/json

{
    "documentId": "x-alias:get-products",
    "variables": {
        "category": "electronics"
    }
}
```

When invoking a persisted document that contains multiple queries, use the `operationName` parameter to specify which query to run:

```http
POST /v1/{your-project}/{your-environment} HTTP/1.1
Host: graphql.germanywestcentral.umbracocompose.com
Content-Type: application/json

{
    "documentId": "x-alias:my-software-names",
    "operationName": "EnglishVariantSoftware"
}
```
