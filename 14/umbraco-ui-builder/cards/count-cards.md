---
description: Configuring count cards in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Count Cards

Count cards allow you to define cards directly against the [collection](../collections/overview.md) configuration, providing a basic **where clause** to use in a count SQL statement. These work perfectly for basic data visualizations based on counts of entities in a collection.

If you need to do more than a basic count, you'll want to take a look at the [custom cards](custom-cards.md) documentation.

## Adding a count card to a collection

Cards allow you to display basic summaries of key information that may be useful to the editor.

### **AddCard(string name, Lambda whereClauseExpression, Lambda cardConfig = null) : CardConfigBuilder**

Adds a card with the given name and **where clause** filter expression. Expression must be a `boolean` expression.

````csharp
// Example
collectionConfig.AddCard("Older than 30", p => p.Age > 30, cardConfig => {
    ...
});
````

### **AddCard(string name, string icon, Lambda whereClauseExpression, Lambda cardConfig = null) : CardConfigBuilder**

Adds a card with the given name + icon and **where clause** filter expression. Expression must be a `boolean` expression.

````csharp
// Example
collectionConfig.AddCard("Older than 30", "icon-umb-users", p => p.Age > 30, cardConfig => {
    ...
});
````

### Change the color of a count card

#### **SetColor(string color) : CardConfigBuilder**

Sets the color of the card.

````csharp
// Example
cardConfig.SetColor("blue");
````

### Add a suffix to a count value

#### **SetSuffix(string suffix) : CardConfigBuilder**

Sets the suffix of the card value.

````csharp
// Example
cardConfig.SetSuffix("years");
````

### Formatting the value of a count

#### **SetFormat(Lambda formatExpression) : CardConfigBuilder**

Sets the format expression for the card.

````csharp
// Example
cardConfig.SetFormat((v) => $"{v}%");
````
