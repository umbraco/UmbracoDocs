---
versionFrom: 8.0.0
---

# Dropdown

`Alias: Umbraco.DropDown.Flexible`

`Returns: String` or `IEnumerable<string>`

Displays a list of preset values. Either a single value or multiple values (formatted as a collection of strings) can be returned.

## Settings

### Enable multiple choice

If enabled, editors will be able to select multiple values from the dropdown otherwise only a single value can be selected.

### Prevalues

Prevalues are the options which are shown in the dropdown list. You can add, edit, or remove values here.

## Data Type Definition Example

![Dropdown Data Type Definition](images/Dropdown-DataType-v8.png)

## Content Example

### Single Value

![Single dropdown content example](images/DropdownSingle-Content.png)

### Multiple Values

![Multiple dropdown content example](images/DropdownMultiple-Content.png)

## MVC View Example

### Typed - single item

```csharp
@if (Model.HasValue("category"))
{
    <p>@(Model.Value<string>("category"))</p>
}
```

### Typed - multiple items

```csharp
@if (Model.HasValue("categories"))
{
    var categories = Model.Value<IEnumerable<string>>("categories");
    <ul>
        @foreach (var category in categories)
        {
            <li>@category</li>
        }
    </ul>
}
```
