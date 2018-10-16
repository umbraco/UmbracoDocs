# Headless .NET client

:::warning
Before you start, you'll need to create a Headless project on Cloud which can be done by following the instructions at __[umbraco.com/headless](https://www.umbraco.com/headless)__. 

_Be aware that the Umbraco headless is still in beta._
:::

## Using the client

_Below are examples for various types of projects_

### [ASP.NET Core MVC (Static route website)](website-static.md)

_This example is for creating a statically routed website which means that it's a normal MVC application that defines it's own routes, like a brochure website. URLs will not be dynamic._

### [ASP.NET Core MVC (Content Managed website)](website-managed.md)

_This example is for creating a fully content managed website where URLs will be dynamic and be based on the same URLs generated in Umbraco. This also gives you the ability to Hijack routes for specific Document Types like in a normal Umbraco installation._

### [.NET Core Console Application](console.md)

_This example is for creating a .NET Core Console (command line) application_

### [ASP.NET Framework website](website-framework.md)

_This example shows how to build a traditional ASP.NET Framework website on Windows and Visual Studio using the Umbraco Headless Client._

### [Query data with the .NET Headless Client](Query.md)

_This article will cover both basic queries where you filter on a document type and a single property but also more advanced ones where you can use either XPath or Lucene queries for maximum flexibility_
