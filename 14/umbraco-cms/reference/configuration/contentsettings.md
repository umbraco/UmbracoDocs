---
description: Information on the content settings section
---

# Content Settings

Content settings contains a handful of settings related to the content in the CMS. It includes settings such as allowed upload files, image settings, and much more. All the values in the content settings has default values, so all configuration is optional.

The following snippet will give an overview of the keys and values in the content section including the default values:

```json
"Umbraco": {
  "CMS": {
    "Content": {
      "ContentVersionCleanupPolicy": {
        "EnableCleanup": false,
        "KeepAllVersionsNewerThanDays": 7,
        "KeepLatestVersionPerDayForDays": 90
      },
      "AllowEditInvariantFromNonDefault": true,
      "AllowedMediaHosts":  [],
      "AllowedUploadedFileExtensions": [],
      "DisableDeleteWhenReferenced": false,
      "DisableUnpublishWhenReferenced": false,
      "DisallowedUploadedFileExtensions": ["ashx", "aspx", "ascx", "config", "cshtml", "vbhtml", "asmx", "air", "axd", "xamlx"],
      "Error404Collection": [],
      "HideBackOfficeLogo": false,
      "Imaging": {
        "ImageFileTypes": ["jpeg", "jpg", "gif", "bmp", "png", "tiff", "tif"],
        "AutoFillImageProperties": [
          {
            "Alias": "umbracoFile",
            "ExtensionFieldAlias": "umbracoExtension",
            "HeightFieldAlias": "umbracoHeight",
            "LengthFieldAlias": "umbracoBytes",
            "WidthFieldAlias": "umbracoWidth"
          }
        ]
      },
      "LoginBackgroundImage": "login/login.jpg",
      "LoginLogoImage": "login/logo_light.svg",
      "LoginLogoImageAlternative": "login/logo_dark.svg",
      "Notifications": {
        "DisableHtmlEmail": false,
        "Email": null
      },
      "PreviewBadge": "<![CDATA[<b>My HTML here</b>]]>",
      "ResolveUrlsFromTextString": false,
      "ShowDeprecatedPropertyEditors": false,
      "ShowDomainWarnings": true
    }
  }
}
```

## Root level settings

In the root level section, that is those without a separate sub section like Imaging, you can configure:

### Allow edit invariant from non-default

Invariant properties are properties on a multilingual site that are not varied by culture. This means that they share the same value across all languages added to the website.

When the setting is set to `false` the invariant properties that are shared between all languages can only be edited from the default language. This means you need access to the default language, in order to edit the property.

When set to `true` (default) the invariant properties will need to be unlocked before they can be edited. The lock exists in order to make it clear that this change will affect more languages.

### Allowed upload file extensions

If greater control is required than available from the `DisallowedUploadedFileExtensions` setting, this setting can be used to store a list of file extensions. If provided, only files with these extensions can be uploaded via the backoffice.

### Allowed media hosts

By default, only relative URLs are allowed when getting URLs for resized images or thumbnails using the ImagesController. If you need absolute URLs you will have to add the allowed hosts to this list. The value could be `["umbraco.com", "www.umbraco.com", "our.umbraco.com"]`.

### Disable delete when referenced

This setting allows you to specify whether a user can delete content or media items that depend on other items. This also includes any descendants that have dependencies. Setting this to **true** will remove or disable the _Delete_ button.

### Disable unpublish when referenced

This setting allows you to specify whether or not users can unpublish content items that depend on other items or have descendants that have dependencies. Setting this to **true** will disable the _Unpublish_ button.

### Disallowed upload file extensions

This setting consists of a list of file extensions that editors shouldn't be allowed to upload via the backoffice.

### Error 404 collection

In case of a 404 error (page not found) Umbraco can return a default page instead. This is set here. Notice you can also set a different error page, based on the current culture so a 404 page can be returned in the correct language.

```json
"Error404Collection": [
  {
    "ContentId": 1,
    "Culture": "en-US"
  }
]
```

The above example shows what you need to do if you only have a single site that needs to show a custom 404 page. You specify which node that should be shown when a request for a non-existing page is being made. You can specify the node in three ways:

1. Enter the nodes **id** (`"ContentId": 1`)
2. Enter the node's **GUID** (`"ContentKey": "4f96ffdd-b969-46a8-949e-7935c41fabc0"`)
3. Use [IContentLastChanceFinder](../../tutorials/custom-error-page.md#set-a-custom-404-page-using-icontentlastchancefinder) to find the node.

{% hint style="info" %}

* Ids are usually local to the specific solution (so won't point to the same node in two different environments if you're using Umbraco Cloud).
* GUIDs are universal and will point to the same node on different environments, provided the content was created in one environment and deployed to the other(s).
{% endhint %}

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

If you have more than two sites and forget to add a 404 page and a culture, the default page will act as fallback. Same happens if you for some reason forget to define a hostname on a site.

### Hide backoffice logo

This setting can be used to hide the Umbraco logo in backoffice.

### Login background image

You can specify your own background image for the login screen here. The image will automatically get an overlay to match backoffice colors. This path is relative to the `wwwroot/umbraco` path. The default location is: `wwwroot/umbraco/login/login.jpg`.

### Login logo image

You can specify your own image for the small logo in the top left corner of the login screen. This path is relative to the `wwwroot/umbraco` path. The default location is: `wwwroot/umbraco/login/logo_light.svg`.

### Login logo image (alternative)

You can specify your own alternative image for the small logo in the top left corner of the login screen. The alternative image is shown on light backgrounds (for example for mobile resolutions). This path is relative to the `wwwroot/umbraco` path. The default location is: `wwwroot/umbraco/login/logo_dark.svg`.

### Preview badge

This allows you to customize the preview badge being shown when you're previewing a node.

```json
"PreviewBadge": "<![CDATA[<a id=\"umbracoPreviewBadge\" style=\"position: absolute; top: 0; right: 0; border: 0; width: 149px; height: 149px; background: url('{1}/preview/previewModeBadge.png') no-repeat;\" href=\"{0}/endPreview.aspx?redir={2}\"><span style=\"display:none;\">In Preview Mode - click to end</span></a>]]>"
```

### Resolve urls from text string

This setting is used when you're running Umbraco in virtual directories. Setting this to true can increase render time for pages with a large number of links. However, this is required if Umbraco is running in a virtual directory.

### Show deprecated property editors

This setting is used for controlling whether or not the Data Types marked as obsolete should be visible in the dropdown when creating new Data Types.

By default this is set to `false`. To make the obsolete data types visible in the dropdown change the value to `true`.

### Show Domain Warnings

If you do not configure Domains for each language in a multilingual site then every time you publish your content you get this warning:

`Content published: Domains are not configured for multilingual site, please contact an administrator, see log for more information.`

If you have a use case for not setting the domains, you can set this setting **ShowDomainWarnings** to `false` to stop the warning from displaying.

## ContentVersionCleanupPolicy

The global settings for the scheduled job which cleans historic content versions. These settings can be overridden per Document Type.

Current draft and published versions will never be removed, nor will individual content versions which have been marked as "preventCleanup".

See [Content Version Cleanup](../../fundamentals/data/content-version-cleanup.md) for more details on overriding configuration and preventing cleanup of specific versions.

```json
"ContentVersionCleanupPolicy": {
  "EnableCleanup": false,
  "KeepAllVersionsNewerThanDays": 7,
  "KeepLatestVersionPerDayForDays": 90
}
```

To retain only the current draft and published version, set both the "keep" settings values to 0. The next time the scheduled job runs (hourly) all non-current versions (except those marked "prevent cleanup") will be removed.

### EnableCleanup

When set to `true`, a scheduled job will delete historic content versions that are not retained according to the policy every hour.

When set to `false`, the scheduled job will not delete any content versions, regardless of any overridden settings for a Document Type.

The dotnet new template provides an `appsettings.json` file with the default value set to `true` for all sites.

### KeepAllVersionsNewerThanDays

All versions that fall in this period will be kept.

### KeepLatestVersionPerDayForDays

For content versions that fall in this period, the most recent version for each day is kept. All previous versions for that day are removed unless marked as preventCleanup.

This variable is independent of `KeepAllVersionsNewerThanDays`, if both were set to the same value `KeepLatestVersionPerDayForDays` would never apply as `KeepAllVersionsNewerThanDays` is considered first.

## Imaging

This section is used for managing how Umbraco handles images, allowed attributes and, which properties of an image that should be automatically updated on upload.

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

You can define what properties should be automatically updated when an image is being uploaded. This means that if you decide to rename the default **umbracoWidth** and **umbracoHeight** properties the values in **`"WidthFieldAlias"`** and **`"HeightFieldAlias"`** need to be updated. This needs to happen in order to automatically populate the values when the image is being uploaded.

### Custom media document

If you need to create a custom Media Type to handle images you need to add another object using the custom Media Type alias. Like below. Keep in mind that the width and height attributes have also been changed in this example.

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

## Notifications

Umbraco can send out email notifications, set the sender email address for the notifications emails here. To set the SMTP server used to send the emails, edit the standard Simple Mail Transfer Protocol (SMTP) section in the global section, see [global settings](globalsettings.md) for more information.
