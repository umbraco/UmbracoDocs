---
versionFrom: 8.0.0
---

# Checkbox List

`Alias: Umbraco.CheckBoxList`

`Returns: IEnumerable<string>`

Displays a list of preset values as a list of checkbox controls. The text saved is a IEnumerable collection of the text values.

*NOTE: Unlike other property editors, the Prevalue IDs are not directly accessible in Razor*

## Data Type Definition Example

![True/Checkbox List Definition](images/checkbox-list-setup-v8.png)

## Content Example

![Checkbox List Example](images/checkbox-list-content.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    if (Model.HasValue("superHeros"))
    {
        <ul>
            @foreach (var item in Model.Value<IEnumerable<string>>("superHeros"))
            {
                <li>@item</li>
            }
        </ul>
    }
}
```

### With Modelsbuilder

```csharp
@{
    if (Model.SuperHeros.Any())
    {
        <ul>
            @foreach (var item in Model.SuperHeros)
            {
                <li>@item</li>
            }
        </ul>
    }
}
```