---
versionFrom: 7.0.0
---

# Checkbox List

`Alias: Umbraco.CheckBoxList`

`Returns: Comma Separated String`

Displays a list of preset values as a list of checkbox controls.

*NOTE: Unlike other property editors, the Prevalue IDs are not directly accessible in Razor*

## Data Type Definition Example

![True/Checkbox List Definition](images/checkbox-list-setup.png)

## Content Example

![Checkbox List Example](images/checkbox-list-content.png)

## MVC View Example

### Typed

```csharp
@{
    if (Model.Content.HasValue("superHeros"))
    {
        <ul>
            @foreach (var item in Model.Content.GetPropertyValue<IEnumerable<string>>("superHeros"))
            {
                <li>@item</li>
            }
        </ul>
    }
}
```

### Dynamic (Obsolete)

:::warning
See [Common pitfalls](https://our.umbraco.com/documentation/reference/Common-Pitfalls/#dynamics) for more information about why the dynamic approach is obsolete.
:::

```csharp
@{
    if (CurrentPage.HasValue("superHeros"))
    {
        <ul>
            @foreach (var item in CurrentPage.superHeros.Split(','))
            {
                <li>@item</li>
            }
        </ul>
    }
}
```
