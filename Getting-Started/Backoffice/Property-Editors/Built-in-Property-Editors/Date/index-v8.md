---
versionFrom: 8.0.0
---
# DateTime

`Returns: DateTime`

Displays a calendar UI for selecting dates which are saved as a DateTime value.

## Data Type Definition Example

![Data Type Definition Example](images/DateTime-DataType.png)

The only setting that is available for manipulating the Date property is to set a format. By default the format of the date in the Umbraco backoffice will be `YYYY-MM-DD`, but you can easily change this to something else. See [MomentJS.com](https://momentjs.com/) for the supported formats.

## Content Example

![Content Example](images/Date-Time-Content.png)

## MVC View Example - displays a datetime

### With Modelsbuilder

```csharp
@Model.DatePicker
@Model.Value("datePicker")
```

### Without Modelsbuilder

```csharp
@Model.Value<DateTime>("datePicker")
```