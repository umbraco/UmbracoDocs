# Adding a workflow type to Umbraco Forms

*This builds on the "[adding a type to the provider model](adding-a-type.md)" chapter*

Add a new class to your project and have it inherit from `Umbraco.Forms.Core.WorkflowType`, implement the class. For this sample we will focus on the execute method. This method process the current record (the data submitted by the form) and have the ability to change data and state.

```csharp
using Serilog;
using System;
using System.Collections.Generic;
using Umbraco.Forms.Core;
using Umbraco.Forms.Core.Data.Storage;
using Umbraco.Forms.Core.Enums;
using Umbraco.Forms.Core.Persistence.Dtos;
using Microsoft.Extensions.Logging;
using Umbraco.Core.Composing;

namespace MyFormsExtensions
{
    public class TestWorkflow : WorkflowType
    {
        private readonly ILogger<TestWorkflow> _logger;

        public TestWorkflow(ILogger<TestWorkflow> logger)
        {
            _logger = logger;

            this.Id = new Guid("ccbeb0d5-adaa-4729-8b4c-4bb439dc0202");
            this.Name = "TestWorkflow";
            this.Description = "This workflow is just for testing";
            this.Icon = "icon-chat-active";
            this.Group = "Services";
        }

        public override WorkflowExecutionStatus Execute(WorkflowExecutionContext context)
        {
            // first we log it
            _logger.LogDebug("the IP " + context.Record.IP + " has submitted a record");

            // we can then iterate through the fields
            foreach (RecordField rf in context.Record.RecordFields.Values)
            {
                // and we can then do something with the collection of values on each field
                List<object> vals = rf.Values;

                // or get it as a string
                rf.ValuesAsString(false);
            }

            //Change the state
            context.Record.State = FormState.Approved;

            _logger.LogDebug("The record with unique id {RecordId} that was submitted via the Form {FormName} with id {FormId} has been changed to {RecordState} state",
               context.Record.UniqueId, context.Form.Name, context.Form.Id, "approved");

            return WorkflowExecutionStatus.Completed;
        }

        public override List<Exception> ValidateSettings()
        {
            return new List<Exception>();
        }
    }
}
```

## Information available to the workflow

### Record information

The `Execute()` method gets a `WorkflowExecutionContext` which has properties for the related `Form`, `Record`, and `FormState`.  This parameter contains all information related to the workflow.

The `Record` contains all data and metadata submitted by the form.  As shown in the example above, you can iterate over all `RecordField` values in the form. You can also retrieve a specific record field by alias using the following method:

```csharp
RecordField? recordField = context.Record.GetRecordFieldByAlias("myalias");
```

Having obtained a reference to a record field, the submitted value can be retrieved via:

```csharp
var fieldValue = recordField.ValuesAsString(false);
```

The `ValuesAsString` will JSON escape the result by default. If you do not want this escaping to occur, pass `false` as the parameter.

If the field stores multiple values, they are delimited with a comma. In many cases, you can safely split on that delimiter to obtain the individual values. However, this can lead to issues if the prevalues being selected also contain commas. If that's a concern, the following extension method is available in `Umbraco.Forms.Core.Extensions` to correctly parse the selected prevalues:

```csharp
IEnumerable<string> selectedPrevalues = recordField.GetSelectedPrevalues();
```

### Form and state information

The `Form` references the form the record is from and `FormState` provides its state (submitted or approved).

Other context, such as the current `HttpContext`, if needed can be passed as constructor parameters (for example: the `HttpContext` can be accessed by injecting `IHttpContextAccessor`).

## Registering the workflow type

To use the new workflow type, you will need to register it as part of application startup.

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
            builder.WithCollectionBuilder<WorkflowCollectionBuilder>()
                .Add<TestWorkflow>();
        }
    }
}
```
