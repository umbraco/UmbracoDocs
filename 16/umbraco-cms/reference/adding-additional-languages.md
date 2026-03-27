---
description: >-
  Learn how to make additional language cultures available in Umbraco when they
  do not appear in the backoffice language dropdown.
---

# Adding Additional Languages

When adding a new language in the Umbraco backoffice, you may find that a language culture you need is not listed in the dropdown. This article explains why some cultures are missing and how to make them available.

## Why some languages are missing

From version 9 onward, Umbraco runs on .NET (Core) and uses [app-local ICU (International Components for Unicode)](https://learn.microsoft.com/en-us/dotnet/core/extensions/globalization-icu#app-local-icu) for globalization data. This is a deliberate choice to ensure consistent behavior across platforms (Windows, Linux, and macOS).

The app-local ICU data contains fewer culture codes than the Windows NLS (National Language Support) data that .NET Framework used. If you are migrating from Umbraco 8 or earlier, you may notice that some cultures you previously used are no longer listed.

In addition, Umbraco's default `IIsoCodeValidator` filters out cultures flagged as `UserCustomCulture`. This ensures the available languages are consistent across all platforms and hosting environments. Under app-local ICU, some valid BCP (Best Current Practice) 47 locale codes (such as `zh-HK`) are classified as custom cultures even though they are standard cultures.

These two factors combined mean certain languages will not appear in the backoffice language dropdown by default.

## How to add missing languages

You can make additional cultures available by replacing Umbraco's default `IIsoCodeValidator` and `ICultureService` implementations using a [composer](../implementation/composing.md).

The custom `IIsoCodeValidator` allows the additional ISO codes to pass validation. The custom `ICultureService` ensures those cultures appear in the backoffice dropdown list.

{% hint style="info" %}
The `IIsoCodeValidator` is used when saving or updating language ISO codes and backoffice user cultures. Changes to the validator affect all culture validation in Umbraco, not only the language selection dropdown.
{% endhint %}

Add the following code to your project, updating the `_additionalIsoCodes` array with the culture codes you need:

```csharp title="AllowAdditionalCulturesComposer.cs"
using System.Globalization;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Services;

namespace MySite.Composers;

/// <summary>
/// Replaces the default <see cref="IIsoCodeValidator"/> and <see cref="ICultureService"/>
/// to allow specific cultures that are valid BCP 47 locales but get incorrectly flagged as
/// <see cref="CultureTypes.UserCustomCulture"/> on .NET with app-local ICU, or are not
/// enumerated by <see cref="CultureInfo.GetCultures"/> despite being resolvable.
/// </summary>
public class AllowAdditionalCulturesComposer : IComposer
{
    private static readonly string[] _additionalIsoCodes = ["zh-HK"];

    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IIsoCodeValidator>(
            new AllowAdditionalCulturesIsoCodeValidator(_additionalIsoCodes));
        builder.Services.AddUnique<ICultureService>(provider =>
            new AllowAdditionalCulturesCultureService(
                provider.GetRequiredService<IIsoCodeValidator>(),
                _additionalIsoCodes));
    }
}

internal class AllowAdditionalCulturesIsoCodeValidator : IIsoCodeValidator
{
    private readonly IsoCodeValidator _inner = new();
    private readonly HashSet<string> _additionalIsoCodes;

    public AllowAdditionalCulturesIsoCodeValidator(params string[] additionalIsoCodes)
        => _additionalIsoCodes = new HashSet<string>(additionalIsoCodes, StringComparer.OrdinalIgnoreCase);

    public bool IsValid(CultureInfo culture)
        => _inner.IsValid(culture) || _additionalIsoCodes.Contains(culture.Name);
}

internal class AllowAdditionalCulturesCultureService : ICultureService
{
    private readonly CultureService _inner;
    private readonly string[] _additionalIsoCodes;

    public AllowAdditionalCulturesCultureService(
        IIsoCodeValidator isoCodeValidator,
        string[] additionalIsoCodes)
    {
        _inner = new CultureService(isoCodeValidator);
        _additionalIsoCodes = additionalIsoCodes;
    }

    public CultureInfo[] GetValidCultureInfos()
    {
        CultureInfo[] baseCultures = _inner.GetValidCultureInfos();

        // Resolve and append any additional cultures not already in the list.
        var existing = new HashSet<string>(baseCultures.Select(c => c.Name), StringComparer.OrdinalIgnoreCase);

        IEnumerable<CultureInfo> extra = _additionalIsoCodes
            .Where(code => !existing.Contains(code))
            .Select(code =>
            {
                try { return CultureInfo.GetCultureInfo(code); }
                catch (CultureNotFoundException) { return null; }
            })
            .Where(c => c is not null)
            .Cast<CultureInfo>();

        return baseCultures
            .Concat(extra)
            .OrderBy(c => c.EnglishName)
            .ToArray();
    }
}
```

Replace `"zh-HK"` in the `_additionalIsoCodes` array with the culture codes you need. You can add multiple codes, for example: `["zh-HK", "zh-MO"]`.

When the application starts, the composer will automatically register the custom implementations. The additional cultures will then appear in the backoffice language dropdown.
