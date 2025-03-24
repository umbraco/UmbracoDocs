---
description: Learn how to configure custom cards in Umbraco UI Builder.
---

# Custom Cards

Custom cards enable more complex metric calculations and are defined by a class that implements the `Card` base class.

When Umbraco UI Builder resolves a card, it tries to do so from the global DI container. This means you can inject any dependencies required for the card's value calculation. If no type is found in the DI container, Umbraco UI Builder will fall back to manually instantiating a new instance of the value mapper.

## Defining a Custom Card

To define a custom card, create a class that inherits from the base class `Card` and configure it in the constructor as shown below:

````csharp
// Example
public class AvgPersonAgeCard : Card
{
    public override string Alias => "avgPersonAge";
    public override string Name => "Average Age";
    public override string Icon => "icon-calendar";
    public override string Color => "green";
    public override string Suffix => "yrs";
        
    public override object GetValue(object parentId = null)
    {
        // Perform value calculation logic
    }
}
````

The required configuration options are:

* **Name:** The name of the card.
* **Alias:** A unique alias for the card.
* **GetValue(object parentId = null):** A method to retrieve the card's value.

The optional configuration options are:

* **Icon:** An icon displaed in the card.
* **Color:** The color of the card.
* **Suffix:** The suffix displayed after the card value.

## Adding a Custom Card to a Collection

### Using the `AddCard()` Method

Adds a custom card of the specified type to the collection.

#### Method Syntax

```cs
AddCard() : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.AddCard<AvgPersonAgeCard>();
````

### Using the `AddCard(Type cardType)` Method

Adds a custom card of the specified type to the collection, using the `Type` parameter to pass the card type dynamically.

#### Method Syntax

```cs
AddCard(Type cardType) : CollectionConfigBuilder<TEntityType>
```

#### Example

````csharp
collectionConfig.AddCard(typeof(AvgPersonAgeCard));
````
