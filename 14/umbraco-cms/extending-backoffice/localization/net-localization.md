---
description: NET Umbraco Core Localization files.
---

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

# .NET Localization

In this article, you will find information about the Core Localization files. You can also find information about where to find and use them, and how to keep them up-to-date.

## Where to find the core localization files

The core Umbraco localization files are found at the following location within the [Umbraco source](https://github.com/umbraco/Umbraco-CMS/tree/contrib/src/Umbraco.Core/EmbeddedResources/Lang):

```xml
Umbraco-CMS/src/Umbraco.Core/EmbeddedResources/Lang/
```

These localization files are shipped with Umbraco and should not be modified.

### User localization files

If you want to override Umbraco Core translations or translations shipped with packages,  these files are located here:

```xml
/config/lang/{language}.user.xml
```

{% hint style="info" %}
The `/config/lang/` folders do not exist on a clean installation of the CMS. You will need to create them at the root of your project.&#x20;
{% endhint %}

By default, these files are empty but you can add any new keys you want or override existing ones with your own translations. The nice part about the user files is that they will not get overwritten by the installer when you upgrade your Umbraco versions.

In order for these files to deploy when you do a `dotnet publish`, you need to add the following to your `.csproj` file:

```xml
<ItemGroup>
    <Content Include="config/**" CopyToOutputDirectory="Always" />
</ItemGroup>
```

## Using the localizations

`ILocalizedTextService` is used to localize strings, and is available through dependency injection. First, inject the service, and then use the `Localize()` method available in the namespace `Umbraco.Extensions` to localize the string with the format `[area]/[key]`:

```csharp
public MyClass(ILocalizedTextService textservice)
{
    var localizedLabel = textservice.Localize("dialog/mykey");
}
```

### Package localization files

If you are a package developer, see the article for[UI Localization](ui-localization.md).

## Help keep the language files up to date

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
