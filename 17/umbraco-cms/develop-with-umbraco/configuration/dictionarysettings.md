---
description: Information on the dictionary settings section.
---

# Dictionary

Dictionary settings allow you to configure how dictionary items are searched in the Umbraco backoffice.

The following snippet contains all the available options with their default values:

```json
{
  "Umbraco": {
    "CMS": {
      "Dictionary": {
        "EnableValueSearch": false,
        "KeySearchMode": "StartsWith"
      }
    }
  }
}
```

## EnableValueSearch

Key: `EnableValueSearch`

Type: `bool` (default: `false`)

Enables searching dictionary items by their **translation values** in addition to **keys** in the backoffice.

When set to `false` (default), only dictionary keys are searched.

When set to `true`, both dictionary keys and translation values are searched. Values use substring matching, allowing editors to find dictionary items by their translated content.

{% hint style="info" %}
This feature is **disabled by default** to preserve backward compatibility and performance. It is recommended to enable the setting only when your editors need to search by translation values.
{% endhint %}

## KeySearchMode

Key: `KeySearchMode`

Type: `string` (default: `StartsWith`)

Controls how the search term is matched against the dictionary item key. It accepts two values:

* `StartsWith` (default): only items with a key that begins with the search term are returned. Searching for `Intro` does not return the item `FanclubIntroText`.
* `Contains`: items with a key that includes the search term at any position are returned. Searching for `Intro` returns the item `FanclubIntroText`.

{% hint style="info" %}
`Contains` matching cannot use the database index on the key column. On installations with a large number of dictionary items, the lookup is less efficient than with the default `StartsWith`.
{% endhint %}

## Related Links

* [Dictionary Items](../../manage-and-publish-content/publishing-and-workflow/editorial-tools/dictionary-items.md)
* [Creating a Multilingual Site](../tutorials/multilanguage-setup.md)
