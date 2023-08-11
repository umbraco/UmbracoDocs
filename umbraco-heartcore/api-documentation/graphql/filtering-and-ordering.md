---
description: Documentation for GraphQL filtering in Umbraco Heartcore.
---

# Filtering and Ordering

The GraphQL API allows for filtering and ordering root and traversion collections (ancestors, children and descendants).

For information on the different filters available and how the filter ad order types are generated see [Schema Generation](schema-generation.md#filtering).

## Using filters

To start filtering the content, an `where` argument can be passed to the collection query. E.g. to find all products where it's price is higher than 100 we can write the following query.

```graphql
query {
  allProduct(
    where: {
      price_gte: 100
    }
  ) {
    edges {
      node {
        name
        price
      }
    }
  }
}
```

Filters can be combined with `AND` and `OR`, e.g. if we want to find all content on level `2` or `3` that is updated after `2020-03-13` we write the following query.

```graphql
query {
  allContent(
    where: {
      AND: [
        { level_any: [2, 3] }
        { updateDate_gt: "2020-09-13" }
      ]
    }
  ) {
    edges {
      node {
        name
      }
    }
  }
}
```

Or if we want to get all of type person which names does not start with `t` we can write the following query.

```graphql
query {
  allContent(
    where: {
      NOT: [
        { name_starts_with: "t" }
      ]
    }
  ) {
    edges {
      node {
        name
      }
    }
  }
}
```

We can combine `AND`, `OR` and `NOT` in a single query e.g. if we wan't to get all content on level `1` or `2` that does not start with `b` or `j` we can write the following query.

```graphql
query {
  allContent(
    where: {
      AND: [
        { level_any: [1, 2] }
        {
          NOT: [
            {
              OR: [
                { name_starts_with: "b" }
                { name_starts_with: "j" }
              ]
            }
          ]
        }
      ]
    }
  ) {
    edges {
      node {
        name
      }
    }
  }
}
```

Filtering can also be applied to types returning `Content` and `Media`, e.g. if we want all content of type `Post` where the author name is `Rasmus`, we can write the following query.

```graphql
query {
  allPosts(where: { author: { name: "Rasmus" } }) {
    edges {
      node {
        name
        url
      }
    }
  }
}
```

## Previewing

The collection can also return draft content by passing the `preview` argument with a boolean to the query. Draft content is always protected and requires an Api-Key.

Lets say we want to show all our products that haven't been published, we can write the following query.

```graphql
query {
  allProduct(
    preview: true
  ) {
    edges {
      node {
        name
      }
    }
  }
}
```

## Ordering

The collection can also be sorted by passing the `orderBy` argument to the query.

If `orderBy` is not specified the collections are ordered by `path` which is the order they appear in, in the Umbraco Backoffice tree.

Lets say we want to show all our products ordered by price in ascending order, we can write the following query.

```graphql
query {
  allProduct(
    orderBy: price_ASC
  ) {
    edges {
      node {
        name
      }
    }
  }
}
```

We can even add multiple values to the `orderBy` argument to order by multiple fields. E.g. if we want to order products by price and then by name, we write the following query.

```graphql
query {
  allProduct(
    orderBy: [ price_ASC, name_ASC ]
  ) {
    edges {
      node {
        name
        price
      }
    }
  }
}
```

## Paging

We can also limit the number of results returned by paging. To achieve this one can use `first` and `after` to do forward paging and `last` and `before` to do backward paging.

The cursor can be obtained by including the `cursor` field on an edge e.g. to get the first `50` products we can write the following query.

```graphql
query {
  allProduct(
    first: 50
  ) {
    edges {
      cursor
      node {
        name
        price
      }
    }
  }
}
```

We can then use the `cursor` from the last item to get items that appear after that one. We can also request the `PageInfo` object which holds information on the start and end cursors and if there are more pages.

{% hint style="info" %}
`first` can only be used in combination with`after`, and `last` can only used with `before`.

Also `hasNextPage` is only populated when doing forward paging and`asPreviousPage` is populated when doing backward paging.
{% endhint %}

```graphql
query {
  allProduct(
    first: 50
  ) {
    edges {
      cursor
      node {
        name
        price
      }
    }
    pageInfo {
      endCursor
      hasNextPage
    }
  }
}
```

## Combining filter, order, and paging

Everything shown up until now can be combined in a single query, the following query will get the first 50 products where the `price` is greater than `100` and order the result in ascending order by `price` and then by `name`.

```graphql
query {
  allProduct(
    first: 50
    where: {
      price_gte: 100
    }
    orderBy: [price_ASC, name_ASC]
  ) {
    edges {
      cursor
      node {
        name
        price
      }
    }
    pageInfo {
      endCursor
      hasNextPage
    }
  }
}
```
