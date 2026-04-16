---
description: >-
  The owner of the values for properties, enabling you to communicate with other
  properties.
---

# Property Dataset Context

Property Editors UIs require a Dataset Context to be present for them to work. This enables Property Editor UIs to have a generic relationship with their ownership and work in various cases.

The Dataset Context holds a name for the entity and a set of property values.

Retrieve a reference to the Property Dataset Context to start communicating:

```typescript
this.consumeContext(UMB_PROPERTY_DATASET_CONTEXT, async (context) => {
    ...
});
```

### Observe the value of another Property

Observe a value if you are using it in your UI. In the following example, the \`alias\` is used to retrieve the value of another property:

```typescript
this.consumeContext(UMB_PROPERTY_DATASET_CONTEXT, async (context) => {
    this.observe(
        await context?.propertyValueByAlias("alias-of-other-property"),
        (value) => {
            console.log("the value of the other property", value)
        }
    );
});
```

### Set the value of another Property

You can alter the value of another property in this way:

```typescript
this.consumeContext(UMB_PROPERTY_DATASET_CONTEXT, async (context) => {
    this.datasetContext = context;
});

...

updateValue() {
    this.datasetContext?.setPropertyValue("alias-of-other-property", "The updated value");
}
```

### Dataset Context in relation to Property Editors and Workspaces

A Dataset Context is the connection point between a Property Editor and a Workspace.

The Workspace has the root ownership, where the Dataset represents a specific Variant.

The hierarchy is as follows:

* Workspace Context
  * Property Dataset Context
    * Property Editor UIs

If you want to set or read values from properties of the same variant, use the Property Dataset Context. If you need values from another variant, use the Workspace Context instead.
