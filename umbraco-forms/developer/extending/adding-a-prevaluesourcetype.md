# Adding a Prevalue Source Type to Umbraco Forms

The following example shows an illustrative custom prevalue source type that returns a hard-coded list of values. It can be extended for your needs via injection of services via the constructor. Dynamic settings can be applied and validated as shown in the [Validate type settings with ValidateSettings()](adding-a-type#validate-type-settings-with-validatesettings) article.

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
                    Value = "item-one",
                    Caption = "Item One"
                },
                new PreValue
                {
                    Id = 2,
                    Value = "item-two",
                    Caption = "Item Two"
                }
            };

        /// <inheritdoc/>
        public override List<Exception> ValidateSettings()
        {
        // this is used to validate any dynamic settings you might apply to the PreValueSource
        // if there are no dynamic settings, return an empty list of Exceptions:
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
