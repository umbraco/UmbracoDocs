---
description: Learn about the cookies required for accessing the Umbraco Backoffice and their purposes.
---

# Cookies

The cookies listed in this article are required only for accessing the Backoffice. You can include these in your own cookie policy, if you wish.

## Necessary Cookies

The below cookies are necessary for accessing the Umbraco Backoffice and functioning of the website. They allow you to enjoy the contents and services you request.

| Name                       | Purpose                                                                                                           | Expiration |
|----------------------------|-------------------------------------------------------------------------------------------------------------------|------------|
| UMB_PREVIEW                | Allows a previewed page to act as a published page only on the browser which has initialized previewing.          | Session    |
| UMB-WEBSITE-PREVIEW-ACCEPT | Client-side cookie that determines whether the user has accepted to be in Preview Mode when visiting the website. | Session    |
| umb_installId              | Used to store the Umbraco software installer id.                                                                  | Session    |
| UMB_UPDCHK                 | Enables your system to check for the Umbraco software updates.                                                    | Session    |
| UMB-XSRF-V                 | Used to store the backoffice antiforgery token validation value.                                                  | Session    |
| TwoFactorRememberBrowser   | Default authentication type used for storing that 2FA is not needed on next login                                 | Session    |
| UMB_SESSION                | Preserves the visitor's session state across page requests.                                                       | Session    |

The `UMB_SESSION` cookie is secure if you are using HTTPS pages. However, if you wish to secure the cookie in your code, add the following in the `Program.cs` file after `Build();`

```cs
builder.Services.AddSession(options =>
    {
        options.Cookie.Name = "UMB_SESSION";
        options.Cookie.HttpOnly = true;
        options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
    });
```

For information on the rest of the cookies, see the [Constants-Web.cs](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Core/Constants-Web.cs) file on GitHub.
