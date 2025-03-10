---
description: >-
  Find all the resources you need when you're developing and customizing an
  Umbraco website - be it backend or extending the backoffice.
---

# Developing websites

Umbraco is built on top of a Microsoft MVC framework. You can build upon this technology to work alongside and extend the functionality in Umbraco. It is also designed to be pluggable so that you can replace key components with your own custom implementations if prefer.

{% hint style="info" %}
It is possible to build an Umbraco site without Visual Studio and the techniques on this page - see the [Creating websites with Umbraco](../creating-websites-with-umbraco.md) section.
{% endhint %}

This section is dedicated to introducing techniques that will help you get started with developing an Umbraco site. You'll find out how to develop the framework of an Umbraco project as well as how to extend and customize the Umbraco backoffice.

The concepts in this section go beyond standard templating methodologies and introduce some Umbraco-specific terms and helpers, such as SurfaceControllers and management service APIs. All of which is the technology that you can take advantage of when developing with Umbraco.

You will also find information regarding Umbraco's underlying dependency injection framework.

This will break into two sections: Extending the Umbraco backoffice and Developing custom websites.

## [Extending the Umbraco backoffice](extending-the-umbraco-backoffice.md)

The Umbraco backoffice can be extended using AngularJS and C#. Customizing the Umbraco backoffice and editing experience includes creating your own Property Editors, Dashboards, and packages. You will also find information about how to customize things like Health Checks and the built-in search functionality.

Check out [the Extending section](https://docs.umbraco.com/welcome/getting-started/developing-websites-with-umbraco/extending-the-umbraco-backoffice) in the CMS docs for a good place to start.

{% hint style="info" %}
From a frontend perspective, Umbraco does not dictate HTML, CSS, or JS in your website build. There is nothing Umbraco-specific about it.
{% endhint %}

## [Customizing Umbraco sites](customizing-umbraco-sites.md)

Umbraco is highly customizable which means you can integrate it with anything and make it behave as you want. With Umbraco, you start out with a clean slate.

Umbraco uses ASP.NET and MVC patterns and you can extend and write your own controllers using the approach outlined in this section.

![Umbraco on devices](../../../new-backoffice/.gitbook/assets/backoffice.png)

## Integrated Development Environment (IDE) recommendations

When you are customizing or extending your Umbraco website using C# we recommend using [Visual Studio](https://visualstudio.microsoft.com/vs/community/).

You can also use a simpler tool like [Visual Studio Code](https://visualstudio.microsoft.com/free-developer-offers/) or any other text editor you prefer working with. However, this is only recommended when you're not working directly with the C# files.

{% hint style="info" %}
While you can use a text editor, put changes in the `App_code` folder, and have it compiled on startup; we recommend using an IDE.

An IDE will give you a lot of support, as it's built for working with C# files, ASP.NET, and MVC frameworks.
{% endhint %}
