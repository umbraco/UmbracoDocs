---
versionFrom: 8.0.0
---

# DateTime

`Returns: DateTime`

Displays a calendar UI for selecting dates which are saved as a DateTime value.

## Data Type Definition Example

![Data Type Definition Example](images/date-time-v8.png)

The only setting that is available for manipulating the Date property is to set a format. By default the format of the date in the Umbraco backoffice will be `YYYY-MM-DD HH:mm:ss`, but you can easily change this to something else. See [MomentJS.com](https://momentjs.com/) for the supported formats.

## Content Example

![Content Example](images/date-picker-v8.png)

## MVC View Example - displays a datetime

### With Modelsbuilder

```csharp
@Model.DatePicker
```

### Without Modelsbuilder

```csharp
@Model.Value("datePicker")
```