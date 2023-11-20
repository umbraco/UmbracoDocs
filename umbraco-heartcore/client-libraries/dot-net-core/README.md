# .NET Client library

In this article you can learn more about the .NET client library that you can clone and use with your Umbraco Heartcore projects.

It is a library for .NET Core and is based on .NET Standard 2.0. This means that it can be used on the most .NET frameworks, for example UWP, Xamarin.Android, Xamarin.Mac and Desktop .NET 4.6.1.

## Download and install

The .NET library can be found on GitHub: [.NET client library for Umbraco Heartcore](https://github.com/umbraco/Umbraco.Headless.Client.Net).

You can also install it through NuGet:

```
> Install-Package Umbraco.Headless.Client.Net
```

{% hint style="info" %}
Please be aware that the minimum NuGet client version requirement has been updated to 2.12. This change is made to support multiple .NET Standard targets in the NuGet package.
{% endhint %}

You will receive a Visual Studio solution file that references the client library (Umbraco.Headless.Client.Net). Additionally, there is a test project (Umbraco.Headless.Client.Net.Tests) utilizing xUnit for unit and integration tests.

Along with the client library you will also find two samples based on the library. We have built an MVC sample and a console sample.

## [MVC sample](mvc-samples.md)

Test your Umbraco Heartcore project against a small MVC site. You can choose to use our sample project and content, or connect to your own project and build your own views and controllers.

## [Content Management sample](content-management-sample.md)

Get to know the content management service and how to use it to manage content and media programmatically.
