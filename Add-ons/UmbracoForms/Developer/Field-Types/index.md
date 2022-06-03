---
versionFrom: 7.0.0
versionTo: 10.0.0
meta.Title: "Umbraco Forms Field Types"
---

# Field Types

Umbraco Forms comes with a various number of Field Types to allow you to request certain data in the forms that you design & build.
This documentation is to guide specific details about field types that we ship that require some detail in how they work.

## Date Picker

The date picker uses a front-end library called [PikaDay.js](https://github.com/dbushell/Pikaday) to display a UI to pick dates from.
As of version 4.4.0 of Umbraco Forms we have added the support for the Pikaday date picker to be localised based on the page the form is rendered on.
This displays the picked date in the correct locale. Using JavaScript we update a hidden field with a standard date format to send to the server for storing the record submission in a standard format. This is to avoid locale mixing up dates.

To achieve this a new Razor partial view is included `/Views/Partials/Forms/DatePicker.cshtml`. Once on a page with a form that includes a Date Picker, this includes the MomentJS library to help with the date locale formatting & the appropriate changes to Pikaday.js to support the locales.
If you wish to use a different DatePicker component this is the file that you would customise to your needs.

### datepicker configuration of the year range

The datepicker has one configuration setting  to control the number of year shown. The default is 10 years which makes the picker unusable for picking birth dates.

Go to `~/App_Data/UmbracoForms/umbracoforms.config` and update `<setting key="DatePickerYearRange" value="10" />` to a higher number (e.g. 100)
