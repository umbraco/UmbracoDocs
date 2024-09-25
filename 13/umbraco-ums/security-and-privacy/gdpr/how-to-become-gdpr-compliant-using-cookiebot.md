# How To Become GDPR Compliant Using Cookiebot

You can integrate with a cookie consent banner service such as CookieBot and [depending on the users choice you can configure certain parts of uMS](../../../../the-umarketingsuite-broad-overview/the-umarketingsuite-cookie/module-permissions/).

This has been covered in our documentation previously, but this tutorial gives you a full working implementation to use with [CookieBot](https://www.cookiebot.com/) in particular.

![]()

## Code Example

The code example below shows how to create the back-end code to read the CookieBot consent cookie from the end-user, and based on that decides which features of uMarketingSuite it should enable or disable.

First we need to create a class that implements the interface **uMarketingSuite.Business.Permissions.ModulePermissions.IModulePermissions**

We can use this class to check the current HTTPContext Request Cookies for the CookieBot cookie which is named **CookieConsent**

From some of the [documentation from CookieBot](https://www.cookiebot.com/en/developer/) we can implement the same logic to check if the value of the cookie is -1 or another value. If it is set to -1, CookieBot is indicating to us that this is a user within a region that does not require consent.

The rest of the code is deserializing the JSON string stored inside the cookie from CookieBot and mapping it the relevant cookie permission we want to use for turning on or off the uMarketingSuite features.

**CookieBotModulePermissions.cs**

```
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System.Web;
using uMarketingSuite.Business.Permissions.ModulePermissions;

namespace uMarketingSuite.StarterKit.CookieBot
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
                        // Then we can mark the uMarketingSuite features as allowed
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
            var decodedConsent = HttpUtility.UrlDecode(rawCookieBotConsentValues);

            if(decodedConsent == null)
            {
                return false;
            }

            // Deserizalize the consent to a dynamic object
            var cookieBotConsentValues = JsonConvert.DeserializeObject(decodedConsent);
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
        [JsonProperty("necessary")]
        public bool Necessary { get; set; }

        [JsonProperty("preferences")]
        public bool Preferences { get; set; }

        [JsonProperty("statistics")]
        public bool Statistics { get; set; }

        [JsonProperty("marketing")]
        public bool Marketing { get; set; }
    }
}
```

**CookieBotComposer.cs**

```
using uMarketingSuite.Business.Permissions.ModulePermissions;
using uMarketingSuite.Common.Composing;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace uMarketingSuite.StarterKit.CookieBot
{
    [ComposeAfter(typeof(AttributeBasedComposer))]
    public class CookieBotComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Services.AddUnique<IModulePermissions, CookieBotModulePermissions>();
        }
    }
}
```

#### CookieBot Cookie

We use the existing CookieBot cookie Keys map these to the following uMarketingSuite features

| **CookieBot Key** | **uMarketingSuite Feature** |
| ----------------- | --------------------------- |
| Preferences       | Personalization             |
| Statistics        | Analytics                   |
| Marketing         | A/B Testing                 |

#### Configuring CookieBot

Please refer to CookieBot documentation on how to setup and configure your Cookie Consent Banner. This allows you to change the wording and the look and feel of the cookie consent banner to suit your needs along with its placement etc.

#### Installing CookieBot

From the CookieBot website after generating your cookie consent banner, it gives you a JavaScript tag that you need to insert into the **\<head>** of your HTML template such as.

```
<script id="Cookiebot" src="https://consent.cookiebot.com/uc.js" 
        data-cbid="your-guid" 
        data-blockingmode="auto" 
        type="text/javascript"></script>
```

#### Tracking a visitors Initial Pageview

Because uMarketingSuite does not actively track visitors until they have given their consent in the Cookiebot configuration as setup in this tutorial, it is required to **reload the current page as soon as the visitor has given consent** in order to track the current page visit the visitor has given consent on. If no reload is performed the visitors referrer and/or campaign information will not be tracked!

You can do this by hooking into & handling the CookiebotOnAccept Event as described in the [Cookiebot documentation](https://www.cookiebot.com/en/developer/#h-event-handling), and forcing a page reload using Javascript after the visitor has given consent. Calling the "window.location.reload();" method would be the preferred option, as this will preserve any referrers & query strings supplied in the current request, resulting in uMarketingSuite processing the current page visit & visitor correctly
