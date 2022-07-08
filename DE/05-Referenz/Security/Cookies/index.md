---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Cookies

The cookies listed in this article are required only for accessing the Backoffice. You can include these in your own cookie policy, if you wish.

## Necessary Cookies

The below cookies are necessary while accessing the Umbraco Backoffice for functioning of the website or to allow you to enjoy the contents and services you request.

| Name                       | Purpose                                                                                                           | Expiration |
|----------------------------|-------------------------------------------------------------------------------------------------------------------|------------|
| UMB_PREVIEW                | Allows a previewed page to act as a published page only on the browser which has initialized previewing.          | Session    |
| UMB-WEBSITE-PREVIEW-ACCEPT | Client-side cookie that determines whether the user has accepted to be in Preview Mode when visiting the website. | Session    |
| umb_installId              | Used to store the Umbraco software installer id.                                                                  | Session    |
| UMB_UPDCHK                 | Enables your system to check for the Umbraco software updates.                                                    | Session    |
| UMB-XSRF-V                 | Used to store the backoffice antiforgery token validation value.                                                  | Session    |
| UMB-XSRF-TOKEN             | Set for angular to pass in to the header value for "X-UMB-XSRF-TOKEN"                                             | Session    |
| TwoFactorRememberBrowser   | Default authentication type used for storing that 2FA is not needed on next login                                 | Session    |

For information on the rest of the cookies, see the [Constants-Web.cs file on Github](https://github.com/umbraco/Umbraco-CMS/blob/5bfab13dc5a268714aad2426a2b68ab5561a6407/src/Umbraco.Core/Constants-Web.cs).
