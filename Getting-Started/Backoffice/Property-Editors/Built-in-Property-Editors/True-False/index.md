---
versionFrom: 8.0.0
---

# Checkbox

`Returns: Boolean`

Checkbox is a standard checkbox which saves either 0 or 1, depending on the checkbox being checked or not.

## Data Type Definition Example

![True/False Data Type Definition](images/Checkbox-Data-Type.png)

The Checkbox property has a setting which allows you to set the default value of the checkbox, either checked (true) or unchecked (false).

It is also possible to define a label, that will be displayed next to the checkbox on the content.

## Content Example

![No Edit Content Example](images/Checkbox-Content.png)

## MVC View Example

```csharp
@{
    if (!Model.Value<bool>("myCheckBox"))
    {
        <p>The Checkbox is not checked!</p>
    }
}
```