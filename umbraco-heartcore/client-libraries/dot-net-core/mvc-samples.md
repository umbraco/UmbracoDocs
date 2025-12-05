# MVC Sample

In `/samples/Umbraco.Headless.Client.Samples.Web/` you will find a .NET 6.0-based MVC website implementation. It presents one possible approach to creating a website using Umbraco Heartcore for Content Delivery.

The sample is built around a sample project with the alias `demo-headless`. You can choose to test the sample with the sample project or connect the sample to your own project.

## Prerequisites

* [.NET 6.0](https://dotnet.microsoft.com/en-us/download/dotnet/6.0)

## Run the sample on your local machine

Before running the sample, you must define which Umbraco Heartcore project you want to fetch content from.

* Open the `appsettings.json` found in `samples/Umbraco.Headless.Client.Samples.Web/Umbraco.Headless.Client.Samples.Web/`
* Add your project alias or use the default alias of the sample project, `demo-headless`

```json
{
    "Heartcore": {
        "ProjectAlias": "demo-headless",
        "ApiKey": ""
    }
}
```

The `ApiKey` can be left blank when using the `demo-headless` sample project. If you are testing with your project and have chosen to protect the content exposed via the Content Delivery API, you will need an API Key. It is an option that has to be actively turned on via the Umbraco Backoffice in the Headless tree in the Settings section. Read more about this feature in the [Backoffice users and API Keys article](../../getting-started/backoffice-users-and-api-keys.md).

The MVC sample can be run in one of two ways:

### 1. Use the command line

Using a command-line tool, run the following two commands in the `Umbraco.Headless.Client.Samples.Web` folder:

```bash
dotnet restore
dotnet run
```

The first command will restore the packages and the second will run the site. Alternatively, you can use the new hot-reload functionality:

```bash
dotnet watch run
```

To run the project and hot reload or recompile the project whenever changes are detected.

### 2. Using an Integrated Development Environment (IDE)

Run the application in Visual Studio or Visual Studio Code by hitting `F5`.

{% hint style="info" %}
* Visual Studio Code (VSCode) requires you to have a launch configuration before `F5`will work.
* The editor will prompt you to add a launch configuration if you have the `C#` extension installed in VSCode.
{% endhint %}

## Show your content

For the following section, a Umbraco Heartcore project with the following content structure will be used:

![Content structure](../../.gitbook/assets/content-structure.png)

{% hint style="info" %}
To connect to your project, you need to change the `ProjectAlias` value in the `application.json` file as demonstrated in [Run the sample on your local machine](mvc-samples.md#run-the-sample-on-your-local-machine).
{% endhint %}

When you have connected the client project to your Umbraco project and run the client project, you will be presented with a default page. The page shows the properties and the data from the content node at the root of your website. This is because no view or controller has yet been defined for your content structure.

We will need to define and build a view and/or an MVC controller for the content types (Document Types) in our client project in order for us to start rendering content.

There are two ways to do this:

* Define a view file using the Document Type alias or
* Build a controller using the already defined UmbracoController

Each approach is explained in more detail below.

### Define a view file

1. Create a model class for the content type you want to render, e.g., `Models/HomePage.cs`. Make sure the model extends the abstract class `Content` and that the properties you want to render from the Umbraco content node are defined as public properties with PascalCasing. PascalCasing means that a content node property called `personName` will be mapped to the `PersonName` property in the model.
2. Create a `homePage.cshtml` file in `Views/DefaultUmbraco` - the name of the file should be the alias of the Document Type the root content node is using.
3. Set `HomePage` as the model.
4. Set layout to `null` - this can be used later on when you want to share one layout between more views.

```csharp
@model Umbraco.Headless.Client.Net.Delivery.Models.Content
@{
    Layout = null;
}
```

When you build the solution and start it up, this view file will now be used to populate the frontend.

### Build a controller

1. Right-click the `Controllers` folder in Visual Studio and select _Add > Controller..._
2. Select _MVC Controller - Empty_
3. Use the alias of the Document Type used on the root content node for the name of the controller, e.g. `HomePageController`
4. Set the controller to use `UmbracoController`
5. Set the `Index()` action to return `UmbracoContext.Content`

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Headless.Client.Samples.Web.Mvc;

namespace Umbraco.Headless.Client.Samples.Web.Controllers
{
    public class HomePageController : Controller
    {
        public HomePageController(UmbracoContext umbracoContext) : base(umbracoContext)
        {
        }

        public IActionResult Index()
        {
            return View(UmbracoContext.Content);
        }
    }
}
```

The controller is now in place but to show our content we also need to define a view.

1. Create a folder in `/Views` using the alias of the Document Type, e.g. `/HomePage`.
2. Create an `Index.cshtml` file in the new folder.
3. Follow steps 2-3 from the [Define a view file](mvc-samples.md#define-a-view-file) section.
4. Build and run the solution.

## Building view files

To render the data from the properties on our content, we need to use the `@Model.PropertyName` approach, where the value is the Name of the property you want to display the data from.

An example could be a text string property with the alias `heading`. To render the data from this property on the frontend, we will need to use `@Model.Heading`.

note To render data from a property, the property must be defined in the view model (`@model`), and it must match an alias on the corresponding content node from your Umbraco project.

Below is a complete example of how a view for a root node could look.

```html
@using Umbraco.Headless.Client.Net.Delivery.Models;
@model HeroPage
@{
    Layout = null;
}

<!DOCTYPE HTML>
<html>

<head>
    <title>@Model.Title</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
</head>

<body>

    <h1>@Model.Heading</h1>

    <div>

        <p>@Html.Raw(Model.BodyText)</p>

        <img src="@(Model.PromoImage?.Url)?width=300" />

    </div>

</body>
</html>
```

HTML is used to build the general structure of the article, while we use Razor to render data from our Umbraco Heartcore project.

## References

* [Overview of ASP.NET Core MVC](https://docs.microsoft.com/en-us/aspnet/core/mvc/overview?view=aspnetcore-2.2)
* [Tutorial: Get started with ASP.NET Core MVC](https://docs.microsoft.com/en-gb/aspnet/core/tutorials/first-mvc-app/start-mvc?view=aspnetcore-2.2\&tabs=visual-studio)
* [API Documentation for Umbraco Heartcore](../../api-documentation/)
* [Create an Umbraco Heartcore project](../../getting-started/creating-a-heartcore-project.md)
