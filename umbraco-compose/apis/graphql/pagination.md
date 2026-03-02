---
description: >-
  Explains how pagination and query complexity limits work in the Umbraco
  Compose GraphQL API.
---

# Pagination

GraphQL queries in Umbraco Compose support two different pagination approaches depending on the type of data being paginated:

* **Cursor-based pagination** for references (connections)
* **Index-based pagination** for nested/embedded arrays

{% hint style="info" %}
The page size is limited to a maximum of 100 items per page. If you request more than 100 items, the API will return an error. The default page size is 10 items per page.
{% endhint %}

## Connections

Pagination for references follows the Relay Connection specification and supports forward pagination using the `first` and `after` arguments.

To paginate through all results, use the `endCursor` from the previous response as the `after` argument in your next request. You can see if there are more pages by checking that `hasNextPage` is `true`.

{% tabs %}
{% tab title="GraphQL" %}
{% code lineNumbers="true" %}
```graphql
query($cursor: String) {
  allContent(
    first: 2
    after: $cursor
  ) {
    items {
      id
    }
    pageInfo {
      endCursor
      hasNextPage
    }
  }
}
```
{% endcode %}
{% endtab %}

{% tab title="Response" %}
{% code lineNumbers="true" %}
```json
{
  "data": {
    "allContent": {
      "items": [{
        "id": "abc"
      }, {
        "id": "abc123"
      }],
      "pageInfo": {
        "endCursor": "eyAiaWQiOiAiYWJjMTIzIiwgInZhcmlhbnQiOiBudWxsLCAiX190eXBlU2NoZW1hQWxpYXMiOiAicGFnZSIgfQo=",
        "hasNextPage": true
      }
    }
  }
}
```
{% endcode %}
{% endtab %}
{% endtabs %}

{% hint style="warning" %}
The returned cursor is only valid for the specified [`orderBy`](sorting.md) fields. Changing them invalidates existing cursors for the new fields. You must request a new cursor from `{ edge { cursor } }` field, or the page info's `startCursor` or `endCursor` fields.
{% endhint %}

## Lists

For nested or embedded arrays, `skip` and `first` can be used for pagination.

{% tabs %}
{% tab title="GraphQL" %}
{% code lineNumbers="true" %}
```graphql
query {
  allContent(
    first: 2
  ) {
    items {
      id
      ... on Page {
        blocks(skip: 5, first: 2) {
          ... on Banner {
            name
          }
        }
      }
    }
  }
}
```
{% endcode %}
{% endtab %}

{% tab title="Response" %}
{% code lineNumbers="true" %}
```json
{
  "data": {
    "allContent": {
      "items": [{
        "id": "abc",
        "blocks": [{
          "name": "Block 6"
        },{
          "name": "Block 7"
        }]
      }]
    }
  }
}
```
{% endcode %}
{% endtab %}
{% endtabs %}

## Complexity Limits

The GraphQL API implements a complexity-based rate-limiting system. Each scalar field adds 1 to the cost. Each reference level adds 1 to the scalar cost, multiplied by the number of items fetched in a collection. For example, if you limit your query to fetch `5` items and `3` fields, the total cost is `15`.

The total complexity cost is limited to 15.000.

{% hint style="info" %}
The cost is calculated before the query is executed. It is based on the potential number of items and not the actual items returned from a query.
{% endhint %}

The total cost of a query is returned in the `Umb-GraphQL-Query-Cost` response header.

When a query exceeds this limit, the API will return an error:

```json
{
  "errors": [
    {
      "message": "Query is too complex to execute. Complexity is 32102; maximum allowed on this endpoint is 15000.",
      "extensions": {
        "code": "COMPLEXITY",
        "codes": [
          "COMPLEXITY"
        ]
      }
    }
  ]
}
```

Optimize your queries using one or more of the options listed below:

* Reduce the number of fields requested.
* Limit the depth of nested references.
* Use pagination to reduce the number of items retrieved per query.

## Error Handling

When making pagination requests, it is worth keeping an eye out for the following pitfalls:

* Requesting more than 100 items per page will result in an error.
* Using invalid cursors will result in an error.
* Invalid `skip` or `first` values (for example, negative numbers) will result in errors.

Example GraphQL error response for an invalid page size:

```json
{
  "errors": [
    {
      "message": "Invalid value for argument 'first' of field 'content'. Value cannot be greater than 100",
      "locations": [
        {
          "line": 2,
          "column": 18
        }
      ],
      "extensions": {
        "code": "INVALID_VALUE",
        "codes": [
          "INVALID_VALUE"
        ],
        "number": "5.6"
      }
    }
  ]
}
```
