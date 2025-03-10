---
description: >-
  How to use member authorization with the Delivery API to access protected
  content.
---

# Protected content in the Delivery API

Umbraco allows for restricting access to content. Using the "Public access" feature, specific content items can be protected and made accessible only for authorized members. The same is possible in the Delivery API.
By default, protected content is ignored by the Delivery API, and is never exposed through any API endpoints. However, by enabling member authorization in the Delivery API, protected content can be accessed by means of access tokens.

{% hint style="info" %}
If you are not familiar with members in Umbraco, please read the [Members](https://docs.umbraco.com/umbraco-cms/fundamentals/data/members) article.
{% endhint %}

{% hint style="info" %}
This article describes how to access protected content in a client-to-server context, using an interactive authorization flow.
If you are looking to achieve server-to-server access to protected content, please refer to [server-to-server access article](server-to-server-access.md) instead.
{% endhint %}

## Member authorization

Member authentication and authorization in the Delivery API is performed using the OpenId Connect flow _Authorization Code Flow + Proof Key of Code Exchange (PKCE)_. This is a complex authorization flow, and it is beyond the scope of this article to explain it. Many articles can be found online that explain the flow in detail.
Most programming languages have OpenId Connect client libraries to handle the complexity for us. [`AppAuth`](https://appauth.io/) is a great example of such a library. In ASP.NET Core, OpenId Connect support is built into the framework.

### Enabling member authorization

Member authorization is an opt-in feature of the Delivery API. To enable it, configure `MemberAuthorization:AuthorizationCodeFlow` in the `DeliveryApi` section of `appsettings.json`:

- `Enabled` must be `true`.
- One or more `LoginRedirectUrls` must be configured. These specify where the server is allowed to redirect the client after a successful authorization.
- Optionally one or more `LogoutRedirectUrls` must be configured. These specify where the server is allowed to redirect the client after successfully terminating a session.
  - These are only necessary if logout is implemented in the client.

{% hint style="warning" %}
All redirect URLs must be absolute and contain the full path to the expected resource. It is not possible to use wildcards or to allow all paths under a given domain.
{% endhint %}

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "CMS": {
            "DeliveryApi": {
                "Enabled": true,
                "MemberAuthorization": {
                    "AuthorizationCodeFlow": {
                        "Enabled": true,
                        "LoginRedirectUrls": [
                            "https://absolute.redirect.url/path/after/login"
                        ],
                        "LogoutRedirectUrls": [
                            "https://absolute.redirect.url/path/after/logout"
                        ]
                    }
                }
            }
        }
    }
}
```

{% endcode %}

{% hint style="info" %}
When changing the `MemberAuthorization` configuration, Umbraco must be restarted to pick up on the changes.
{% endhint %}

{% hint style="warning" %}
When enabling or disabling member authentication, the `DeliveryApiContentIndex` must be rebuilt to correctly reflect the existing content protection state.
The index can be rebuilt from the [Examine Management dashboard](https://docs.umbraco.com/umbraco-cms/reference/searching/examine/examine-management).
{% endhint %}

## Server endpoints

Many client libraries support automatic discovery of the server OpenId endpoints. This is also supported by the Delivery API, so likely we do not have to worry about the server endpoints.
If automatic discovery is not applicable, the server endpoints must be configured manually. The server endpoints can be found at `https://{server-host}/.well-known/openid-configuration`.

{% hint style="info" %}
Keep in mind that the API versions can change over time, which might affect the configuration.
{% endhint %}

## Client configuration

To connect the client and the server, we need to apply some configuration details to the connection:

- The `client_id` must be `umbraco-member`.
- The `response_type` must be `code`.
- The `redirect_uri` must be one of the configured `LoginRedirectUrls`.
- The `scope` must either be empty, or be `openid` and/or `offline_access`.
- _PKCE_ must be enabled.

For inspiration, the [samples section](./#basic-client-configuration) at the end of this article shows how to configure an ASP.NET Core client.

## Logging in members

_Authorization Code Flow +  Proof Key of Code Exchange (PKCE)_ requires the authentication service (identity provider) to be separate from the client application. This is to ensure that credentials are never exposed directly to the client application.
As an authentication service, we can use both Umbraco's built-in member authentication and external identity providers. By default the Delivery API attempts to use the built-in member authentication.

### How to use the built-in member authentication

First and foremost we need a login page. By ASP.NET Core defaults, this page should be located at `/Account/Login`. However, we can change the default path by adding the following piece of code:

{% code title="ConfigureCustomMemberLoginPathExtensions.cs" %}

```csharp
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
namespace Umbraco.Samples;
public static class ConfigureCustomMemberLoginPathExtensions
{
    public static IUmbracoBuilder SetCustomMemberLoginPath(this IUmbracoBuilder builder)
    {
        builder.Services.ConfigureOptions<ConfigureCustomMemberLoginPath>();
        return builder;
    }
    private class ConfigureCustomMemberLoginPath : IConfigureNamedOptions<CookieAuthenticationOptions>
    {
        public void Configure(string? name, CookieAuthenticationOptions options)
        {
            if (name != IdentityConstants.ApplicationScheme)
            {
                return;
            }
            Configure(options);
        }
        // replace options.LoginPath with the path you want to use for default member logins
        public void Configure(CookieAuthenticationOptions options)
            => options.LoginPath = "/path/to/the-custom-login-page";
    }
}
```

{% endcode %}

To invoke this code, we need to call `SetCustomMemberLoginPath()` in `Program.cs`:

{% code title="Program.cs" %}

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    // add this line
    .SetCustomMemberLoginPath()
    .Build();
```

{% endcode %}

No matter the path to the login page, we still need a page to render the login screen. Create a content item located at the login page path, and use this template to render it:

{% code title="Login.cshtml" %}

```html
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@using Umbraco.Cms.Web.Common.Models
@using Umbraco.Cms.Web.Website.Controllers
@using Microsoft.AspNetCore.Mvc.TagHelpers
@{
    Layout = null;
    var loginModel = new LoginModel
    {
        // important: we must set the redirect URL from the query string
        RedirectUrl = Context.Request.Query["ReturnUrl"]
    };
}
<html lang="en">
<head>
    <title>Login page</title>
</head>
<body>
@using (Html.BeginUmbracoForm<UmbLoginController>("HandleLogin", new { RedirectUrl = loginModel.RedirectUrl }))
{
    <h4>Log in with a local account.</h4>
    <hr />
    <div asp-validation-summary="ModelOnly" class="text-danger"></div>
    <div>
        <label asp-for="@loginModel.Username"></label>
        <input asp-for="@loginModel.Username" required />
        <span asp-validation-for="@loginModel.Username"></span>
    </div>
    <div>
        <label asp-for="@loginModel.Password"></label>
        <input asp-for="@loginModel.Password" required />
        <span asp-validation-for="@loginModel.Password"></span>
    </div>
    <button type="submit" class="btn btn-primary">Log in</button>
}
</body>
</html>
```

{% endcode %}

With all this in place, it's time to test the setup. Use a browser to perform a request to `https://{server-host}/umbraco/delivery/api/v1/security/member/authorize` with these query string parameters:

- `client_id=umbraco-member`
- `redirect_uri=https://absolute.redirect.url/path/after/login` (replace the value with one of the configured login redirect URLs)
- `response_type=code`
- `code_challenge=WZRHGrsBESr8wYFZ9sx0tPURuZgG2lmzyvWpwXPKz8U`
- `code_challenge_method=S256`

If everything works as expected, the request will yield a redirect to the login page. Completing the login form will cause a redirect to the specified redirect URL with a `code` query string parameter. The `code` can subsequently be exchanged for an access token, which can be used to access protected content.

{% hint style="info" %}
Do not worry about the URL construction and subsequent handling of the `code` parameter. This complexity is what the OpenId Connect client libraries handle for us.
{% endhint %}

For more inspiration on using the built-in member authentication, check the [Members Registration and Login](https://docs.umbraco.com/umbraco-cms/tutorials/members-registration-and-login) article. Here you will also learn how to create member sign-up functionality.

### How to use external identity providers

Umbraco allows adding external identity providers for both backoffice users and members. The process is documented in detail in the [External Login Providers](https://docs.umbraco.com/umbraco-cms/reference/security/external-login-providers/) article.

The Delivery API supports the same functionality. In the following we'll be using GitHub to test this.

First, we need to create an OAuth App in GitHub. This is done in the [GitHub Developer Settings](https://github.com/settings/developers). Use `https://{server-host}/umbraco/signin-github` as authorization callback URL in the App.

Once the App is created, generate a new client secret within the App. Make sure to copy both the client ID of your App and the generated secret.

Now we need to connect Umbraco members with the App:

1. Add the NuGet package `AspNet.Security.OAuth.GitHub` to your Umbraco project.
2. Add the code below to configure the connection to the App. Remember to update the OAuth client ID and secret.

{% code title="GitHubAuthenticationExtensions.cs" %}

```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Web.Common.Security;
namespace Umbraco.Samples;
public static class GitHubAuthenticationExtensions
{
    private const string Scheme = "GitHub";
    public static IUmbracoBuilder AddGitHubAuthentication(this IUmbracoBuilder builder)
    {
        builder.Services.ConfigureOptions<GitHubMemberExternalLoginProviderOptions>();
        builder.AddMemberExternalLogins(logins =>
        {
            logins.AddMemberLogin(
                membersAuthenticationBuilder =>
                {
                    membersAuthenticationBuilder.AddGitHub(
                        membersAuthenticationBuilder.SchemeForMembers(Scheme),
                        options =>
                        {
                            // add your client ID and secret here
                            options.ClientId = "{OAuth App client ID}";
                            options.ClientSecret = "{OAuth App client secret}";
                            options.CallbackPath = "/umbraco/signin-github";
                            options.Scope.Add("user:email");
                            options.SaveTokens = true;
                        });
                });
        });
        return builder;
    }
    private class GitHubMemberExternalLoginProviderOptions : IConfigureNamedOptions<MemberExternalLoginProviderOptions>
    {
        public void Configure(string? name, MemberExternalLoginProviderOptions options)
        {
            if (name is not $"{Constants.Security.MemberExternalAuthenticationTypePrefix}{Scheme}")
            {
                return;
            }
            Configure(options);
        }
        public void Configure(MemberExternalLoginProviderOptions options)
            => options.AutoLinkOptions = new MemberExternalSignInAutoLinkOptions(
                autoLinkExternalAccount: true,
                defaultCulture: null,
                defaultIsApproved: true,
                defaultMemberTypeAlias: Constants.Security.DefaultMemberTypeAlias);
    }
}
```

{% endcode %}

Finally, we need to invoke the connection configuration by calling `AddGitHubAuthentication()` in `Program.cs`.

{% code title="Program.cs" %}

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    // add this line
    .AddGitHubAuthentication()
    .Build();
```

{% endcode %}

{% hint style="info" %}
There are multiple ways of registering extensions and dependencies like these in your Umbraco project. Which method to use depends on your implementation and preferred way of working.
Learn more about this in the [Dependency Injection](../using-ioc.md) article.
{% endhint %}

Now we can test the setup. We'll be calling `https://{server-host}/umbraco/delivery/api/v1/security/member/authorize` as described previously, but we need to add one more query string parameter:

- `identity_provider=UmbracoMembers.GitHub`

If the setup is correct, the request will yield a redirect to the GitHub login page. Here we need to authorize the GitHub OAuth App we created earlier, in order to complete the login. Upon completion, a series of redirects will once more take us to the specified redirect URL with a `code` query string parameter.

Different client libraries have different ways of declaring the `identity_provider` in the authorization request. The [samples section](./#using-a-named-identity-provider) shows how to configure this in an ASP.NET Core client.

### Combining built-in member authentication and external identity providers

We can also add the external identity providers to the member authentication login screen. This way the end user can decide whether to log in as a registered member, or use an external identity provider.

The [Login partial view](https://github.com/umbraco/Umbraco-CMS/blob/contrib/src/Umbraco.Core/EmbeddedResources/Snippets/Login.cshtml) features an implementation of this combined login experience.

## Accessing protected content

When the authorization flow completes we'll obtain an access token. This token can be used as a bearer token to access protected content for the logged-in member:

```http
GET /umbraco/delivery/api/v2/content/{query}
Authentication: Bearer {access token}
```

Access tokens expire after one hour. Once expired, a new access token must be obtained to continue accessing protected content.

## Refresh tokens

Refresh tokens provide a means to obtain a new access token without having to go through the authentication flow. A refresh token is issued automatically by the Delivery API when the `offline_access` scope is specified in the authorization request.

{% hint style="info" %}
Refresh tokens are subject to certain limitations and can result in security issues if not applied correctly. All this is beyond the scope of this article to explain in detail. Please familiarize yourself with the inner workings of refresh tokens before applying them in a solution.
{% endhint %}

## Logging out members

The member authorization is tied to the access and refresh tokens obtained in the authorization flow. Discarding these tokens efficiently terminates the access to protected content.

However, the tokens are still valid and can be reapplied until they expire. Depending on your scenario, it might be prudent to revoke the tokens and maybe even terminate the session on the server.

### Revoking tokens

Access and refresh tokens can be revoked by performing a `POST` request containing the token:

```http
POST /umbraco/delivery/api/v1/security/member/revoke
     client_id=umbraco-member
     token={token to revoke}
Content-Type: application/x-www-form-urlencoded
```

### Terminating a session

When terminating a session on the server, the member is logged out of Umbraco. This means any subsequent authorization attempt will require an explicit login.

To terminate the active session for any given member, you must redirect the browser to the signout endpoint. The request must contain one of the white-listed `LogoutRedirectUrls` from the `appsettings.json`:

```http
GET /umbraco/delivery/api/v1/security/member/signout?post_logout_redirect_uri={valid URL from LogoutRedirectUrls}
```

### User info

The "user info" endpoint is part of the [OpenId Connect core spec](https://openid.net/specs/openid-connect-core-1_0.html#UserInfo).

This implementation returns a few of the [standard claims](https://openid.net/specs/openid-connect-basic-1_0.html#StandardClaims), all of which are subject of availability:

- `sub` (required claim)
- `name` (if available)
- `email` (if available)

On top of this, the member groups (if any) are returned in the role claim.

The implementation is build to be extendable, so custom claims can be added to these claims - and the core claims can be removed, too.

```http
GET /umbraco/delivery/api/v1/security/member/userinfo
```

## Testing with Swagger

The Delivery API Swagger document can be configured to support member authentication.

Before we can do that, we need two things in place:

1. We have to implement a login page [as described above](./#logging-in-members).
2. We must add `https://{server-host}/umbraco/swagger/oauth2-redirect.html` to the configured `LoginRedirectUrls`.

With these in place, we can enable member authentication in Swagger for the Delivery API by adding the following to `Program.cs`:

{% code title="Program.cs" %}

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();
builder.Services.ConfigureOptions<Umbraco.Cms.Api.Delivery.Configuration.ConfigureUmbracoMemberAuthenticationDeliveryApiSwaggerGenOptions>();
```

{% endcode %}

The Swagger UI will now feature authorization.

{% hint style="info" %}
Remember to use `umbraco-member` as `client_id` when authorizing. `client_secret` can be omitted, as it is not used by the authorization flow.
{% endhint %}

## Client configuration samples

The following samples show how to configure an ASP.NET Core client to utilize member authorization in the Delivery API.
To put these samples into context, please refer to the article above.

### Basic client configuration

{% code title="Program.cs" %}

```csharp
builder.Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = "cookie";
        options.DefaultSignInScheme = "cookie";
        options.DefaultChallengeScheme = "oidc";
    })
    .AddCookie("cookie")
    .AddOpenIdConnect("oidc", options =>
    {
        // the Umbraco site is the "authority" (also referred to as "issuer")
        options.Authority = "https://{server-host}";
        // set the "client_id" parameter
        options.ClientId = "umbraco-member";
        // set the "response_type" parameter
        options.ResponseType = "code";
        // set the "redirect_uri" parameter (will be converted to an absolute URL by the framework)
        options.CallbackPath = "/signin-oidc";
        // set the "scope" parameter (remove the default scopes and only use the "openid" scope)
        options.Scope.Clear();
        options.Scope.Add("openid");
        // enable PKCE
        options.UsePkce = true;
        // use a form POST as response mode
        options.ResponseMode = "form_post";
    });
```

{% endcode %}

### Using a named identity provider

{% code title="Program.cs" %}

```csharp
builder.Services.AddAuthentication(...)
    .AddOpenIdConnect("oidc", options =>
    {
        // ...
        // set the "identity_provider" parameter
        options.Events.OnRedirectToIdentityProvider = context =>
        {
            context.ProtocolMessage.IdentityProvider = "UmbracoMembers.GitHub";
            return Task.CompletedTask;
        };
    });
```

{% endcode %}

## Limitations

When using external identity providers, Umbraco still allows for performing local two-factor authentication for members. This feature is not available in the Delivery API. Instead, two-factor authentication should be performed at the identity provider.
