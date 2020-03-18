---
versionFrom: 7.0.0
---

# Date

`Returns: Date`

Displays a calendar UI for selecting dates which are saved as a DateTime value.

## Data Type Definition Example

![Data Type Definition Example](images/DateTime-DataType.png)

The only setting that is available for manipulating the Date property is to set a format. By default the format of the date in the Umbraco backoffice will be `YYYY-MM-DD`, but you can change this to something else. See [MomentJS.com](https://momentjs.com/) for the supported formats.

## Content Example

![Content Example](images/Date-Time-Content.png)

## MVC View Example - displays a datetime

### Typed

```csharp
@(Model.Content.GetPropertyValue<DateTime>("datePicker").ToString("dd MM yyyy"))
```

### Dynamic (Obsolete)

:::warning
See [Common pitfalls](https://our.umbraco.com/documentation/reference/Common-Pitfalls/#dynamics) for more information about why the dynamic approach is obsolete.
:::

```csharp
@{
    @CurrentPage.datePicker.ToString("dd-MM-yyyy")
}
```
