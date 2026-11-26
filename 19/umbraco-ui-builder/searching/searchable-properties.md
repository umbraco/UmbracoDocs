---
description: Configure searchable properties in Umbraco UI Builder.
---

# Searchable Properties

Searchable properties allow you to define any `String` based properties in a model. It can be searched via Umbraco UI Builder's list view and entity picker search controls.

Both direct `String` properties and `String` properties within nested objects can be made searchable, provided the parent object is not `null`.

![Search](../.gitbook/assets/search.png)

## Defining Searchable Properties

### Using `AddSearchableProperty()` Method

Use `AddSearchableProperty` to specify which properties should be included in search functionality.

#### Method Syntax

```cs
AddSearchableProperty(Lambda searchablePropertyExpression) : CollectionConfigBuilder<TEntityType>
```

#### Example

```cs
collectionConfig.AddSearchableProperty(p => p.FirstName);
collectionConfig.AddSearchableProperty(p => p.Address.Street);
```

## Search Expression Pattern

By default, search uses the `StartsWith` method, so results include entries that begin with the search term. To match the search term anywhere within the property value, use the `Contains` search expression pattern.

### Example

```csharp
collectionConfig.AddSearchableProperty(p => p.FirstName); // will search for keywords that start with.
collectionConfig.AddSearchableProperty(p => p.FirstName, SearchExpressionPattern.Contains); // will search for keywords that are contained.
```
