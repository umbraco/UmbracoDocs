---
versionFrom: 8.0.0
---

# Repeatable textstrings

`Alias: Umbraco.MultipleTextstring`

`Returns: array of strings`

The Repeatable textstrings property editor enables a content editor to make a list of text items. For best use with an unordered-list.

## Data Type Definition Example

![Repeatable textstrings Data Type Definition](images/Repeatable-Textstrings-DataType.png)

## Content Example

![Repeatable textstrings Content](images/Repeatable-Textstrings-Content.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@{
    if (Model.Value<string[]>("keyFeatureList").Length > 0)
    {
        <ul>
            @foreach (var item in Model.Value<string[]>("keyFeatureList"))
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
    if (Model.KeyFeatureList.Any())
    {
        <ul>
            @foreach (var item in Model.KeyFeatureList)
            {
                <li>@item</li>
            }
        </ul>
    }
}
```