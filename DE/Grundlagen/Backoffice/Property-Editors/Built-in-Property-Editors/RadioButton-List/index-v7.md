---
versionFrom: 7.0.0
---

# Radiobutton List

`Returns: Prevalue ID`

Pretty much like the name indicates this Data type enables editors to choose from list of radiobutton

## Data Type Definition Example

![Radiobutton List Data Type Definition](images/RadioButton-List-DataType-v7.png)

## Content Example

![Radiobutton List Content](images/RadioButton-List-Content-v7.png)

## MVC View Example

### Typed

```csharp
@if (Model.Content.HasValue("miniFigure"))
{
    var preValue = Umbraco.GetPreValueAsString(Model.Content.GetPropertyValue<int>("miniFigure"));
    <p>@preValue</p>
}
```

### Dynamic (Obsolete)

See [Common pitfalls](https://our.umbraco.com/documentation/reference/Common-Pitfalls/#dynamics) for more information about why the dynamic approach is obsolete.

```csharp
@if (CurrentPage.HasValue("miniFigure"))
{
    var preValue = Umbraco.GetPreValueAsString(CurrentPage.miniFigure);
    <p>@preValue</p>
}
```
