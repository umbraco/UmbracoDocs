#Developer documentation
Developer documentation covers working with Umbraco Forms from a developer standpoint. It covers retrieving data, it shows how to extend the system by hooking into the provider model, and finally it describes the available events and workflows you can use to extend or integrate Umbraco Forms.

##[Preparing your Frontend](Prepping-Frontend/index.md)
Before adding a form to your site we'll need to make sure you have the necessary client dependencies.

##[Custom markup](Custom-Markup/index.md)
Write your forms your way. You have full control over your form's HTML markup and styling

##[Rendering Forms scripts where you want](Rendering-Scripts/index.md)
Control where you want Forms to render it's javascript

##[Working with Record data](Working-With-Data/index.md)
See how you can fetch and display record data from your razor macros

##[Extending](Extending/index.md)##
Learn how you can extend Umbraco Forms with your own custom providers

##[Configuration](Configuration/index.md)##
Learn about some of the configuration options that are available to you to modify how Umbraco Forms works.

##[Field Types](Field-Types/index.md)##
Learn about the default Field Types that are shipped with Umbraco Forms and any specific details how these work.

##[Magic strings](Magic-Strings/index.md)##
Learn about the magic string formats that Umbraco Forms supports, that can retrieve information from various sources such as Session, Cookies, Umbraco Page Fields, Member fields, Form fields to use in workflows.

##[Storing Form Files with IFileSystem](IFileSystem/index.md)##
Learn how you can implement a custom IFileSystem to store the Forms, Workflows, PreValues and other JSON based files to suit your needs. Available in Umbraco Forms 4.4.0 and greater