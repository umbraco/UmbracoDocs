# Adding A Prevalue Source Type To Umbraco Forms

_This builds on the "_[_Adding a type to the provider model_](adding-a-type.md)_" article_

Add a new class to your project - inherit it from `Umbraco.Forms.Core.FieldPreValueSourceType` and implement the class.

The following example shows an illustrative custom prevalue source type that returns a hard-coded list of values. It can be extended for your needs via injection of services via the constructor. (See additional example at the bottom.)

Dynamic settings can be applied and validated as shown in the [Validate type settings with ValidateSettings()](adding-a-type.md#validate-type-settings-with-validatesettings) article.

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

{% hint style="info" %}
The `PreValue` model in Umbraco Forms Versions 8.13.0, 9.5.0, 10.1.0, and above includes a `.Caption` property. This property is set separately from the `.Value` property. In the previous versions, the `Value` is generally used as the caption when rendered on the form.
{% endhint %}

## Another Example Using Dependency Injection to Access Additional Services

This example will take a user-provided Content Node and create a custom Prevalue list from the property data on that node. Your own `FieldPreValueSourceType` can get its data from wherever you like - an API call, custom functions, etc.

```csharp
using System;
using System.Collections.Generic;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Web;
using Umbraco.Forms.Core;
using Umbraco.Forms.Core.Models;
namespace MyFormsExtensions
    public class FormPrevaluesSourceNode : FieldPreValueSourceType
    {
        private readonly ILogger _logger;
        private readonly IUmbracoContextFactory _UmbracoContextFactory;
        //DEFINE ANY CONFIGURATION SETTING HERE
        [Umbraco.Forms.Core.Attributes.Setting(name: "Source Node",
            Alias = "SourceNodeId",
            Description = "Node holding the Options desired.",
            View = "pickers.content")]
        public string SourceNodeId { get; set; }
        public FormPrevaluesSourceNode(
            ILogger<FormPrevaluesSourceNode> logger
            , IUmbracoContextFactory umbracoContextFactory
        )
        {
            _logger = logger;
            _UmbracoContextFactory = umbracoContextFactory;
            this.Id = new Guid("0E4D4E2B-56E1-4E86-84E4-9A0A6051B57C"); //MAKE THIS UNIQUE!
            this.Name = "Content-defined Form Prevalues Source Node";
            this.Description = "Select a node of type 'FormPrevaluesSourceNode'";
            this.Group = "Custom";
            this.Icon = "icon-science";
        }
        /// <summary>
        /// The main method where the PreValues are defined and returned.
        /// </summary>
        /// <param name="field"></param>
        /// <param name="form"></param>
        /// <returns>List of 'Umbraco.Forms.Core.Models.PreValue'</returns>
        public override List<PreValue> GetPreValues(Field field, Form form)
        {
            List<PreValue> result = new List<PreValue>();
            try
            {
                // Access the Configuration Setting and check that is is valid
                if (!string.IsNullOrEmpty(SourceNodeId))
                {
                    var nodeId = 0;
                    var isValidId = Int32.TryParse(SourceNodeId, out nodeId);
                    if (isValidId)
                    {
                        IPublishedContent iPub;
                        using (var umbracoContextReference = _UmbracoContextFactory.EnsureUmbracoContext())
                        {
                            iPub = umbracoContextReference.UmbracoContext.Content.GetById(nodeId);
                        }
                        if (iPub != null)
                        {
                            int sort = 0;
                            //This is using a ModelsBuilder Model to strongly-type the selected node
                            var preValSourceNode = new Models.FormPrevaluesSourceNode(iPub, null);
                            foreach (var prevalue in preValSourceNode.PreValues)
                            {
                                PreValue pv = new PreValue();
                                pv.Id = $"{iPub.Id}-{sort}";
                                pv.Value = prevalue.StoredValue;
                                pv.Caption = prevalue.DisplayText; //.Caption only available in Forms Versions  8.13.0+, 9.5.0+, & 10.1.0+
                                pv.SortOrder = sort;
                                result.Add(pv);
                                sort++;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError($"Unable to get options from FormPrevaluesSourceNode #{SourceNodeId}", ex);
            }
            return result;
        }
        /// <summary>
        /// This is where any checks for Configuration validity are done.
        /// The exceptions will be displayed in the back-office UI to the user.
        /// </summary>
        /// <returns>List of 'System.Exception'</returns>
        public override List<Exception> ValidateSettings()
        {
            List<Exception> exceptions = new List<Exception>();
            if (string.IsNullOrEmpty(SourceNodeId))
            {
                exceptions.Add(new Exception("'Source Node' setting not filled out"));
            }
            else
            {
                var nodeId = 0;
                var isValidId = Int32.TryParse(SourceNodeId, out nodeId);
                if (isValidId)
                {
                    IPublishedContent iPub;
                    using (var umbracoContextReference = _UmbracoContextFactory.EnsureUmbracoContext())
                    {
                        iPub = umbracoContextReference.UmbracoContext.Content.GetById(nodeId);
                    }
                    if (iPub != null && iPub.ContentType.Alias != Models.FormPrevaluesSourceNode.ModelTypeAlias)
                    {
                        exceptions.Add(new Exception("'Source Node' needs to be of type 'FormPrevaluesSourceNode'"));
                    }
                }
            }
            return exceptions;
        }
    }
}
```

You will then need to register this new type as a dependency (either in `Program.cs` or in your own IComposer, as shown here).

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Forms.Core.Providers;
namespace MyFormsExtensions
{
    public class FormsComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            //Adding Custom Form PreValueSource
            builder.WithCollectionBuilder<FieldPreValueSourceCollectionBuilder>()
                .Add<FormPrevaluesSourceNode>();
        }
    }
}
```
