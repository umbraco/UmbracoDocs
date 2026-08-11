# Integrate Property Editors

Property Editors can be used and implemented anywhere in the Umbraco Backoffice.

## Property & Property Dataset Components

The simplest way to integrate one or more Property Editors is done using two Components: the Property Dataset component and a Property component.

The `umb-property` component renders a property using a Property Editor UI.

The `umb-property-dataset` component provides the dataset for any properties within. It holds the data even if the actual property is not rendered. This makes it possible to hide properties in tabs or other ways.

In the following example a dataset is implemented with two properties:

```js
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

Notice how the values of the properties are handled by the dataset, leaving you with one component to integrate.

[Read more about Property Dataset here](property-dataset.md)
