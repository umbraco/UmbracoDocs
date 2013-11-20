#tinyMceConfig

Here you will find documentation relating to the options you can add/modify in the tinyMceConfig.config file. 
The configuration you set here will be used by each TinyMce instance as it is initalised in Umbraco.

##Command

Inside of the `<commands>` node you will find multiple `<command>` nodes. Each one of these nodes defines a icon/button
that can appear on the formatting bar inside of Umbraco and the command that is triggered when it is clicked.

    <command>
      <umbracoAlias>code</umbracoAlias>
      <icon>images/editor/code.gif</icon>
      <tinyMceCommand value="" userInterface="false" frontendCommand="code">code</tinyMceCommand>
      <priority>1</priority>
    </command>
    
`umbracoAlias` defines a unique alias within Umbraco for the command. This alias should not contain any spaces.

`icon` defines the path to an image file to be used on the formatting toolbar. This image should be 16px x 16px in size.

`tinyMceCommand` defines the tinyMceCommand properties. 

To further break this down, the `value` attribute is usually an empty value as most commands perform formatting tasks as
opposed to returning values. The `userInterface` attribute takes a boolean value indicating whether or not the command 
has an additional UI component to display e.g. a new dialog to  assist with inserting images. `frontendCommand` defines 
the name of the command to execute. This value usually matches the value of the `tinyMceCommand` node.

`priority` defines the sort order for the commands and should be sequentially incremented for each new command.
