---
versionFrom: 8.0.0
---

# Examine Events

_Examine events are ways to modify the data being indexed._

## TransformingIndexValues

The TransformingIndexValues event allows you to manipulate the data that will be indexed during an index operation. With this event you can add, remove or modify the data that is going into the index which can be helpful in many scenarios.

### Example

In the [Quick Start](Quick-Start/index.md) documentation you can see how to perform a search with Examine. That is great if you want to search between node names or you know that you always want to search for a specific field - e.g. `bodyText`.

However, what if you want to search through several different node types and search across many different fields, you will typically need to have a query that looks like this:

```c#
var textFields = new[] { "title", "description",  "content", .... };
var results = searcher.CreateQuery("content")
                    .GroupedOr(textFields, searchTerm)
                    .Execute();
```

This can be simplified. Instead you can use TransformingIndexValues event (used to be called GatheringNodeData in Umbraco 7) to add a custom field to the indexed data to combine the data from several fields and then you can search on that one field. This is done via a [composer](../../../Implementation/Composing/index.md).

## Creating a TransformingIndexValues event

:::note
This example will build upon the Umbraco Starterkit as it is a good starting point for some content. Feel free to use your own site, but some content may need to be generated.
:::

So to add a TransformingIndexValues event we will add a controller that inherits from `IComponent`. Something like this:

```c#
public class ExamineEvents : IComponent
{
    private readonly IExamineManager _examineManager;
    private readonly IUmbracoContextFactory _umbracoContextFactory;
    private readonly IScopeProvider _scopeProvider;

    public ExamineEvents(IExamineManager examineManager, IUmbracoContextFactory umbracoContextFactory, IScopeProvider scopeProvider)
    {
        _examineManager = examineManager;
        _umbracoContextFactory = umbracoContextFactory;
        _scopeProvider = scopeProvider;
    }

    public void Initialize()
    {
        if (!_examineManager.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out IIndex index))
           throw new InvalidOperationException($"No index found by name {Constants.UmbracoIndexes.ExternalIndexName}");

        //we need to cast because BaseIndexProvider contains the TransformingIndexValues event
        if (!(index is BaseIndexProvider indexProvider))
            throw new InvalidOperationException("Could not cast");

        indexProvider.TransformingIndexValues += IndexProviderTransformingIndexValues;
    }

    private void IndexProviderTransformingIndexValues(object sender, IndexingItemEventArgs e)
    {
        //will be added in next step
    }

    public void Terminate()
    {
    }
}
```

You can read more about this [syntax and Components here](../../../Implementation/Composing/index.md). We can now add the logic to combine fields in the `IndexProviderTransformingIndexValues` method:

```c#
if (e.ValueSet.Category == IndexTypes.Content)
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

    //Accessing the Umbraco Cache code will be added in the next step.
    //combinedFields.AppendLine(GetBreadcrumb(e.ValueSet.Values["id"].FirstOrDefault()?.ToString()));

    e.ValueSet.TryAdd("combinedField", combinedFields.ToString());

    
}
```

So at this point we have done something along the lines of:
- Get the ExternalIndex
- Get the valueset for the ExternalIndex
- For each field, add the content to a new field called `combinedField`

Next is an optional step to highlight how you can access the Umbraco published cache during an indexing event. In this example, we will be adding the breadcrumb values to our combined field.

```cs
private string GetBreadcrumb(string id)
{
    if (int.TryParse(idString, out var id))
    {
        using(var scope = _scopeProvider.Create(autocomplete: true))
        {
            using (var umbracoContextReference = _umbracoContextFactory.EnsureUmbracoContext())
            {
                var nodeBeingIndexed = umbracoContextReference.UmbracoContext.Content.GetById(id);
                return nodeBeingIndexed.Ancestor != null ?  
                    string.Join(" ", nodeBeingIndexed.AncestorsOrSelf().Select(n => n.Name)) :
                    string.Empty;
            }
        }
    }
}
```

:::note
This example is here to highlight the user of the Scope Provider. A Scope is required for many things in Umbraco, from controlling database transactions to how service level events are handled to how nucache manages it's snapshots (and more). Although Umbraco tries to ensure there is a Scope available, this is not always the case, especially when working in background threads / events. As such, it is important to wrap calls to Umbraco Services/Contexts in a Scope, as without this unusual errors can occur, including the disposal of objects still required. *For more information on this, please see the answer to this [forum question](https://our.umbraco.com/forum/using-umbraco-and-getting-started/102676-triggering-index-rebuild-via-hangfire-causes-objectdisposedexception-in-nucache)*
:::

Before this works the component will have to be registered in a composer. If you already have a composer you can add it to that one, but for this example we will make a new composer:

```c#
//This is a composer which automatically appends the ExamineEvents component
public class ExamineComposer : ComponentComposer<ExamineEvents>, IUserComposer
{
    // you could override `Compose` if you wanted to do more things, but if it's just registering a component there's nothing else that needs to be done.
}
```

We append it so it runs as the last one. Now if you start up your website and [rebuild your indexes](examine-management.md), then you can find the new field in the search results:

![Example of adding a Transforming Index Values field](images/transforming-index-values.png)

At this point you can create a query for only that field:

```c#
var results = searcher.CreateQuery("content").Field("combinedField", searchTerm).Execute();
```
