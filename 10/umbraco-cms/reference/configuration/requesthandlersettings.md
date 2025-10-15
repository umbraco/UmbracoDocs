---
meta.Title: Umbraco Request Handler Settings
description: Information on the request handler settings section
---

# Request handler settings

The options in the request handler let us do some quite useful things, like deciding whether or not to use trailing slashes and setting URL replacement for special characters.

Let's have a further look at each option below.

Here is a snippet containing all the default values of the `RequestHandler` section.

```js
"Umbraco": {
  "CMS": {
    "RequestHandler": {
      "AddTrailingSlash": true,
      "ConvertUrlsToAscii": "try",
      "EnableDefaultCharReplacements": true,
      "CharCollection": [
      {
        "Char": " ",
        "Replacement": "-"
      },
      {
        "Char": "\\",
        "Replacement": ""
      },
      {
        "Char": "'",
        "Replacement": ""
      },
      {
        "Char": "%",
        "Replacement": ""
      },
      {
        "Char": ".",
        "Replacement": ""
      },
      {
        "Char": ";",
        "Replacement": ""
      },
      {
        "Char": "/",
        "Replacement": ""
      },
      {
        "Char": "\\\\",
        "Replacement": ""
      },
      {
        "Char": ":",
        "Replacement": ""
      },
      {
        "Char": "#",
        "Replacement": ""
      },
      {
        "Char": "+",
        "Replacement": "plus"
      },
      {
        "Char": "*",
        "Replacement": "star"
      },
      {
        "Char": "&",
        "Replacement": ""
      },
      {
        "Char": "?",
        "Replacement": ""
      },
      {
        "Char": "æ",
        "Replacement": "ae"
      },
      {
        "Char": "ä",
        "Replacement": "ae"
      },
      {
        "Char": "ø",
        "Replacement": "oe"
      },
      {
        "Char": "ö",
        "Replacement": "oe"
      },
      {
        "Char": "å",
        "Replacement": "aa"
      },
      {
        "Char": "ü",
        "Replacement": "ue"
      },
      {
        "Char": "ß",
        "Replacement": "ss"
      },
      {
        "Char": "|",
        "Replacement": "-"
      },
      {
        "Char": "<",
        "Replacement": ""
      },
      {
        "Char": ">",
        "Replacement": ""
      }
      ]
    }
  }
}
```

## Add trailing slash

This will add a trailing slash to the url when **`<addTrailingSlash>`** is set to "true". If you don't want to have a trailing slash, set the value to **false**.

### Convert urls to ascii

This setting tells Umbraco to convert all urls to ASCII, if set to false the urls will remain UTF-8.

This setting can be set to **try** This will make the engine try to convert the name to an ASCII implementation. If it fails, it will fallback to the name. Reason is that some languages don't have ASCII implementations, therefore the urls would end up being empty.

### Enable default character replacements

This setting tells Umbraco to use the default character replacements. If you don't want the default character replacements, set this to false.

### Char collection

This settings contains a lot of obejcts with a **`"Char"`** and **`"Replacement`** key, each of these object holds a character that should be replaced, and what it should be replaced with.

So, if:

```json
{
  "Char": "ñ",
  "Replacement": "n"
}
```

is added to the list, the **ñ** will be shown as a **n** in the url.
