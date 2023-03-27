---
description: >-
  Details an integration available for Google Search Console, built and maintained by Umbraco HQ.
---

# Google Search Console Integration

This integration provides an extension for Umbraco CMS allowing programmatic access to URL-level data for properties managed in Google Search Console and the indexed version of a URL.

Install from NuGet via:
https://www.nuget.org/packages/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.URLInspectionTool

Source code is at:
https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.URLInspectionTool

Available on the Umbraco Marketplace at:
https://marketplace.umbraco.com/package/umbraco.cms.integrations.seo.googlesearchconsole.urlinspectiontool

## Prerequisites

Requires minimum versions of Umbraco:

- CMS V8: 8.4.0
- CMS V9: 9.0.1

## How To Use

### Authentication

The package uses OAuth2 security protocol for authentication. After the authorization process completes successfully,
the access token and the refresh token will be saved into the Umbraco database.

All requests to the Google Search Console API will include the access token in the authorization header.

### Working With the URL Inspection Tool

The URL Inspection Tool is accessible from each content node via the _URL Inspection_ content app.

If you haven't connected you Google account yet, you will be able to authorize your Umbraco application
by using the _Connect_ button. This will prompt the Google authorization window and at the end of the process you will receive
the access token and the refresh token.

You can also choose to remove access to Google Search Console API by triggering the _Revoke_ action. This will remove the access token and the refresh token
from the database.

Before you can properly use the URL Inspection Tool to retrieve data from the Search Console API you
will need to register the domain of you Umbraco website as a property in [Google Search Console](https://search.google.com/search-console).

After Google has verified your ownership, the _URL Inspection_ tool will provide the proper results. Otherwise a _PERMISSION_DENIED_
error will be prompted.

The URL Inspection Tool API expects three parameters, two mandatory:
- inspectionUrl - fully-qualified URL to inspect. Must be under the property specified in "siteUrl".
- siteUrl - the URL of the property as defined in Search Console.
- languageCode - optional; default value is "en-US".

More information can be found [here](https://developers.google.com/webmaster-tools/v1/urlInspection.index/inspect)

