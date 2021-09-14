---
versionFrom: 8.0.0
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
using Umbraco.Core.Logging;
using Umbraco.Core.Composing;

namespace PrereleaseForm8_4.Workflows
{
    /// <summary>
    /// Summary description for TestWorkflow
    /// </summary>
    public class TestWorkflow : WorkflowType
    {   
        public TestWorkflow()
        {
            this.Id = new Guid("ccbeb0d5-adaa-4729-8b4c-4bb439dc0202");
            this.Name = "TestWorkflow";
            this.Description = "This workflow is just for testing";
            this.Icon = "icon-chat-active";
            this.Group = "Services";                      
        }
        public override WorkflowExecutionStatus Execute(Record record, RecordEventArgs e)
        {
            // first we log it
            Current.Logger.Debug<TestWorkflow>("the IP " + record.IP + " has submitted a record");            

            // we can then iterate through the fields
            foreach (RecordField rf in record.RecordFields.Values)
            {
                // and we can then do something with the collection of values on each field
                List<object> vals = rf.Values;

                // or get it as a string
                rf.ValuesAsString();
            }
                      
            //Change the state
            record.State = FormState.Approved;

            Current.Logger.Debug<TestWorkflow>("The record with unique id {RecordId} that was submitted via the Form {FormName} with id {FormId} has been changed to {RecordState} state",
               record.UniqueId, e.Form.Name, e.Form.Id, "approved");

            return WorkflowExecutionStatus.Completed;
        }

        public override List<Exception> ValidateSettings()
        {
            return new List<Exception>();
        }
       
    }
}
```

The `Execute()` method gets a `Record` and a `RecordEventArgs` argument. These 2 arguments contains all information related to the workflow. The record contains all data and meta data submitted by the form. The RecordEventArgs contains references to what form the record is from, what state it is in and a reference to the current `HttpContext`.
