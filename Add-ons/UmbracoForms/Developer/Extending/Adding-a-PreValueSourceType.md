---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Adding a Prevalue Source Type to Umbraco Forms

*This builds on the "[adding a type to the provider model](Adding-a-Type.md)" chapter*

Add a new class to your project and have it inherit from `Umbraco.Forms.Core.FieldPreValueSourceType`, implement the class. 

This example will take a user-provided Content Node and create a custom Prevalue list from property data on that node. Your own `FieldPreValueSourceType` can get its data from wherever you like - an API call, custom functions, etc.

```csharp
namespace MyUmbracoFormsExtensions
{
    using System;
    using System.Collections.Generic;
    using Microsoft.Extensions.Logging;
    using Umbraco.Cms.Core;
    using Umbraco.Cms.Core.Models.PublishedContent;
    using Umbraco.Cms.Core.Web;
    using Umbraco.Forms.Core;
    using Umbraco.Forms.Core.Models;

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
            List<Exception> exs = new List<Exception>();

            if (string.IsNullOrEmpty(SourceNodeId))
            {
                exs.Add(new Exception("'Source Node' setting not filled out"));
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
                        exs.Add(new Exception("'Source Node' needs to be of type 'FormPrevaluesSourceNode'"));
                    }
                }
            }

            return exs;
        }
    }
}
```

You will then need to register this new type as a dependency (either in 'Startup.cs' or in your own IComposer, as shown here.

```csharp
namespace MyUmbracoFormsExtensions
{
    using Umbraco.Cms.Core.Composing;
    using Umbraco.Cms.Core.DependencyInjection;
    using Umbraco.Forms.Core.Providers;
    
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

:::note
The PreValue model was updated in Umbraco Forms Versions: 8.13.0, 9.5.0, & 10.1.0 to include a `.Caption` property which can be set separately from the `.Value` property. In previous versions, the `Value` would generally be used as the caption when rendered on the form.
:::

