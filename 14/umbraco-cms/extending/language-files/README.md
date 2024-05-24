---
description: >-
  This article overviews how an Umbraco CMS website uses and manages
  localization files.
---

# Language Files & Localization

Localization files are used to translate:

* The Umbraco backoffice user interface so that end users can use Umbraco in their native language. This is particularly important for content editors who do not speak English.
* The member identity errors in an Umbraco website enable end users to use Umbraco in the website language.

You can also:

* Override existing language files.
* Include translations for your own package. Read [Add translations for your packages](../../extending/packages/language-files-for-packages.md) to see how to you can achieve this.

## [.NET Localization](net-localization.md)

Defines how to use the .NET Core Umbraco Localization files.

## [UI Localization](ui-localization.md)

Defines how to use the UI Umbraco Localization files.

{% hint style="info" %}
You can use localization files for Document and Media Types as well. You can find more information about this in the [Document Type Localization](../../fundamentals/data/defining-content/document-type-localization.md) article.
{% endhint %}

# Supported Languages

Current [languages](https://github.com/umbraco/Umbraco-CMS/tree/contrib/src/Umbraco.Core/EmbeddedResources/Lang) with their ISO codes that are included in new Umbraco installations are:

* `bs-BS` - Bosnian (Bosnia and Herzegovina)
* `cs-CZ` - Czech (Czech Republic)
* `cy-GB` - Welsh (United Kingdom)
* `da-DK` - Danish (Denmark)
* `de-DE` - German (Germany)
* `en-GB` - English (United Kingdom)
* `en-US` - **English (United States)** (fallback language)
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
