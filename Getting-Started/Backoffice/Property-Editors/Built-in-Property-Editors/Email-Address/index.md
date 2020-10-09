---
versionFrom: 8.0.0
---

# Dropdown

`Alias: Umbraco.DropDown.Flexible`

`Returns: String`

Displays an email address.

## Settings

### Enable required checkbox (8.7.0 and below)

If you type an email thats not correct the Umbraco will display a warning label under the property editor. When you publish the page that this editor is located on, Umbraco will clean the input.

If enabled, umbraco will display a warning label under the property editor when you publish the page this editor is located on and clean the input.

This functionality has been deprecated in `8.8.0` and above. You simply select the mandatory checkbox when adding the property editor to a document type.

## Data Type Definition Example

### 8.8.0 and higher
![Email Data Type Definition 8.8.0](images/EmailAddress-DataType-v8.8.png)

### Mandatory checkbox example
![Mandatory Checkbox Example](images/mandatory-checkbox.png)

### 8.0.0 - 8.7.0
![Email Data Type Definition 8.0.0 - 8.7.0](images/EmailAddress-DataType-v8.png)

## Content Example

![Single email address content example](images/EmailAddress-DataType-Content.png)

## MVC View Example

### Typed

```csharp
@if (Model.HasValue("email"))
{
    var emailAddress = Model.Value<string>("email");

    <p>@email</p>
}
```
