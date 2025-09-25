---
description: >-
  This article explains how to implement CookieBot with Umbraco Engage to comply
  with GDPR.
---

# How to become GDPR compliant using cookiebot

Integrating a cookie consent banner service such as CookieBot allows you to configure parts of Umbraco Engage based on [user consent](../../developers/introduction/the-umbraco-engage-cookie/module-permissions.md).

This article gives you a working implementation to use with [CookieBot](https://www.cookiebot.com/).

<figure><img src="../../.gitbook/assets/image (7) (3).png" alt="Cookiebot in Umbraco."><figcaption><p>Cookiebot in Umbraco.</p></figcaption></figure>

## Code Example

The code example below shows how to create the backend code to read the CookieBot consent cookie from the end user. Based on that, decide which features of Umbraco Engage it should enable or disable.

1. Create a class that implements the `Umbraco.Engage.Infrastructure.Permissions.ModulePermissions.IModulePermissions` interface.
2. Check the current HTTPContext Request Cookies for the CookieBot cookie which is named **CookieConsent.**

From some of the [documentation from CookieBot](https://www.cookiebot.com/en/developer/), implement the same logic to check if the value of the cookie is -1 or another value. If it is set to -1, CookieBot is indicating to us that this is a user within a region that does not require consent.

The rest of the code is deserializing the JSON string stored inside the cookie from CookieBot. It maps to the relevant cookie permission used for turning Umbraco Engage features on or off.

**CookieBotModulePermissions.cs**

```cs
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Text.RegularExpressions;
using System.Web;
using Umbraco.Engage.Infrastructure.Permissions.ModulePermissions;

namespace Umbraco.Engage.StarterKit.CookieBot
{
    public class CookieBotModulePermissions : IModulePermissions
    {
        public bool AbTestingIsAllowed(HttpContext context)
        {
            // Need to check CookieBot consent cookie
            // Did they consent to AB testing
            return IsAllowed(context, "marketing");
        }

        public bool AnalyticsIsAllowed(HttpContext context)
        {
            // Need to check CookieBot consent cookie
            // Did they consent to Analytics
            return IsAllowed(context, "statistics");
        }

        public bool PersonalizationIsAllowed(HttpContext context)
        {
            // Need to check CookieBot consent cookie
            // Did they consent to Personalization
            return IsAllowed(context, "preferences");
        }

        public bool IsAllowed(HttpContext context, string cookiePermission)
        {
            // C# Code from CookieBot to check for their cookie
            // https://www.cookiebot.com/en/developer/#h-server-side-usage
            var rawCookieBotConsentValues = context.Request.Cookies["CookieConsent"];
            
            if (rawCookieBotConsentValues != null)
            {
                switch (rawCookieBotConsentValues)
                {
                    case "-1":
                        // The user is not within a region that requires consent - all cookies are accepted
                        // Then we can mark Umbraco Engage features as allowed
                        return true;

                    default:
                        // The user has given their consent
                        return CheckCookieBotValue(rawCookieBotConsentValues, cookiePermission);
                }
            }

            //The user has not accepted cookies - set strictly necessary cookies only 
            return false;
        }

        public bool CheckCookieBotValue(string rawCookieBotConsentValues, string cookiePermissionToCheck)
        {
            // Read current user consent in encoded JSON
            // Sample JSON cookie payload
            /*
             * {
             *      stamp:'Ov4gD1JVnDnBaJv8K2wYQlyWlnNlT/AKO768tibZYdQGNj/EolraLw==',
             *      necessary:true,
             *      preferences:false,
             *      statistics:true,
             *      marketing:false,
             *      method:'explicit',
             *      ver:1,
             *      utc:1698057791350,
             *      region:'gb'
             * }
            */

            // Decode the consent string
            var rawDecodedConsent = HttpUtility.UrlDecode(rawCookieBotConsentValues);

            if(rawDecodedConsent == null)
            {
                return false;
            }
            
            // Because the CookieBot consent cookie is not actually valid JSON, we need to do some preprocessing.
            // Step 1: Quote property names (e.g., stamp → "stamp")
            var consentStep1 = Regex.Replace(rawDecodedConsent, @"(?<={|,)\s*(\w+)\s*:", m => $"\"{m.Groups[1].Value}\":");

            // Step 2: Replace single-quoted string values with double quotes
            var consentStep2 = Regex.Replace(consentStep1, @"'([^']*)'", "\"$1\"");

            // Deserialize the consent to a dynamic object
            var cookieBotConsentValues = JsonSerializer.Deserialize<CookieBotConsent>(consentStep2);
            if (cookieBotConsentValues == null)
            {
                // Something went wrong with the cookieConsent deserialization
                return false;
            }

            switch (cookiePermissionToCheck)
            {
                case "necessary":
                    return cookieBotConsentValues.Necessary;

                case "preferences":
                    return cookieBotConsentValues.Preferences;

                case "statistics":
                    return cookieBotConsentValues.Statistics;

                case "marketing":
                    return cookieBotConsentValues.Marketing;
                default:
                    break;
            }

            return false;
        }
    }

    public class CookieBotConsent
    {
        [JsonPropertyName("necessary")]
        public bool Necessary { get; set; }

        [JsonPropertyName("preferences")]

        public bool Preferences { get; set; }

        [JsonPropertyName("statistics")]
        public bool Statistics { get; set; }

        [JsonPropertyName("marketing")]
        public bool Marketing { get; set; }
    }
}
```

**CookieBotComposer.cs**

{% code overflow="wrap" lineNumbers="true" %}
```cs
using Umbraco.Cms.Core.Composing;
using Umbraco.Engage.Common.Composing;
using Umbraco.Engage.Infrastructure.Permissions.ModulePermissions;

namespace Umbraco.Engage.StarterKit.CookieBot
{
    [ComposeAfter(typeof(UmbracoEngageApplicationComposer))]
    public class CookieBotComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Services.AddUnique<IModulePermissions, CookieBotModulePermissions>();
        }
    }
}
```
{% endcode %}

### CookieBot Cookie Keys

The existing CookieBot cookie Keys are mapped to the following Umbraco Engage features:

| **CookieBot Key** | **Umbraco Engage Features** |
| ----------------- | --------------------------- |
| Preferences       | Personalization             |
| Statistics        | Analytics                   |
| Marketing         | A/B Testing                 |

### Configuring CookieBot

For information on setting up and configuring your Cookie Consent Banner, see the [Cookiebot Documentation](https://www.cookiebot.com/en/developer/). It contains information on changing the wording and the look and feel of the cookie consent banner.

### Installing CookieBot

To install CookieBot, insert the JavaScript tag provided by CookieBot into the `<head>` of your HTML template:

```html
<script id="Cookiebot" src="https://consent.cookiebot.com/uc.js" 
        data-cbid="your-guid" 
        data-blockingmode="auto" 
        type="text/javascript"></script>
```

### Tracking a Visitor's Initial Pageview

Umbraco Engage does not actively track visitors until they have given their consent to the Cookiebot configuration. After the visitor consents, you need to **reload** the page to track the visit. If no reload is performed the visitor's referrer and/or campaign information will not be tracked.

Use JavaScript to reload the page when consent is given by handling the **CookiebotOnAccept** event:

```js
 window.location.reload();
```

Calling the above method will preserve any referrers and query strings supplied in the current request. It results in Umbraco Engage processing the current page visit and visitor correctly.

For more details, see [Cookiebot Documentation](https://www.cookiebot.com/en/developer/#h-event-handling).
