---
description: >-
  Explains how to filter GraphQL query results in Umbraco Compose using field
  conditions, filter methods, and boolean logic.
---

# Filtering

GraphQL query results can be filtered by specifying a `where` argument.

The value of this argument should be an object with information about the field and the type of filter to apply. For example, to retrieve the name of the product with ID 7 from the `products` collection, use the following query:

```graphql
query {
    products (where: { id: 7 }) {
        items {
            ... on Product {
                id
                name
                price
            }
        }
    }
}
```

## Filter Methods

In the above query, no filter type has been supplied, so GraphQL will default to comparing equality. It is possible to supply a different filter method. Do this by appending a filter suffix separated by an underscore character. Filters can only be applied to supported field types, as shown below:

<details>

<summary>All field types</summary>

| Suffix      | Includes Results When...                         |
| ----------- | ------------------------------------------------ |
| _No suffix_ | The field is equal to a given value              |
| \_any       | The field is equal to any value in a given array |

</details>

<details>

<summary>Numbers &#x26; Datetimes</summary>

| Suffix | Includes Results When...                            |
| ------ | --------------------------------------------------- |
| \_gt   | The field is greater than a given value             |
| \_gte  | The field is greater than or equal to a given value |
| \_lt   | The field is less than a given value                |
| \_lte  | The field is less than or equal to a given value    |

</details>

<details>

<summary>Strings</summary>

| Suffix         | Includes Results When...                |
| -------------- | --------------------------------------- |
| \_contains     | The field contains a given substring    |
| \_starts\_with | The field starts with a given substring |
| \_ends\_with   | The field ends with a given substring   |

</details>

For example, to retrieve all products priced at $10 or more, use the following query:

```graphql
query {
    products (where: { price_gte: 10 }) {
        items {
            ... on Product {
                # Selected fields
            }
        }
    }
}
```

## Filtering by Type

You can filter results to include only content items with a specific type schema. You can do that by specifying only the type schema name as the value of a where clause. For example, to select all content items of type `product` from the `content` collection, you might use the following query:

```graphql
query {
    content (where: product)
    {
        items {
            ... on Product {
                # Selected fields
            }
        }
    }
}
```

## Nested Filtering

You can filter on properties of a nested object. This is done by passing a likewise nested object to the `where` argument. For example, the following query fetches all articles written by authors with specific names.

```graphql
query {
    articles (where: {
        author: {
            name_any: ["John", "Jane"]
        }
    })
    {
        items {
            ... on Article {
                # Selected fields
            }
        }
    }
}
```

## Filter Logic

Queries can also combine or invert filters using boolean operators.

```graphql
query {
    authors (where: {
        AND: [
            { firstName: "John" },
            { lastName: "Doe" }
        ]
    })
    {
        items {
            ... on Author {
                # Selected fields
            }
        }
    }
}
```

The boolean operators themselves may be nested inside of one another to create complex filters.
