---
description: >-
  Explains how to sort GraphQL query results using single, multiple, and nested
  `orderBy` criteria.
---

# Sorting

You can sort GraphQL query results by specifying an `orderBy` argument.

The value of this argument should be an array of objects that specify a property to sort by and a sort direction. For example, to sort all products by the alphabetical order of their names, use the following query:

```graphql
query {
    products (orderBy: [{ name: ASC }]) {
        items {
            ... on Product {
                id
                name
                category
            }
        }
    }
}
```

Use `ASC` for ascending order or `DESC` for descending order.

## Multiple Sorting

It is possible to specify multiple sort criteria. Results are ordered first by properties defined earlier in the array. Later properties apply only when higher-priority values are equal.

For example, to order products alphabetically by category, then by name, use the following query:

```graphql
query {
    products (orderBy: [
        { category: ASC }
        { name: ASC }
    ])
    {
        items {
            ... on Product {
                id
                name
                category
            }
        }
    }
}
```

## Nested Sorting

You can also sort by nested properties using an object with the same nesting structure.

For example, to order books by the name of their author, use the following query:

```graphql
query {
    books (orderBy: [{
        author: {
            name: ASC
        }
    }])
    {
        items {
            ... on Book {
                name
                author {
                    name
                }
            }
        }
    }
}
```
