---


meta.Title: "Umbraco Content Dashboard Settings"
description: "Information on the content dashboard settings section"
---

# Content Dashboard Settings

Allows you to configure the Content Dashboard settings for Umbraco.

```json
{
  "Umbraco": {
    "CMS": {
      "ContentDashboard": {
        "AllowContentDashboardAccessToAllUsers": false,
        "ContentDashboardPath": "cms",
        "ContentDashboardUrlAllowlist": []
      }
    }
  }
}
```

## AllowContentDashboardAccessToAllUsers

Gets a value indicating whether the Content Dashboard should be available to all users.

When the value is `true` the dashboard is visible for all user groups. Otherwise, when the value is `false`, the default access rules for that dashboard will be in use.

## ContentDashboardPath

Gets the path to use when constructing the URL for retrieving data for the content dashboard.

## ContentDashboardUrlAllowlist

Gets the allowed addresses to retrieve data for the content dashboard.

No addresses specified indicates that any URL is allowed.

