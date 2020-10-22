---
versionFrom: 8.0.0
---

# Decimal

`Alias: Umbraco.Decimal`

`Returns: decimal`

## Data Type Definition Example

![Data Type Definition Example](images/definition-example.png)

In the example above the possible values for the input field would be [8, 8.5, 9, 9.5, 10]

*All other values will be removed in the content editor when saving or publishing.*

If the value of **Step Size** is not set then all decimal values between 8 and 10 is possible to input in the content editor.

## Content Example

![Content Example](images/content-example.png)

## MVC View Example
### With Modelsbuilder
```csharp
@Model.MyDecimal
```
### Without Modelsbuilder
```csharp
@Model.Value("MyDecimal")
```
