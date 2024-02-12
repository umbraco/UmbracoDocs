---
meta.Title: "Add a Magic String Format Function"
---

# Adding a Magic String Format Function

_This builds on the "_[_adding a type to the provider model_](adding-a-type.md)_" chapter_

Umbraco Forms [Magic Strings](../magic-strings.md) can be used to replace placeholders within form elements with values from different sources. Sources include the HTTP request or the Umbraco page where the form is hosted.

These values can be formatted using [filter functions](../magic-strings.md#formatting-magic-strings).

Filter functions for common operations such as truncating a string or formatting a date or number are provided.  It's also possible to create custom ones in code.

## Creating a custom format function

To create a custom format function, create a class that implements `IParsedPlaceholderFormatter`.

The `FunctionName` property provides the name of the function that will be used within the form's magic string.

The `FormatValue` property parses the provided value and arguments and returns the formatted value as a string.

The following example shows the implementation of a function that bounds an integer value.  It takes two arguments, a minimum and maximum value.  If the value read from the magic string source is numeric, and fits within the two bounds, it is returned.  Otherwise, either the minimum or maximum value is returned depending on whether the value is lower or higher than the bounds respectively.

```csharp
using System.Globalization;
using Umbraco.Forms.Core.Interfaces;

namespace Umbraco.Forms.Core.Providers.ParsedPlacholderFormatters
{
    public class BoundNumber : IParsedPlaceholderFormatter
    {
        public string FunctionName => "bound";

        public string FormatValue(string value, string[] args)
        {
            if (args.Length != 2)
            {
                return value;
            }

            if (!int.TryParse(args[0], out var min) || !int.TryParse(args[1], out var max))
            {
                return value;
            }

            if (int.TryParse(value, out int valueAsInteger) ||
                int.TryParse(value, NumberStyles.None, CultureInfo.InvariantCulture, out valueAsInteger))
            {
                if (valueAsInteger < min)
                {
                    return min.ToString();
                }

                if (valueAsInteger > max)
                {
                    return max.ToString();
                }

                return valueAsInteger.ToString();
            }

            return value;
        }
    }
}
```

## Registering the custom format function

As with other provider types, the custom function needs to be registered. An example registration using the `IUmbracoBuilder` is shown below:

```csharp
public static IUmbracoBuilder AddCustomProviders(this IUmbracoBuilder builder)
{
    builder.FormsParsedPlaceholderFormatters()
        .Add<BoundNumber>();
    return builder;
}
```

## Using the custom format function

The format function can be used within a form's magic string in the same way as the ones provided with Umbraco Forms.

For the example provided, it would be used like this:

```none
[#field | bound: 1: 10]
```
