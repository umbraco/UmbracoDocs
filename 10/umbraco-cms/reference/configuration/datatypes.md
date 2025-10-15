---

meta.Title: "Umbraco Data Types Settings"
description: "Information on the data types settings section"
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
  - Allows data types to be changed after creation. This can lead to data on content is not valid on the Data Type.
- `"False"`
  - Disallow Data Type changes. (Recommended value, unless you really know what you are doing)
- `"FalseWithHelpText"`
  - Disallow Data Type changes, but show the users a help text so they understand why.
