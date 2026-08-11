---
description: >-
  Collections are containers for logically grouping related content within an
  environment, and they define the root scope for GraphQL queries (with optional
  traversal via references and filters).
---

# Collections

A collection in Umbraco Compose is a container for logically grouping related content. There may be one or more collections per [environment](environments.md). The content instances you ingest should be placed into an existing collection of your choice.

## Collection Considerations

When designing your content architecture in Umbraco Compose, you should keep in mind some collection principles.

Requests to the GraphQL API will always target a single collection for the root content that they return. However, it is also possible to retrieve other content in a single query if it is [referenced](referenced-content.md) from an item in the target collection.

GraphQL queries will return all items in the target collection unless they are explicitly [filtered out](../apis/graphql/filtering.md).
