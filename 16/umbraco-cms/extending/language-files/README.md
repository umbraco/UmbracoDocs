---
description: >-
  This article overviews how an Umbraco CMS website uses and manages
  localization with language files.
---

# Language Files & Localization

## Language Files & Localization

Language files are used to localise the Umbraco backoffice, so Users can use Umbraco in their native language. This is particularly important for content editors who do not speak English.

With language files, you can also:

* Override existing (core) localizations.
* Define localization for your own package.

### [UI Localization](../../customizing/foundation/localization.md)

Defines how to use the UI Umbraco Localization. This is the primary source of localization for the backoffice.

### [.NET Localization](net-localization.md)

Defines how to use the .NET Core Umbraco Localization. This is only relevant for localization that happens server-side - for example, for sending emails.

{% hint style="info" %}
You can use localization files for Document and Media Types as well. You can find more information about this in the [Document Type Localization](../../fundamentals/data/defining-content/document-type-localization.md) article.
{% endhint %}

## Supported Languages

Current [languages](https://github.com/umbraco/Umbraco-CMS/tree/contrib/src/Umbraco.Core/EmbeddedResources/Lang) with their ISO codes that are included in new Umbraco installations are:

* `bs-BS` - Bosnian (Bosnia and Herzegovina)
* `cs-CZ` - Czech (Czech Republic)
* `cy-GB` - Welsh (United Kingdom)
* `da-DK` - Danish (Denmark)
* `de-DE` - German (Germany)
* `en` - **English (United Kingdom)** (fallback language)
* `en-US` - English (United States)
* `es-ES` - Spanish (Spain)
* `fr-FR` - French (France)
* `he-IL` - Hebrew (Israel)
* `hr-HR` - Croatian (Croatia)
* `it-IT` - Italian (Italy)
* `ja-JP` - Japanese (Japan)
* `ko-KR` - Korean (Korea)
* `nb-NO` - Norwegian Bokmål (Norway)
* `nl-NL` - Dutch (Netherlands)
* `pl-PL` - Polish (Poland)
* `pt-BR` - Portuguese (Brazil)
* `ro-RO` - Romanian (Romania)
* `ru-RU` - Russian (Russia)
* `sv-SE` - Swedish (Sweden)
* `tr-TR` - Turkish (Turkey)
* `ua-UA` - Ukrainian (Ukraine)
* `zh-CN` - Chinese (China)
* `zh-TW` - Chinese (Taiwan)
