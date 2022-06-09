---
meta.Title: "Developing websites with Umbraco"
meta.Description: "This section shows you some beginner tools and information to get your started with Umbraco 8. From making a local installation to extending the backoffice."
versionFrom: 8.0.0
---
# Developing websites with Umbraco

Umbraco is built on top of a Microsoft MVC framework. You can build upon this technology to work alongside and extend the functionality in Umbraco. It is also designed to be pluggable so that you can replace key components with your own custom implementations if prefer.

:::tip
It is perfectly possible to build an Umbraco site without using Visual Studio and the techniques introduced on this page - see the [Creating websites with Umbraco](../Creating-websites-with-Umbraco) section.
:::

This section is dedicated to introducing techniques that will help you get started with developing with an Umbraco site. You will find information on how to develop with the underlying framework of an Umbraco project as well as details on how you can extend the Umbraco backoffice to customize the editing experience.

The concepts detailed in this section will go beyond standard out-of-the-box templating methodologies, and introduce some Umbraco specific terms and helper functionality, e.g. such as SurfaceControllers and management service APIs. All of which is technology that you can take advantage of when developing with Umbraco.

You will also find information regarding Umbraco's underlying dependency injection framework.

This will break into two sections: Extending the Umbraco backoffice and Developing custom websites.

## [Extending the Umbraco backoffice](Extending-the-Umbraco-Backoffice)

The Umbraco backoffice can be extended using AngularJS and C#. Customizing the Umbraco backoffice and editing experience includes creating your own Property Editors, Dashboards, and packages. You will also find information about how to customize things like Health Checks and the built-in search functionality.

[Checkout the Extending section of these docs](../../Extending/) for a good place to start.

:::note
From a frontend perspective, Umbraco does not dictate HTML, CSS, or JS in your website build. There is nothing Umbraco specific about it.
:::

## [Customizing Umbraco sites](Customizing-Umbraco-sites)

Umbraco is highly customizable which means you can basically integrate it with anything and make it behave as you want. With Umbraco, you start out with a clean slate.

Umbraco uses ASP.NET and MVC patterns and you can extend and write your own controllers using the approach outlined in this section.

:::center
![Umbraco on devices](images/Umbraco_Brand_Guidelines_2020_30_Illustrationbuilding.png)
:::

## IDE recommendations

When you are customizing or extending your Umbraco website using C# we recommend using [Visual Studio](https://visualstudio.microsoft.com/vs/community/).

You can also use a simpler tool like [Visual Studio Code](https://visualstudio.microsoft.com/free-developer-offers/) or any other text editor you prefer working with. However, this is only recommended when you're not working directly with the C# files.

:::tip
Whilst it's perfectly possible to use a tool like Notepad and put the code in the `App_code` folder of your site, and have it compiled when the site starts up, we do recommend using a tool like Visual Studio instead.

The tool will give you a lot of support along the way, as it's built for working with C# files, ASP.NET and MVC frameworks.
:::
