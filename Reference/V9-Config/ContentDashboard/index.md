---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Umbraco Content Dashboard Settings"
meta.Description: "Information on the content dashboard settings section"
---

# Content Dashboard Settings

Allows you to configure the content dashboard settings for Umbraco.

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

Gets a value indicating whether the content dashboard should be available to all users.
`true` if the dashboard is visible for all user groups; otherwise, `false` and the default access rules for that dashboard will be in use.

## ContentDashboardPath

Gets the path to use when constructing the URL for retrieving data for the content dashboard.

## ContentDashboardUrlAllowlist

Gets the allowed addresses to retrieve data for the content dashboard.
No addresses specified indicates that any URL is allowed.

