---
versionFrom: 8.0.0
---

# Templating

_Templating in Umbraco consists of 3 larger concepts, namely Templates (Views), Partials (Partial Views) and Macros (Macro Partials). Templates are used for the HTML layout of your pages, partials can be included in your templates for shared functionality across different page templates and macros for reusable dynamic components that can be controlled by editors to embed functionality into the grid or rich text areas._

## Templating technology

In Umbraco V8 there is now only one type of templating technology:

* MVC (views)

:::note
 The WebForms (masterpages) and dynamic razor approaches to templating are still available in Umbraco 7, but are now no longer supported in Umbraco 8.
:::



#### [Working with MVC (views, razor, etc...)](Mvc/index.md)

Describes how to work with MVC views, the razor syntax and APIs available as well details on how to create forms, step-by-step guides and other advanced techniques.

## [Macros](Macros/index.md)

Describes how to set up a macro, use macro parameters & configuring caching. Defines the different types of macros and provides details on the different macro engine APIs and their usage.

## [Models Builder](Modelsbuilder/)
A tool that can generate a complete set of strongly-typed published content models for Umbraco. Models are available in controllers, views, anywhere. Runs either from the Umbraco UI, from the command line, or from Visual Studio.
