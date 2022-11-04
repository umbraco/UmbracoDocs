---
meta.Title: "Umbraco Forms Developer Documentation"
meta.Description: "Developer documentation covering retrieving data, how to extend the system by hooking into the provider model, and describes the available events and workflows you can use to extend or integrate Umbraco Forms."
---

# Developer Documentation

Developer documentation covers working with Umbraco Forms from a developer standpoint. It covers retrieving data, extending the system by hooking into the provider model, and describing the events and workflows available to extend or integrate Umbraco Forms.

## [Preparing your Frontend](prepping-frontend.md)

Ensure you have the necessary client dependencies before adding a Form to your site.

## [Rendering Forms Scripts](rendering-scripts.md)

Control where you want Forms to render its JavaScript.

## [Themes](themes.md)

Themes provide an easier and efficient way of rendering Form HTML markup replacing the methods used in version 4.x.

## [Custom Markup](custom-markup.md)

Customize your Forms your way. You have full control over your Form's HTML markup and styling.

## [Email Templates](email-templates.md)

Sends custom HTML email templates using the **Send email with template (Razor)** workflow.

## [Working with Record Data](working-with-data.md)

Fetch and display record data from your Razor macros.

## [Persist Forms Data in the Umbraco Database](forms-in-the-database.md)

Persist all data from Umbraco Forms in the database. Configure your Umbraco Forms installation to migrate all forms data into the Umbraco database.

## [Extending](extending/README.md)

Extend Umbraco Forms with your own custom providers.

## [Configuration](configuration/README.md)

Look at some of the available configuration options to modify how Umbraco Forms works.

## [Security](security.md)

Understand the security model of Umbraco Forms.

## [Magic Strings](magic-strings.md)

Learn about the magic string formats that Umbraco Forms supports that can retrieve information from various sources such as Session, Cookies, Umbraco Page Fields, Member fields, Form fields to use in workflows.

## [Health Checks](healthchecks/README.md)

Introducing the health checks provided to confirm your Umbraco Forms installation is running as intended. Understand how to handle any issues reported.

## [Localization](localization.md)

Discusses how the backoffice for Umbraco Forms is available translated into the language your editors like to work with.

## [Content Apps](contentapps.md)

Adding an Umbraco content app to the Umbraco Forms backoffice section.

## [Headless/AJAX Forms](ajaxforms.md)

Umbraco Forms provides an API for client-side rendering and submission of forms, useful when you want to handle forms in a headless style scenario.

## [Block List Filters](blocklistfilters.md)

Customize the appearance of Umbraco's block list editor when adding a form to a block.

## [Storing prevalue text files with IPreValueTextFileStorage](iprevaluetextfilestorage.md)

Learn how you can implement a custom IPreValueTextFileStorage to store the prevalue text files to suit your needs.
