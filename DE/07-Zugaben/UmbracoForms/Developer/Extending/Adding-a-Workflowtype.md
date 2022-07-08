---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Adding a workflow type to Umbraco Forms

*This builds on the "[adding a type to the provider model](Adding-a-Type.md)" chapter*

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
                rf.ValuesAsString();
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

The `Execute()` method gets a `WorkflowExecutionContext` which has properties for the related `Form`, `Record` and `FormState`.  Essentially, this parameter contains all information related to the workflow.  The `Record` contains all data and meta data submitted by the form. The `Form` references the form the record is from, and `FormState` provides it's state.  Other context, such as the current `HttpContext`, if needed can be passed as constructor parameters (e.g. the `HttpContext` can be accessed by injecting `IHttpContextAccessor`).

You will then need to register this new workflow type as a dependency.

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
