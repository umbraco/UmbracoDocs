# Entity Data Picker

`Schema Alias: Umbraco.EntityDataPicker`

`UI Alias: Umb.PropertyEditorUi.EntityDataPicker`

`Returns: Umbraco.Cms.Core.Models.EntityDataPickerValue`

`Supported Data Source Types:` [Picker](../../../../customizing/property-editors/data-source-types/picker/README.md)

The Entity Data Picker property editor allows editors to pick one or more entities from a configurable data source. The selected entities are stored as an array of strings, where each string represents the ID of the selected entity.

### With Models Builder

```razor
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<EntityDataPickerTest>
@{
    Layout = null;
}
<html lang="en">
<head>
    <title>Entity Data Picker</title>
</head>
<body>
@if (Model.MyEntityPicker is null)
{
    <p>No entity picker value found</p>
}
else
{
    <p>Data source: <strong>@Model.MyEntityPicker.DataSource</strong></p>
    <p>Picked IDs:</p>
    <ul>
        @foreach (string id in Model.MyEntityPicker.Ids)
        {
            <li>@id</li>
        }
    </ul>
}
</body>
</html>
```

### Without Models Builder

```razor
@using Umbraco.Cms.Core.Models
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = null;
    var entityDataPickerValue = Model.Value<EntityDataPickerValue>("myEntityPicker");
}
<html lang="en">
<head>
    <title>Entity Data Picker</title>
</head>
<body>
@if (entityDataPickerValue is null)
{
    <p>No entity picker value found</p>
}
else
{
    <p>Data source: <strong>@entityDataPickerValue.DataSource</strong></p>
    <p>Picked IDs:</p>
    <ul>
        @foreach (string id in @entityDataPickerValue.Ids)
        {
            <li>@id</li>
        }
    </ul>
}
</body>
</html>
```
