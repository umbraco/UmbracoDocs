---
description: >-
  Customize the regular expression based validation patterns available for text
  fields.
---

# Adding a Validation Pattern

When creating a text field in Umbraco Forms, a validation pattern in the form of a regular expression can be applied. Default patterns can be removed or re-ordered, and custom ones created and added.

## Provided patterns

Umbraco Forms ships with three patterns: number, email, and URL. The class names are `Number`, `Email`, and `Url` respectively, and all are found in the `Umbraco.Forms.Core.Providers.ValidationPatterns` namespace.

## Creating a custom validation pattern

To create a custom format function, create a class that implements `IValidationPattern`. You will need to initialize five properties:

* `Alias` - an alias that should be unique across the patterns and is typically camel-cased with no spaces.
* `Name` - the name of the pattern that will be visible in the backoffice.
* `LabelKey` - as an alternative to providing a name, a translation key can be provided. This will be used to look-up the name in the correct language for the backoffice user.
* `Pattern` - the regular expression pattern.
* `ReadOnly` - a flag indicating whether the pattern can be edited in the backoffice.

The following example shows the implementation of a pattern for a United Kingdom postcode (credit for the [pattern](https://stackoverflow.com/a/69806181/489433) to [Mecanik](https://stackoverflow.com/users/6583298/mecanik) at StackOverflow).

```csharp
using Umbraco.Forms.Core.Interfaces;
namespace Umbraco.Forms.TestSite.Business.ValidationPatterns
{
    public class UkPostCode : IValidationPattern
    {
        public string Alias => "ukPostCode";
        public string Name => "UK Post Code";
        public string LabelKey => string.Empty;
        public string Pattern => @"^([a-zA-Z]{1,2}[a-zA-Z\d]{1,2})\s(\d[a-zA-Z]{2})$";
        public bool ReadOnly => true;
    }
}
```

## Registering the validation pattern

As with other provider types, the validation pattern needs to be registered. There are options to add, remove, and re-order patterns.

An example registration using the `IUmbracoBuilder` is shown below:

```csharp
public static IUmbracoBuilder AddCustomProviders(this IUmbracoBuilder builder)
{
    builder.FormsValidationPatterns()
        .Append<UkPostCode>();
    return builder;
}
```

## Using the pattern

With the pattern registered it will be available for selection by editors in the backoffice when they create validation for fields supporting this feature.

![Validation pattern](../../.gitbook/assets/validation-pattern.png)
