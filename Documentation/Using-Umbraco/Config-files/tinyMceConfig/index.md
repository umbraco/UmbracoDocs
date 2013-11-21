#tinyMceConfig

Here you will find documentation relating to the options you can add/modify in the  tinyMceConfig.config file. The configuration you set here will be used by each TinyMce instance as it is initalised in Umbraco.

##commands

Inside of the `<commands>` node you will find multiple `<command>` nodes. Each one of these nodes defines a icon/button that can appear on the formatting bar inside of Umbraco and the command that is triggered when it is clicked.

    <command>
      <umbracoAlias>code</umbracoAlias>
      <icon>images/editor/code.gif</icon>
      <tinyMceCommand value="" userInterface="false" frontendCommand="code">code</tinyMceCommand>
      <priority>1</priority>
    </command>
    
`umbracoAlias` defines a unique alias within Umbraco for the command. This alias should not contain any spaces.

`icon` defines the path to an image file to be used on the formatting toolbar. This image should be 16px x 16px in size.

`tinyMceCommand` defines the tinyMceCommand properties. 

To further break this down, the `value` attribute is usually an empty value as most commands perform formatting tasks as opposed to returning values. The `userInterface` attribute takes a boolean value indicating whether or not the command has an additional UI component to display e.g. a new dialog to  assist with inserting images. `frontendCommand` defines the name of the command to execute. This value usually matches the value of the `tinyMceCommand` node.

`priority` defines the sort order for the commands and should be sequentially incremented for each new command.

##plugins

Inside of the `<plugins>` node you can find one or more `<plugin>` nodes. Each one of these nodes defines a plugin which extends the functionality of TinyMce.

    <plugin loadOnFrontend="true">paste</plugin>


##validElements

The `validElements` node defines which elements will remain in the edited text when the TinyMce Rich Text Editor (RTE) saves. You can use this to limit the returned HTML to a subset.

This option contains a comma separated list of element conversion chunks. Each chunk contains information about how one element and its attributes should be treated. 

###Control characters:

The following table of control characters is taken from [the official TinyMce documentation](http://www.tinymce.com/wiki.php/configuration:valid_elements "the official TinyMce documentation") on the topic:

<table>
<thead>
<tr><th>Name</th><th>Summary</th></tr>
</thead>
<tbody>
<tr>
<td>@</td>
<td>

Rules with this name will be applied to all elements defined after this rule. So @[attr1|attr2] will enable attr1 and attr2 for all elements, but element1,@[attr1|attr2],element2,element3 will enable attr1 and attr2 only for element2 and element3.

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