---
description: >-
  This article overviews how an Umbraco CMS website uses and manages
  localization files.
---

# UI Localization

{% hint style="warning" %}
This article is a work in progress.
{% endhint %}

## Overview

This is the subarticle of [Localization](./) and will cover the use of localization for the UI in the Backoffice. For localizations related to .NET, see the [.NET Localization](.net-localization.md) article.

Localization files are used to translate:

* The Umbraco backoffice user interface so that end users can use Umbraco in their native language. This is particularly important for content editors who do not speak English.
* The member identity errors in an Umbraco website enable end users to use Umbraco in the website language.

If you are a package developer, then check out the [Localization ](./)article to see how to include translations for your own package.&#x20;

## Layout of the localization files

The localization files for the UI are JS modules with a default export containing a key-value structure organized in sections.

```js
export default {
	section: {
		key1: 'value1',
		key2: 'value2',
	},
};
```

The sections and keys will be formatted into a map in Umbraco with the format `section_key1` and `section_key2.` These form the unique key they are requested.

The values can be either a string or a function that returns a string:

```js
export default {
	section: {
		key1: 'value1',
		key2: (count) => {
			count = parseInt(count, 10);
			if (count === 0) return 'Nothing';
			if (count === 1) return 'One thing';
			return 'Many things';
		},
	},
};	
```

## Missing localization keys

As Umbraco is a continually evolving product, it is inevitable that new text is added regularly to the English language version of these files. This may mean that some of the above languages are no longer up to date.

If a key is not found in the current language, the fallback language will be used. The fallback language is **English (United States)**.

If a translation is missing, the default value within `umb-localize` will be shown within the user interface.

```markup
<umb-localize key="general_ok_not_found">Default value</umb-localize>
```

Instead of showing the default value we can show the key alias if we set `debug="true"`

```markup
<umb-localize key="general_ok_not_found" debug="true"></umb-localize>
```

If you modify core language files or introduce a new language, please assist the community by sharing your updates. This can be done by [submitting a pull request](https://docs.umbraco.com/welcome/contribute/getting-started) so that your changes are merged into the core.
