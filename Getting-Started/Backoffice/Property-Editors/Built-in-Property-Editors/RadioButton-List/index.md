---
versionFrom: 8.0.0
---

# Radiobutton List

`Alias: Umbraco.RadioButtonList`

`Returns: string`

Pretty much like the name indicates this Data type enables editors to choose from list of radio buttons and returns the value of the selected item as string.

## Data Type Definition Example

![Radiobutton List Data Type Definition](images/RadioButton-List-DataType-v8.png)

## Content Example

![Radiobutton List Content](images/RadioButton-List-Content-v8.png)

## MVC View Example

### Typed

#### Without Modelsbuilder
```csharp
@if (Model.HasValue("colorTheme"))
{
    var value = Model.Value("colorTheme");
    <p>@value</p>
}
```

#### With Modelsbuilder
```csharp
@if (Model.HasValue("colorTheme"))
{
    var value = Model.ColorTheme;
    <p>@value</p>
}
```
