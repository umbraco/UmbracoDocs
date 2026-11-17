---
description: Learn how to configure custom cards in Umbraco UI Builder.
---

# Custom Cards

Custom cards enable more complex metric calculations and are defined by a class that implements the `Card` base class.

When Umbraco UI Builder resolves a card, it tries to do so from the global DI container. This means you can inject any dependencies required for the card's value calculation. If no type is found in the DI container, Umbraco UI Builder will fall back to manually instantiating a new instance of the value mapper.

## Defining a Custom Card

To define a custom card, create a class that inherits from the base class `Card`. Override `GetValueAsync` to calculate the card's value.

The following card shows the average age of the people in a `people` collection. The card uses a `Person` model with an `int` ID, an `Age` property, and a `TeamId` property.

{% code title="AvgPersonAgeCard.cs" %}
```csharp
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Threading.Tasks;
using MyProject.Models;
using Umbraco.UIBuilder.Configuration.Cards;
using Umbraco.UIBuilder.Persistence;

namespace MyProject.Cards;

public class AvgPersonAgeCard : Card
{
    private readonly IRepositoryFactory _repositoryFactory;

    public AvgPersonAgeCard(IRepositoryFactory repositoryFactory)
        => _repositoryFactory = repositoryFactory;

    public override string Alias => "avgPersonAge";
    public override string Name => "Average Age";
    public override string Icon => "icon-calendar";
    public override string Color => "green";
    public override string? Suffix => "yrs";

    public override async Task<object?> GetValueAsync(object? parentId = null, CancellationToken cancellationToken = default)
    {
        // In a child collection, only count the people of the parent team
        Expression<Func<Person, bool>>? whereClause = null;
        if (parentId is not null && int.TryParse(parentId.ToString(), out int teamId))
        {
            whereClause = x => x.TeamId == teamId;
        }

        var result = await _repositoryFactory
            .GetRepository<Person, int>("people")
            .GetAllAsync(whereClause, cancellationToken: cancellationToken);

        if (!result.Success || result.Model is null || !result.Model.Any())
        {
            return 0;
        }

        return Math.Round(result.Model.Average(x => x.Age), 1);
    }
}
```
{% endcode %}

The `parentId` parameter holds the ID of the parent entity, or `null` when there is no parent. The value is the ID as the backoffice sends it, usually a string. It is not converted to the type of the parent's ID.

Umbraco UI Builder only calls `GetValueAsync`. By default, `GetValueAsync` calls `GetValue`, so a card that only overrides `GetValue` keeps working. Override `GetValueAsync` when the card awaits anything. A card that overrides neither method throws a `NotImplementedException`.

### Configuration Options

| Option | Description | Required |
| --- | --- | --- |
| `Name` | The name of the card. | Yes |
| `Alias` | A unique alias for the card. | Yes |
| `GetValueAsync(object? parentId = null, CancellationToken cancellationToken = default)` | A method to retrieve the card's value. | Yes, or `GetValue` |
| `GetValue(object? parentId = null)` | The synchronous version of `GetValueAsync`. | Yes, or `GetValueAsync` |
| `Icon` | An icon displayed in the card. | No |
| `Color` | The color of the card. | No |
| `Suffix` | The suffix displayed after the card value. | No |

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
