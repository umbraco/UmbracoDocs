---
description: >-
  Referenced content allows content items to be stored independently and linked
  together using references.
---

# Referenced Content

In many cases, your content will reference other content.

For example, consider a blog site. It may have many articles, each of which refers to the author who wrote them.

In one part of your application, such as on an individual article page, an author is queried in the context of an article. However your application may also list all the articles by a single author. Since both articles and authors can be the main "subject" in different contexts, it doesn't make sense to store either as a [nested property](type-schemas.md#nested-properties) of the other.

Instead, both items should be stored independently in Compose and configured to _reference_ one another.

## Defining Content References

You can configure a property in a type schema to reference other content, either a single item or multiple items.

Single item references are established by including a `$ref` field directly on a property configuration object. The value of the `$ref` field should be the type schema alias of the target content.

Multiple item references are similar, except the `$ref` field should be configured beneath the `items` property of the array.

The following example shows both:

* An article type schema that contains a singular reference to an author
* An author type schema that contains an array reference to many articles

{% tabs %}
{% tab title="article" %}
```json
{
    "$schema": "https://umbracocompose.com/v1/schema",
    "allOf": [
        { "$ref": "https://umbracocompose.com/v1/node" }
    ],
    "properties": {
        "title": {
            "type": "string"
        },
        "author": {
            "type": "object",
            "$ref": "author"
        }
    }
}
```
{% endtab %}

{% tab title="author" %}
```json
{
    "$schema": "https://umbracocompose.com/v1/schema",
    "allOf": [
        { "$ref": "https://umbracocompose.com/v1/node" }
    ],
    "properties": {
        "name": {
            "type": "string"
        },
        "articles": {
          "type": "array",
          "items": {
            "type": "object",
            "$ref": "article"
          }
        }
    }
}
```
{% endtab %}
{% endtabs %}

## Ingestion

Ingesting a reference to a content item is done in much the same way as ingesting any other property. The value of the reference property should simply be the id of the content item which is being referred to. In the case of array references, it should instead be an array of all such ids.

For example, to store two articles and their author according to the type schemas defined above, send the following to the Ingestion API:

```json
[
    {
        "id": "1",
        "type": "article",
        "data": {
            "title": "Top 5 Tips & Tricks for Umbraco Compose",
            "author": "3"
        }
    },
    {
        "id": "2",
        "type": "article",
        "data": {
            "title": "Why You'll Never Use Anything Else After Compose!",
            "author": "3"
        }
    },
    {
        "id": "3",
        "type": "author",
        "data": {
            "name": "John C. Ompose",
            "articles": ["1", "2"]
        }
    }
]
```

{% hint style="info" %}
References don't need to go both directions. If you only wish to use the relationship in one direction, then you may wish to save some overhead by only configuring the reference in that direction.

For example, if your application never needs to show a list of all articles by an author, then you might choose to omit the articles property (and therefore reference) from an author.
{% endhint %}

## Retrieval

Retrieving referenced content instances via GraphQL can be done with a fragment. It is up to your query to handle any possible referenced types.

For the article/author scenario, a sample GraphQL query might look like the following.

```graphql
query {
  content {
    items {
      ... on Article {
        title
        author {
          items {
            ... on Author {
              name
            }
          }
        }
      }
    }
  }
}

```
