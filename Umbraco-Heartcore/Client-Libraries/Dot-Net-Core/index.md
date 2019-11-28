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

In order to use and test with the sample you will need an Umbraco Heartcore project with content, media and Document Types that correspond to those setup in the Views and Models of the sample website. You can use demo-headless as the project alias to get started with the sample. The Project behind this alias has been used as the source of the sample, so its a good place to start.

## Console Sample