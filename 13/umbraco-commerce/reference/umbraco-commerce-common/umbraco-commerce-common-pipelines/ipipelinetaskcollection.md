---
title: IPipelineTaskCollection
description: API reference for IPipelineTaskCollection in Umbraco Commerce
---
## IPipelineTaskCollection

```csharp
public interface IPipelineTaskCollection : IComposedCollection<IPipelineTask>, 
    IEnumerable<IPipelineTask>, IReadOnlyCollection<IPipelineTask>
```

**Inheritance**

* interface [IComposedCollection&lt;T&gt;](../umbraco-commerce-common-composing/icomposedcollection-1.md)

**Namespace**
* [Umbraco.Commerce.Common.Pipelines](README.md)

### Properties

#### OnFail

```csharp
public IPipelineAction OnFail { get; set; }
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Common.dll -->
