# Entity Data Picker

`Schema Alias: Umbraco.Plain.Json` // TODO: update when alias is final

`UI Alias: Umb.PropertyEditorUi.EntityDataPicker`

`Returns: IEnumerable<string>`

`Supported Data Source Types:` [picker](../../../../customizing/property-editors/property-editor-data-source-types/README.md)

The Entity Data Picker property editor allows editors to pick one or more entities from a configurable data source. The selected entities are stored as an array of strings, where each string represents the ID of the selected entity.

### With Models Builder

```csharp
@if(Model.MyDataItems.Any()){
  <ul>
    @foreach(var item in Model.MyDataItems){
      <li>@item</li>
    }
  </ul>
}
```

### Without Models Builder

```csharp
@if(Model.HasValue("MyDataItems"))
{
 var myDataItems = Model.Value<IEnumerable<string>>("MyDataItems");
  <ul>
    @foreach(var item in myDataItems)
    {
      <li>@item</li>
    }
  </ul>
}
```

### Content Delivery API
```json
// Missing example
```
