---
versionFrom: 9.0.0
meta.Title: "Umbraco Request Handler Settings"
meta.Description: "Information on the request handler settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Request handler settings

The options in the request handler let us do some quite useful things, like deciding whether or not to use trailing slashes and setting URL replacement for special characters.

Let's have a further look at each option below.

Here is a snippet containing all the default values of the `RequestHandler` section.

```json
{
	"Umbraco": {
		"CMS": {
			"RequestHandler": {
				"AddTrailingSlash": true,
				"ConvertUrlsToAscii": "try",
				"CharCollection": [{
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
}
```

### Add trailing slash

This will add a trailing slash to the url when **`<addTrailingSlash>`** is set to "true".
If you don't want to have a trailing slash, set the value to **false**.

### Convert urls to ascii

This setting tells Umbraco to convert all urls to ASCII, if set to false the urls will remain UTF-8. 

This setting can be set to **try** This will make the engine try to convert the name to an ASCII implementation. If it fails, it will fallback to the name. Reason is that some languages don't have ASCII implementations, therefore the urls would end up being empty.

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
