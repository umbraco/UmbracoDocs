---
description: >-
  Details a package supporting creation of integrations with external services that use an OAuth flow for authentication and authorization.
---

# Authorized Services

## Introduction

**Umbraco Authorized Services** is an Umbraco package designed to reduce the effort needed to integrate third party solutions into Umbraco solutions.  Many such services require an OAuth flow fir authentication and authorization.  Working with these services requires a fair bit of plumbing code to handle creating an authorized connection.  This is necessary before the developer working with the service can get to using the provided API to implement the business requirements.

There are similarities to the flow that needs to be implemented for different services.  Steps include:

- Redirecting to an authentication endpoint.
- Handling the response including an authentication code and exchanging it for an access token.
- Securely storing the token.
- Including the token in API requests.
- Serializing requests and deserializing the API responses.
- Handling cases where the token has expired and obtaining a new one via a refresh token.

There are though also differences, across request and response structures and variations in the details of the flow itself.

The package tries to implement a single, best practice implementation of working with OAuth. For particular providers the specific flow required can be customized via configuration or code.

## Features

For the solution developer, the Umbraco Authorized Services offers two primary features.

Firstly there's an tree available in the _Settings_ section of the backoffice, called _Authorized Services_. The tree shows the list of services based on the details provided in configuration.

[insert pic]

Each tree entry has a management screen where an administrator can authenticate with an app that has been setup with the service.  The status of each service is shown on this screen. When authorized, the authentication and authorization flow has been completed and an access token stored.

[insert pic]

Secondly, the developer has access to an interface - `IAuthorizedServiceCaller` - that they can inject instances of and use to make authorized requests to the service's API.

## Usage

### App Creation

Services that this package are intended to support will offer an OAuth authentication and authorization flow against an "app". The developer will need to create this "app" with the service.  By doing this information such as the "client ID" and "client secret" can be applied in configuration.

### Installation

The package can be installed into your Umbraco solution from [NuGet](https://www.nuget.org/packages/Umbraco.AuthorizedServices).

### Configuring a Service

Details of services available need to be applied to the Umbraco web application's configuration, which, if using the `appSettings.json` file, will look as follows. Other sources such as environment variables can also be used, as per standard .NET configuration.

```json
  "Umbraco": {
    "CMS": {
        ...
    },
    "AuthorizedServices": {
      "TokenEncryptionKey": "",
      "Services": [
        {
          "Alias": "",
          "DisplayName": "",
          "ApiHost": "",
          "IdentityHost": "",
          "TokenHost": "",
          "RequestIdentityPath": "",
          "AuthorizationRequestsRequireRedirectUri": true|false,
          "RequestTokenPath": "",
          "JsonSerializer": "",
          "RequestTokenFormat": "",
          "ClientId": "",
          "ClientSecret": "",
          "UseProofKeyForCodeExchange": true|false,
          "Scopes": "",
          "AccessTokenResponseKey": "access_token",
          "RefreshTokenResponseKey": "refresh_token",
          "ExpiresInResponseKey": "expires_in",
          "SampleRequest": ""
        },
      ]
    }
```

#### Configuration Elements

The following section describes each of the configuration elements. An example is provided for one service provider (GitHub).

Not all values are required for all services.  Those that are required are marked with an "*" below.

##### TokenEncryptionKey

Provides an optional key used to encrypt and decrypt tokens when they are saved and retrieved from storage respectively.

##### Services

The collection of services available for authorization and usage.

###### Alias *

The alias of the service, which must be unique across the service collection.

###### DisplayName *

Provides a friendly name for the service used for identification in the user interface.

###### ApiHost *

The host name for the service API that will be called to deliver business functionality. For example, for Github this is `https://api.github.com`.

###### IdentityHost *

The host name for the service's authentication endpoint, used to initiate the authorization of the service by asking the user to login. For GitHub, this is `https://github.com`.

###### TokenHost

Some providers make available a separately hosted service for handling requests for access tokens. If that's the case, it can be provided here. If not provided, the value of `IdentityHost` is used. For GitHub, this is not necessary as the value is `https://github.com`, the same as the identity host.

###### RequestIdentityPath *

Used, along with `IdentityHost` to construct a URL that the user is redirected to when initiating the authorization of the service via the backoffice. For GitHub, the required value is `/login/oauth/authorize`.

###### AuthorizationRequestsRequireRedirectUri

Some providers require a redirect URL to be provided with the authentication request. For others, instead it's necessary to configure this as part of the registered app. The default value if not provided via configuration is `false`, which is sufficient for the GitHub example.

###### RequestTokenPath *

Used, along with `TokenHost` to construct a URL used for retrieving access tokens. For GitHub, the required value is `/login/oauth/access_token`.

###### RequestTokenFormat

An enum value that controls how the request to retrieve an access token is formatted. Options are `Querystring` and `FormUrlEncoded`. `Querystring` is the default value and is used for GitHub.

###### RequestTokenFormat

An enum value that defines the JSON serializer to use when creating requests and deserializing responses. Options are `Default` and `JsonNet` and `SystemTextJson`.

- `Default` - uses the Umbraco CMS default `IJsonSerializer`.
- `JsonNet` - uses the JSON.Net serializer.
- `SystemTextJson` - uses the System.Text.Json serializer.

###### ClientId *

This value will be retrieved from the registered service app.

###### ClientSecret *

This value will be retrieved from the registered service app.  As the name suggests, it should be kept secret and so is probably best not added directly to `appSettings.json` and checked into source control.

###### UseProofKeyForCodeExchange *

This flag will extend the OAuth flow with an additional security layer called [PKCE (Proof Key for Code Exchange)](https://auth0.com/docs/get-started/authentication-and-authorization-flow/authorization-code-flow-with-proof-key-for-code-exchange-pkce).

In the OAuth with PKCE (Proof Key for Code Exchange) flow, a random code will be generated on the client and stored under the name `code_verifier`. Using the `SHA-256` algorithm it will be hashed under the name `code_challenge`.

When the authorization URL is generated, the `code_challenge` will be sent to the OAuth Server, which will store it. The next request for access token will pass the `code_verifier` as a header key. The OAuth Server will compare it with the previously sent `code_challenge`.

###### Scopes *

This value will be configured on the service app and retrieved from there. Best practice is to define only the set of permissions that the integration will need.  For GitHub, the single scope needed to retrieve details about a repository's contributors is `repo`.

###### AccessTokenResponseKey

The expected key for retrieving an access token from a response. If not provided the default `access_token` is assumed.

###### RefreshTokenResponseKey

The expected key for retrieving a refresh token from a response. If not provided the default `refresh_token` is assumed.

###### ExpiresInResponseKey

The expected key for retrieving the datetime of token expiry from a response. If not provided the default `expires_in` is assumed.

###### SampleRequest

An optional sample request can be provided, which can be used to check that an authorized service is functioning as expected from the backoffice.  For example, to retrieve the set of contributors to the Umbraco repository hosted at GitHub, this request can be used: `/repos/Umbraco/Umbraco-CMS/contributors`.

### Authorizing a Service

With one or more service configured, it will be available from the items within a tree in the _Settings_ section.

Clicking on an item will show some details about the configured service, and it's authentication status.

If the service is not yet authorized, click the _Authorize Service_ button to trigger the authentication and authorization flow. You will be directed to the service to login, and optionally choose an account.  You will then be asked to agree to the permissions requested by the app. Finally you will be redirected back to the Umbraco backoffice. You should see confirmation that an access token has been retrieved and stored such that the service is now authorized. If provided, you can click the _Verify Sample Request_ button to ensure that service's API can be called.

### Calling an Service

To make a call to an authorized service, you first need to obtain an instance of `IAuthorizedServiceCaller`. This is registered with the dependency injection framework and as such can be injected into a controller, view or service class where it needs to be used.

If making a request where all information is provided via the path and querystring, such as GET requests, the following method should be invoked:

```csharp
Task<TResponse> SendRequestAsync<TResponse>(string serviceAlias, string path, HttpMethod httpMethod);
```

The parameters for the request are as follows:

- `serviceAlias` - the alias of the service being invoked (e.g. `github`).
- `path` - the path to the API method being invoked (e.g. `/repos/Umbraco/Umbraco-CMS/contributors`).
- `httpMethod` - the HTTP method to use for the request (e.g. `HttpMethod.Get`).

There is also a type parameter:
- `TResponse` - defines the strongly typed representation of the service method's response, that the raw response content will be deserialized into.

If you need to provide data in the request an overload is available. This can be used for POST or PUT requests that trigger the creation or update of a resource:

```csharp
Task<TResponse> SendRequestAsync<TRequest, TResponse>(string serviceAlias, string path, HttpMethod httpMethod, TRequest? requestContent = null)
    where TRequest : class;
```

The additional parameter is:

- `requestContent` - the strongly typed request content, which will be serialized and provided in the request.

And additional type parameter:
- `TRequest` - defines the strongly typed representation of the request content.


If you need to work with the raw JSON response, there are equivalent methods for both of these that omit the deserialization step:

```csharp
Task<string> SendRequestRawAsync(string serviceAlias, string path, HttpMethod httpMethod);

Task<string> SendRequestRawAsync<TRequest>(string serviceAlias, string path, HttpMethod httpMethod, TRequest? requestContent = null)
    where TRequest : class;
```

Finally, there are convenience extension methods available for each of the common HTTP verbs. These allow you to simplify the requests and omit the `HttpMethod` parameter, e.g.

```csharp
Task<TResponse> GetRequestAsync<TResponse>(string serviceAlias, string path);
```

## Verified Providers

The following service providers have been tested against the package implementation. For each one the necessary configuration is listed.

As integrations with more providers are successfully completed, we plan to maintain the details for each here. Pull requests updating this list with verified integrations are welcome.

### Aprimo

```json
{
  "Alias": "aprimo",
  "DisplayName": "Aprimo",
  "ApiHost": "https://[tenant].dam.aprimo.com/api/core",
  "IdentityHost": "https://[tenant].aprimo.com",
  "TokenHost": "https://[tenant].aprimo.com",
  "RequestIdentityPath": "/login/connect/authorize",
  "RequestTokenPath": "/login/connect/token",
  "RequestTokenFormat": "FormUrlEncoded",
  "AuthorizationRequestsRequireRedirectUri": true,
  "UseProofKeyForCodeExchange": true,
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "api offline_access",
  "SampleRequest": ""
},
```

### Facebook

```json
{
  "Alias": "facebook",
  "DisplayName": "Facebook",
  "ApiHost": "https://graph.facebook.com",
  "IdentityHost": "https://www.facebook.com",
  "TokenHost": "https://graph.facebook.com",
  "RequestIdentityPath": "/v3.0/dialog/oauth",
  "RequestTokenPath": "/v3.0/oauth/access_token",
  "RequestTokenFormat": "FormUrlEncoded",
  "AuthorizationRequestsRequireRedirectUri": true,
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "email public_profile",
  "SampleRequest": "/v3.0/me"
}
```

### GitHub

```json
{
  "Alias": "github",
  "DisplayName": "GitHub",
  "ApiHost": "https://api.github.com",
  "IdentityHost": "https://github.com",
  "TokenHost": "https://github.com",
  "RequestIdentityPath": "/login/oauth/authorize",
  "RequestTokenPath": "/login/oauth/access_token",
  "RequestTokenFormat": "Querystring",
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "repo",
  "SampleRequest": "/repos/Umbraco/Umbraco-CMS/contributors"
},
```

### Google Search Console

```json
{
  "Alias": "google",
  "DisplayName": "Google Search Console",
  "ApiHost": "https://searchconsole.googleapis.com",
  "IdentityHost": "https://accounts.google.com",
  "TokenHost": "https://oauth2.googleapis.com",
  "RequestIdentityPath": "/o/oauth2/auth",
  "RequestTokenPath": "/token",
  "RequestTokenFormat": "FormUrlEncoded",
  "AuthorizationRequestsRequireRedirectUri": true,
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "https://www.googleapis.com/auth/webmasters https://www.googleapis.com/auth/webmasters.readonly",
  "SampleRequest": "/v1/urlInspection/index:inspect"
},
```

### Hubspot

```json
{
  "Alias": "hubspot",
  "DisplayName": "HubSpot",
  "ApiHost": "https://api.hubapi.com",
  "IdentityHost": "https://app-eu1.hubspot.com",
  "TokenHost": "https://api.hubapi.com",
  "RequestIdentityPath": "/oauth/authorize",
  "AuthorizationRequestsRequireRedirectUri": true,
  "RequestTokenPath": "/oauth/v1/token",
  "RequestTokenFormat": "FormUrlEncoded",
  "JsonSerializer": "SystemTextJson",
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "crm.objects.contacts.read crm.objects.contacts.write",
  "SampleRequest": "/crm/v3/objects/contacts?limit=10&archived=false"
},
```

### LinkedIn

```json
{
  "Alias": "linkedin",
  "DisplayName": "LinkedIn",
  "ApiHost": "https://api.linkedin.com",
  "IdentityHost": "https://www.linkedin.com",
  "TokenHost": "https://www.linkedin.com",
  "RequestIdentityPath": "/oauth/v2/authorization",
  "RequestTokenPath": "/oauth/v2/accessToken",
  "RequestTokenFormat": "FormUrlEncoded",
  "AuthorizationRequestsRequireRedirectUri": true,
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "r_emailaddress r_liteprofile w_member_social",
  "SampleRequest": "/v2/me"
},
```

### Microsoft Dynamics

```json
{
  "Alias": "dynamics",
  "DisplayName": "Dynamics",
  "ApiHost": "https://[instance].crm4.dynamics.com/api/data/v9.2",
  "IdentityHost": "https://login.microsoftonline.com",
  "TokenHost": "https://login.microsoftonline.com",
  "RequestIdentityPath": "/common/oauth2/v2.0/authorize",
  "RequestTokenPath": "/common/oauth2/v2.0/token",
  "RequestTokenFormat": "FormUrlEncoded",
  "AuthorizationRequestsRequireRedirectUri": true,
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "https://[instance].crm4.dynamics.com/.default",
  "SampleRequest": "/msdyncrm_marketingforms"
},
```

### Semrush

```json
{
  "Alias": "semrush",
  "DisplayName": "Semrush",
  "ApiHost": "https://oauth.semrush.com",
  "IdentityHost": "https://oauth.semrush.com",
  "TokenHost": "https://oauth.semrush.com",
  "RequestIdentityPath": "/auth/login",
  "RequestTokenPath": "/oauth2/access_token",
  "RequestTokenFormat": "FormUrlEncoded",
  "AuthorizationRequestsRequireRedirectUri": true,
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "user.id,domains.info,url.info,positiontracking.info",
  "SampleRequest": ""
},
```

### Shopify

```json
{
  "Alias": "shopify",
  "DisplayName": "Shopify",
  "ApiHost": "https://[shop-name].myshopify.com",
  "IdentityHost": "https://[shop-name].myshopify.com",
  "TokenHost": "https://[shop-name].myshopify.com/admin",
  "RequestIdentityPath": "/admin/oauth/authorize",
  "RequestTokenPath": "/oauth/access_token",
  "RequestTokenFormat": "FormUrlEncoded",
  "AuthorizationRequestsRequireRedirectUri": true,
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "read_products",
  "SampleRequest": "/admin/api/2022-01/products.json"
},
```

### Twitter

```json
{
  "Alias": "twitter",
  "DisplayName": "Twitter",
  "ApiHost": "https://api.twitter.com",
  "IdentityHost": "https://twitter.com",
  "TokenHost": "https://api.twitter.com",
  "RequestIdentityPath": "/i/oauth2/authorize",
  "RequestTokenPath": "/2/oauth2/token",
  "RequestTokenFormat": "FormUrlEncoded",
  "AuthorizationRequestsRequireRedirectUri": true,
  "UseProofKeyForCodeExchange": true,
  "ClientId": "",
  "ClientSecret": "",
  "Scopes": "offline.access tweet.read users.read",
  "SampleRequest": "/2/users/me"
},
```

## Contributing

The Authorized Services package is open-source and we welcome issues, suggestions for improvement or PRs.

You can find the [source code and issue tracker at GitHub](https://github.com/umbraco/Umbraco.AuthorizedServices).

The readme file there contains further information, expanding on the documentation you have read here. This will help anyone interested in understanding how it has been developed and interested in contributing to the solution.