---
description: "Information on the Rich text editor settings"
---

# Rich text editor settings

{% hint style="warning" %}
The global configuration of RichTextEditor will be removed in Umbraco 14 to support more rich text editors in the future. Instead, a new extension type called “tinyMcePlugin” will be added.
{% endhint %}

This settings section allows you to configure the behaviour of the rich text editor, everything from plugins to commands. Everything has a default value, so it's not required to configure any of this yourself.

{% hint style="info" %}
**Are you using custom configuration or plugins with TinyMCE?**

In Umbraco 11 the TinyMCE version supported has been upgraded from version 4 to version 6. You need to migrate to the latest version if you are using TinyMCE plugins or custom configuration.

If your site is upgraded from an older version, follow the migration guides below to upgrade the TinyMCE version as well.

* [Migrate from version 4 to version 5](https://www.tiny.cloud/docs/tinymce/5/migration-from-4x/)
* [Migrate from version 5 to version 6](https://www.tiny.cloud/docs/tinymce/6/migration-from-5x/)
* [Migrate from version 6 to version 7](https://www.tiny.cloud/docs/tinymce/latest/migration-from-6x/)

{% endhint %}

A config with all the values can be seen underneath. Since there are a lot of defaults configured, some of these have been omitted for the sake of readability. Anywhere something has been omitted it is shown with `{...}`.

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
      },
      "CloudApiKey": "q8j4e5{...}w8c270p"
    }
  }
}
```

## Plugins

Allows you to specify what plugins should be enabled for the rich text editor as a comma seperated list of the plugin names.

To learn more about how to use the plugins, see the [Rich Text Editor Plugins](../../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/rte-plugins.md) article.

## Valid elements

Allows you to specify the valid HTML elements for the rich text editor as well as the allowed properties. For instance, in the config above the `a` element is allowed, and it's allowed to have `onclick`, `href`, and many more attributes.

## Invalid elements

Specifies invalid HTML elements for the rich text editor. For instance, in the config above the `font` element is not allowed.

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

## Cloud API key

Allows you to specify a Cloud API key for the rich text editor. Set this if you want to use the [TinyMCE Cloud](https://www.tiny.cloud/) service. After setting this the Backoffice automatically loads the plugins.js file from the cloud service, which is known as [cloud deployment of plugins only](https://www.tiny.cloud/docs/tinymce/6/features-only/).

To learn more about how to use the Cloud API key, see the [Plugins](../../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/rte-plugins.md#adding-a-premium-plugin) article.

{% hint style="info" %}
You can go to [TinyMCE Cloud](https://www.tiny.cloud/) and sign up for a free trial. You will get a Cloud API key that you can use to try out the premium plugins.
{% endhint %}
