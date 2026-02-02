---
description: 'REST ingestion guide for Umbraco Compose: upserts, deletes, and bulk payloads.'
---

# RESTful Ingestion

## Upserting

To create or update data in Umbraco Compose, set the `action` parameter on each entry to `upsert`.

This action combines `insert` and `update` functionality. If an entry with a matching `id` already exists in the collection, Umbraco Compose will update it with your new data. If no matching entry is found, Umbraco Compose will create a new entry in the collection.

{% hint style="warning" %}
While it is possible to ingest any valid JSON data, Umbraco Compose will only expose the fields that correspond to the specified type schema. It is, therefore, best practice to only ingest data that is going to be used.
{% endhint %}

```json
[
  {
    "id": "1",
    "type": "software",
    "data": {
      "name": "Umbraco Compose"
    },
    "action": "upsert"
  }
]

```

## Deleting

To delete data from Umbraco Compose, you must specify the `id` of the entry and set the `action` to `"delete"`.

```json
[
  {
    "id": "1",
    "action": "delete"
  }
]
```

## Bulk ingestion

With Umbraco Compose, it is possible to bulk ingest data, which may include both upserts and deletes. This is controlled by the `action` parameter.

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
    "type": "Software",
    "data": {
      "name": "Umbraco Forms"
    },
    "action": "upsert"
  }
]
```
