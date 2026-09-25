---
description: >-
  Why you should maintain templates, partial views, stylesheets, and JavaScript
  files in your project using an IDE instead of the backoffice.
---

# Managing Views and Assets

Templates, partial views, stylesheets, and JavaScript files are all files in your Umbraco project. Templates and partial views are Razor views, and stylesheets and JavaScript files are static assets.

The backoffice can create and edit these files, but managing them there isn't the recommended approach for most projects. Instead, maintain these files in your project using an IDE, and keep them in source control with the rest of your code. For more information, see [Source Control](../application-code/backend-and-custom-logic/source-control.md).

## Limitations of Backoffice Editing

### Limited Editor Tooling

The backoffice editors are plain text editors. They don't offer the tooling an IDE gives you, such as IntelliSense, linting, or formatting.

### Changes Can Be Lost

Depending on how you deploy, edits made in the backoffice of a deployed site might not move to your other environments. The next deployment can also overwrite them.

### Templates and Partial Views

Templates and partial views contain C# code, but the backoffice editor doesn't warn you about errors in it. Nothing flags a mistyped property name or a missing `using` directive before you save. Mistakes only surface when the page renders.

The runtime mode of your site also affects backoffice editing:

* In `Production` runtime mode, creating, editing, renaming, and deleting templates and partial views in the backoffice is blocked entirely. For more information, see [Runtime Modes](../../run-in-production/runtime-modes.md).
* Outside `Production`, backoffice changes take effect immediately only in `BackofficeDevelopment` mode (the default) with the `Umbraco.Cms.DevelopmentMode.Backoffice` package installed. Otherwise, you must rebuild and restart the site. For details, see ["InMemoryAuto models builder and Razor runtime compilation have moved into their own package"](../../get-started/upgrading-and-migrating/version-specific/README.md#umbraco-17) in the Version-specific upgrades guide.

## When to Use the Backoffice

The backoffice is still a good way to scaffold a starting point:

* Generate a template alongside a new Document Type. For more information, see [Working with Templates](templates.md).
* Create a partial view from one of the built-in snippets. For more information, see [Partial Views](design/partial-views.md).

After the file is created, continue editing it in an IDE.

## Where the Files Live

| File type | Default location |
| --- | --- |
| Templates | `Views` |
| Partial views | `Views/Partials` |
| Stylesheets | `wwwroot/css` |
| JavaScript files | `wwwroot/scripts` |

Your site can serve stylesheets and JavaScript from anywhere under `wwwroot`, so these files don't have to sit in the default folders. The backoffice only lists the folders set by the `UmbracoCssPath` and `UmbracoScriptsPath` settings. For more information, see [Global Settings](../configuration/globalsettings.md).

## Adding Files Outside the Backoffice

Stylesheets and JavaScript files in the folders set by `UmbracoCssPath` and `UmbracoScriptsPath` appear in the backoffice, even when you add or edit them elsewhere. Click **...** next to the **Stylesheets** or **Scripts** folder and select **Reload children** to see the changes.

Templates work differently. Templates are registered in the Umbraco database, so a `.cshtml` file you add to the `Views` folder doesn't appear in the backoffice on its own. Create a template in the backoffice with an alias that matches the file name without the `.cshtml` extension. For example, a template with the alias `homePage` uses the `Views/homePage.cshtml` file. Umbraco keeps your existing file content instead of overwriting it. For more information, see [Working with Templates](templates.md).

## Related Articles

* [Working with Templates](templates.md)
* [Partial Views](design/partial-views.md)
* [Stylesheets and JavaScript](design/stylesheets-javascript.md)
