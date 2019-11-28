---
versionFrom: 8.0.0
---

# .NET Core Client library

In this article you can learn more about the .NET Core client library that you can clone and use with your Umbraco Heartcore projects.

It is a library for .NET Core and is based on NetStandard 2.0. This means that it can be used on the most .Net frameworks. A few examples could be UWP, Xamarin.Android, Xamarin.Mac, Desktop .Net 4.6.1 and .NET Core.

## Download and install

The .NET Core library can be found on GitHub: [.NET Core client library for Umbraco Heartcore](https://github.com/umbraco/Umbraco.Headless.Client.Net). 

You can also install it through NuGet:

```
> Install-Package Umbraco.Headless.Client.Net
```

:::note
Please be aware that the minimum NuGet client version requirement has been updated to 2.12 in order to support multiple .NET Standard targets in the NuGet package.
:::

You will get a Visual Studio solution file which references the client library itself (Umbraco.Headless.Client.Net) as well as a test project (Umbraco.Headless.Client.Net.Tests) which uses xUnit for unit and integration tests.

Along with the client library you will also find two samples using the library. We have built an MVC sample and a console sample. Below you will find instructions on how to clone these down and set them up for testing with your own Heartcore project.

## MVC Sample

In `/samples/Umbraco.Headless.Client.Samples.Web/` you will find a .NET Core 2.2 based MVC website implementation. It presents one possible approach to creating a website using Umbraco Heartcore for Content Delivery.

The sample is built up around a sample Heartcore project with the alias `demo-headless`. You can choose to test the sample with the sample project or connect the sample to your own Heartcore project.

### Prerequisites

- [.NET Core SDK 2.2](https://dotnet.microsoft.com/download/dotnet-core/2.2)

### Run the sample on your local machine

Before running the sample you will need to define which Umbraco Heartcore project you want to fetch content from.

- Open the `application.json` found in `samples/Umbraco.Headless.Client.Samples.Web/Umbraco.Headless.Client.Samples.Web/`
- Add your project alias or use the alias of the sample project, `demo-headless`

```
{
    "Umbraco": {
        "ProjectAlias": "demo-headless",
        "ApiKey": ""
    }
}
```

The `ApiKey` can be left blank when using the `demo-headless` sample project. If your testing with your own Heartcore project and have chosen to protect the content exposed via the Content Delivery API then you will need an API-Key. It is an option that has to be actively turned on via the Umbraco Backoffice in the Headless tree in the Settings section. Read more about that in the [Backoffice users and API Keys article](../../Getting-Started-Cloud/Backoffice-Users-and-API-Keys).

The MVC sample can be run in one of two ways:

**1. Use the command line**

This is done by running the following two commands in the `Umbraco.Headless.Client.Samples.Web` folder:

```
> dotnet restore
> dotnet run
```

The first command will restore the packages and the second will run the site.

**2. Using an IDE**

Run the application in Visual Studio or Visual Studio Code by hitting `F5`.

### Show your content

For the following section, as Heartcore project with the following content structure will be used:

![Content structure](images/content-structure.png)

When you've connected the MVC sample to your own Umbraco Heartcore project you will be presented with a page showing the properties and the data from the content node at the root of your website. This is because we need to define which view or controller should be used for the content on our project.

This can be done in two ways: Define a view file using the Document Type alias or build a controller using the already defined UmbracoController.

**Define a view file**

1. Create a new 

By default the application will try to route the URLs to through Umbraco Heartcore by calling `https://cdn.umbraco.io/content/url?url={url}`. Is the response a `200 OK` the `UmbracoContext.Content` is set to the response.

The router wiill then check if there is a controller for the specific content type (Document Type) e.g. if the content type alias is `textPage` it will look for a controller named `TextPageController` and uses the UmbracoController. If that is found, the `Index` action is called. Otherwise the `DefaultUmbracoController` is called and will then render a view named `Views/DefaultUmbraco/{contentTypeAlias}.cshtml` with Umbraco.Headless.Client.Net.Delivery.Models.Content as the model.



## Console Sample