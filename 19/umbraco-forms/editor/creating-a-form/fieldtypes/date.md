# Date

The Date field lets a visitor pick a date. It uses the date picker built into the visitor's browser, which shows the date in the visitor's own format.

Forms stores the date in a standard format, so dates entered in different locales don't get mixed up.

Use the **Minimum date** and **Maximum date** settings to limit which dates a visitor can pick.

The **Placeholder** setting has no effect in the default theme, because browsers don't show a placeholder in a date field.

To use a different date picker, a developer can override the `FieldType.DatePicker.cshtml` view in a custom theme. For more information, see the [Field Types](../../../developer/field-types.md#date-picker) article.
