# Expanders

Workflow Expanders allow developers to capture additional data as part of a workflow submission. Expansion data is displayed in the workflow detail dialog, and can be accessed programmatically via Workflow notifications or custom code.

Implementing a Workflow Expander requires a C# class definition, and a backoffice extension.

## Server-side implementation

The server-side implementation requires a C# class fulfilling the `IWorkflowExpander` interface:

```csharp
    public class DocumentWorkflowExpander : IWorkflowExpander
    {
        /// <summary>
        /// Defines the entity type associated with the workflow instance.
        /// This is the only required property.
        /// </summary>
        public string For => "document";

        public bool? Bar { get; set; }
    }
```

In this example, the Expander will be applied to document workflows. The `Bar` property has a corresponding property in the client-side implementation. The Expander can define multiple properties - the example includes a single property for simplicity.

The Expander does NOT need to be registered. Workflow builds a collection on startup, minimising developer work.

## Client-side implementation

The client-side implementation requires a backoffice extension of type `workflowExpansion`:

```ts
{
    type: 'workflowExpansion',
    alias: "MyWorkflowExtensions.Expansion.Document",
    name: "Custom Workflow Document Workflow Expansion",
    entityType: UMB_DOCUMENT_ENTITY_TYPE,
    meta: {
        properties: [{
            alias: "bar",
            propertyEditorUiAlias: "Umb.PropertyEditorUi.Toggle",
            label: "A custom property",
            description: "It can have a description if required",
            validation: { mandatory: true },
            weight: 800,
            // include is passed the current workflow state and a boolean indicating the variation state of the current entity.
            // The function is optional and must return a boolean value.
            include: (args) => args.state?.allowScheduling && args.varies,
        }]
    }
}
```

The `workflowExpansion` type requires `meta.properties`, where `properties` is an array of expander definitions.

In this example, the `alias` matches a property from the C# class. The `propertyEditorUiAlias` can be any valid property editor, but ideally would be a basic editor - a toggle, a textstring or similar.

The default properties in the workflow submit dialog are also registered using this extension-first approach.
