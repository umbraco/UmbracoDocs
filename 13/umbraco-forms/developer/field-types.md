# Field Types

Umbraco Forms comes with a number of Field Types to allow you to request certain data in the forms that you design & build. This documentation is to guide specific details about field types that we ship that require some detail in how they work.

## Date Picker

The date picker uses a front-end library called [PikaDay.js](https://github.com/dbushell/Pikaday) to display a UI to pick dates from. We have added the support for the Pikaday date picker to be localized based on the page the form is rendered on. This displays the picked date in the correct locale. In JavaScript, we update a hidden field with a standard date format. This is done to send the date to the server, ensuring the record submission is stored in a standard format. This is to avoid locale mixing up dates.

To achieve this a new Razor partial view is included `/Views/Partials/Forms/DatePicker.cshtml`. Once on a page with a form that includes a Date Picker, it also includes the MomentJS library to assist with date locale formatting. Additionally, there are appropriate changes to Pikaday.js to support the locales. If you wish to use a different DatePicker component this is the file that you would customize to your needs.

### Date Picker configuration of the year range

The `DatePicker` has one configuration setting to control the number of year shown. The default is 10 years which makes the picker unusable for picking birth dates.

Go to your `appsettings.json` and add:
```json
  "Umbraco": {
    "CMS": {
        ...
    },
    "Forms": {
      "FieldTypes": {
        "DatePicker": {
          "DatePickerYearRange": 12
        }
      }
     }
    }
```

You can then change the `DatePickerYearRange` to a higher number (for example 100).
