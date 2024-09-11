# Property Dataset

A Property Dataset is a Context API that holds the data for a set of properties.

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
