#IShortStringHelper

Every [URL segment](outbound-pipeline.md#segments) is converted into a URL readable string.  

In Umbraco version 4 and version 6 the [LegacyShortStringHelper](https://github.com/umbraco/Umbraco-CMS/blob/7.0.0/src/Umbraco.Core/Strings/LegacyShortStringHelper.cs) is  backward compatible with the behaviour of v4.x.

    // That one is initialized by default in v4 & v6
    public class LegacyShortStringHelper : IShortStringHelper
    { … }

    // But feel free to use your own
    public class ShortStringHelperResolver
    { … }


To implement your own short string helper, implement the following interface
  
    public interface IShortStringHelper
    {
    …
    }


If you can, you should switch to the `DefaultShortStringHelper`:

    // That one is the future default helper
    public class DefaultShortStringHelper : IShortStringHelper
    { … }

The DefaultShortStringHelper has:
 
- Improved performance
- Improved utf-8 support (e.g. native "déjà" to "deja" substitution)
- Many configuration options
- 80% backward-compatible with pre-6

No reason not to try it!