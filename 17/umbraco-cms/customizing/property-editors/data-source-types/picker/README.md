# Picker Data Source Type

The `Umb.DataSourceType.Picker` Data Source Type is used by Property Editors that pick entities, for example, the built-in [Entity Data Picker Property Editor](../../../../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/entity-data-picker.md).

## Register a Picker Data Source

**Data Source Manifest**

```typescript
{
  type: 'propertyEditorDataSource',
  dataSourceType: 'Umb.DataSourceType.Picker',
  alias: 'Umb.PropertyEditorDataSource.MyPickerDataSource',
  name: 'My Picker Data Source',
  api: () => import('./my-picker-data-source.js'),
  meta: {
   label: 'My Data Source',
   description: 'A good description of the data source',
   icon: 'icon-database',
  },
},
```

The new Picker supports two types of data structures:

-   [Collection Data](./picker-collection-data-source.md)
-   [Tree Data](./picker-tree-data-source.md)
