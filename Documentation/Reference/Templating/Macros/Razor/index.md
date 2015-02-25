#Building Macros with Razor

_Reference snippets for working with the Razor language in Umbraco macros. These samples shows how to use the DynamicNode API with razor, but does go into detail on the different methods and properties._

##[Hello World](hello-world.md)
Writing a simple Razor macro to output the name, url and ID of the current page, as well as iterating through child pages of the current pages.

##[Basic Razor syntax](basic-razor-syntax.md)
Syntax samples for handling common logical tasks, such as loops, if/else, and using @ to separate Code and markup

##[Using Macro Parameters](using-macro-parameters.md)
Using Macro parameters to pass changeable values to a Razor script to increase flexibility and reusability of the macro.

##[Using Razor axes](using-razor-axes.md)
Razor axes is a feature of DynamicNode, which allows you to query for specific parts of the content tree without using hardcoded Ids.

##[Using Pluralised queries](using-pluralised-queries.md)
Pluralised queries enables you to query and filter pages with a simple syntax.

##Using Razor functions to make recursive queries
A razor function is a small, embedded method you can call inside of your razor scripts

##[Using Umbraco Dictionary Items](using-dictionary-items.md)
How to access dictionary items from Razor

##[Umbraco.library](../../../Api/UmbracoLibrary/index.md)
Umbraco.library is a collection of helpers available to both Razor and Xslt 
