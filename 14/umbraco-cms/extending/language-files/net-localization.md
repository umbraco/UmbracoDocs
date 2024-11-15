---
description: NET Umbraco Core Localization files.
---

# .NET Localization

## .NET Localization

In this article, you will find information about the Core Localization files. You can also find information about where to find and use them, and how to keep them up-to-date.

### Use cases

.NET localization has limited use cases in Umbraco, as all backoffice localization is performed with [UI Localization](../../customizing/foundation/localization.md).

In other words, .NET localization is only applied server-side with no accompanying UI - for example:

* Sending emails.
* User login error handling.
* Health checks.

### Where to find the core localization files

The core Umbraco localization files are found at the following location within the [Umbraco source](https://github.com/umbraco/Umbraco-CMS/tree/contrib/src/Umbraco.Core/EmbeddedResources/Lang):

```xml
Umbraco-CMS/src/Umbraco.Core/EmbeddedResources/Lang/
```

These localization files are shipped with Umbraco and should not be modified.

#### User localization files

If you want to override Umbraco Core .NET localization, create new files in the following location and format:

```xml
/config/lang/{language}.user.xml
```

{% hint style="info" %}
The `/config/lang/` folders do not exist on a clean installation of the CMS. You will need to create them at the root of your project. In an Umbraco Cloud project this will need to be in the `src` project.
{% endhint %}

In order for these files to deploy when you do a `dotnet publish`, you need to add the following to your `.csproj` file:

```xml
<ItemGroup>
    <Content Include="config/**" CopyToOutputDirectory="Always" />
</ItemGroup>
```

### Using the localizations

`ILocalizedTextService` is used to localize strings, and is available through dependency injection. You can use the `Localize()` method available in the namespace `Umbraco.Extensions` to localize the string by `area` and `key`:

```csharp
using Umbraco.Cms.Core.Services;

namespace UmbracoDocs.Samples;

public class LocalizationSample
{
    private readonly ILocalizedTextService _localizedTextService;

    public LocalizationSample(ILocalizedTextService localizedTextService)
        => _localizedTextService = localizedTextService;

    public string LocalizeMyText(string area, string key)
        => _localizedTextService.Localize(area, key);
}
```

### Help keep the language files up to date

As Umbraco is a continually evolving product it is inevitable that new text is added regularly to the English language version of these files. This may mean that some of the above languages are no longer up to date.

If a translation is missing, the key "**alias**" used will be shown within the user interface, as an example:

```xml
[assignDomain]
```

The language files are XML files with a straight-forward layout as seen below.

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language alias="en" intName="English (UK)" localName="English (UK)" lcid="" culture="en-GB">
    <creator>
        <name>The Umbraco community</name>
        <link>https://community.umbraco.com</link>
    </creator>
    <area alias="actions">
        <key alias="assignDomain">Culture and Hostnames</key>
        <key alias="auditTrail">Audit Trail</key>
        ...
    </area>
    ...
</language>
```

In the above example of a missing translation for "**assignDomain**", locate this string in the en.xml file. Then copy the whole "**Key**" element into the relevant language file. Afterwards you can translate the text, as an example here is the Spanish version of the above snippet:

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language alias="es" intName="Spanish" localName="español" lcid="10" culture="es-ES">
    <creator>
        <name>The Umbraco community</name>
        <link>https://community.umbraco.com</link>
    </creator>
    <area alias="actions">
        <key alias="assignDomain">Administrar hostnames</key>
        <key alias="auditTrail">Auditoría</key>
        ...
    </area>
    ...
</language>
```

If you modify core language files or introduce a new language, you can assist the community by sharing your updates. This can be done by [submitting a pull request](https://github.com/umbraco/Umbraco-CMS/blob/contrib/.github/CONTRIBUTING.md) so that your changes are merged into the core.
