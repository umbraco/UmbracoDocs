#Managing macros

_Describes how to create/update a macro and its parameters_

##Creating macros

There are a couple of ways to create a macro. 

The first way is to manually create a macro in the macro tree in the developer section:

![Create macro](images/create-macro-tree.png?raw=true)

Give it a name in the dialog screen, and then you'll be presented with the macro editor:

![Macro editor](images/macro-editor.png?raw=true)

From here you'll need to choose the macro type you want to render (see here for full details: [Macro Types](macro-types.md))

The 2nd option to create a macro is to create the macro type directly on its tree and select the checkbox "Create macro". For example, if you create a Partial View Macro File in the Developer section, the dialog will prompt you to also create a macro for this item. 

![Macro editor](images/create-macro-from-type.png?raw=true)

##Rich text options

> Use in editor

If selected will allow an editor to insert this macro in to a rich text field

> Render content in editor

If selected, when an editor inserts this macro in to a rich text editor, the actual contents of the macro will be displayed in the editor based on the current page context. If a macro is processor intensive then it is recommended to not check this option and instead a default message will be displayed in the editor indicating that it's a macro element.

##Caching options

> Cache period

Defines how many seconds the macro output will be cached for once it is rendered

> Cache by page

If selected, then this result of this macro will be cached based on the current page it is rendered on. This is useful if your macro has content that is dynamic to the current page it is being rendered on. If your macro's output is static (the same) no matter what page it is rendered on then it is better to not check this box.

> Cache personalized

Similar to the 'cache by page', this will cache the output of a macro based on a member that is logged in. If you macro is static (the same) no mattter what member is logged in, or if your website does not have membership then it is better to not check this box.

##Macro parameters

Macro parameters can be used to change the output of a macro at runtime. Macro parameters are often used as a way for your editors to change the output of a macro when they insert them into rich text editors. As an example, suppose you have a widget that displays a list of links which are children of a particular content item. You could define a macro parameter that indicates for which content item to render child links for and your editor can select this content item when inserting the macro into the rich text editor.

The macro parameter dialog looks like this:

![Macro editor](images/macro-parameter-editor.png?raw=true)

Here you can add/modify/remove macro parameters.

###Default macro parameter types

This list defines the different types of macro parameters:

- *bool* - A true/false value
- *contentPicker* - the ID of the selected node as a single integer
- *contentRandom* - the xml from a random node
- *contentTree* - the xml of the selected node and its child nodes
- *contentType* - the alias of a selected content type as a string
- *contentTypeMultiple* - a comma separated list of selected content type aliases
- *mediaCurrent* - the xml of the selected media item
- *number* - an integer
- *propertyTypePicker* - the alias of the selected property type
- *propertyTypePickerMultiple* - a comma separated list of selected property type aliases 
- *tabPicker* - the caption of the selected tab
- *tabPickerMultiple* - a comma separated list of selected tab captions
- *text* - a text string
- *textMultiline* - a text string