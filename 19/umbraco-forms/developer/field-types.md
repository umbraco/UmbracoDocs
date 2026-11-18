# Field Types

Umbraco Forms comes with a number of Field Types to allow you to request certain data in the forms that you design & build. This documentation is to guide specific details about field types that we ship that require some detail in how they work.

## Date Picker

The Date field in the default theme renders a native HTML `<input type="date">`. The browser provides the date picker and shows the date in the visitor's own format. The submitted value is always in the `yyyy-MM-dd` format, so dates from different locales are stored the same way.

The **Minimum date** and **Maximum date** settings render as the input's `min` and `max` attributes.

The view is `/Views/Partials/Forms/Themes/default/Fieldtypes/FieldType.DatePicker.cshtml`. To use a different date picker component, override this view in a custom theme. For more information, see the [Themes](themes.md) article.

### Date Picker configuration for custom themes

The default theme doesn't use the `DatePickerYearRange` and `DatePickerFormat` settings. They remain available for a custom theme that renders its own date picker.

For example, to show a range of 100 years, add the following to your `appsettings.json` file:

```json
  "Umbraco": {
    "CMS": {
        ...
    },
    "Forms": {
      "FieldTypes": {
        "DatePicker": {
          "DatePickerYearRange": 100
        }
      }
     }
    }
```
