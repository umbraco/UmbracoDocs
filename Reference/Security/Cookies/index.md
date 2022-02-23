---
versionFrom: 9.0.0
---

# Cookies

We use cookies to understand the usage of the website, improve the website performance, and to increase the relevance of our communication and advertising.

## Necessary Cookies

These cookies are necessary while accessing Umbraco backoffice for the functioning of the website or to allow you to enjoy the contents and services you request.

| Name                       | Purpose                                                                                                           | Expiration |
|----------------------------|-------------------------------------------------------------------------------------------------------------------|------------|
| UMB_PREVIEW                | Allows a previewed page to act as a published page only on the browser which has initialized previewing.          | Session    |
| UMB-WEBSITE-PREVIEW-ACCEPT | Client-side cookie that determines whether the user has accepted to be in Preview Mode when visiting the website. | Session    |
| UMB_INSTALLID              | Used to store the Umbraco software installer id.                                                                  | Session    |
| UMB_UPDCHK                 | Enables your system to check for the Umbraco software updates.                                                    | Session    |
| UMB-XSRF-V                 | Used to store the backoffice antiforgery token validation value.                                                  | Session    |
| UMB-XSRF-TOKEN             | Set for angular to pass in to the header value for "X-UMB-XSRF-TOKEN"                                             | Session    |
| X-UMB-XSRF-TOKEN           | The header name that angular uses to pass in the token to validate the cookie                                     | Session    |
| umbraco-no-content         | Displays the route name of the page when the website has no published content.                                    | Session    |
| TwoFactorRememberBrowser   | Default authentication type used for storing that 2FA is not needed on next login                                 | Session    |

For information on the rest of the cookies, see the [Constants-Web.cs file on Github](https://github.com/umbraco/Umbraco-CMS/blob/5bfab13dc5a268714aad2426a2b68ab5561a6407/src/Umbraco.Core/Constants-Web.cs).