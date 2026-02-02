---
description: >-
  Type schemas represent the structure of your content. They describe which
  properties exist on a content type, and which other types it might relate to.
---

# Type Schemas

Type schemas are defined using [JSON schema](https://json-schema.org/) notation in the Management API.

## Minimal Example

A minimal type schema representing a generic named object might look like the following:

```json
{
    "$schema": "https://umbracocompose.com/v1/schema",
    "allOf": [{
        "$ref": "https://umbracocompose.com/v1/node"
    }],
    "properties": {
        "name": {
            "type": "string"
        }
    }
}
```

## Required Components

At this time, it is necessary to include three components in every Umbraco Compose type schema:

* **Schema definition**: The `$schema` property of a type schema must have a value of `https://umbracocompose.com/{version}/schema`, where version represents a set of rules against which the schema will be validated. These rules may change over time, but breaking changes will only come alongside a new version of the schema.
* **Node schema reference**: Compose type schemas must include a reference to the inbuilt Node "base" type in the `allOf` array. This declaration tells Compose to include fundamental properties such as the ID and variant for an item, without you having to declare them yourself.
* **Property data**: Information about available properties of the type. While it is possible for a type to contain no properties, most use-cases will require defining some.

## Properties

Properties define the fields available on your content type. Each property requires:

* A **name** (the property key in the JSON)
* A **type** (one of the supported types below)

Properties must have a static type. The following types are supported:

| Property type | Description                                                                                                           |
| ------------- | --------------------------------------------------------------------------------------------------------------------- |
| string        | Text values of any length, including letters, numbers, and special characters (e.g., "Product Name").                 |
| integer       | Whole numbers without decimal points (e.g., -1, 0, 42, 1000).                                                         |
| number        | Numeric values that can include decimals, supporting both integers and floating-point numbers (e.g., 3.14, 42, -7.5). |
| boolean       | True or false values.                                                                                                 |
| array         | A list of values. Use the `items` property to define the type of elements in the array.                               |
| object        | Used for nested properties or references to other content.                                                            |

### String Formats

String properties can specify a `format` to indicate the expected data format:

| Format        | Description                                      |
| ------------- | ------------------------------------------------ |
| date          | Date without time (ISO 8601, e.g., "2024-01-15") |
| date-time     | Date with time (ISO 8601)                        |
| time          | Time without date                                |
| html          | HTML markup content                              |
| uuid          | UUID/GUID identifier                             |
| uri           | Absolute URI                                     |
| uri-reference | Relative or absolute URI                         |

Example:

```json
{
  "publishDate": { "type": "string", "format": "date" },
  "createdAt": { "type": "string", "format": "date-time" },
  "website": { "type": "string", "format": "uri" }
}
```

## Nested Properties

Properties may be nested within other properties. This allows you to group related fields together, creating a clear hierarchy in your data structure.

To configure nested properties, you can define a `properties` block on a higher-level property. The higher-level property must have its `type` set to `"object"`. For example:

```json
    "$schema": "https://umbracocompose.com/v1/schema",
    "allOf": [{
        "$ref": "https://umbracocompose.com/v1/node"
    }],
    "properties": {
        "address": {
            "type": "object",
            "properties": {
                "streetLine1": {
                    "type": "string"
                }
            }
        }
    }
```

{% hint style="info" %}
Nested properties are not limited to immediately under the root. It is possible to define nested properties on other properties that are themselves nested.
{% endhint %}

## Composing Type Schemas

There are different ways in which you can combine different type schemas in order to reduce complexity. This can streamline either the schemas themselves or the GraphQL queries your applications make.

### Named Partial Type Schemas (`$defs`)

You can define re-usable parts of a type schema using a named definition. The `$defs` property of your type schema is a map of named partial type schemas. Other properties may refer to these partial schemas using the `$ref` property in conjunction with a reference to the `$def`.

For example, to re-use an address schema, you might do the following:

```json
{
    "$schema": "https://umbracocompose.com/v1/schema",
    "allOf": [
        { "$ref": "https://umbracocompose.com/v1/node" }
    ],
    "properties": {
        "physicalAddress": { "$ref": "#/$defs/Address" },
        "mailingAddress": { "$ref": "#/$defs/Address" }
    },
    "$defs": {
        "Address": {
            "type": "object",
            "properties": {
                "streetName": { "type": "string" },
                "streetNumber": { "type": "string" },
                "city": { "type": "string" }
            }
        }
    }
}
```

Likewise, it is possible to use `$defs` for types in an array property:

```json
{
    "$schema": "https://umbracocompose.com/v1/schema",
    "allOf": [
        { "$ref": "https://umbracocompose.com/v1/node" }
    ],
    "properties": {
        "addresses": {
            "type": "array",
            "items": { "$ref": "#/$defs/Address" }
        }
    },
    "$defs": {
        "Address": {
            "type": "object",
            "properties": {
                "streetName": { "type": "string" },
                "streetNumber": { "type": "string" },
                "city": { "type": "string" }
            }
        }
    }
}
```

### Referenced Content

It is possible to compose two types of schemas in such a way that:

* Content instances that use the types are stored (and can be updated) independently of one another, _but_
* When retrieved, one may be embedded inside the other.

This is most useful when content comes from different source systems, but you would like to combine it into a single unified response.

For example, consider a scenario in which `Article` objects originate in one system, but `Author` information is stored in another. You might use the following two type schemas:

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
        "firstName": {
            "type": "string"
        },
        "lastName": {
            "type": "string",
        }
    }
}
```
{% endtab %}
{% endtabs %}

See [Referenced Content](referenced-content.md) for more information about how to define and query referenced content properties.

## Delivery Properties

It is possible to configure some of how GraphQL returns your content by specifying a `$delivery` section on your property.

For example, to ingest content with one property name but retrieve it using a different one, then you can specify the `fieldName` delivery property.

The following Type Schema expects the `sku` field to be defined when instances are created. However, when queried via GraphQL, no `sku` field will be available. Rather, that field will be called `productName`.

```json
{
    "$schema": "https://umbracocompose.com/v1/schema",
    "allOf": [
      { "$ref": "https://umbracocompose.com/v1/node" }
    ],
    "properties": {
        "sku": {
            "type": "string",
            "$delivery": {
                "fieldName": "productName"
            }
        }
    }
}
```

The following delivery properties are available:

| Property      | Description                                                                                                                                                                                  |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| expose        | Determines whether the property is exposed by GraphQL or remains internal to the platform. Set this to `false` to prevent the property from being returned from GraphQL. Defaults to `true`. |
| fieldName     | Allows you to override the name of the property in GraphQL. Defaults to the name of the property.                                                                                            |
| refCollection | Controls which collection from which referenced content will be retrieved. Defaults to the current collection if not specified.                                                              |

## Further Reading

For more information about defining Type Schemas, refer to the [JSON schema documentation](https://json-schema.org/docs).
