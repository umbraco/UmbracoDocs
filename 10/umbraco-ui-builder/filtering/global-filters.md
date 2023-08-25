---
description: Configuring a global filter in Konstrukt, the back office UI builder for Umbraco.
---

# Global Filters

Sometimes you may only want to work with a sub-set of data within a given collection so this is where the global filters comes in handy. These allow you to define a filter to apply to all queries for a given collection.

## Applying a global filter

Applying a global filter is controlled via the [collections](../collections/overview.md) configuration.

#### **SetFilter(Lambda whereClauseExression) : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Sets the filter where clause expression. Expression must be a `boolean` expression.

````csharp
// Example
collectionConfig.SetFilter(p => p.Current);
````