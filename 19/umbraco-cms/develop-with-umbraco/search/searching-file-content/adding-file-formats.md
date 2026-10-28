---
description: >-
  Developer documentation for extending the file-to-text indexing package.
---

# Adding file formats

The file-to-text indexing package is extendable, so you can add support for additional file formats. This is done by implementing an `IFileValueHandler` for each file format.

## Example

The following example adds MS Word (`.docx`) as a supported file format. It leverages [`DocSharp.Docx`](https://www.nuget.org/packages/DocSharp.Docx) to parse Word files into plain text.

{% code title="DocxFileValueHandler.cs" %}
```csharp
using DocSharp.Docx;
using Umbraco.Cms.Search.Extension.FileToText.FileIndexing;

namespace My.Site.FileValueHandlers;

public class DocxFileValueHandler : IFileValueHandler
{
    public bool CanHandle(string extension)
        => extension.InvariantEquals(".docx");

    public Task<string> GetFileContentsAsync(Stream stream, CancellationToken cancellationToken)
    {
        var converter = new DocxToTxtConverter();
        var text = converter.ConvertToString(stream);
        return Task.FromResult(text);
    }
}
```
{% endcode %}

The `IFileValueHandler` implementation must be registered as singleton:

{% code title="DocxFileValueHandler.cs" %}
```csharp
using My.Site.FileValueHandlers;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Search.Extension.FileToText.FileIndexing;

namespace My.Site.DependencyInjection;

public class DocxFileValueHandlerComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.AddSingleton<IFileValueHandler, DocxFileValueHandler>();
}
```
{% endcode %}
