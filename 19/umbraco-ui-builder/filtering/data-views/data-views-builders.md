---
description: Learn how to configure data views builders in Umbraco UI Builder.
---

# Data Views Builders

Data views builders allow you to create a collection’s data views dynamically at runtime. By default, Umbraco UI Builder uses hard-coded data views from the configuration. However, if you need to generate data views dynamically, a data views builder is required.

When resolving a data views builder, Umbraco UI Builder first attempts to retrieve it from the global Dependency Injection (DI) container. This allows injecting required dependencies into the builder. If no type is defined in the DI container, Umbraco UI Builder falls back to manually instantiating a new instance of the value mapper.

## Defining a Data Views Builder

To define a data views builder, create a class that inherits from `DataViewsBuilder<TEntityType>`. Override `GetDataViewsAsync` and `GetDataViewWhereClause`.

The following builder adds a data view for each team in a `teams` collection. Each data view lists the people of one team. The builder uses a `Team` model with an `int` ID and a `Name`, and a `Person` model with a `TeamId` property.

{% code title="PersonDataViewsBuilder.cs" %}
```csharp
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Threading.Tasks;
using MyProject.Models;
using Umbraco.UIBuilder.Configuration.Builders.DataViews;
using Umbraco.UIBuilder.Models;
using Umbraco.UIBuilder.Persistence;

namespace MyProject.DataViews;

public class PersonDataViewsBuilder : DataViewsBuilder<Person>
{
    private const string AliasPrefix = "team-";

    private readonly IRepositoryFactory _repositoryFactory;

    public PersonDataViewsBuilder(IRepositoryFactory repositoryFactory)
        => _repositoryFactory = repositoryFactory;

    public override async Task<IEnumerable<DataViewSummary>> GetDataViewsAsync(CancellationToken cancellationToken = default)
    {
        var result = await _repositoryFactory
            .GetRepository<Team, int>("teams")
            .GetAllAsync(orderBy: x => x.Name, cancellationToken: cancellationToken);

        if (!result.Success || result.Model is null)
        {
            return [];
        }

        return result.Model.Select(team => new DataViewSummary
        {
            Name = team.Name,
            Alias = AliasPrefix + team.Id.ToString(CultureInfo.InvariantCulture),
            Group = "Team",
        }).ToList();
    }

    public override Expression<Func<Person, bool>> GetDataViewWhereClause(string dataViewAlias)
    {
        // An alias without a valid team ID gives 0, which matches no team
        int teamId = 0;
        if (dataViewAlias.StartsWith(AliasPrefix, StringComparison.Ordinal))
        {
            _ = int.TryParse(dataViewAlias[AliasPrefix.Length..], NumberStyles.Integer, CultureInfo.InvariantCulture, out teamId);
        }

        return x => x.TeamId == teamId;
    }
}
```
{% endcode %}

The methods are:

* **`GetDataViewsAsync`:** Returns the list of data views to choose from. Override it when building the list awaits anything.
* **`GetDataViews`:** The synchronous version of `GetDataViewsAsync`. Override one of the two methods.
* **`GetDataViewWhereClause`:** Returns the boolean **where clause** expression for the given data views alias. This method is required.

Umbraco UI Builder only calls `GetDataViewsAsync`. By default, `GetDataViewsAsync` calls `GetDataViews`, so a builder that only overrides `GetDataViews` keeps working. A builder that overrides neither method throws a `NotImplementedException`.

The method signatures are:

```cs
Task<IEnumerable<DataViewSummary>> GetDataViewsAsync(CancellationToken cancellationToken = default)
IEnumerable<DataViewSummary> GetDataViews()
Expression<Func<TEntityType, bool>> GetDataViewWhereClause(string dataViewAlias)
```

## Setting the Data Views Builder of a Collection

Setting a data views builder is controlled via the [Collections](../../collections/overview.md) settings.

### Using the `SetDataViewsBuilder()` Method

Sets the collection's data views builder, allowing you to define data views dynamically at runtime.

#### Method Syntax

```cs
SetDataViewsBuilder<TDataViewsBuilder>() : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.SetDataViewsBuilder<PersonDataViewsBuilder>();
```

### Using the `SetDataViewsBuilder(Type)` Method

Sets the collection's data views builder, allowing you to define data views dynamically at runtime.

#### Method Syntax

```cs
SetDataViewsBuilder(Type dataViewsBuilderType) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.SetDataViewsBuilder(typeof(PersonDataViewsBuilder));
```

### Using the `SetDataViewsBuilder(DataViewsBuilder<TEntityType>)` Method

Sets the collection's data views builder, allowing you to define data views dynamically at runtime.

#### Method Syntax

```cs
SetDataViewsBuilder(DataViewsBuilder<TEntityType> dataViewsBuilder) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.SetDataViewsBuilder(new PersonDataViewsBuilder());
```
