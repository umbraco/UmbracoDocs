---
description: >-
  Explains how to sort GraphQL query results using single, multiple, and nested
  `orderBy` criteria.
---

# Sorting

You can sort GraphQL query results by specifying an `orderBy` argument.

The argument takes an array of sort criteria. Each item in the array specifies the type schema alias, field to sort on, and the direction. Use `ASC` for ascending order or `DESC` for descending order.

For example, to sort all products by the alphabetical order of their names, use the following query:

```graphql
query {
    products (orderBy: [{ product: { name: ASC }}]) {
        items {
            ... on Product {
                # requested fields
            }
        }
    }
}
```

When sorting by a Compose system field such as `id` or `variant`, the type schema alias should be omitted.

```graphql
query {
    products (orderBy: [{ id: DESC }]) {
        items {
            ... on Product {
                # requested fields
            }
        }
    }
}
```

## Sorting on Multiple Fields

You can specify multiple sort criteria. Criteria earlier in the array take precedence. Later sorts apply only when earlier values are equal.

For example, to order products alphabetically by category, then by name, use the following query:

```graphql
query {
    products (orderBy: [
        { product: { category: ASC }}
        { product: { name: ASC }}
    ])
    {
        items {
            ... on Product {
                # requested fields
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
        book: {
            author: {
                name: ASC
            }
        }
    }])
    {
        items {
            ... on Book {
                # requested fields
            }
        }
    }
}
```

## Sorting Behaviour

You can sort on fields of type integer, number, string, and boolean. Arrays and objects cannot be sorted on directly.

Null values are placed first for ascending sorts and last for descending sorts.

A collection can contain items of more than one type schema. When you sort on a field of a specific type, results are grouped by type schema first. The groups follow the order in which the types appear in the `orderBy` array.
