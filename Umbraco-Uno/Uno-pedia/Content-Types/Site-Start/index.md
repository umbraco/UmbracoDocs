---
versionFrom: 8.0.0
---

# Start (Site)

The Start page is based on a Content Type called "Site". It serves as the main page of the website, also called the frontpage or root page. When visitors visits the website, the Start page is the first this they will see.

As with most content types in Umbraco Uno, [widgets](../../Widgets) are used to build the structure and setup the content of the page. Add as many or as few widgets as necessary to populate the Start page.

:::note
The Start page also contains the SEO and the Settings groups for configuring various options around the page like whether or not to hide the footer content and what title should be used for SEO.

Learn more about these options in the [Specific Settings](../../Settings/Specific-Settings) article.
:::

## Navigation

The Start page also provides options for customizing the websites navigation menu. These can be found in the "Navigation" group, and any configuration set in that group will apply to all pages on the website.

The following provides details for each of the configuration option in the Navigation group.

### Custom navigation

The default navigation on any Umbraco Uno website is built based on pages added to the content tree in the Content section. Unless the "Hide In Navigation" is checked, all pages will automatically be added to the navigation menu in the header of the website.

To avoid the dynamically added navigation menu, this feature can be used to create a custom and static navigation.

Clicking "Add Content" will provide 2 options:

1. Navigation item and
2. Big Navigation

Learn more about the difference of these two as well as how to set them up in the [Navigation menu](../../../Creating-Content/Navigation-menu) article.

### Buttons

Add one or more buttons to the right-hand side of the navigation menu.

Read the [Buttons](../../Widgets/Buttons) article for more details on the various options for creating buttons.

### Phone Number and Email

Add contact information which will be visible on smaller screens such as tablets and phones. Both phone number and email will be places above the items in the navigation.

### Enable Sub Header

The sub header is placed above the default navigation menu. Use the "Sub Header Left" and "Sub Header Right" to populate the sub header with links and text and/or icons.

### Sub Header Left and Sub Header Right

Add items to the sub header in either the left or the right side of the page.

For each item in the header the following can be configured:

* Name (also used as the link text)
* Icon
* Custom icon color (default: gray)
* Link (external or internal)
* Children (sub pages)

### Disable Language Picker

Check this if the language picker should be hidden. This is only relevant for websites using multiple languages, as the picker will be visible by default once pages are pulished in more than one language.

## Footer

As with the Navigation group, the Footer group on the Start page, provides configuration options to customize the footer of the website. All options in this group will apply to the footer on each page on the website.

### Footer Columns

The footer section of the websites is setup much like the [Grid widget](../../Widgets/Grid), and provides a total of 7 different widgets:

* [Contact](../../Widgets/Contact)
* Navigation
* [Text](../../Widgets/Text)
* [Opening Hours](../../Widgets/Opening-hours)
* [Social Links](../../Widgets/Social-links)
* [Logos](../../Widgets/Logos)
* Line break

:::tip
To ensure a consistent structure of the footer, it's recommended that you define the *Column width* for each widget added to the footer section.
:::

### Bottom Text

Any text added to this field will be presented at the very bottom of the website.

A typical use for this placement is copyright statements and other important references.
