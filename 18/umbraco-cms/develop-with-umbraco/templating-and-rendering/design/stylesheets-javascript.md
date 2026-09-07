---
description: Information on working with stylesheets and JavaScript in Umbraco.
---

# Stylesheets And JavaScript

Stylesheets and JavaScript files control the appearance and behavior of your website. In Umbraco, these files live in the `wwwroot` folder of your project. You can also manage them from the backoffice.

This article explains how to work with stylesheets and JavaScript and clarifies how styling works with the Rich Text Editor (RTE) Data Type.

{% hint style="warning" %}
Managing stylesheets and JavaScript through the backoffice is not the recommended approach for most projects. The backoffice editor doesn't integrate with source control, build tooling, or local testing.

Maintain these files in your project using your own IDE, and deploy them through your regular build and deployment process. For more information, see [Source Control](../../application-code/backend-and-custom-logic/source-control.md).

Your site can serve stylesheets and JavaScript from anywhere under `wwwroot`, so these files don't have to sit in the folders shown below. The backoffice only lists the folders set by the `UmbracoCssPath` and `UmbracoScriptsPath` settings, which default to `wwwroot/css` and `wwwroot/scripts`. For more information, see [Global Settings](../../configuration/globalsettings.md).

Files you add or edit in those folders still appear in the backoffice. Click **...** next to the **Stylesheets** or **Scripts** folder and select **Reload children** to see the changes.
{% endhint %}

## Stylesheets in the Backoffice

Stylesheets are used to define how your website content is displayed. You can create and manage CSS files from the **Settings** section.

### Creating a stylesheet

To create a stylesheet:

1. Go to **Settings** section in the backoffice.
2. Expand the **Stylesheets** folder.
3. Click the **⋯** (options) menu.
4. Select **Create**.

![Creating a new stylesheet](../../../.gitbook/assets/creating-stylesheet.png)

5. Select **Stylesheet file**.
6. Give the file a name and add your CSS.

![Stylesheet Editor](../../../.gitbook/assets/stylesheet-editor.png)

7. Click **Save**.

The stylesheet is saved in the `wwwroot/css` folder of your project by default.

### Using stylesheets

Stylesheets created in the backoffice are standard CSS files. To use them on your website, reference them in your templates or layout files:

![Linking CSS in template](../../../.gitbook/assets/linking-stylesheet.png)

```html
<link rel="stylesheet" href="@Url.Content("~/css/umbraco-starterkit-style.css")"/>
```

or

```html
<link rel="stylesheet" href="/css/mystylesheet.css" />
```

## JavaScript files in the Backoffice

JavaScript files can also be created and managed from the backoffice.

### Creating a JavaScript file

To create JavaScript files:

1. Go to **Settings** section in the backoffice.
2. Expand the **Scripts** folder.
3. Click the **⋯** (options) menu.
4. Select **Create**.

![Creating a new JavaScript](../../../.gitbook/assets/creating-scripts.png)

5. Select **JavaScript file**.
6. Give the file a name and add your JavaScript code.

![Sample JavaScript](../../../.gitbook/assets/sample-Javacsript.png)

7. Click **Save**.

The JavaScript is saved in the `wwwroot/scripts` folder of your project by default.

### Using JavaScript files

Navigate to the template where you would like to reference your scripts:

```html
<script src="/scripts/myScript.js"></script>
```

![Reference the script in template](../../../.gitbook/assets/script-reference.png)

## Rich Text Editor styling

Editor styles are configured using the Style Menu in RTE. To provide editors with predefined styles such as classes, tags, or IDs, you must configure them as part of the Style Menu configuration. For more information, see the [Rich Text Editor](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/style-menu#creating-a-custom-style-select-menu) article.

{% hint style="info" %}
Styles defined in your CSS must still exist for the frontend, but they will not automatically appear in the Rich Text Editor.
{% endhint %}

If content appears differently in the backoffice editor than on the frontend, it may be caused by additional stylesheets applied in your site.
