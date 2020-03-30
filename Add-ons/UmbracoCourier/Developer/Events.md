---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Events

Courier has several different events you can hook into and override. They are all placed in the `Umbraco.Courier.DataResolvers.Events` namespace. To override or extend an event, you will need to add an override method of the specific event you want to override, and ensure that is available on both the source and target environment. A quick way to do so is to add a class to your ~/App_Code folder, but in most setups you will probably prefer  to add it somewhere it makes sense to you.

## RebuildLuceneIndexes

By default Lucene/Examine indexes will be rebuilt on Courier deployments - it is possible to override, or stop the indexes from being rebuilt automatically.


When you implement a class that extends the event you want, your IDE should suggest the class you want to override. Here is the base generated class:

```csharp
using Umbraco.Courier.Core;
using Umbraco.Courier.DataResolvers.Events;

namespace DefaultNamespace
{
    public class CustomCourierIndexEvent : RebuildLuceneIndexes
    {
        public override void Execute(ItemIdentifier itemId, SerializableDictionary<string, string> parameters)
        {
            // do custom things here
            base.Execute(itemId, parameters);
        }
    }
}
```

If you want to disable indexing entirely you can get rid of the base and implement this:

```csharp
using Umbraco.Courier.Core;
using Umbraco.Courier.DataResolvers.Events;

namespace DefaultNamespace
{
    public class CustomCourierIndexEvent : RebuildLuceneIndexes
    {
        public override void Execute(ItemIdentifier itemId, SerializableDictionary<string, string> parameters)
        {
            // we don't want it to index here
            // base.Execute(itemId, parameters);
        }
    }
}
```

The code snippet above will disable automatic re-indexing on deployments, which can be useful in certain situations.
