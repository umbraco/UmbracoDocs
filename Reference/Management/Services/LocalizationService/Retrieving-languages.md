# Retrieving languages

### Getting a single language

The localization service contains a number of methods for looking up languages. If you already know the ID of a specific language (eg. the default language has ID `1`), you can use the `GetLanguageById` method to get the reference to that language:

    // Get a reference to the language by it's ID
    ILanguage language1 = ls.GetLanguageById(1);

Alternative, you can look up a language by it's culture code via the `GetLanguageByCultureCode` method:

    // Get a reference to the language by it's culture code
    ILanguage language2 = ls.GetLanguageByCultureCode("English (United Kingdom)");

or via the `GetLanguageByIsoCode` method:

    // Get a reference to the language by it's ISO code
    ILanguage language3 = ls.GetLanguageByIsoCode("en-US");
    
The culture code is the friendly name of the language in Umbraco, which for the default language is `en-US` (same as the ISO code), but for other languages is something like `English (United Kingdom)` or `Danish (Denmark)`. 

The ISO code is a combination of the two-letter ISO 639-1 language code (lowercase) and two-letter ISO-3166 country code (uppercase). Eg. `en-US` for English in the United States, `en-GB` for English in the United Kingdom and `da-DK` for Danish in Denmark.

All three methods will return an instance of the [ILanguage](https://our.umbraco.org/apidocs/csharp/api/Umbraco.Core.Models.ILanguage.html) interface, which has traditional properties like `Id` and `Key`, but also properties specific to the language like `CultureName`, `CultureInfo` and `IsoCode`. You can see the API reference for further information on the properties of the interface.

### Getting all languages

If you need instead need a list of all installed languages, you can use the `GetAllLanguages` method. It takes no parameters, and as such a returns a collection of all languages (with no pagination like some of the other services):

    // Get a collection of all languages
    IEnumerable<ILanguage> languages = ls.GetAllLanguages();
    
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
    
As shown in the example above, you can get the `System.Globalization.CultureInfo` instance of each language, which determines how numbers, dates and similar should be either parsed or formatted in .NET.

## Full example

Below you can see a full example of the examples shown above - including the necessary imports:

    @using System.Globalization
    @using Umbraco.Core.Services
    @inherits UmbracoViewPage

    @{

        // Get a reference to the localization service
        ILocalizationService ls = ApplicationContext.Services.LocalizationService;

        // Get a collection of all languages
        IEnumerable<ILanguage> languages = ls.GetAllLanguages();

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


        // Get a reference to the language by it's ID
        ILanguage language1 = ls.GetLanguageById(1);

        // Get a reference to the language by it's culture code
        ILanguage language2 = ls.GetLanguageByCultureCode("English (United Kingdom)");

        // Get a reference to the language by it's ISO code
        ILanguage language3 = ls.GetLanguageByIsoCode("en-US");

        <pre>@language1</pre>
        <pre>@language2</pre>
        <pre>@language3</pre>

    }
