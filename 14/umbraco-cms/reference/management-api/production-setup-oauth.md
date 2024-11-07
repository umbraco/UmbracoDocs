---
description: Set up OAuth authorization for Umbraco Management API in local and production environments.
---

# Overview

{% hint style="info" %}

This guide is created by a community member and is not managed by Umbraco HQ. Some attributes or features may evolve as the Management API continues to develop.

{% endhint %}

This guide covers how to set up OAuth authorization for the Umbraco Management API for both local development and production environments. Authorization configuration can differ greatly between environments, and understanding these differences is key.

Before proceeding, it is recommended to read the [Management API overview](./README.md). It provides fundamental information about the authorization process and its significance.

This guide will walk through:

1. [Environment Differences and Challenges](#environment-differences-and-challenges)
2. [Configuring appsettings.json](#configuring-appsettingsjson)
3. [Setting up Production-Local Authorization](#setting-up-production-local-authorization)
4. [Creating a Custom Client ID](#creating-a-custom-client-id)
5. [Minimal API Implementation](#minimal-api-implementation)
6. [Configuring Authorization in Production](#configuring-authorization-in-production)
7. [Common Pitfalls and Troubleshooting](#common-pitfalls-and-troubleshooting)

## Environment Differences and Challenges

The Umbraco Management API authorization works seamlessly in non-production environments using tools like Swagger or Postman. However, in production, some key differences and limitations exist:

- **Swagger and Postman Integration**: Only allowed in non-production, facilitating testing.
- **Client Restrictions**: In production, only the `umbraco-back-office` client is allowed.
- **OAuth2 Flows:** Requires careful handling to ensure secure setup without Swagger available.

To avoid conflicts and guarantee smooth integration in production, it's crucial to create a custom client and tailor the authorization flow accordingly.

## Configuring appsettings.json

To override the default callback URL for OAuth authorization, update the `appsettings.json` file as follows: (this uses client: `umbraco-back-office`)


```json
"Umbraco": {
  "CMS": {
    "Security": {
      "AuthorizeCallbackPathName": "/callback"
    }
  }
}
```

This configuration specifies a custom callback path for OAuth. However, it may interfere with the default backoffice callback, affecting accessibility.

## Setting up Production-Local Authorization

In a production environment, Swagger UI is disabled, and only the `umbraco-back-office` client can be used. This requires a more advanced approach.

## Creating a Custom Client ID

To avoid conflicts with the backoffice, a new client should be created. Below are the steps to set up a custom client using a Minimal API:

### Extending `OpenIdDictApplicationManagerBase`

Create a new client for production use by extending the `OpenIdDictApplicationManagerBase`.

```csharp
public class CustomApplicationManager : OpenIdDictApplicationManagerBase
{
    public CustomApplicationManager(IOpenIddictApplicationManager applicationManager)
        : base(applicationManager)
    {
    }

    public async Task EnsureCustomApplicationAsync(string clientId, Uri redirectUri, CancellationToken cancellationToken = default)
    {
        if (!redirectUri.IsAbsoluteUri)
        {
            throw new ArgumentException("The provided URL must be an absolute URL.", nameof(redirectUri));
        }

        var clientDescriptor = new OpenIddictApplicationDescriptor
        {
            DisplayName = "Custom Application",
            ClientId = clientId,
            RedirectUris = { redirectUri },
            ClientType = OpenIddictConstants.ClientTypes.Public,
            Permissions = {
                OpenIddictConstants.Permissions.Endpoints.Authorization,
                OpenIddictConstants.Permissions.Endpoints.Token,
                OpenIddictConstants.Permissions.GrantTypes.AuthorizationCode,
                OpenIddictConstants.Permissions.ResponseTypes.Code
            }
        };

        await CreateOrUpdate(clientDescriptor, cancellationToken);
    }
}
```

The above code allows you to define a new custom client. This client will not interfere with the existing `umbraco-back-office` client, ensuring smooth integration and avoiding callback conflicts.

## Minimal API Implementation

To set up a Minimal API that integrates the custom client, follow these steps:

### Creating the Minimal API Application

Below is a complete setup for using Minimal API to create and manage custom OAuth clients for the Umbraco Management API.

```csharp
builder.Services.AddScoped<CustomApplicationManager>(provider =>
{
    var applicationManager = provider.GetRequiredService<IOpenIddictApplicationManager>();
    return new CustomApplicationManager(applicationManager);
});

app.MapPost("/create-client", async (ClientModel model, CustomApplicationManager applicationManager) =>
{
    try
    {
        if (string.IsNullOrEmpty(model.ClientId))
            return Results.BadRequest("Client ID is required.");

        if (!Uri.TryCreate(model.RedirectUri, UriKind.Absolute, out var redirectUri))
            return Results.BadRequest("Invalid redirect URI.");

        await applicationManager.EnsureCustomApplicationAsync(model.ClientId, redirectUri);
        return Results.Ok("Client created/updated successfully.");
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message);
    }
}).WithName("CreateClient");

app.MapGet("/login", (Auth auth, IConfiguration config, IBackOfficeApplicationManager backOfficeApplicationManager) =>
{
    var baseUrl = config["Umbraco:BaseUrl"];
    var authorizationUrl = auth.GetAuthorizationUrl();
    return Results.Redirect(baseUrl + authorizationUrl);
});

app.MapGet("/callback", async (Auth auth, HttpContext httpContext, IConfiguration configuration) =>
{
    var code = httpContext.Request.Query["code"];
    var state = httpContext.Request.Query["state"];
    if (string.IsNullOrEmpty(code) || string.IsNullOrEmpty(state))
    {
        return Results.BadRequest("Invalid callback parameters");
    }
    try
    {
        var tokenResponse = await auth.HandleCallback(code, state);
        //
        return Results.Redirect("/dashboard");
    }
    catch (Exception ex)
    {
        return Results.BadRequest($"Authentication failed: {ex.Message}");
    }
});

public class ClientModel
{
    public string ClientId { get; set; }
    public string RedirectUri { get; set; }
}
```

This implementation demonstrates how to use Minimal API to manage OAuth clients dynamically, allowing better integration into production workflows.

## Configuring Authorization in Production

To configure authorization using the custom client:

1. Update your `appsettings.json` file:

```json
{
  "BaseUrl": "https://your-production-domain",
  "ClientId": "newclientId", // Set to the new custom client ID you created
  "AuthorizationEndpoint": "/umbraco/management/api/v1/security/back-office/authorize",
  "TokenEndpoint": "/umbraco/management/api/v1/security/back-office/token",
  "RedirectUri": "https://your-production-domain/callback" // Callback URL for your newly created client ID
}
```

2. Use the custom client manager endpoint (`/create-client`) to create a new client for use in production.

3. Handle token retrieval and secure storage in your application. Store tokens securely to avoid exposure, for instance by using HTTP-only cookies.

## Common Pitfalls and Troubleshooting

### Callback Interference with Back Office

If the `umbraco-back-office` client causes callback conflicts, use a custom client with a distinct redirect URI to prevent overlap with backoffice authentication.
