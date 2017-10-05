# Macros

_Describes how to set up a macro, use macro parameters & configuring caching. Defines the different types of macros and provides details on the different macro engine APIs and their usage_

## What is a macro?

A macro is a reusable piece of functionality that you can re-use throughout your site. Macros can be configured with parameters and be inserted into a Rich Text Editor. You can define what macros are available for your editors to insert in to the rich text editor. When an editor inserts a macro into the rich text editor it will prompt them to fill out any of the defined parameters for the macro.

## Rendering Macros

Here's a basic method to render macros:

	@Umbraco.RenderMacro("myMacroAlias")

[Overloaded Methods](../Mvc/views.md#renderingMacros)

## Macro types

All macro types will work in either MVC or WebForms templating engines

### [Partial View Macros](Partial-View-Macros/index.md)

**This is the recommended macro type to use**, it uses the exact same syntax and objects as MVC views.

### [Xslt macros](Xslt/index.md)

Information, examples and best practices according to readability and performance in your XSLT/XPath snippets.
