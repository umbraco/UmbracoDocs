---
description: "Information on the data types settings section"
---

# Data Types Settings

Allows you to configure the behavior of data types.

```json
{
  "Umbraco": {
    "CMS": {
      "DataTypes": {
        "CanBeChanged": "True",
        "OfferDeprecatedPropertyEditors": false
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

## OfferDeprecatedPropertyEditors

Gets or sets a value indicating whether deprecated property editors are offered when choosing the property editor for a Data Type.

By default this is set to `false`, and deprecated property editors are hidden from the property editor picker. Set it to `true` to offer them. Where deprecated property editors are shown, they're marked as deprecated.

Data Types that already use a deprecated property editor keep working either way. The setting only controls whether a deprecated property editor can be chosen for a Data Type that doesn't already use it.

{% hint style="info" %}
In Umbraco 18 and earlier, this setting was `Umbraco:CMS:Content:ShowDeprecatedPropertyEditors`. The old key is no longer read.
{% endhint %}
