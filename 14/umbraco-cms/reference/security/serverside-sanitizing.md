---
description: This section describes how to sanitize the Rich Text Editor serverside
---

# Sanitizing the Rich Text Editor

The Rich Text Editor is sanitized on the frontend by default, however, you may want to do this serverside as well. The libraries that are out there tend to have very strict, and therefore, problematic dependencies, so we'll leave it up to you how you want to sanitize the HTML.

## Implementing your own IHtmlSanitizer

To make this task as easy as possible we've added an abstraction called `IHtmlSanitizer`, by default this doesn't do anything, but you can overwrite it with your own implementation to handle sanitization how you see fit. This interface only has a single method `string Sanitize(string html)`, the output of this method is what will be stored in the database when you save a RichText editor.

To add your own sanitizer you must first create a class the implements the interface:

```csharp
using Umbraco.Cms.Core.Security;

namespace MySite.HtmlSanitization;

public class MyHtmlSanitizer : IHtmlSanitizer
{
    public string Sanitize(string html)
    {
        // Sanitize the html parameter here
        return "<h1>Sanitized HTML</h1>";
    }
}
```

As you can see this specific implementation doesn't do a whole lot, but the `Sanitize` method is where you can use a library, or even your own sanitizer implementation, to sanitize the RichText editor input.

Now that you've added your own custom `IHtmlSanitizer` you must register it in the container to replace the existing NoOp sanitizer.

You can register it directly in the `Program.cs` or use a composer.

{% hint style="info" %}
Learn more about registering dependencies and when to use which method in the [Dependency Injection](../using-ioc.md) article.
{% endhint %}

The extension method could look like the following:

```csharp
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Security;
using Umbraco.Extensions;

namespace MySite.HtmlSanitization;

public static class BuilderExtensions
{
    public static IUmbracoBuilder AddHtmlSanitizer(this IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IHtmlSanitizer, MyHtmlSanitizer>();
        return builder;
    }
}
```

The extension can then be invoked in the `CreateUmbracoBuilder()` builder chain in the `Program.cs` file:

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddHtmlSanitizer() // Call you extension method here.
    .Build();
```

Another option is to create a composer for handling the extension method:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Security;
using Umbraco.Extensions;

namespace MySite.HtmlSanitization;

public class SanitizerComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IHtmlSanitizer, MyHtmlSanitizer>();
    }
}
```

With your custom sanitizer in place the Rich Text Editor will always contain the "Sanitized HTML" heading. This shows that everything is working as expected, and that whatever your sanitizer returns is what will be saved.
