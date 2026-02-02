---
description: >-
  Aliases identify Management API entities. Learn the naming rules, validation
  constraints, and reserved values that you cannot use.
---

# Aliases

All Management API entities can be identified by an alias.

Aliases must typically be unique within a given scope, most often per-environment.

## Alias Validation

All aliases must comply with the following:

* Contain at least 3 characters, and no more than 255.
* Contain only ASCII letters, digits, and dash `-` characters.
* Not start with a number.
* Not start or end with a dash `-` character, nor contain multiple dashes in a row.
* Not be on the [reserved list](aliases.md#reserved-aliases).

In addition to the above, project and environment aliases must not contain upper-case ASCII letters.

## Reserved Aliases

The following are reserved values that may not be used when providing an alias for any Management API entity.

<details>

<summary>Reserved Aliases</summary>

* BigInt
* Boolean
* Byte
* Collection
* ComplexScalar
* Date
* DateOnly
* DateTime
* DateTimeOffset
* Decimal
* Float
* Guid
* Half
* HTML
* Id
* Int
* JSON
* LinkImport
* LinkPurpose
* Long
* Mutation
* Node
* NodeConnection
* NodeEdge
* NodeFilterInput
* PageInfo
* Query
* SByte
* Scalar
* Short
* String
* Subscription
* TimeOnly
* TimeSpanMilliseconds
* TimeSpanSeconds
* UInt
* Umbraco
* ULong
* UShort
* Uri

</details>
