---
description: Configuring count cards in Konstrukt, the backoffice UI builder for Umbraco.
---

# Count Cards

Count cards allow you to define cards directly against the [collection](../collections/overview.md) configuration, providing a basic where clause to use in a count SQL statement. These work perfectly for simple data visualizations based on simple counts of entities in a collection.

If you need to do more than a simple count, you'll want to take a look at the [custom cards](custom-cards.md) documentation.

## Adding a count card to a collection

Cards allow you to display simple summaries of key information that may be useful to the editor.

#### **AddCard(string name, Lambda whereClauseExpression, Lambda cardConfig = null) : KonstruktCardConfigBuilder**

Adds a card with the given name and where clause filter expression. Expression must be a `boolean` expression.

````csharp
// Example
collectionConfig.AddCard("Older than 30", p => p.Age > 30, cardConfig => {
    ...
});
````

#### **AddCard(string name, string icon, Lambda whereClauseExpression, Lambda cardConfig = null) : KonstruktCardConfigBuilder**

Adds a card with the given name + icon and where clause filter expression. Expression must be a `boolean` expression.

````csharp
// Example
collectionConfig.AddCard("Older than 30", "icon-umb-users", p => p.Age > 30, cardConfig => {
    ...
});
````

### Change the color of a count card

#### **SetColor(string color) : KonstruktCardConfigBuilder**

Sets the color of the card.

````csharp
// Example
cardConfig.SetColor("blue");
````

### Add a suffix to a count value

#### **SetSuffix(string suffix) : KonstruktCardConfigBuilder**

Sets the suffix of the card value.

````csharp
// Example
cardConfig.SetSuffix("years");
````

### Formatting the value of a count

#### **SetFormat(Lambda formatExpression) : KonstruktCardConfigBuilder**

Sets the format expression for the card.

````csharp
// Example
cardConfig.SetFormat((v) => $"{v}%");
````