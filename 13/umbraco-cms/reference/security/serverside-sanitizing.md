---
description: This section describes how to sanitize the Rich Text Editor serverside
---

# Sanitizing the Rich Text Editor

With default Umbraco settings, the Rich Text Editor is partially sanitized on the frontend.  However, server-side sanitization may also be desired, and an extension point is available for this purpose.

Libraries for this are available but tend to have strict dependencies that make them unsuitable for shipping with Umbraco. Clients will also have different requirements for how strict they want the sanitization to be.  For these reasons, it's left to the implementer to determine how HTML should be sanitized.

## Implementing your own IHtmlSanitizer

We have added an abstraction called `IHtmlSanitizer`, which by default does nothing. You can override it with your own implementation to handle sanitization as you see fit. This interface has a single method: `string Sanitize(string html)`. The output of this method is what will be stored in the database when you save a Rich Text Editor.

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

The `Sanitize` method in this implementation is where you can use a library. You could also use your own sanitizer implementation, to sanitize the Rich Text Editor input.

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

Or you can use a Composer:

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

## Client side validation

As mentioned, when using TinyMCE as the rich text editor, there is client-side sanitization available.  You can tighten this up further by removing elements and attributes you don't need from the [list of allowed elements](https://docs.umbraco.com/umbraco-cms/13.latest/reference/configuration/richtexteditorsettings#valid-elements).