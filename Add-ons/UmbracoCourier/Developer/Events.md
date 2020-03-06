---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Events

## RebuildLuceneIndexes
By default Lucene/Examine indexes will be rebuilt on Courier deployments - if you wish to override, or stop the indexes from being rebuilt automatically, add a C#/.cs file in App_Code directory on both source and target environments (e.g. overrideScript.cs)

The file will be loaded automatically as long as it is C# code with .cs extension.


```csharp
using Umbraco.Core.Logging;
using Umbraco.Courier.Core;
using Umbraco.Courier.DataResolvers.Events;

namespace DefaultNamespace
{
    public class CourierTest : RebuildLuceneIndexes
    {
        public override void Execute(ItemIdentifier itemId, SerializableDictionary<string, string> parameters)
        {
            LogHelper.Info<CourierTest>("This is where it would normally have rebuilt the index");
        }
    }
}
```

The code snippet above will disable automatic re-indexing on deployments, which can be useful in certain situations.
