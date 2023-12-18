---
description: Configuring custom cards in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Custom Cards

Custom cards allow you to perform more complex metric calculations and are defined via a class implementing the `Card` base class.

When Umbraco UI Builder resolves a card it will attempt to do so from the global DI container. This means you can inject any dependencies that you require for your card to calculate its value. If there is no type defined in the DI container, Umbraco UI Builder will fall-back to manually instantiating a new instance of value mapper.

## Defining a custom card

To define a card you create a class that inherits from the base class `Card` and configure it within the constructor like so.

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
* **GetValue(object parentId = null):** A method to get the cards value.

Additional optional configuration options are:

* **Icon:** An icon to display in the card.
* **Color:** The color of the card.
* **Suffix:** A suffix to display after the card value.

## Adding a custom card to a collection

### **AddCard<TCardType>() : CollectionConfigBuilder&lt;TEntityType&gt;**

Adds a card of the given type to the collection.

````csharp
// Example
collectionConfig.AddCard<AvgPersonAgeCard>();
````

### **AddCard(Type cardType) : CollectionConfigBuilder&lt;TEntityType&gt;**

Adds a card of the given type to the collection.

````csharp
// Example
collectionConfig.AddCard(typeof(AvgPersonAgeCard));
````
