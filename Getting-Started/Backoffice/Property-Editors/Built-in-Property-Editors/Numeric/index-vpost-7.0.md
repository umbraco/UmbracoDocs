---
keywords: numeric property editors v7.0 version7.0
versionFrom: 7.0.0
versionTo: 7.2.8
---

# Numeric

`Alias: Umbraco.Integer`

`Returns: Integer`

Numeric is an HTML input control for entering numbers. Since it's a standard HTML element the options and behaviour is all controlled by the browser and therefore is beyond the control of Umbraco.

## Data Type Definition Example

![Numeric Data Type Definition](images/7/numeric-datatype.png)

## Settings

## Content Example

![Numeric Content Definition](images/7/numeric-content.png)


## MVC View Example

```csharp
@{
    if(Model.Content.HasValue("amount")){
        <p>@(Model.Content.GetPropertyValue<string>("amount"))</p>
    }
}
```
