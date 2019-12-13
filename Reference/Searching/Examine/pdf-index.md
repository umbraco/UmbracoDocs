---
versionFrom: 8.0.0
---

# PDF indexes and multisearchers

If you want to index PDF files and search for them you will need to use the [UmbracoExamine.Pdf extension package](https://github.com/umbraco/UmbracoExamine.PDF).

## Installation

Install with Nuget:
`Install-Package UmbracoCms.UmbracoExamine.PDF`

You will then have a new Examine index called "PDFIndex" available.

## Multi index searchers

To use the multisearcher in Umbraco 8, you can instantiate it when needed like:

```csharp
using(var multiSearcher = new MultiIndexSearcher("MultiSearcher", new IIndex[] {
    externalIndex,
    pdfIndex
}))
{
 ...
};
```

Or you can register a multi index searcher with the ExamineManager on startup like:

```csharp
using Examine;
using Examine.LuceneEngine.Providers;
using Umbraco.Core.Composing;
using UmbracoExamine.PDF;

[ComposeAfter(typeof(ExaminePdfComposer))] //this must execute after the ExaminePdfComposer composer
public class MyComposer : ComponentComposer<MyComponent>, IUserComposer
{
}

public class MyComponent : IComponent
{
    private readonly IExamineManager _examineManager;

    public MyComponent(IExamineManager examineManager)
    {
        _examineManager = examineManager;
    }

    public void Initialize()
    {
        //Get both the external and pdf index
        if (_examineManager.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out var externalIndex)
            && _examineManager.TryGetIndex(PdfIndexConstants.PdfIndexName, out var pdfIndex))
        {
            //register a multisearcher for both of them
            var multiSearcher = new MultiIndexSearcher("MultiSearcher", new IIndex[] { externalIndex, pdfIndex });
            _examineManager.AddSearcher(multiSearcher);
        }
    }

    public void Terminate() { }
}
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
