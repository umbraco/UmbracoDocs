---
versionFrom: 7.0.0
versionTo: 8.0.0
---

# tinyMceConfig

Here you will find documentation relating to the options you can add/modify in the tinyMceConfig.config file. The configuration you set here will be used by each TinyMce instance as it is initialized in Umbraco.

## commands

Inside of the `<commands>` node you will find multiple `<command>` nodes. Each one of these nodes defines a icon/button that can appear on the formatting bar inside of Umbraco and the command that is triggered when it is clicked.

```xml
<command>
  <umbracoAlias>code</umbracoAlias>
  <icon>images/editor/code.gif</icon>
  <tinyMceCommand value="" userInterface="false" frontendCommand="code">code</tinyMceCommand>
  <priority>1</priority>
</command>
```

`umbracoAlias` defines a unique alias within Umbraco for the command. This alias should not contain any spaces.

`icon` defines the path to an image file to be used on the formatting toolbar. This image should be 16px x 16px in size.

`tinyMceCommand` defines the tinyMceCommand properties.

To further break this down, the `value` attribute is usually an empty value as most commands perform formatting tasks as opposed to returning values. The `userInterface` attribute takes a boolean value indicating whether or not the command has an additional UI component to display e.g. a new dialog to  assist with inserting images. `frontendCommand` defines the name of the command to execute. This value usually matches the value of the `tinyMceCommand` node.

`priority` defines the sort order for the commands and should be sequentially incremented for each new command.

## plugins

Inside of the `<plugins>` node you can find one or more `<plugin>` nodes. Each one of these nodes defines a plugin which extends the functionality of TinyMce. Below you will find the standard plugins configured in a clean install of Umbraco v7.x.

```xml
<plugins>
    <plugin loadOnFrontend="true">code</plugin>
    <plugin loadOnFrontend="true">codemirror</plugin>
    <plugin loadOnFrontend="true">paste</plugin>
    <plugin loadOnFrontend="true">anchor</plugin>
    <plugin loadOnFrontend="true">charmap</plugin>
    <plugin loadOnFrontend="true">table</plugin>
    <plugin loadOnFrontend="true">lists</plugin>
    <plugin loadOnFrontend="true">hr</plugin>
  </plugins>
```

## validElements

The `validElements` node defines which elements will remain in the edited text when the TinyMce Rich Text Editor (RTE) saves. You can use this to limit the returned HTML to a subset.

This option contains a comma separated list of element conversion chunks. Each chunk contains information about how one element and its attributes should be treated.

Here is an example of the standard valid elements that come with a clean install of Umbraco v7.x.

```xml
 <validElements>
      <![CDATA[+a[id|style|rel|data-id|rev|charset|hreflang|dir|lang|tabindex|accesskey|type|name|href|target|title|class|onfocus|onblur|onclick|
ondblclick|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onkeypress|onkeydown|onkeyup],-strong/-b[class|style],-em/-i[class|style],
-strike[class|style],-u[class|style],#p[id|style|dir|class|align],-ol[class|reversed|start|style|type],-ul[class|style],-li[class|style],br[class],
img[id|dir|lang|longdesc|usemap|style|class|src|onmouseover|onmouseout|border|alt=|title|hspace|vspace|width|height|align|umbracoorgwidth|umbracoorgheight|onresize|onresizestart|onresizeend|rel|data-id],
-sub[style|class],-sup[style|class],-blockquote[dir|style|class],-table[border=0|cellspacing|cellpadding|width|height|class|align|summary|style|dir|id|lang|bgcolor|background|bordercolor],
-tr[id|lang|dir|class|rowspan|width|height|align|valign|style|bgcolor|background|bordercolor],tbody[id|class],
thead[id|class],tfoot[id|class],#td[id|lang|dir|class|colspan|rowspan|width|height|align|valign|style|bgcolor|background|bordercolor|scope],
-th[id|lang|dir|class|colspan|rowspan|width|height|align|valign|style|scope],caption[id|lang|dir|class|style],-div[id|dir|class|align|style],
-span[class|align|style],-pre[class|align|style],address[class|align|style],-h1[id|dir|class|align|style],-h2[id|dir|class|align|style],
-h3[id|dir|class|align|style],-h4[id|dir|class|align|style],-h5[id|dir|class|align|style],-h6[id|style|dir|class|align|style],hr[class|style],
dd[id|class|title|style|dir|lang],dl[id|class|title|style|dir|lang],dt[id|class|title|style|dir|lang],object[class|id|width|height|codebase|*],
param[name|value|_value|class],embed[type|width|height|src|class|*],map[name|class],area[shape|coords|href|alt|target|class],bdo[class],button[class],iframe[*]]]>
    </validElements>
```

### Control characters

The following table of control characters is taken from [the official TinyMce documentation](http://www.tinymce.com/wiki.php/configuration:valid_elements "the official TinyMce documentation") on the topic:

<table>
<thead>
<tr><th>Name</th><th>Summary</th></tr>
</thead>
<tbody>
<tr>
<td>@</td>
<td>

Rules with this name will be applied to all elements defined after this rule. So `@[attr1|attr2]` will enable attr1 and attr2 for all elements, but element1, `@[attr1|attr2]`, element2, element3 will enable attr1 and attr2 only for element2 and element3.

If applied in extended_valid_elements, it is only effective for the elements in the extended_valid_elements list.

</td>
</tr>
<tr>
<td>,</td>
<td>Separates element chunk definitions.</td>
</tr>
<tr>
<td>/</td>
<td>Separates element synonymous. The first element is the one that will be output.</td>
</tr>
<tr>
<td>|</td>
<td>Separates attribute definitions.</td>
</tr>
<tr>
<td>[</td>
<td>Starts a new attribute list for an element definition.</td>
</tr>
<tr>
<td>]</td>
<td>Ends an attribute list for an element definition.</td>
</tr>
<tr>
<td>!</td>
<td>Makes attributes required. If none of the required attributes are set, the element will be removed. For example, "!href".</td>
</tr>
<tr>
<td>=</td>
<td>Makes the attribute default to the specified value. For example, "target=_blank"</td>
</tr>
<tr>
<td>:</td>
<td>Forces the attribute to the specified value. For example, "border:0"</td>
</tr>
<tr>
<td>&lt;</td>
<td>Verifies the value of an attribute (only the listed values are allowed). For example, "target&lt;_blank?_self"</td>
</tr>
<tr>
<td>?</td>
<td>Separates attribute verification values. See above.</td>
</tr>
<tr>
<td>+</td>
<td>Makes the element open if no child nodes exists. For example, "+a".</td>
</tr>
<tr>
<td>-</td>
<td>Enables removal of empty elements such as &lt;strong /&gt;. For example, "-strong".</td>
</tr>
<tr>
<td>#</td>
<td>Enables padding of empty elements. This will pad with &amp;nbsp; if they are empty. For example, "#p".</td>
</tr>
</tbody>
</table>

## invalidElements

This option should contain a comma separated list of element names to exclude from the saved content. Elements in this list will be removed when your content is saved.

```xml
<invalidElements>font</invalidElements>
```

## extendedValidElements

Extended valid elements is a configuration option of TinyMCE that is normally used to apply extensions to the `validElements` setting of TinyMCE. This configuration setting is however not available in the current implementation of TinyMCE in Umbraco CMS.

### customConfig

The `customConfig` node contains any custom configuration you would like applied to TinyMce when each instance is initialized. For examples of configuration options see the [official TinyMce Configuration options documentation](http://www.tinymce.com/wiki.php/Configuration3x "official TinyMce Configuration Options documentation").

```xml
<customConfig>
    <!--    <config key="myKey">mySetting</config>-->
    <config key="entity_encoding">raw</config>
    <config key="spellchecker_rpc_url">GoogleSpellChecker.ashx</config>
</customConfig>
```
