---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Adding a Prevalue Source Type to Umbraco Forms

The following example shows an illustrative custom prevalue source type that returns a hard-coded list of values. It can be extended for your needs via injection of services via the constructor. Settings can be applied and validated as shown in the other example custom types in this section.

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Forms.Core;
using Umbraco.Forms.Core.Models;

namespace MyFormsExtensions
{
    public class FixedListPrevalueSource : FieldPreValueSourceType
    {
        public FixedListPrevalueSource()
        {
            Id = new Guid("42C8158D-2AA8-4621-B653-6A63C7545768");
            Name = "Fixed List";
            Description = "Example prevalue source providing a fixed list of values.";
        }

        public override List<PreValue> GetPreValues(Field field, Form form) =>
            new List<PreValue>
            {
                new PreValue
                {
                    Id = 1,
                    Value = "Item One"
                },
                new PreValue
                {
                    Id = 2,
                    Value = "Item Two"
                }
            };

        /// <inheritdoc/>
        public override List<Exception> ValidateSettings()
        {
            var exceptions = new List<Exception>();
            return exceptions;
        }
    }
}
```

You will then need to register this new prevalue source type as a dependency.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Forms.Core.Providers;

namespace MyFormsExtensions
{
    public class Startup : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.WithCollectionBuilder<FieldPreValueSourceCollectionBuilder>()
                .Add<FixedListPrevalueSource>();
        }
    }
}
```
