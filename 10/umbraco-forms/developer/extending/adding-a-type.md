---
meta.Title: "Adding a type to the provider model"
---

# Adding a type to the provider model

To add a new type, no matter if it's a workflow, field, data source, etc, there is a number of tasks to perform to connect to the Forms provider model. This chapter walks through each step and describes how each part works. This chapter will reference the creation of a workflow type. It is, however, the same process for all types.

## Preparations

Create a new class library project in Visual Studio add references to the `Umbraco.Forms.Core.dll` (available via referencing the [NuGet package](https://www.nuget.org/packages/Umbraco.Forms.Core/)). You might also need to reference [Umbraco.Forms.Core.Providers](https://www.nuget.org/packages/Umbraco.Forms.Core.Providers/).

## Adding the type to Forms

The Forms API contains a collection of classes that can be registered at startup or in an Umbraco component. So to add a new type to Forms you inherit from the right class. In the sample below we use the class for the workflow type.

```csharp
public class LogWorkflow : Umbraco.Forms.Core.WorkflowType
{
    private readonly ILogger<LogWorkflow> _logger;

    public LogWorkflow(ILogger<LogWorkflow> logger)
    {
        _logger = logger;
    }

    public override WorkflowExecutionStatus Execute(WorkflowExecutionContext context)
    {
        throw new NotImplementedException();
    }

    public override List<Exception> ValidateSettings() {
        throw new NotImplementedException();
    }
}
```

When you implement this class you get two methods added. One of them is Execute which performs the execution of the workflow and the other is a method which validates the workflow settings, we will get back to these settings later on.

Any dependencies required that are registered with the dependency injection container can be provided via the constructor.

Even though we have the class inheritance in place, we still need to add a bit of default information.

## Setting up basic type information

Even though we have the class inheritance in place, we still need to add a bit of default information. This information is added in the class's constructor like this:

```csharp
public LogWorkflow(ILogger<LogWorkflow> logger) {

    _logger = logger;

    this.Name = "The logging workflow";
    this.Id = new Guid("D6A2C406-CF89-11DE-B075-55B055D89593");
    this.Description = "This will save an entry to the log";
}
```

All three are mandatory and the ID must be unique, otherwise the type might conflict with an existing one.

## Adding settings to a type

Now that we have a basic class setup, we would like to pass setting items to the type. So we can reuse the type on multiple items but with different settings. To add a setting to a type, we add a property to the class, and give it a specific attribute like this:

```csharp
[Umbraco.Forms.Core.Attributes.Setting("Log Header",
        Description = "Log item header",
        View = "TextField")]
public string LogHeader { get; set; }
```

The Umbraco.Forms.Core.Attributes.Setting registers the property in Umbraco Forms and there will automatically be UI and storage generated for it. In the attribute, a name, description and the view to be rendered is defined.

With the attribute in place, the property value is set every time the class is instantiated by Umbraco Forms. This means you can use the property in your code like this:

```csharp
[Umbraco.Forms.Core.Attributes.Setting("Document ID",
        Description = "Node the log entry belongs to",
        View = "Pickers.Content")]
public string Document { get; set; }

public override WorkflowExecutionStatus Execute(WorkflowExecutionContext context) {
    _logger.LogInformation("Record submitted from: {IP}", context.Record.IP);
    return WorkflowExecutionStatus.Completed;
}
```

For all types that use the provider model, settings work this way. By adding the Setting attribute Forms automatically registers the property in the UI and sets the value when the class is instantiated.

## Validate type settings with ValidateSettings()

The `ValidateSettings()` method which can be found on all types supporting dynamic settings, is used for making sure the data entered by the user is valid and works with the type.

```csharp
public override List<Exception> ValidateSettings() {
    List<Exception> exceptions = new List<Exception>();
    int docId = 0;
    if (!int.TryParse(Document, out docId))
        exceptions.Add(new Exception("Document is not a valid integer"));
    return exceptions;
}
```

## Registering the class with Umbraco and Forms

To register the type, ensure your web application project has a reference to the class library - either via a project or NuGet reference - and add the following code into the startup pipeline.  In this example, the registration is implemented as an extension method to `IUmbracoBuilder` and should be called from `Startup.cs`:

```csharp
public static IUmbracoBuilder AddUmbracoFormsCustomProviders(this IUmbracoBuilder builder)
{
    builder.WithCollectionBuilder<WorkflowCollectionBuilder>()
        .Add<LogWorkflow>();
}
```

An alternative approach is to use a composer, as per this example:

```csharp
public class UmbracoFormsCustomProvidersComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.WithCollectionBuilder<WorkflowCollectionBuilder>()
            .Add<LogWorkflow>();
    }
}
```

From Umbraco Forms 9.5 and 10.0, there are further convenience methods you can use for registering custom types. These are found in the namespace `Umbraco.Forms.Core.Providers.Extensions`.

For example, instead of the following:

```csharp
    builder.WithCollectionBuilder<WorkflowCollectionBuilder>()
        .Add<LogWorkflow>();
```

Your workflow can be registered using:

```csharp
    builder.AddFormsWorkflow<LogWorkflow>():
```

Or:

```csharp
    builder.FormsWorkflows().Add<LogWorkflow>();
```

Existing items that are not required in a particular installation can be removed with:

```csharp
    builder.FormsWorkflows().Exclude<Slack>();
```

Also look in the reference chapter for complete class implementations of workflows, fields and export types.

## Overriding default providers in Umbraco Forms

It is possible to override and inherit the original provider, be it a Field Type or Workflow etc. The only requirement when inheriting a fieldtype that you wish to override is to ensure you do not override/change the Id set for the provider, and make sure your class is public.

Here is an example of overriding the Textarea field aka Long Answer.

```csharp
public class TextareaWithCount : Umbraco.Forms.Core.Providers.FieldTypes.Textarea
{
    // Added a new setting when we add our field to the form
    [Umbraco.Forms.Core.Attributes.Setting("Max length",
    Description = "Max length",
    View = "TextField")]
    public string MaxNumberOfChars { get; set; }

    public TextareaWithCount()
    {
        // Set a different view for this fieldtype
        this.FieldTypeViewName = "FieldType.TextareaWithCount.cshtml";

        // We can change the default name of 'Long answer' to something that suits us
        this.Name = "Long Answer with Limit";
    }

    public override IEnumerable<string> ValidateField(Form form, Field field, IEnumerable<object> postedValues, HttpContext context, IPlaceholderParsingService placeholderParsingService, List<string> errors)
    {
        var baseValidation = base.ValidateField(form, field, postedValues, context, placeholderParsingService, errors);
        var value = postedValues.FirstOrDefault();

        if (value != null && value.ToString().Length < int.Parse(MaxNumberOfChars))
        {
            return baseValidation;
        }

        var custom = new List<string>();
        custom.AddRange(baseValidation);
        custom.Add("String is way way way too long!");

        return custom;
    }
}
```

As discussed in the previous section, you must also register the extended field type within a composer.  You also need to create the the backoffice field type view.

**Composer:**

```csharp
public class UmbracoFormsCustomProvidersComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.FormsFields().Add<TextareaWithCount>();
    }
}
```

**Backoffice View:**

Add a new HTML file as per the name of the field class (e.g. `textareawithcount.html`) to `\wwwroot\App_Plugins\umbracoforms\Backoffice\Common\FieldTypes\` within your project. For this example, we can copy the original `textarea.html` file used by the standard 'Long Answer' field.

The AngularJS client-side files are shipped with Umbraco Forms as part of a Razor Class Library. So you won't find these files on disk when you install the package.

However if you do want to reference them you can view and extract them from the [`Umbraco.Forms.StaticAssets` NuGet package](https://nuget.info/packages/Umbraco.Forms.StaticAssets).
