# Forms

### Installing uMarketingSuite Forms Addon

Tracking Umbraco Forms submissions, you need to ensure you have [Umbraco Forms](https://umbraco.com/products/add-ons/forms/) installed with a valid license from Umbraco HQ along with installing the [uMarketingSuite Forms Addon package from Nuget](https://www.nuget.org/packages/uMarketingSuite.UmbracoForms).

### Summary

uMarketingSuite measures interactions with Umbraco Forms on your website automatically if you include the [uMarketingSuite analytics JavaScript file](/analytics/clientside-events-and-additional-javascript-files/). No additional configuration is needed. The data is visualized in the backoffice in **Marketing** &gt; **Analytics** &gt; **Forms**.

We measure the following:

- The time a visitor started filling the form
- The time a visitor finished filling the form (i.e. when it was submitted)
- If the visitor has seen the form, i.e. whether it was in their viewport
- If the form was submitted successfully
    - Note this is based on client side validation only. If client side validation passes it is seen as a successful submit
- If the form raised any client side errors, and how many.
- Focus/unfocus events of each field and whether the field was empty or contained data at that time.

## The report

In you Analytics section you will see a tab "Forms" where all data about your forms is gathered.

![]()

In this overview you can see:

- How many times a form has been shown
- How many times a visitor started filling in the form
- The number of times a form was submitted (so filled in and hitting the "submit" button)
- How often a form was abandoned without submitting the form
- How many errors were triggered in the form

By clicking on the form you can drill down to this specific form and you see more details of the specific form fields. For each field you see:

- How many times did the field receive focus
- How often was this field the last field before a visitor abandoned the form
- How often an error was triggered on the specific field

![]()

This data gives you great insights on how to optimize your forms to create a better conversion rate.

Finally you can drilldown to a specific field to see which type of error was triggered; a validation error or a mandatory error.

### Tracking a visitor Form submissions

Using uMarketingSuite Forms addon it is possible to track a specific visitor to your website and see if they have made any form submissions. In order to do so, follow these simple steps:

- Edit an Umbraco Form you wish to track visitors for and go to the design view
- Add a new field to your form called '**Analytics - VisitorId**`
- Give the new form field a name such as **Visitor ID**
- In the settings of the field type called **Template** specify a URL such as this

https://**yoursite.com**/umbraco/#uMarketingSuite/profiles/profiles/insights?id=**[[visitor.id]]**

By setting this value to the URL of your website to a deep link to the uMarketingSuite profiles with the visitor ID, you will be able to click through directly to view the visitor profile from Forms workflows such as emails, slack messages etc and exported excel data

![]()

### Disable Umbraco Forms tracking

You can disable Umbraco Forms tracking either on form level or on field level by adding the attribute "**umarketingsuite-no-tracking**" to either the form tag or to a field tag (i.e. input / select / textarea).