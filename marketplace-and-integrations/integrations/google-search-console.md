---
description: >-
  Details an integration available for Google Search Console, built and
  maintained by Umbraco HQ.
---

# Google Search Console

This integration provides an extension for Umbraco CMS. It provides details on indexed URLs managed in Google Search Console.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.URLInspectionTool)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.UrlInspectionTool)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.seo.googlesearchconsole.urlinspectiontool)

## Minimum version requirements

### Umbraco CMS

| Major      | Minor/Patch |
| ---------- | ----------- |
| Version 8  | 8.4.0       |
| Version 9  | 9.0.1       |
| Version 10 | 10.0.0      |
| Version 11 | 11.0.0      |

## Authentication

The package uses the OAuth2 security protocol for authentication. After the authorization process completes successfully, the access token and the refresh token will be saved into the Umbraco database.

All requests to the Google Search Console API will include the access token in the authorization header.

## Working With the URL Inspection Tool

The URL Inspection Tool is accessible from each content node via the **URL Inspection** content app.

If you haven't connected your Google account yet, you can authorize your Umbraco application by using the _Connect_ button. This will prompt the Google authorization window and at the end of the process, you will receive the access token and the refresh token.

You can also choose to remove access to Google Search Console API by triggering the _Revoke_ action. This will remove the access token and the refresh token from the database.

Before you can retrieve data from the Search Console API you need to register the domain of your Umbraco website. This is done at the [Google Search Console](https://search.google.com/search-console).

After Google has verified your ownership, the _URL Inspection_ tool will provide the proper results. Otherwise, a "permission denied" error will be shown.

## The URL Inspection Tool API

The URL Inspection Tool API expects three parameters, two mandatory:

* InspectionUrl - a fully-qualified URL to inspect. It must be under the property specified in "siteUrl".
* SiteUrl - the URL of the property as defined in the Search Console.
* LanguageCode - optional; the default value is "en-US".

More information can be found [in the official Google Developers documentation](https://developers.google.com/webmaster-tools/v1/urlInspection.index/inspect).
