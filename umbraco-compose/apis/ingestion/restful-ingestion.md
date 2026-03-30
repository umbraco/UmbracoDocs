---
description: 'REST ingestion guide for Umbraco Compose: upserts, deletes, and bulk payloads.'
---

# RESTful Ingestion

You can integrate Umbraco Compose with applications that control the payload sent to the Ingestion API.

These scenarios are perfect for standard RESTful ingestion.

If you do not have control over the payload sent by your application, then you may wish to consider using an [Ingestion Function](./functions.md) instead.

## Making an Ingestion Request

The RESTful ingestion endpoint expects an HTTP `PUT` request. The body of the request should be `application/json` and should consist an array of [Ingestion objects](./ingestion-structure.md).

An example of ingesting a single content item might look like the following:

```HTTP
PUT /{project-alias}/{environment-alias}/{collection-alias}
Host: ingest.{region}.umbracocompose.com
Content-Type: application/json
Authorization: Bearer {access-token}

[
  {
    "id": "1",
    "type": "Software",
    "data": {
      "name": "Umbraco Compose"
    },
    "action": "upsert"
  }
]
```
