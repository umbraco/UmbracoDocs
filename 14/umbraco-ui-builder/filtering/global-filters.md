---
description: Configuring a global filter in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Global Filters

If you want to work with a subset of data within a given collection then this is where the global filters come in handy. These allow you to define a filter to apply to all queries for a given collection.

## Applying a global filter

Applying a global filter is controlled via the [collections](../collections/overview.md) configuration.

### **SetFilter(Lambda whereClauseExpression) : CollectionConfigBuilder&lt;TEntityType&gt;**

Sets the filter **where clause** expression. Expression must be a `boolean` expression.

````csharp
// Example
collectionConfig.SetFilter(p => p.Current);
````
