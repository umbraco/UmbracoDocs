---


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
      "Plugins": ["paste", "anchor", "charmap", "table", "lists", "advlist", "hr", "autolink", "directionality", "tabfocus", "searchreplace"],
      "ValidElements": "+a[id|style|rel|data-id|data-udi|rev|charset|hreflang|dir|lang|tabindex|accesskey|type|name|href|target|title|class|onfocus|onblur|onclick|ondblclick|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onkeypress|onkeydown|onkeyup],-strong/-b[class|style],-em/-i[class|style],-strike[class|style],-s[class|style],-u[class|style],#p[id|style|dir|class|align],-ol[class|reversed|start|style|type],-ul[class|style],-li[class|style],br[class],img[id|dir|lang|longdesc|usemap|style|class|src|onmouseover|onmouseout|border|alt=|title|hspace|vspace|width|height|align|umbracoorgwidth|umbracoorgheight|onresize|onresizestart|onresizeend|rel|data-id],-sub[style|class],-sup[style|class],-blockquote[dir|style|class],-table[border=0|cellspacing|cellpadding|width|height|class|align|summary|style|dir|id|lang|bgcolor|background|bordercolor],-tr[id|lang|dir|class|rowspan|width|height|align|valign|style|bgcolor|background|bordercolor],tbody[id|class],thead[id|class],tfoot[id|class],#td[id|lang|dir|class|colspan|rowspan|width|height|align|valign|style|bgcolor|background|bordercolor|scope],-th[id|lang|dir|class|colspan|rowspan|width|height|align|valign|style|scope],caption[id|lang|dir|class|style],-div[id|dir|class|align|style],-span[class|align|style],-pre[class|align|style],address[class|align|style],-h1[id|dir|class|align|style],-h2[id|dir|class|align|style],-h3[id|dir|class|align|style],-h4[id|dir|class|align|style],-h5[id|dir|class|align|style],-h6[id|style|dir|class|align|style],hr[class|style],small[class|style],dd[id|class|title|style|dir|lang],dl[id|class|title|style|dir|lang],dt[id|class|title|style|dir|lang],object[class|id|width|height|codebase|*],param[name|value|_value|class],embed[type|width|height|src|class|*],map[name|class],area[shape|coords|href|alt|target|class],bdo[class],button[class],iframe[*],figure,figcaption,cite,video[*],audio[*],picture[*],source[*],canvas[*]",
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

Allows you to specify what plugins should be enabled for the rich text editor as a comma separated list of the plugin names.

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

