---
description: Describes how markdown to HTML is carried out within Umbraco.
---

# Markdown to HTML Conversion

Umbraco requires Markdown to be converted into HTML. Primarily, this is to support the [Markdown property editor](../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/markdown-editor.md). There are also internal use cases, for example, in rendering email notification content for [health checks](../extending/health-check/README.md).

The conversion is managed via the `IMarkdownToHtmlConverter` interface.

Umbraco registers a default implementation of `HeyRedMarkdownToHtmlConverter`, which is based on the [Hey Red Markdown library](https://github.com/hey-red/Markdown).

Also provided is an unregistered, alternate implementation of `MarkdigMarkdownToHtmlConverter`, based on the [Markdig library](https://github.com/xoofx/markdig).

Both implementations convert standard markdown into HTML, but there are some subtle differences in the output produced.

## Modifying the Default Behavior

If you prefer to use the Markdig-based implementation, you can replace the default registration with the following composer:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Strings;
using Umbraco.Cms.Infrastructure.Strings;

public class MarkdownToHtmlComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IMarkdownToHtmlConverter, MarkdigMarkdownToHtmlConverter>();
    }
}
```

Alternatively, the interface itself can be implemented directly, enabling you to use the library and custom behavior you prefer:

```csharp
namespace Umbraco.Cms.Core.Strings;

public interface IMarkdownToHtmlConverter
{
    /// <summary>
    /// Converts the specified Markdown-formatted text to an HTML-encoded string.
    /// </summary>
    /// <param name="markdown">The input string containing Markdown syntax to be converted.</param>
    /// <returns>A string containing the HTML representation of the input Markdown.</returns>
    public string ToHtml(string markdown);
}
```

## Planned Updates

The Hey Red Markdown library is now deprecated. We expect to make the implementation based on Markdig the default one registered from Umbraco 18. The Hey Red Markdown library implementation will be removed in Umbraco 19.
