---
description: "Represents a Language. Installed languages can be found in the settings section."
---

# Language

Represents a Language. Installed languages can be found in the settings section.

* **Namespace:** `Umbraco.Cms.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:

```csharp
using Umbraco.Cms.Core.Models;
```

## Constructors

### new Language(GlobalSettings globalSettings, string isoCode)

Constructor for creating a new `Language` object where the necessary parameter are the global settings as `GlobalSettings` and the isoCode as a `string`.

{% hint style="info" %}
To create a new Language the global setting parameter is necessary. You can find more info about how to use configuration in code in the [Config article](../../configuration/#reading-configuration-in-code).
{% endhint %}

## Properties

### .CultureInfo

Gets the CultureInfo object for the language.

```csharp
var language = new Language(globalSettings, "en-US");
CultureInfo cultureInfo = language.CultureInfo;
return cultureInfo;
```

### .CultureName

Gets or sets the culture name of the language.

```csharp
var language = new Language(globalSettings, "en-US");
string cultureName = language.CultureName;
return cultureName;
```

### .FallbackLanguageId

Gets or sets the identifier of a fallback language. The fallback language can be used in multi-lingual scenarios, to help define fallback strategies when a value does not exist for a requested language.

```csharp
var language = new Language(globalSettings, "en-US");
int? fallbackLanguageId = language.FallbackLanguageId;
return fallbackLanguageId;
```

### .IsDefault

Gets or sets a value indicating whether the language is the default language.

```csharp
var language = new Language(globalSettings, "en-US");
bool isDefault = language.IsDefault;
return isDefault;
```

### .IsMandatory

Gets or sets a value indicating whether the language is mandatory. When a language is mandatory, a multi-lingual document cannot be published without that language being published, and unpublishing that language unpublishes the entire document.

```csharp
var language = new Language(globalSettings, "en-US");
bool isMandatory = language.IsMandatory;
return isMandatory;
```

### .IsoCode

Gets or sets the ISO code of the language.

```csharp
var language = new Language(globalSettings, "en-US");
return language.IsoCode;
```
