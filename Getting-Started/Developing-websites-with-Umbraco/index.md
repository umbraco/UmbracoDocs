---
meta.Title: “Developing websites with Umbraco"
meta.Description: “This section shows you some beginner tools and information to get your started with Umbraco 8. From making a local installation to extending the backoffice.”
versionFrom: 8.0.0
---
# Developing websites with Umbraco

Umbraco is built on top of a Microsoft MVC framework. You can build upon these techniques to work alongside and extend Umbraco functionality. It is also designed to be pluggable so that you can replace key components of functionality with your own implementations if you know better. 

:::tip
It's perfectly possible to build an Umbraco site without using Visual Studio and the techniques introduced on this page - see [Creating website with Umbraco](Creating-websites-with-Umbraco) or [Umbraco Uno](Umbraco-Uno)... 
::: 

This section is dedicated to introducing techniques to help you get started with developing with a Umbraco site, going beyond standard out of the box templating methodologies, and introduce some Umbraco Specific terms, and helper functionality e.g. such as SurfaceController and RenderMvc controller and management service APIs you can take advantage of, along with information regarding Umbraco's underlying dependency injection framework.

This will break into two sections: Extending the Umbraco backoffice and developing custom websites.

## [Extending the Umbraco backoffice](../Getting-Started/Developing-websites-with-Umbraco/Extending-the-Umbraco-Backoffice/index.md)

The Umbraco backoffice can be extended with AngularJS and C#. This includes but is not limited to creating your own property editors, dashboards, and packages. It could also be things like custom health checks or extending the built-in search functionality.

See [here](https://our.umbraco.com/documentation/Extending/) for a good place to start..

## [Customizing Umbraco sites](../Getting-Started/Developing-websites-with-Umbraco/Customizing-Umbraco-sites/index.md)

Umbraco is highly customizable which means you can basically integrate it with anything and make it behave as you want. With Umbraco, you start out with a clean slate.

:::note
From a frontend perspective, Umbraco does not dictate HTML, CSS, or JS in your website build. There is nothing Umbraco specific about it.
:::

Umbraco uses ASP.NET and MVC patterns and you can extend and write your own controllers using the approach outlined in this section.

:::center
![Umbraco on devices](images/Umbraco_Brand_Guidelines_2020_30_Illustrationbuilding.png)
:::

## Which IDE to use for writing code with Umbraco?
When you are customizing or extending your Umbraco website using C# we recommend using [Visual Studio] - link to the Community edition

You can also use a simpler tool like [Visual Studio Code](https://visualstudio.microsoft.com/free-developer-offers/) or any other text editor you prefer working with, however, this is only recommended if you’re when you’re not working directly with C# files.

_When developing, and writing code to work alongside a Umbraco site, whilst it’s perfectly possible to use notepad, and put your code in the app_code folder of your site, and have it compiled when the site starts up, it’s really much easier to use Visual Studio in some way._

