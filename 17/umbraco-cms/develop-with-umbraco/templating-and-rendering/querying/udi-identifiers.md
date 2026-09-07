---
description: >-
  UDIs are an identifier format in Umbraco. Learn how they are structured, how to
  query content with them, and how to convert between UDIs and GUIDs.
---

# UDI Identifiers

A Unique Document Identifier (UDI) is a string that identifies an Umbraco entity. An example of a UDI is `umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2`.

Most Umbraco APIs identify entities by their GUID key. The backoffice and the Management API both work with plain GUIDs. UDIs are more commonly used as a storage and integration format.

## Format

A UDI consists of three parts:

| Part | Example | Description |
| --- | --- | --- |
| Scheme | `umb://` | Marks the value as an Umbraco identifier. |
| Entity type | `document` | The type of entity the identifier points to. Other examples are `media`, `member`, and `data-type`. |
| Identifier | `4fed18d8c5e34d5e88cfff3a5b457bf2` | The unique identifier of the entity. |

### GUID and string UDIs

The identifier part is either a GUID or a string. Which one is used depends on the entity type.

A [`GuidUdi`](https://apidocs.umbraco.com/v17/csharp/api/Umbraco.Cms.Core.GuidUdi.html) has a GUID as its identifier. The GUID is written without dashes. Most entity types use this format, such as `document`, `media`, and `member`.

```none
umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2
```

A [`StringUdi`](https://apidocs.umbraco.com/v17/csharp/api/Umbraco.Cms.Core.StringUdi.html) has a string as its identifier, such as a file path or a culture code. A few entity types use this format, such as `stylesheet`, `script`, and `language`.

```none
umb://stylesheet/style.css
umb://language/en-US
```

## Query content with a UDI

`IPublishedContentQuery` accepts UDIs directly through the `Content(Udi)` and `Media(Udi)` overloads. You do not need to convert a UDI to a GUID first.

The following example resolves a UDI in a view:

{% code title="MyView.cshtml" %}

```csharp
@using Umbraco.Cms.Core
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@inject IPublishedContentQuery PublishedContentQuery

@{
    const string storedValue = "umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2";
    if (UdiParser.TryParse(storedValue, out Udi? udi))
    {
        // Pass the UDI straight to the query. No conversion needed.
        IPublishedContent? content = PublishedContentQuery.Content(udi);
        <p>@content?.Name</p>
    }
}
```

{% endcode %}

`UmbracoHelper` exposes the same overloads. In a view that inherits `UmbracoViewPage`, you can call `Umbraco.Content(udi)` instead.

## Convert between UDIs and GUIDs

Use `UdiParser.TryParse()` to read a UDI. Parsing is safer than manipulating the string, as it validates both the entity type and the identifier. The `Guid` property gives you the key used by the GUID-first APIs:

```csharp
if (UdiParser.TryParse("umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2", out GuidUdi? udi))
{
    Guid contentKey = udi.Guid;
}
```

To build a UDI from an entity type and a GUID key, use `Udi.Create()`:

```csharp
Guid contentKey = Guid.Parse("4fed18d8-c5e3-4d5e-88cf-ff3a5b457bf2");
Udi udi = Udi.Create(Constants.UdiEntityType.Document, contentKey);
```

These types are all in the `Umbraco.Cms.Core` namespace.
