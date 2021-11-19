---
versionFrom: 9.1.0
meta.Title: "Umbraco Content Settings"
meta.Description: "Information on the content settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Content Settings

Content settings contains various settings regarding content in the CMS, such as allowed upload files, image settings, and much more. All the values in the content settings has default values, so all configuration is optional.

To get an overview of the keys and values in the global section, the following snippet will contain all available options, along with their default values:

```json
"Umbraco": {
  "CMS": {
    "Content": {
      "ResolveUrlsFromTextString": false,
      "Error404Collection": [],
      "PreviewBadge": "",
      "MacroErrors": "Inline",
      "DisallowedUploadFiles": ["ashx", "aspx", "ascx", "config", "cshtml", "vbhtml", "asmx", "air", "axd", "xamlx"],
      "AllowedUploadFiles": [],
      "ShowDeprecatedPropertyEditors": false,
      "LoginBackgroundImage": "~/assets/img/login.jpg",
      "LoginLogoImage": "~/assets/img/application/umbraco_logo_white.svg",
      "Notifications": {
        "Email": "",
        "DisableHtmlEmail": false
      },
      "Imaging": {
        "ImageFileTypes": ["jpeg", "jpg", "gif", "bmp", "png", "tiff", "tif"],
        "AutoFillImageProperties": {
          "Alias": "umbracoFile",
          "WidthFieldAlias": "umbracoWidth",
          "HeightFieldAlias": "umbracoHeight",
          "LengthFieldAlias": "umbracoBytes",
          "ExtensionFieldAlias": "umbracoExtension"
        }
      },
      "ContentVersionCleanupPolicy": {
        "EnableCleanup": false,
        "KeepAllVersionsNewerThanDays": 7,
        "KeepLatestVersionPerDayForDays": 90
      }
    }
  }
}
```

## Root level settings

In the root level section, that is those without a seperate sub section like Imaging, you can configure:

### Resolve urls from text string

This setting is used when you're running Umbraco in virtual directories. Setting this to true can increase render time for pages with a large number of links, however, this is required if Umbraco is running in a virtual directory.

### Error 404 collection

In case of a 404 error (page not found) Umbraco can return a default page instead. This is set here. Notice you can also set a different error page, based on the current culture so a 404 page can be returned in the correct language.

```json
"Error404Collection": [{
  "ContentId": 1,
  "Culture": "en-US"
}]
```

The above example shows what you need to do if you only have a single site that needs to show a custom 404 page. You specify which node that should be shown when a request for a non-existing page is being made. You can specify the node in three ways:

1. Enter the nodes **id** (`"ContentId": 1`)
2. Enter the node's **GUID** (`"ContentKey": "4f96ffdd-b969-46a8-949e-7935c41fabc0"`)
3. Enter the XPath to find the node (`"ContentXPath": "/root/Home//TextPage[@urlName = 'error404'"`)

:::note

- Ids are usually local to the specific solution (so won't point to the same node in two different environments if you're using Umbraco Cloud).
- GUIDs are universal and will point to the same node on different environments, provided the content was created in one environment and deployed to the other(s).
- When using XPath, there is no "context" (i.e. you can't find the node based on "currentPage") so needs to be a global absolute path.

:::

:::warning Remember to recycle the app pool to make sure changes to this section take effect. 

:::

If you have multiple sites, with different cultures, setup in your tree then you will need to setup the errors section like below:

```json
"Error404Collection": [
  {
    "ContentId": 1,
    "Culture": "default"
  },
  {
    "ContentId": 200,
    "Culture": "en-US"
  }]
```

If you have more than two sites and for some reason forget to update the above section with a 404 page and a culture then the default page will act as a fallback. Same happens if you for some reason forget to define a hostname on a site.

### Preview badge

This allows you to customize the preview badge being shown when you're previewing a node.

```json
"PreviewBadge": "<![CDATA[<a id=\"umbracoPreviewBadge\" style=\"position: absolute; top: 0; right: 0; border: 0; width: 149px; height: 149px; background: url('{1}/preview/previewModeBadge.png') no-repeat;\" href=\"{0}/endPreview.aspx?redir={2}\"><span style=\"display:none;\">In Preview Mode - click to end</span></a>]]>"
```

### Macro errors

This setting allows you to specify how errors in macros should be handled.

Options:
* Inline - Default Umbraco behavior, show an inline error within the macro but allow the page to continue rendering.
* Silent - Silently suppress the error and do not display the offending macro.
* Throw - Throw an exception.
* Content - Silently suppress the error, and dusplay custom content reported in the error event args.

### Disallowed upload files

This setting consists of a list of file extensions that editors shouldn't be allowed to upload via the backoffice.

### Allowed upload files

If greater control is required than available from the above, this setting can be used to store a list of file extensions. If provided, only files with these extensions can be uploaded via the backoffice.

### Show deprecated property editors

This setting is used for controlling whether or not the data types marked as obsolete should be visible in the dropdown when creating new data types.

By default this is set to false. To make the obsolete data types visible in the dropdown change the value to **true**

### Login background image

You can specify your own background image for the login screen here. The image will automatically get an overlay to match backoffice colors. This path is relative to the `wwwroot/umbraco` path. The default location is: `wwwroot/umbraco/assets/img/installer.jpg`.

### Login logo image

You can specify your own image for the small logo in the top left cornor of the login screen. This path is relative to the `wwwroot/umbraco` path. The default location is: `wwwroot/umbraco/assets/img/application/umbraco_logo_white.svg`.

## Notifications

Umbraco can send out email notifications, set the sender email address for the notifications emails here. To set the SMTP server used to send the emails, edit the standard SMTP section in the global section, see [global settings](../GlobalSettings/index-v9.md) for more information.


## Imaging

This section is used for managing how umbraco handles images, allowed attributes and, which properties of an image that should be automatically updated on upload.

```json
"Imaging": {
  "ImageFileTypes": ["jpeg", "jpg", "gif", "bmp", "png", "tiff", "tif"],
  "AutoFillImageProperties": {
    "Alias": "umbracoFile",
    "WidthFieldAlias": "umbracoWidth",
    "HeightFieldAlias": "umbracoHeight",
    "LengthFieldAlias": "umbracoBytes",
    "ExtensionFieldAlias": "umbracoExtension"
  }
}
```

Let's break it down.

### ImageFileTypes

This is a separated list of accepted image formats

### AutoFillImageProperties

You can define what properties should be automatically updated when an image is being uploaded. This means that if you decide to rename the default **umbracoWidth** and **umbracoHeight** properties to **width** and **height** then the values in **`"WidthFieldAlias"`** and **`"HeightFieldAlias"`** need to be updated with the new property aliases. This needs to happen in order to automatically populate the values when the image is being uploaded.

### Custom media document

If you need to create a custom media document type to handle images called something like "Custom Image" with an alias of **customImage** then you need to add another object where the **alias** is set to **customImage**. Like below. Note that the width and height attributes have also been changed in this example.

```json
"Imaging": {
  "ImageFileTypes": ["jpeg", "jpg", "gif", "bmp", "png", "tiff", "tif"],
  "AutoFillImageProperties": [
    {
      "Alias": "umbracoFile",
      "WidthFieldAlias": "umbracoWidth",
      "HeightFieldAlias": "umbracoHeight",
      "LengthFieldAlias": "umbracoBytes",
      "ExtensionFieldAlias": "umbracoExtension"
    },
    {
      "Alias": "customImage",
      "WidthFieldAlias": "width",
      "HeightFieldAlias": "height",
      "LengthFieldAlias": "umbracoBytes",
      "ExtensionFieldAlias": "umbracoExtension"
    }
  ]
}
```

## ContentVersionCleanupPolicy

The global settings for the scheduled job which cleans up historic content versions, these settings can be overridden per document type.

Current draft and published versions will never be removed, nor will individual content versions which have been marked as "preventCleanup".

See [Content Version Cleanup](/documentation/Fundamentals/Data/Content-Version-Cleanup/index.md) for more details on overriding configuration and preventing cleanup of specific versions.

```json
"ContentVersionCleanupPolicy": {
  "EnableCleanup": false,
  "KeepAllVersionsNewerThanDays": 7,
  "KeepLatestVersionPerDayForDays": 90
}
```

If you don't wish to retain any content versions except for the current draft and currently published you can set both of the
"keep" settings values to 0, after which the next time the scheduled job runs (hourly) all non-current versions (except
 those marked "prevent cleanup") will be removed.

### EnableCleanup

When true a scheduled job will delete historic content versions that are not kept according to the policy every hour.

When false, the scheduled job will never delete any content versions regardless of overridden settings for a document type.

This defaults to false when not set in the configuration which will be the case for those upgrading from v9.0.0, however, the dotnet new template will supply an appsettings.json with the value set to true for all sites starting from v9.1.0.

### KeepAllVersionsNewerThanDays

All versions that fall in this period will be kept.

### KeepLatestVersionPerDayForDays

For content versions that fall in this period, the most recent version for each day is kept but all previous versions for that day are removed unless marked as preventCleanup.

This variable is independent of KeepAllVersionsNewerThanDays, if both were set to the same value KeepLatestVersionPerDayForDays would never apply as KeepAllVersionsNewerThanDays is considered first.