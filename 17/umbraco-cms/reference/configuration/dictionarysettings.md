---
description: "Information on the dictionary settings section"
---

# Dictionary Settings

Dictionary settings allow you to configure how dictionary items are searched in the Umbraco backoffice.

The following snippet contains all the available options with their default values:

```json
{
  "Umbraco": {
    "CMS": {
      "Dictionary": {
        "UseDictionaryValueSearch": false
      }
    }
  }
}
```

## UseDictionaryValueSearch

Key: `UseDictionaryValueSearch`

Type: `bool` (default: `false`)

Enables searching dictionary items by their **translation values** in addition to **keys** in the backoffice.

When set to `false` (default), only dictionary keys are searched using prefix matching.

When set to `true`, both dictionary keys and translation values are searched. Keys use prefix matching while values use substring matching, allowing editors to find dictionary items by their translated content.

{% hint style="info" %}
This feature is **disabled by default** to preserve backward compatibility and performance. Only enable it if your editors need to search by translation values.
{% endhint %}

## Related Links

- [Dictionary Items](../../fundamentals/data/dictionary-items.md)
- [Creating a Multilingual Site](../../tutorials/multilanguage-setup.md)
