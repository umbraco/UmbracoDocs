---
description: >-
  Installing Umbraco Search into your Umbraco CMS
---

# Installation

In this article, you will learn how to install Umbraco Search into your Umbraco CMS.

## Requirements

Umbraco Search is compatible with Umbraco 17.

## NuGet Packages

Umbraco Search is installed from NuGet.

There are multiple NuGet packages which cover different aspects of search:

- [`Umbraco.Cms.Search.Core`](https://nuget.org/packages/Umbraco.Cms.Search.Core) contains the core functionality.
- [`Umbraco.Cms.Search.BackOffice`](https://nuget.org/packages/Umbraco.Cms.Search.BackOffice) allows Umbraco Search to power the backoffice content search.
- [`Umbraco.Cms.Search.DeliveryApi`](https://nuget.org/packages/Umbraco.Cms.Search.BackOffice) allows Umbraco Search to power the [Content Delivery API](../../umbraco-cms/reference/content-delivery-api).
- [`Umbraco.Cms.Search.Provider.Examine`](https://www.nuget.org/packages/Umbraco.Cms.Search.Provider.Examine) is the default search provider implementation.

## Basic functionality

To get started, install Umbraco Search and the Examine search provider from NuGet:

```bash
dotnet add package Umbraco.Cms.Search.Core
dotnet add package Umbraco.Cms.Search.Provider.Examine
```

With these packages installed, enable Umbraco Search using a composer:

{% code title="SiteComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Search.Core.DependencyInjection;
using Umbraco.Cms.Search.Provider.Examine.DependencyInjection;

namespace My.Site.DependencyInjection;

public sealed class SiteComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder
            // add core services for search abstractions
            .AddSearchCore()
            // add the Examine search provider
            .AddExamineSearchProvider();
    }
}
```
{% endcode %}

{% hint style="info" %}
See Examine specific configuration options in the [Examine search provider](../getting-started/examine-search-provider.md) article.
{% endcode %}

### The backoffice search

To include the backoffice search:

1.  Install the NuGet package:

    ```bash
    dotnet add package Umbraco.Cms.Search.BackOffice
    ```
2.  Enable the package in the composer:

    {% code title="SiteComposer.cs" %}
    ```csharp
    // use Umbraco Search for backoffice search
    builder.AddBackOfficeSearch();
    ```
    {% endcode %}

### The Content Delivery API

To include the Content Delivery API:

1.  Install the NuGet package:

    ```bash
    dotnet add package Umbraco.Cms.Search.DeliveryApi
    ```
2.  Enable the package in the composer:

    {% code title="SiteComposer.cs" %}
    ```csharp
    // use Umbraco Search for the Content Delivery API
    builder.AddDeliveryApiSearch();
    ```
    {% endcode %}
