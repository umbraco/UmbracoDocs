---
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Custom indexing
## Customizing the built in indexes

You can modify the built in indexes in several ways:

* Events - giving you control over exactly what data goes into them and how the fields are configured
* Changing the field value types to change how values are stored in the index
* Changing the `IValueSetValidator` to change what goes into the index
* Take control of the entire index creation pipeline to completely change the implementation

We can do all this by using the `ConfigureNamedOptions` pattern.

## Creating a ConfigureOptions class

We will start by creating a ConfigureExamineOptions class, that derives from `IConfigureNamedOptions<LuceneDirectoryIndexOptions>`:
```c#
using Examine.Lucene;
using Microsoft.Extensions.Options;

namespace MySite
{
    public class ConfigureExamineOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
    {
        public void Configure(string name, LuceneDirectoryIndexOptions options)
        {
            throw new System.NotImplementedException();
        }

        public void Configure(LuceneDirectoryIndexOptions options)
        {
            throw new System.NotImplementedException();
        }
    }
}
```

:::note
In this documentation we will use the `ConfigureExamineOptions` class for everything, it is recommended that you seperate this class out per filter for simplicity, for example if you do a lot of configuring for the ExternalIndex class, you would have a `ConfigureExternalIndex` class
:::

When using the `ConfigureNamedOptions` pattern, we have to register this in a composer for it to configure our indexes, this can be done like this:

```c#
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace MySite
{
    public class ExamineComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Services.ConfigureOptions<ConfigureExamineOptions>();
        }
    }
}
```
### Changing field value types

By default Examine will store values into the Lucene index as "Full Text", meaning it will be indexed and analyzed for a textual search. However, if a value that you are storing in a field is numerical, a date/time or another specific value type then you might want to change how this is stored in the index. This way you will be able to take advantage of some features such as numerical range or date features, etc...

There is some documentation about this in the [Examine documentation](https://shazwazza.github.io/Examine/configuration).

The easiest way to modify how a field is configured is using the ConfigureNamedOptions pattern like so:

```c#
using Examine;
using Examine.Lucene;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;

namespace MySite
{
    public class ConfigureExamineOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
    {
        public void Configure(string name, LuceneDirectoryIndexOptions options)
        {
            if (name.Equals(Constants.UmbracoIndexes.ExternalIndexName))
            {
                options.FieldDefinitions.AddOrUpdate(new FieldDefinition("price", FieldDefinitionTypes.Double));
            }
        }

        // Part of the interface, but does not need to be implemented for this.
        public void Configure(LuceneDirectoryIndexOptions options)
        {
            throw new System.NotImplementedException();
        }
    }
}
```
This will either add the `price` field to the index, or if the field already exists, update date its type to double.

## Changing IValueSetValidator

An `IValueSetValidator` is responsible for validating a `ValueSet` to see if it should be included in the index and/or filtering the data in the `ValueSet`. For example, by default the validation process for the ExternalIndex checks if a `ValueSet` has a category type of either "media" or "content" (not member). If a `ValueSet` was passed to the ExternalIndex and it did not pass this requirement it would be ignored.

The `IValueSetValidator` implementation for the built in indexes, can be changed like this:

```c#
using Examine.Lucene;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Infrastructure.Examine;

namespace MySite
{
    public class ConfigureExamineOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
    {
        public void Configure(string name, LuceneDirectoryIndexOptions options)
        {
            if (name.Equals(Constants.UmbracoIndexes.MembersIndexName))
            {
                options.Validator = new MemberValueSetValidator(null, null, new[] {"email"}, null);
            }
        }

        public void Configure(LuceneDirectoryIndexOptions options)
        {
            throw new System.NotImplementedException("This is never called and is just part of the interface");
        }
    }
}
```

## Creating your own index

The following example will show how to create an index that will only include nodes based on the document type _product_.

:::note
We always recommend that you use the existing built in ExternalIndex. You should then query based on the NodeTypeAlias instead of creating a new separate index based on that particular node type. However, should the need arise, the example below will show you how to do it.

Take a look at our [Examine Quick Start](../quick-start/index.md) to see some examples of how to search the ExternalIndex.
:::

In order to create this index we need five things:

1. A definition of the index
2. A ConfigureNamedOptions to configure all the fields of the index
3. A ValueSetBuilder to build the value sets for the index
4. A IndexPopulator to populate the index with the value sets
5. A composer to add all these services to the runtime.


### ProductIndex

```c#
using Examine.Lucene;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Examine;

namespace MySite.MyCustomIndex
{
    public class ProductIndex : UmbracoExamineIndex
    {
        public ProductIndex(
            ILoggerFactory loggerFactory,
            string name,
            IOptionsMonitor<LuceneDirectoryIndexOptions> indexOptions,
            IHostingEnvironment hostingEnvironment,
            IRuntimeState runtimeState) : base(loggerFactory,
            name,
            indexOptions,
            hostingEnvironment,
            runtimeState)
        {
        }
    }
}
```

### ConfigureCustomIndexOptions

```c#
using Examine;
using Examine.Lucene;
using Lucene.Net.Analysis.Standard;
using Lucene.Net.Index;
using Lucene.Net.Util;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Configuration.Models;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Examine;

namespace MySite.MyCustomIndex
{
    public class ConfigureCustomIndexOptions : IConfigureNamedOptions<LuceneDirectoryIndexOptions>
    {
        private readonly IOptions<IndexCreatorSettings> _settings;
        private readonly IPublicAccessService _publicAccessService;
        private readonly IScopeProvider _scopeProvider;

        public ConfigureCustomIndexOptions(
            IOptions<IndexCreatorSettings> settings,
            IPublicAccessService publicAccessService,
            IScopeProvider scopeProvider)
        {
            _settings = settings;
            _publicAccessService = publicAccessService;
            _scopeProvider = scopeProvider;
        }

        public void Configure(string name, LuceneDirectoryIndexOptions options)
        {
            if (name.Equals("ProductIndex"))
            {
                options.Analyzer = new StandardAnalyzer(LuceneVersion.LUCENE_48);
                options.FieldDefinitions = new(
                    new("id", FieldDefinitionTypes.Integer),
                    new("name", FieldDefinitionTypes.FullText)
                    );
                options.UnlockIndex = true;
                options.Validator = new ContentValueSetValidator(true, false, _publicAccessService, _scopeProvider, includeItemTypes: new[] {"product"});
                if (_settings.Value.LuceneDirectoryFactory == LuceneDirectoryFactory.SyncedTempFileSystemDirectoryFactory)
                {
                    // if this directory factory is enabled then a snapshot deletion policy is required
                    options.IndexDeletionPolicy = new SnapshotDeletionPolicy(new KeepOnlyLastCommitDeletionPolicy());
                }
            }
        }

        public void Configure(LuceneDirectoryIndexOptions options)
        {
            throw new System.NotImplementedException();
        }
    }
}
```

### ProductIndexValueSetBuilder

```c#
using System.Collections.Generic;
using Examine;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Infrastructure.Examine;

namespace MySite.MyCustomIndex
{
    public class ProductIndexValueSetBuilder : IValueSetBuilder<IContent>
    {
        public IEnumerable<ValueSet> GetValueSets(params IContent[] contents)
        {
            foreach (var content in contents)
            {
                var indexValues = new Dictionary<string, object>
                {
                    ["name"] = content.Name,
                    ["id"] = content.Id,
                };
                yield return new ValueSet(content.Id.ToString(), "content", indexValues);
            }
        }
    }
}
```
### ProductIndexPopulator
```c#
using System;
using System.Collections.Generic;
using System.Linq;
using Examine;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Examine;

namespace MySite.MyCustomIndex
{
    public class ProductIndexPopulator : IndexPopulator
    {
        private readonly IContentService _contentService;
        private readonly ProductIndexValueSetBuilder _productIndexValueSetBuilder;

        public ProductIndexPopulator(IContentService contentService, ProductIndexValueSetBuilder productIndexValueSetBuilder)
        {
            _contentService = contentService;
            _productIndexValueSetBuilder = productIndexValueSetBuilder;
            RegisterIndex("ProductIndex");
        }
        protected override void PopulateIndexes(IReadOnlyList<IIndex> indexes)
        {
            foreach (var index in indexes)
            {
                var roots = _contentService.GetRootContent();
                index.IndexItems(_productIndexValueSetBuilder.GetValueSets(roots.ToArray()));

                foreach (var root in roots)
                {
                   var valueSets = _productIndexValueSetBuilder.GetValueSets(_contentService.GetPagedDescendants(root.Id, 0, Int32.MaxValue, out _).ToArray());
                   index.IndexItems(valueSets);
                }
            }

        }
    }
}
```

### ExamineComposer
```c#
using Examine;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Infrastructure.Examine;

namespace MySite.MyCustomIndex
{
    public class ExamineComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Services.AddExamineLuceneIndex<ProductIndex, ConfigurationEnabledDirectoryFactory>("ProductIndex");
            builder.Services.ConfigureOptions<ConfigureCustomIndexOptions>();
            builder.Services.AddSingleton<ProductIndexValueSetBuilder>();
            builder.Services.AddSingleton<ProductIndexPopulator>();
        }
    }
}
```
### Result

![Custom product index](images/examine-management-product-index.png)

![Product document](images/examine-management-product-document.png)
