---
description: >-
  Introduces how to access and query content from Umbraco Compose using the
  GraphQL API.
---

# GraphQL

The primary way of serving content from Umbraco Compose to your applications is via the GraphQL API.

You can access the API at [GraphQL API endpoint](https://graphql.germanywestcentral.umbracocompose.com).

The API accepts POST requests with the content type `application/json`. The body must be JSON and include a `query` field containing your GraphQL query as a string. The request body may optionally include variables.

## Authentication

To authenticate with the GraphQL API, you need an API key with the correct scopes. You can read more about generating and using API keys in the [Access Control](../../getting-started/access-control.md) article.

## Queries & Collections

The root object in the GraphQL schema contains one property per collection in the environment. Properties are named after the collection alias in camelCase, with dash characters removed.

For example, a collection with the alias `product-data` will be represented on the root GraphQL object by a property called `productData`.

Each root object property contains a list property called `items`. It includes all valid content items in the collection.
