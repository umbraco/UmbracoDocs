---
versionFrom: 8.0.0
---

# Label

`Alias: Umbraco.Label`

`Returns: String`

Label is a non-editable control and can only be used to display a pre-set text.

## Data Type Definition Example

![Label Data Type Definition](images/Textbox-Setup-v8.png)

## Content Example

![Label Content Example](images/Textbox-Content-v8.png)

## MVC View Example

```csharp
@{
    if (Model.HasValue("pageLabel")){
        <p>@(Model.Value("pageLabel"))</p>
    }
}
```
