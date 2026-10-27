---
description: >-
  A guide for including file content in search
---

# Searching file content

File content is not indexed for search in Umbraco by default. There are two main reasons for that:

1. It can be a very CPU and memory intensive task, which could slow down your entire site.
2. Umbraco can only support a very limited number of file formats out of the box.

If you need to search file content, we have created a file-to-text indexing package. It is free, open source, and can be installed as an optional add-on.

{% hint style="warning" %}
Carefully test the CPU and memory impact of utilizing this package before deploying it to production.
{% endhint %}

## Installation instructions

Install the package from NuGet: 

```
dotnet package add Umbraco.Cms.Search.Extension.FileToText
```

The package registers itself automatically at start-up.

## How it works

By default, the package attempts to index the file content of all Content and Media items.

File content is loaded from any property containing binary file data (for example, a File Upload editor). Subject to file format support, the package extracts text from the binary data and adds it as text to the search index.

Effectively, this means the file content of Content and Media items will be surfaced as results from free text search.

{% hint style="info" %}
For Content, this applies both to draft and published versions.
{% endhint %}

## Configuration options

You can configure the package behavior by adjusting its `IndexingOptions` using the options pattern. It allows for:

- Disabling Content and Media indexing individually.
- Setting an upper limit to the size of files being processed for indexing. 

{% code title="FileToTextConfigurationComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Search.Extension.FileToText.Configuration;

namespace My.Site.DependencyInjection;

public class FileToTextConfigurationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.Configure<IndexingOptions>(config =>
        {
            // Set this to false to skip indexing of file content for Content items
            config.IncludeContent = false;

            // Set this to false to skip indexing of file content for Media items
            config.IncludeMedia = false;

            // Define this to skip files larger than a specified upper boundary
            config.MaxFileSize = 10 * 1024 * 1024; // 10 MB
        });
}
```
{% endcode %}

## File formats included

The package supports indexing of PDF, Markdown and text files. You can extend this by [adding your own file formats](adding-file-formats.md).
