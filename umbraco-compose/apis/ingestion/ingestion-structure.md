---
description: >-
  An overview of available operations for modifying ingested content.
---

# Ingestion Structure

To modify any content in Compose, it needs to be provided with a data structure to describe the changes that should be made. Whether your applications use the standard [RESTful Ingestion](./restful-ingestion.md) endpoint or an [Ingestion Function](./functions.md), the ingestion payload has the same structure.

The Ingestion data structure is a JSON object that contains the following properties.

| Property     | Type              | Description                                                                                                                                |
| ------------ | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `action`     | String            | An [Action](#actions) specifying how you would like to modify the content item represented by this ingestion.                 |
| `id`         | String            | Canonical identifier for the content.                                                                                                      |
| `variant`    | String (optional) | Variant key for the content.                                                                                                               |
| `type`       | String            | Type schema alias for the desired type.                                                                                                    |
| `data`       | Object            | Body of the content.                                                                                                                       |
| `operations` | Object            | Should only be specified when action is `patch`. A JSON Patch ([Request for Comments (RFC) #6902](https://datatracker.ietf.org/doc/html/rfc6902/)) compliant array of operations to mutate an existing content item. |

Even when making changes to a single content item, Ingestions are always supplied in an array.

## Bulk Ingestion

It is possible to modify many content items in a single request or function. To do so, include more than one Ingestion item in the array. Not all items need to have the same action, so it is even possible to add, modify, or remove different items in the same request!

For example:

```json
[
  {
    "id": "1",
    "type": "Software",
    "data": {
      "name": "Umbraco Compose"
    },
    "action": "upsert"
  },
  {
    "id": "5",
    "action": "delete"
  },
  {
    "id": "4",
    "data": {
      "name": "Umbraco Forms"
    },
    "action": "merge-patch"
  }
]
```

## Actions

A range of actions are available for modifying content in Compose.

### `upsert`

This action combines "insert" and "update" functionality. If an entry with a matching `id` already exists in the collection, Umbraco Compose will update it with the object specified in the `data` property. If no matching entry is found, then a new content item will instead be created in the specified collection.

The following ingestion example will result in the existence of a content item called "Umbraco CMS", with an `id` of `"1"`. If an item with that `id` previously existed, it has now been overwritten.

```json
[
  {
    "id": "1",
    "type": "software",
    "data": {
      "name": "Umbraco CMS"
    },
    "action": "upsert"
  }
]
```

### `delete`

This action removes an item with a given `id` and optional `variant` from Umbraco Compose. Only these properties and the `action` should be supplied.

If no such item exists already, then the `delete` operation is a no-op.

```json
[
  {
    "id": "1",
    "action": "delete"
  }
]
```

### `patch`

This action applies an [RFC 6902 JSON Patch](https://datatracker.ietf.org/doc/html/rfc6902/) document to mutate an existing content item.

When using the `patch` action, an ingestion must also supply an array of [patch operations](https://datatracker.ietf.org/doc/html/rfc6902/#section-4) to the `operations` property. These will be used to sequentially modify the item with a given `id` and optional `variant`.

The following ingestion payload adds a `newProperty` to the content item and removes an `oldProperty`.

```json
[
  {
    "id": "1",
    "action": "patch",
    "operations": [
      { "op": "add", "path": "/newProperty", "value": "example" },
      { "op": "remove", "path": "/oldProperty" }
    ]
  }
]
```

For more information about available JSON Patch operations, refer to [its documentation](https://jsonpatch.com/#operations).

A limitation of JSON Patch is that the client application needs to know in advance whether to `add` or `replace` a given property. Attempting to `add` a property that already exists, or to `replace` one that doesn't, will fail to process the ingestion.

### `merge-patch`

To avoid the limitation of JSON Patch above, Umbraco Compose also supports [RFC 7386 JSON Merge Patch](https://datatracker.ietf.org/doc/html/rfc7386).

Using this action, the object in the `data` property of the ingestion will be merged into an existing document according to the rules in the specification.

The following ingestion payload adds a `newProperty` to the content item and removes an `oldProperty`. Unlike the `patch` action, this will not fail if `newProperty` exists or `oldProperty` doesn't.

```json
[
  {
    "id": "1",
    "action": "merge-patch",
    "data": {
      "newProperty": "example",
      "oldProperty": null
    }
  }
]
```

## Type Schemas and Content

Umbraco Compose requires that you define [Type Schemas](../../content-orchestration/type-schemas.md) that specify the structure of your content.

When ingesting content you specify the type schema of an item via the `type` property. Compose will not perform any synchronous validation to ensure that the supplied content matches the type schema. Fields omitted from the type schema cannot be retrieved via GraphQL, even if content instances contain values for those fields.

This is by design to support scenarios in which source systems cannot guarantee message ordering.
