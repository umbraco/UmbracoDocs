# Property Editor Data Source

A Property Editor Data Source is a way to provide data to a Property Editor UI. This allows for the reuse of the same UI across different data sources.

Data Sources are an opt-in feature for the Property Editor UI. When enabled, extensions can register Data Sources, which can be selected in the UI if their type is supported.

## Enable Data Source Support

The Data Source support is enabled in the Property Editor UI manifest. Below is a snippet showing how to enable it. The `forDataSourceTypes` can include any already existing Data Source Types or new custom ones.

**Property Editor UI Manifest**

```typescript
{
  type: 'propertyEditorUi',
  name: 'My Property Editor UI with Data Source support',
  //... more
  meta: {
    //... more
    supportsDataSource: {
      enabled: true,
      forDataSourceTypes: ['My.DataSourceType.Custom']
    }
  }
}
```

When this feature is enabled, it will be possible to pick a Data Source in the Data Type Workspace next to the Property Editor field. The available Data Sources will match the supported Data Source Types of the chosen Property Editor UI.

<figure><img src="../.gitbook/assets/umbraco-docs-data-type-property-editor-data-source.png" alt=""><figcaption><p>Property Editor Data Source Picker</p></figcaption></figure>

## Register a Property Editor Data Source

**Data Source Manifest**

```typescript
 {
  type: 'propertyEditorDataSource',
  dataSourceType: 'My.DataSourceType.Custom',
  alias: 'Umb.PropertyEditorDataSource.MyCustomDataSource',
  name: 'My Custom Data Source',
  api: () => import('./my-custom-data-source.js'),
  meta: {
   label: 'My Data',
   description: 'A good description of the data',
   icon: 'icon-database',
  },
 },
```

### Data Source Settings

Like Property Editor UIs and Schemas, Data Sources can have settings for configuration of the data source. These settings are defined in the manifest under `meta.settings`. The settings for a Data Source will be rendered in the Data Type Workspace together with the Property Editor UI and Schema settings.

**Data Source Manifest**

```typescript
{
  type: 'propertyEditorDataSource',
  alias: 'Umb.PropertyEditorDataSource.MyCustomDataSource',
  //... more
  meta: {
    //... more
    settings: {
      properties: [],
    },
  },
};
```

## Access Data Source Alias in Property Editor UI

When implementing a Property Editor UI element, the Data Source alias can be accessed through the `dataSourceAlias` property.

```typescript
interface UmbPropertyEditorUiElement extends HTMLElement {
    dataSourceAlias?: string;
}
```

## Access Data Source Config in Property Editor UI

The Data Source configuration can be accessed through the `config` property of the Property Editor UI element together with the UI and Schema config.

## Built-in Data Source Types

-   [Picker](../data-source-types/picker/README.md) - Used by Property Editors that pick entities, for example, the Entity Data Picker Property Editor.
