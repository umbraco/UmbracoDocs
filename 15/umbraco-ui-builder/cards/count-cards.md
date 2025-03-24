---
description: Learn how to configure count cards in Umbraco UI Builder.
---

# Count Cards

Count cards allow you to define cards directly against the [Collection](../collections/overview.md) configuration, providing a basic **where clause** to use in a count SQL statement. These work perfectly for basic data visualizations based on counts of entities in a collection.

If you need to do more than a basic count, see the [Custom Cards](custom-cards.md) article.

## Adding a Count Card to a Collection

Count cards display basic summaries of key information that may be useful to the editor.

### Using the `AddCard()` Method

Adds a count card with the specified name and a where clause filter expression. The filter expression must be a `boolean` value.

#### Method Syntax

```cs
AddCard(string name, Lambda whereClauseExpression, Lambda cardConfig = null) : CardConfigBuilder
```

#### Example

````csharp
collectionConfig.AddCard("Older than 30", p => p.Age > 30, cardConfig => {
    ...
});
````

### Using the `AddCard()` Method with Icon

Adds a count card with the specified name, an icon, and a where clause filter expression. The filter expression must be a `boolean` value.

#### Method Syntax

```cs
AddCard(string name, string icon, Lambda whereClauseExpression, Lambda cardConfig = null) : CardConfigBuilder
```

#### Example

````csharp
collectionConfig.AddCard("Older than 30", "icon-umb-users", p => p.Age > 30, cardConfig => {
    ...
});
````

### Change the Color of a Count Card

#### Using the `SetColor()` Method

Sets the color for the count card.

#### Method Syntax

```cs
SetColor(string color) : CardConfigBuilder
```

#### Example

````csharp
cardConfig.SetColor("blue");
````

### Add a Suffix to a Count Value

#### Using the `SetSuffix()` Method

Sets a suffix to be displayed alongside the card value.d

#### Method Syntax

```cs
SetSuffix(string suffix) : CardConfigBuilder
```

#### Example

````csharp
cardConfig.SetSuffix("years");
````

### Formatting the Value of a Count

#### Using the `SetFormat()` Method

Sets a custom format for the card's value.

#### Method Syntax

```cs
SetFormat(Lambda formatExpression) : CardConfigBuilder
```

#### Example

````csharp
cardConfig.SetFormat((v) => $"{v}%");
````
