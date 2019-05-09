---
versionFrom: 8.0.0
---

# TransformingIndexValues

In the [Quick Start](Quick-Start/index.md) documentation you can see how to perform a simple search with Examine. That is great if you want to search between node names or you know that you always want to search for a specific field - e.g. `bodyText`. 

However, what if you want to search through several different node types and search across many different fields, you likely will not want to have a query that looks like this:

```cs
var results = searcher.CreateQuery("content").Field("nodeName", searchTerm)
                    Or().Field("bodyText", searchTerm)
                    Or().Field("description", searchTerm)
                    Or().Field("about", searchTerm)
                    Or().Field("otherText", searchTerm)
                    .Execute();
```

This quickly becomes unmanageable, would have to add each new field to the query as you make them. 

Instead you can use **TransformingIndexValues** (used to be called GatheringNodeData in Umbraco 7). TransformingIndexValues is an Examine event where a new field is created in the index that contains the data from several other fields, you can then search on just that field. This is done via a [composer](../../../Implementation/Composing/index.md).

## Creating a TransformingIndexValues event

:::note
This example will build upon the Umbraco Starterkit as it is a good starting point for some content. Feel free to use your own site, but some content may need to be generated.
:::

So to add a TransformingIndexValues event we will add a controller that inherits from `IComponent`. Something like this:

```cs
public class ExamineEvents : IComponent
{
    private readonly IExamineManager _examineManager;
    private readonly ILogger _logger;

    public ExamineEvents(IExamineManager examineManager, ILogger logger)
    {
        _examineManager = examineManager;
        _logger = logger;
    }

    public void Initialize()
    {
        if (!_examineManager.TryGetIndex("ExternalIndex", out IIndex index))
            throw new InvalidOperationException("No index found by name ExternalIndex");

        //we need to cast because BaseIndexProvider contains the TransformingIndexValues event
        if (!(index is BaseIndexProvider indexProvider))
            throw new InvalidOperationException("Could not cast");

        indexProvider.TransformingIndexValues += IndexProviderTransformingIndexValues;
    }

    private void IndexProviderTransformingIndexValues(object sender, IndexingItemEventArgs e)
    {
        //todo
    }

    public void Terminate()
    {
    }
}
```

If this syntax is confusing you can read more about [Components](../../../Implementation/Composing/index.md). We can now add the logic to combine fields in the `IndexProviderTransformingIndexValues` method:

```cs
if (e.ValueSet.Category == IndexTypes.Content)
{
    try
    {
        var combinedFields = new StringBuilder();
        foreach (var fieldValues in e.ValueSet.Values)
        {
            foreach (var value in fieldValues.Value)
            {
                if (value != null)
                {
                    combinedFields.AppendLine(value.ToString());
                }
            }            
        }

        e.ValueSet.Add("combinedField", combinedFields.ToString());
    }
    catch (Exception ex)
    {
        _logger.Error<ExamineEvents>(ex, "Error combining fields for {ValueSetId}", e.ValueSet.Id);
    }
}
```

So at this point we have done something along the lines of:
- Get the ExternalIndex
- Get the valueset for the ExternalIndex
- For each field, add the content to a new field called `combinedField`

Before this works the component will have to be registered in a composer. If you already have a composer you can add it to that one, for this example we will make a new composer:

```cs
public class CustomComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
        composition.Components().Append<ExamineEvents>();
    }
}
```

We append it so it runs as the last one. Now if you start up your website and [rebuild your indexes](examine-management.md), then you can find the new field in the search results:

![Example of adding a Transforming Index Values field](images/transforming-index-values.png)

At this point you can create a query just for that field:

```cs
var results = searcher.CreateQuery("content").Field("combinedField", searchTerm).Execute();
```