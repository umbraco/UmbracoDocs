# Date

The date picker uses a front-end library called [Pikaday](https://github.com/dbushell/Pikaday) to display a UI to pick dates.

![Date picker on frontend](images/date-picker.png)

Pikaday date picker can be localised based on the page the Form is rendered on.

The date picker displays the picked date in the required locale. Using JavaScript, a hidden field is updated with a standard date format to send to the server for storing record submissions. This avoids the locale mixing up the dates.

To achieve localized date, a Razor partial view is included at `/Views/Partials/Forms/Themes/default/DatePicker.cshtml`.

The **DatePicker.cshtml** includes the `moment-with-locales.min.js` library to help with the date locale formatting and the appropriate changes to Pikaday to support the locales. If you wish to use a different DatePicker component, edit the **DatePicker.cshtml** file as per your needs.

## Configure the Year range

The Date picker has a configuration setting to control the number of years shown in the picker. The default value is 10 years.

You can configure the settings in the `appSettings.json` file:

```json
 "Forms": {
     "FieldTypes": {
         "DatePicker": {
             "DatePickerYearRange": 10
                      }
                }
        }
```

Update `DatePickerYearRange` to a higher number (for example: 100) to increase the numbers of years available in the Date picker.
