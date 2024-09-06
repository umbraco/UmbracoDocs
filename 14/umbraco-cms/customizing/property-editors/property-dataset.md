# Property Dataset

A Property Dataset is a Context API that holds the data for a set of properties.

Its required for `umb-property` element to have a Property Dataset provided. It can be provided via code and we also provide a Element implementation which is documented below.

## Property dataset component

The `umb-property-dataset` component provides a Property Dataset Context for any properties within. This provides a way to implement such purely via Elements.

In the following example a dataset is implemented by using the `umb-property-dataset` component together with with two `umb-property` components:

```xml
<umb-property-dataset .value=${this.data} @change=${this.#onDataChange}>
    <umb-property
        label="Textual input"
        description="Example of text editor"
        alias="textProperty"
        property-editor-ui-alias="Umb.PropertyEditorUi.TextBox"></umb-property>
    <umb-property
        label="List of options"
        description="Example of dropdown editor"
        alias="listProperty"
        .config=${[
            {
                alias: 'multiple',
                value: false,
            },
            {
                alias: 'items',
                value: ['First Option', 'Second Option', 'Third Option'],
            },
        ]}
        property-editor-ui-alias="Umb.PropertyEditorUi.Dropdown"></umb-property>
</umb-property-dataset>
```

## Consume values

Since a Property Dataset is a Context any descending code can consume it and utilize the values.

Such case could be a Workspace View that wants to display a value of a specific property.

The following example shows how to consume the Property Dataset and observe the value of a property with the alias of `my-property-alias`.

```typescript
this.consumeContext(UMB_PROPERTY_DATASET_CONTEXT, async (datasetContext) => {
    this.observe(await datasetContext?.propertyValueByAlias('my-property-alias'), (value) => {
        console.log('the value of `my-property-alias` is', value)
    });
});
```
