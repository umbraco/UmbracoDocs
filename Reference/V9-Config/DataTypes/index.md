---
versionFrom: 10.0.0
meta.Title: "Umbraco Data Types Settings"
meta.Description: "Information on the data types settings section"
---

# Data Types Settings

Allows you to configure the behavior of data types.

```json
{
  "Umbraco": {
    "CMS": {
      "DataTypes": {
        "CanBeChanged": "True"
      }
    }
  }
}
```

## CanBeChanged

Gets or sets a value indicating if data types can be changed after they've been used.

Valid values:

- `"True"`
  - Allows data types to be changed after creation. This can lead to data on content is not valid on the data type.
- `"False"`
  - Disallow data type changes. (Recommeded value, unless you really know what you are doing)
- `"FalseWithHelpText"`
  - Disallow data type changes, but show the users a help text so they understand why.
