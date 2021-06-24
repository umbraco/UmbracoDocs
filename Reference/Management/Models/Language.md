---
versionFrom: 8.0.0
---

# Language

Represents a Language. Installed languages can be found in the settings section.

* **Namespace:** `Umbraco.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:

    using Umbraco.Core.Models;

## Constructors

### new Language(string isoCode)

Constructor for creating a new `Language` object where the necessary parameter is a isoCode as a `string`.

## Properties

### .CultureInfo

Gets the CultureInfo object for the language.

```csharp
var language = new Language("en-US");
return language.CultureInfo;
```

### .CultureName

Gets or sets the culture name of the language.

```csharp
var language = new Language("en-US");
return language.CultureName;
```

### .FallbackLanguageId

Gets or sets the identifier of a fallback language. The fallback language can be used in multi-lingual scenarios, to help define fallback strategies when a value does not exist for a requested language.

```csharp
var language = new Language("en-US");
return language.FallbackLanguageId;
```

### .IsDefault
Gets or sets a value indicating whether the language is the default language.

```csharp
var language = new Language("en-US");
return language.IsDefault;
```

### .IsMandatory

Gets or sets a value indicating whether the language is mandatory. When a language is mandatory, a multi-lingual document cannot be published without that language being published, and unpublishing that language unpublishes the entire document.

```csharp
var language = new Language("en-US");
return language.IsMandatory;
```

### .IsoCode

Gets or sets the ISO code of the language.

```csharp
var language = new Language("en-US");
return language.IsoCode;
```
