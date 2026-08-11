---
description: >-
  Find the resources needed to develop and customize an Umbraco website, whether
  working with backend functionality or extending the backoffice.
---

# Developing websites

Umbraco CMS is built on the Microsoft ASP.NET MVC framework. You can build upon this technology to work alongside and extend the functionality in Umbraco. The platform is designed to be flexible and pluggable, meaning key components can be replaced with custom implementations when needed.

{% hint style="info" %}
It is possible to build an Umbraco site without advanced development tools. For more information, see the [Creating websites with Umbraco](../creating-websites-with-umbraco.md) article.
{% endhint %}

You’ll learn how to:

* Structure and develop an Umbraco project
* Extend and customize the Umbraco backoffice
* Work with Umbraco-specific APIs and helpers
* Use dependency injection within Umbraco

This section is divided into two main areas:

* [Extending the Umbraco Backoffice](./#extending-the-umbraco-backoffice)
* [Customizing Umbraco Sites](./#customizing-umbraco-sites)

## [Extending the Umbraco backoffice](extending-the-umbraco-backoffice.md)

The Umbraco backoffice can be extended using AngularJS and C#. Customizing the Umbraco backoffice and editing experience includes:

* Creating custom Property Editors
* Building Dashboards
* Developing Packages.&#x20;
* Customizing Health Checks
* Extending built-in search functionality

See [the Extending section](https://docs.umbraco.com/welcome/getting-started/developing-websites-with-umbraco/extending-the-umbraco-backoffice) in the CMS docs for a good place to start.

{% hint style="info" %}
From a frontend perspective, Umbraco does not dictate HTML, CSS, or JS in your website build. There is nothing Umbraco-specific about it.
{% endhint %}

## [Customizing Umbraco sites](customizing-umbraco-sites.md)

Umbraco is highly customizable, which means you can integrate it with anything and make it behave as you want. With Umbraco, you start with a clean slate.

Umbraco uses ASP.NET and MVC patterns. Developers can:

* Create custom controllers
* Work with SurfaceControllers
* Integrate management service APIs
* Extend routing and rendering logic

## Development Tools and IDE Recommendations

When developing or extending an Umbraco project using C#, using an Integrated Development Environment (IDE) is recommended.

* **Recommended:** [Microsoft Visual Studio](https://visualstudio.microsoft.com/vs/community/)
* **Alternative:** [Visual Studio Code](https://visualstudio.microsoft.com/free-developer-offers/) or another preferred text editor

While it is technically possible to make changes using a simple text editor and compile on startup, an IDE provides:

* IntelliSense and code completion
* Debugging tools
* Project management support
* Strong integration with ASP.NET and MVC frameworks

Using an IDE significantly improves productivity and reduces the likelihood of errors when working with C# and .NET-based projects.
