---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# PDF indexes and multisearchers

If you want to index PDF files and search for them you will need to use the [UmbracoExamine.Pdf extension package](https://github.com/umbraco/UmbracoExamine.PDF).

## Installation

Install with Nuget:
`dotnet add package Umbraco.ExaminePDF`

You will then have a new Examine index called "PDFIndex" available.

## Multi index searchers

You can register a multi index searcher with the ExamineManager on startup like:

```csharp
using Examine;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using UmbracoExamine.PDF;

namespace MySite.MyCustomIndex
{
    [ComposeAfter(typeof(ExaminePdfComposer))]
    public class ExamineComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Services.AddExamineLuceneMultiSearcher("MultiSearcher", new[] {Constants.UmbracoIndexes.ExternalIndexName, PdfIndexConstants.PdfIndexName});
        }
    }
}}
```

With this approach, the multisearcher will show up in the Examine dashboard and it can be resolved from the ExamineManager like:

```csharp
if (_examineManager.TryGetSearcher("MultiSearcher", out var searcher))
{
    //TODO: use the `searcher` to search
}
```

:::warning
The implementation of IPdfTextExtractor is PdfSharpTextExtractor in this library, which uses PDFSharp to extract the bytes to convert to text. That implementation doesn't deal well with Unicode text which means when some PDF files are read, the result will be 'junk' strings.

It is certainly possible to replace the IPdfTextExtractor using your own composer like

`composition.RegisterUnique<IPdfTextExtractor, MyCustomSharpTextExtractor>();`

The iTextSharp library deals with Unicode in a better way but is a paid for license. If you wish to use iTextSharp or another PDF library you can swap out the IPdfTextExtractor with your own implementation.
:::
