---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Umbraco Rich Text Editor Settings"
description: "Information on the Rich text editor settings section"
---

# Rich text editor settings

This settings section allows you to configure the behaviour of the rich text editor, everything from plugins to commands. Everything has a default value, so it's not required to configure any of this yourself.

A config with all the values can be seen underneath. Since there is a lot of defaults configured, some of these have been omited for the sake of readability, anywhere something has been omitted it's shown with `{...}`.


```json
"Umbraco": {
  "CMS": {
    "RichTextEditor": {
      "Plugins": ["paste", "anchor", "charmap", "table",{...}],
      "ValidElements": "+a[id|style|rel|data-id|data-udi|rev|charset|hreflang|dir|lang|tabindex|accesskey|type|name|href|target|title|class|onfocus|onblur|onclick|ondblclick|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onkeypress|onkeydown|onkeyup],-strong/-b[class|style],-em/-i[class|style],-strike[class|style],-u[class|style],#p[id|style|dir|class|align]{...}]",
      "InvalidElements": "font",
      "Commands": [
        {
          "Alias": "ace",
          "Name": "Source code editor",
          "Mode": "Insert"
        },
        {
          "Alias": "removeformat",
          "Name": "Remove format",
          "Mode": "Selection"
        },
        {
          "Alias": "paste",
          "Name": "Paste",
          "Mode": "All"
        },
        {...}
      ],
      "CustomConfig": {
        "entity_encoding": "raw"
      }
    }
  }
}
```

## Plugins

Allows you to specify what plugins should be enabled for the rich text editor as a comma seperated list of the plugin names.

## Valid elements

Allows you to specify the valid HTML elements for the rich text editor as well as the allowed properties, for instance, in the config above the `a` element is allowed, and it's allowed to have `onclick`, `href`, and many more attributes.

## Invalid elements

Specifies invalid HTML elements for the rich text editor

## Commands

Allows you to specify what commands should be available, as a list of object. These commands are the little buttons you find at the top of the editor, such as bold, italic, and so on.

When specifying these, every object should contain:

* Alias - The alias of the command
* Name - A friendly name descriping the command
* Mode - The mode the command runs on
  * Insert - The command will insert something
  * Selection - The command operate on the text, or elements, selected
  * All - The command operates on everything

## Custom config

Allows you to specify custom key value pairs for the rich text editor.

### Examples
Remove default ```<p>``` tag.
```json
  "Umbraco": {
    "CMS": {
      "RichTextEditor": {
        "CustomConfig": {
          "forced_root_block": ""
        }
      }
    }
  }
```

Add custom styles to the **Formats** dropdown list in the Richtext Editor.

{% hint style="info" %}
Use a text editor to find and replace `\"` with `"`. This will allow you to edit the JSON file in an easier-to-read format. Don't forget to add the `\` back in when you are ready to paste the code back into your `appsettings.json` file.
{% endhint %}

```json
  "Umbraco": {
    "CMS": {
      "RichTextEditor": {
        "CustomConfig": {
          "style_formats": "[{\"title\":\"Headers\",\"items\":[ {\"title\":\"Heading 1\",\"block\":\"h1\"}, {\"title\":\"Heading 2\",\"block\":\"h2\"}, {\"title\":\"Heading 3\",\"block\":\"h3\"}, {\"title\":\"Heading 4\",\"block\":\"h4\"}, {\"title\":\"Heading 5\",\"block\":\"h5\"} ]}]"
        }
      }
    }
  }
```

