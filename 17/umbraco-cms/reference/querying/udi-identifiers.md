# UDI Identifiers

Umbraco uses Unique Document Identifiers (UDIs) to reference most object types, such as content, media, and members. A UDI contains all the metadata needed to retrieve an Umbraco object and is readable within text.

Example:

```text
umb://document/4fed18d8c5e34d5e88cfff3a5b457bf2. 
```

UDIs are commonly used in Umbraco’s querying and management APIs.

## Format

A UDI consists of three parts:

1. Scheme: `umb://` – Identifies as an Umbraco UDI.
2. Type: `document`– Specifies the object type (for example, media, member, Data Type, and so on).
3. GUID Identifier: `4fed18d8c5e34d5e88cfff3a5b457bf2` – A unique identifier for the object (a GUID without dashes).

## Usage

UDIs are useful for retrieving content, media, or other Umbraco objects through the API. Below are examples of how to use a UDI in C# to get content or media.

### Retrieving Content by UDI

You can retrieve a content item using `IContentService`:

```cs
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Models

@inject IContentService contentService

@{
   // Define the UDI string here
    var udiString = "umb://document/334cadfa62dd49049aad86b6e4c02aac"; // Example UDI string

   if (udiString.StartsWith("umb://document/"))
    {
        // Extract the GUID from the UDI string
        var guidString = udiString.Replace("umb://document/", "");
        if (Guid.TryParse(guidString, out var guid))
        {
            // Retrieve the content by GUID
            var content = contentService.GetById(guid);
            if (content != null)
            {
                // Access the body text field
                var bodyText = content.GetValue<string>("bodyText"); // Replace 'bodyText' with the alias of your body text field
                <p>@bodyText</p>  // Output the body text
            }
        else
            {
                <p>Content not found.</p>
            }
        }
        else
        {
            <p>Invalid GUID in the UDI string.</p>
        }
    }
}
```

## UDI Types

There are two types of UDIs in Umbraco:

### GUID UDI

Used for objects that have a GUID identifier, such as content and media.

* [API Reference: GuidUdi](https://apidocs.umbraco.com/v17/csharp/api/Umbraco.Cms.Core.GuidUdi.html)

### String UDI

Used for objects that are not GUID-based, such as dictionary items.

* [API Reference: StringUdi](https://apidocs.umbraco.com/v17/csharp/api/Umbraco.Cms.Core.StringUdi.html)
