# Magic strings
Umbraco Forms has some magic strings that enable you to render values from various sources, such as Session, Cookies, Umbraco Page fields.

## Request
`[@SomeRequestItem]` this allows you to display an item from the current HTTPContext.Request with the key of SomeRequestItem
Eg `[@http_referer]` will populate a field with the HTTP referer.

## Session & Cookies
`[%SomeSessionOrCookieItem]` this allows you to display an item from the current HTTPContext.Session with the key of SomeSessionOrCookieItem. If it cannot be found in the collection of session keys, it will then try to find the item from the HttpContext.Cookies collection with the same key.

## Umbraco Page Field Item
`[#myUmbracoField]` this allows you to use the Umbraco document-type property myUmbracoField from the page containing the form.

## Recursive Umbraco Page Field Item
`[$myRecursiveItem]` this allows you to parse the Umbraco document-type property myRecursiveItem. So if the current page does not contain a value for this then it will request it from the parent up until the root or until it finds a value.

## Parsing Umbraco Form field items
`{myAliasForFormField}` this allows you to display the entered value for that specific field from the form submission. Used in workflows to send an automated email back to the customer based on the email address submitted in the form.

## Parsing Member properties from a form submission
`{member.FOO}` with the prefix of member. in the same syntax above will allow you to retrieve information about the submission if it was submitted by a logged in member.

## Where can I use these magic strings?
These magic strings as we call them can be used in Workflows property/settings. So a name and email address field from the form can be used in an email workflow to send the customer a personalised thank you email.

In addition to using these in Workflow settings, they can be used in default values in hidden fields for examples, normally referral codes from a session, cookie or request item.

## How can I parse these values elsewhere in my C# code or Razor Views?
The method `ParsePlaceHolders()` is a public extension method extending the `string` object and could be used with anything that you wish to try and replace the above tokens in a string.
You will need to reference the following namespace to ensure you can use this in your code `Umbraco.Forms.Core.Extensions`
