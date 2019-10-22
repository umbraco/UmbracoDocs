---
versionFrom: 8.0.0
---

# Custom indexing

Examine has changed quite a bit in Umbraco 8 (and by "a bit" we really mean a lot). In Umbraco 7 everything was configured in the two Examine config files - in Umbraco 8 everything happens through C#.

## Index based on document types

The following example will show how to create an index that will only include nodes based on the document type _product_.

:::note
We always recommend that you use the existing built in ExternalIndex. You should then query based on the NodeTypeAlias instead of creating a new separate index based on that particular node type. However, should the need arise, the example below will show you how to do it.

Take a look at our [Examine Quick Start](../quick-start/index.md) to see some examples of how to search the ExternalIndex.
:::

In order to create this index we need three things:
1. An IndexCreator to create the index(s)
2. A component to register our index to Examine
3. A composer to register our component and index creator

### ProductIndexCreator

```c#
public class ProductIndexCreator : LuceneIndexCreator, IUmbracoIndexesCreator
{
    private readonly IProfilingLogger _profilingLogger;
    private readonly ILocalizationService _localizationService;
    private readonly IPublicAccessService _publicAccessService;

    // Since Umbraco 8 has dependency injection out of the box, we can use it to inject
    // the different services that we need.
    public ProductIndexCreator(IProfilingLogger profilingLogger,
        ILocalizationService localizationService,
        IPublicAccessService publicAccessService
    )
    {
        _profilingLogger = profilingLogger;
        _localizationService = localizationService;
        _publicAccessService = publicAccessService;
    }

        // Noticed that we return a collection of indexes? Technically you
        // can create multiple indexes in an indexCreator :) You can have a look at
        // UmbracoIndexesCreator.cs in the CMS core and see how the CMS does that.
        public override IEnumerable<IIndex> Create()
        {
            var index = new UmbracoContentIndex("ProductIndex",
                CreateFileSystemLuceneDirectory("ProductIndex"),
                new UmbracoFieldDefinitionCollection(),
                new StandardAnalyzer(Version.LUCENE_30),
                _profilingLogger,
                _localizationService,
                // We can use the ContentValueSetValidator to set up rules for the content we
                // want to have indexed. In our case we want published, non-protected nodes of the type "product".
                new ContentValueSetValidator(true, false, _publicAccessService, includeItemTypes: new string[] { "product" }));

            return new[] { index };
        }
}
```

### ProductComponent

```c#
public class ProductComponent : IComponent
{
    private readonly IExamineManager _examineManager;
    private readonly ProductIndexCreator _productIndexCreator;

    public ProductComponent(IExamineManager examineManager, ProductIndexCreator productIndexCreator)
    {
        _examineManager = examineManager;
        _productIndexCreator = productIndexCreator;
    }

    public void Initialize()
    {
        // Because the Create method returns a collection of indexes,
        // we have to loop through them.
        foreach (var index in _productIndexCreator.Create())
        {
            _examineManager.AddIndex(index);
        }
    }

    public void Terminate() { }
}
```

### ProductComposer

```c#
public class ProductComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
        composition.Components().Append<ProductComponent>();
        composition.RegisterUnique<ProductIndexCreator>();
    }
}
```

### Result

![Custom product index](images/examine-management-product-index.png)

![Product document](images/examine-management-product-document.png)
