---
description: Learn how to configure a global filter in Umbraco UI Builder.
---

# Global Filters

Use global filters to work with a specific subset of data within a collection. These filters apply to all queries for a given collection.

## Applying a Global Filter

Configure global filters in the [Collections](../collections/overview.md) settings.

### Using the `SetFilter()` Method

Defines a filter using a **where clause** expression. The expression must return a `boolean` value.

#### Method Syntax

```cs
SetFilter(Lambda whereClauseExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.SetFilter(p => p.Current);
````
