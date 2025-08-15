# Adding a workflow type to Umbraco Forms

*This builds on the "[Adding a type to the provider model](adding-a-type.md)" article.*

You can create a custom workflow type by inheriting from `Umbraco.Forms.Core.WorkflowType` and implementing the required methods. For this example, the focus is on the `Execute()` method. This method process the current record (the data submitted by the form) and allows you to modify data and state.

## Creating a Custom Workflow

Add a new class to your project:

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

### Aborting Subsequent Workflows

If you want to stop further workflows from executing, you can change the record’s state to `Rejected` and return `WorkflowExecutionStatus.Failed`.

#### Example

```csharp
public override Task<WorkflowExecutionStatus> ExecuteAsync(WorkflowExecutionContext context)
{
    // Get a specific field value by alias
    var emailField = context.Record.GetRecordFieldByAlias("email");

    // Check if the email is missing or invalid
    if (emailField == null || string.IsNullOrWhiteSpace(emailField.ValuesAsString(false)))
    {
        _logger.LogWarning("Workflow aborted: Email address is missing.");

        // Set the record state to Rejected and stop further workflows
        context.Record.State = FormState.Rejected;
        return Task.FromResult(WorkflowExecutionStatus.Failed);
    }

    // Continue workflow execution if condition passes
    _logger.LogDebug("Email provided: {Email}", emailField.ValuesAsString(false));
    return Task.FromResult(WorkflowExecutionStatus.Completed);
}
```

This is useful when your workflow detects an error or fails a condition check and you want to abort the rest of the workflow pipeline.

## Information Available to the Workflow

### Record Information

The `Execute()` method receives a `WorkflowExecutionContext` object, which has properties for the related `Form`, `Record`, and `FormState`.  This parameter contains all information related to the workflow.

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

### Form and State Information

The `Form` references the form the record is from and `FormState` provides its state (submitted or approved).

Other context, such as the current `HttpContext`, if needed can be passed as constructor parameters (for example: the `HttpContext` can be accessed by injecting `IHttpContextAccessor`).

## Registering the Workflow Type

To use your custom workflow type, register it at application startup:

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
