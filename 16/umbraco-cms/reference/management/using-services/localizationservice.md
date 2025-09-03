---
description: Example on how to retrieve languages using the LocalizationService.
---

# Localization Service

Learn how to use the Localization service to retrieve languages.

## Getting a single language

The localization service contains a number of methods for looking up languages. If you already know the ID of a specific language (eg. the default language has ID `1`), you can use the `GetLanguageById` method to get the reference to that language:

```csharp
// Get a reference to the language by its ID
ILanguage language1 = _localizationService.GetLanguageById(1);
```

As an alternative, you can look up a language by its ISO code via the `GetLanguageByIsoCode` method:

```csharp
// Get a reference to the language by its ISO code
ILanguage language2 = _localizationService.GetLanguageByIsoCode("en-US");
```

The ISO code is a combination of the two-letter ISO 639-1 language code (lowercase) and two-letter ISO-3166 country code (uppercase). Eg. `en-US` for English in the United States, `en-GB` for English in the United Kingdom and `da-DK` for Danish in Denmark.

Both methods will return an instance of the [ILanguage](https://apidocs.umbraco.com/v15/csharp/api/Umbraco.Cms.Core.Models.ILanguage.html) interface, which has traditional properties like `Id` and `Key`, but also properties specific to the language like `CultureName`, `CultureInfo` and `IsoCode`. You can see the API reference for further information on the properties of the interface.

## Getting all languages

If you need instead need a list of all installed languages, you can use the `GetAllLanguages` method. It takes no parameters, and as such a returns a collection of all languages (with no pagination like some of the other services):

```csharp
// Get a collection of all languages
IEnumerable<ILanguage> languages = _localizationService.GetAllLanguages();

// Iterate over the collection
foreach (ILanguage language in languages)
{
    // Get the .NET culture info
    CultureInfo cultureInfo = language.CultureInfo;

    <pre>ID: @language.Id</pre>
    <pre>Key: @language.Key</pre>
    <pre>Name: @language.CultureName</pre>
    <pre>ISO: @language.IsoCode</pre>
    <pre>Culture info: @cultureInfo</pre>
    <hr />
}
```

As shown in the example above, you can get the `System.Globalization.CultureInfo` instance of each language. The CultureInfo determines how numbers, dates and similar should be either parsed or formatted in .NET.

## Full example

Below you can see a full example of the examples shown above - including the necessary imports:

```csharp
@using System.Globalization
@using Umbraco.Cms.Core.Models
@using Umbraco.Cms.Core.Services
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@inject ILocalizationService LocalizationService

@{
    // Get a collection of all languages
    IEnumerable<ILanguage> languages = LocalizationService.GetAllLanguages();

    // Iterate over the collection
    foreach (ILanguage language in languages)
    {

        // Get the .NET culture info
        CultureInfo cultureInfo = language.CultureInfo;

        <pre>ID: @language.Id</pre>
        <pre>Key: @language.Key</pre>
        <pre>Name: @language.CultureName</pre>
        <pre>ISO: @language.IsoCode</pre>
        <pre>Culture info: @cultureInfo</pre>
        <hr />

    }

    // Get a reference to the language by its ID
    ILanguage language1 = LocalizationService.GetLanguageById(1);

    // Get a reference to the language by its ISO code
    ILanguage language2 = LocalizationService.GetLanguageByIsoCode("en-US");

    <pre>@language1</pre>
    <pre>@language2</pre>
}
```

{% hint style="warning" %}
The above example is using `ILocalizationService` which is currently obsolete and will be removed in v15. Use `ILanguageService` or `IDictionaryItemService` (for dictionary item operations) instead.
{% endhint %}
