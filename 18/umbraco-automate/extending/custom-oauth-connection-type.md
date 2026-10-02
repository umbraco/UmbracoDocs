---
description: >-
  Build a connection type that signs in to an external service with OAuth, using
  the Umbraco.Automate.OpenIddict add-on.
---

# Create a Custom OAuth Connection Type

An OAuth connection type lets editors sign in to an external service from the connection editor, instead of pasting an API key. The Slack add-on works this way. You build one on the `Umbraco.Automate.OpenIddict` add-on, which handles the OAuth flow, stores the tokens, and refreshes them.

An OAuth connection type needs:

* An **OpenIddict provider registration**: the external service the connection signs in to.
* A **settings model** with one field that holds the OAuth credential.
* A **connection type class** that names the provider.

This article uses GitHub as the example. For the basics shared with every connection type, see [Create a Custom Connection Type](custom-connection-type.md).

## Prerequisites

Add the `Umbraco.Automate.OpenIddict` package to your project. It brings in the OpenIddict client and its [web providers](https://github.com/openiddict/openiddict-client-web-integration), the credential storage, and the OAuth property editor.

{% code title=".NET CLI" %}
```bash
dotnet add package Umbraco.Automate.OpenIddict
```
{% endcode %}

The OAuth services register themselves when the package is installed. You don't call anything to enable them.

## Register the OpenIddict Provider

Add the provider in a composer. Automate supplies the client ID, secret, scopes, and redirect URL, so you don't set them here.

{% code title="GitHubComposer.cs" %}
```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace MyProject.Automate;

public sealed class GitHubComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddOpenIddict()
            .AddClient(options => options.UseWebProviders().AddGitHub(_ => { }));
    }
}
```
{% endcode %}

The provider name defaults to the OpenIddict web provider's name, `GitHub` in this example. You use that name in the connection type, the configuration section, and the redirect URL.

If the provider's token response is non-standard, add OpenIddict event handlers in the same composer. The Slack add-on does this to use Slack's V2 OAuth endpoints. A handler can store extra values on the credential by setting these authentication properties:

| Property | Stored as |
| --- | --- |
| `Constants.OAuthProperties.UserAccessToken` | A second access token, such as a Slack user token. |
| `Constants.OAuthProperties.AccountLabel` | A display label for the account, such as a workspace name. |
| `Constants.OAuthProperties.Scopes` | The granted scopes, separated by spaces. |

The `Constants` class is in the `Umbraco.Automate.OpenIddict` namespace.

## Settings Model

The settings model needs one property named `OAuthCredentialsId` of type `Guid?`. Set its editor to `Umb.Automate.OAuth` and pass the provider name in the `provider` configuration value.

{% code title="GitHubConnectionSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class GitHubConnectionSettings
{
    [Field(
        Label = "GitHub account",
        Description = "Authenticate with your GitHub account.",
        EditorUiAlias = "Umb.Automate.OAuth",
        EditorConfig = """[{ "alias": "provider", "value": "GitHub" }]""")]
    public Guid? OAuthCredentialsId { get; set; }
}
```
{% endcode %}

The editor shows the **Authenticate with GitHub** button. Automate finds the credential by the property name and type. With any other name or type, Automate can't link the sign-in to the connection.

## Connection Type Class

Inherit from `OAuthConnectionTypeBase<TSettings>` and override `ProviderName`. It must match the provider name from your composer.

{% code title="GitHubConnectionType.cs" %}
```csharp
using Umbraco.Automate.Core.Connections;
using Umbraco.Automate.OpenIddict.ConnectionTypes;
using Umbraco.Automate.OpenIddict.Credentials;

namespace MyProject.Automate;

[ConnectionType("gitHub", "GitHub",
    Description = "Connect to a GitHub account",
    Group = "Custom",
    Icon = "icon-plug")]
public sealed class GitHubConnectionType : OAuthConnectionTypeBase<GitHubConnectionSettings>
{
    public GitHubConnectionType(
        ConnectionTypeInfrastructure infrastructure,
        IOAuthCredentialsService credentialsService)
        : base(infrastructure, credentialsService)
    {
    }

    public override string ProviderName => "GitHub";

    public override string? SetupDocsUrl => "https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app";
}
```
{% endcode %}

`SetupDocsUrl` is optional. When the provider has no client ID or secret configured, the connection editor links to this page.

The base class validates the connection for you. **Test connection** checks that a credential is present and that a valid access token can be resolved. To also call the service, override `ValidateAsync`, call the base method first, and use the `CredentialsService` property to get the token. The Slack connection type does this to call Slack's `auth.test` endpoint.

The connection type is discovered at startup by its `[ConnectionType]` attribute, like any other connection type.

## Use the Access Token in an Action

Set `ConnectionTypeAlias` on the action to your connection type's alias. At runtime, read the credential ID from the connection settings. Then pass it to `IOAuthCredentialsService.GetValidAccessTokenAsync`.

{% code title="CreateIssueSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class CreateIssueSettings
{
    [Field(Label = "Repository", Description = "The repository, for example my-org/my-repo.")]
    public string Repository { get; set; } = string.Empty;

    [Field(Label = "Title", Description = "The issue title.", SupportsBindings = true)]
    public string Title { get; set; } = string.Empty;
}
```
{% endcode %}

{% code title="CreateIssueAction.cs" %}
```csharp
using System.Net.Http.Headers;
using System.Net.Http.Json;
using Umbraco.Automate.Core;
using Umbraco.Automate.Core.Actions;
using Umbraco.Automate.OpenIddict.Credentials;

namespace MyProject.Automate;

[Action("myProject.gitHub.createIssue", "Create GitHub Issue",
    Description = "Creates an issue in a GitHub repository.",
    Group = "Custom",
    Icon = "icon-plug",
    ConnectionTypeAlias = "gitHub")]
public sealed class CreateIssueAction : ActionBase<CreateIssueSettings>
{
    private readonly IHttpClientFactory _httpClientFactory;
    private readonly IOAuthCredentialsService _credentialsService;

    public CreateIssueAction(
        ActionInfrastructure infrastructure,
        IHttpClientFactory httpClientFactory,
        IOAuthCredentialsService credentialsService)
        : base(infrastructure)
    {
        _httpClientFactory = httpClientFactory;
        _credentialsService = credentialsService;
    }

    public override async Task<ActionResult> ExecuteAsync(
        ActionContext context,
        CancellationToken cancellationToken)
    {
        var settings = context.GetSettings<CreateIssueSettings>();

        var connectionSettings = context.Connection?.GetSettings<GitHubConnectionSettings>();
        if (connectionSettings?.OAuthCredentialsId is not { } credentialsId)
        {
            return ActionResult.Failed(
                new InvalidOperationException("The GitHub connection is not authenticated."),
                StepRunErrorCategory.Authentication);
        }

        // Returns null when the token has expired and can't be refreshed.
        var accessToken = await _credentialsService.GetValidAccessTokenAsync(credentialsId, cancellationToken);
        if (accessToken is null)
        {
            return ActionResult.Failed(
                new InvalidOperationException("The GitHub access token is expired or revoked. Authenticate again."),
                StepRunErrorCategory.Authentication);
        }

        using var client = _httpClientFactory.CreateClient(Constants.HttpClients.Default);
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
        client.DefaultRequestHeaders.UserAgent.ParseAdd("MyProject.Automate");

        using var response = await client.PostAsJsonAsync(
            $"https://api.github.com/repos/{settings.Repository}/issues",
            new { title = settings.Title },
            cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            return ActionResult.Failed(
                new InvalidOperationException($"GitHub returned {(int)response.StatusCode}."),
                StepRunErrorCategory.InvalidResponse);
        }

        return Success();
    }
}
```
{% endcode %}

`GetValidAccessTokenAsync` returns the stored access token while it is valid. If the token expires within five minutes, it uses the refresh token to get a new one and saves it. It returns `null` when:

* The credential doesn't exist.
* The token has expired and the provider issued no refresh token.
* The refresh fails.

Automate only records an expiry when the provider issues a refresh token. A token without a refresh token is treated as long-lived, as Slack's are.

To read the other stored values, such as `UserAccessToken` or `AccountLabel`, call `GetCredentialsAsync` with the same ID. It returns the decrypted `OAuthCredentials`.

## Configure the Provider Credentials

Register an OAuth app with the provider. Set its redirect URL to the callback route, with the provider name in lowercase:

```
https://<your-site>/umbraco/automate/oauth/callback/github
```

Add the app's client ID and secret under `Umbraco:Automate:Providers:<ProviderName>`. Scopes you list here are requested during sign-in.

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "Providers": {
        "GitHub": {
          "ClientId": "your-client-id",
          "ClientSecret": "your-client-secret",
          "Scopes": ["repo"]
        }
      }
    }
  }
}
```
{% endcode %}

Until both the client ID and secret are set, the **Authenticate with GitHub** button is disabled. Keep the client secret out of source control. Use environment variables, user secrets, or a key vault to inject it at deployment time.

Document these keys and the redirect URL for the administrators who install your package. See the Slack add-on's [Installation](../add-ons/slack/installation.md) article for an example.

## How Credentials Behave

Automate applies these rules to every OAuth connection type:

* **One credential per connection.** After sign-in, the editor receives a short-lived token instead of the credential ID. Saving the connection exchanges it for the ID. The token expires after 15 minutes, and a credential that another connection uses is refused.
* **Unused credentials are removed.** An hourly job deletes credentials that no connection refers to and that haven't changed for 24 hours.
* **Tokens are encrypted at rest.** The access, refresh, and user tokens are encrypted in the database.
* **Load-balanced sites share one key ring.** The sign-in token uses ASP.NET Core Data Protection. See [Share the Data Protection Keys](../run-in-production/load-balancing.md#share-the-data-protection-keys).
* **Deploy doesn't transfer credentials.** Editors authenticate the connection on each environment. See [Transferring Automations](../add-ons/deploy/transferring-automations.md).

For the editor's side of the flow, see [Authenticate an OAuth Connection](../backoffice/connections.md#authenticate-an-oauth-connection).

## Verify

Restart your Umbraco site. The **GitHub** connection type appears in the connection type picker under the **Custom** group. Create a connection and click **Authenticate with GitHub**. Sign in, save the connection, and click **Test connection** to confirm the access token is valid.

## See Also

* [Create a Custom Connection Type](custom-connection-type.md)
* [Manage Connections](../backoffice/connections.md)
* [Slack Connection](../add-ons/slack/connection.md)
