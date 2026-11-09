---
description: >-
  Replace the signing and encryption credentials Umbraco uses for security tokens, so identity tokens validate across servers and restarts.
---

# Security Token Credentials

Umbraco includes an OpenID Connect authorization server. This server issues tokens for backoffice users, for members using the Delivery API, and for Management API clients. This article explains which credentials the server uses to sign and encrypt those tokens, and how to replace them.

## How Umbraco uses the credentials

Access tokens, refresh tokens, and authorization codes use the ASP.NET Core Data Protection format. Their protection comes from the Data Protection key ring, not from the credentials described in this article. When Umbraco runs on more than one server, share the key ring as described in the [Data Protection](../infrastructure-and-ops/server-setup/load-balancing/README.md#data-protection) section of the load balancing article.

Identity tokens are different. They are always issued as JSON Web Tokens (JWTs) signed with the signing credentials. The public part of each signing key is published from the `/.well-known/jwks` endpoint. A client that receives an identity token uses those published keys to validate it.

Identity tokens are issued when a client requests the `openid` scope. A typical example is an OpenID Connect client that logs in members through [Protected Content in the Delivery API](../../develop-with-umbraco/headless-and-apis/content-delivery-api/protected-content-in-the-delivery-api/README.md).

## Default behavior

By default, each Umbraco instance generates its own signing and encryption keys at startup. The keys are kept in memory for the lifetime of the application. This has two consequences:

* **Each server has different keys.** In a load balanced setup, `/.well-known/jwks` returns a different key depending on which server handles the request.
* **The keys change when the application restarts.** An identity token issued before a restart can no longer be validated against the keys published after it.

When a client validates an identity token against keys from another server, or from before a restart, login fails. The client reports an error such as:

```
no valid key found in issuer's jwks_uri for key parameters {"kid":"...","alg":"RS256"}
```

## When to replace the credentials

Replace the default credentials when external clients validate identity tokens issued by Umbraco, and either of these applies:

* Your site runs on more than one server, for example in a [load balanced environment](../infrastructure-and-ops/server-setup/load-balancing/README.md).
* You need the published keys to stay the same across restarts and deployments.

If no external client requests identity tokens, the default credentials are sufficient.

## Replacing the credentials

The credentials come from an implementation of `ISecurityTokenCredentialsProvider`, in the `Umbraco.Cms.Api.Common.Security` namespace. The interface has two methods:

* `GetSigningCredentials()` returns the credentials used to sign tokens. At least one asymmetric signing credential is required.
* `GetEncryptionCredentials()` returns the credentials used to encrypt tokens. At least one encryption credential is required.

To use shared credentials, create a provider that returns the same credentials on every server. Usually these come from X.509 certificates that you manage outside Umbraco.

### Preparing the certificates

Create one certificate for signing and one for encryption. Each must include its private key. For OpenIddict's recommendations on these certificates and how to create them, see the [OpenIddict documentation on encryption and signing credentials](https://documentation.openiddict.com/configuration/encryption-and-signing-credentials).

OpenIddict checks the key usage of certificates registered through its own methods, but not of certificates returned from the provider. Make sure the signing certificate has the `DigitalSignature` key usage and the encryption certificate has the `KeyEncipherment` key usage.

Store the certificates where all servers can load them, such as a certificate store or [Azure Key Vault](key-vault.md).

### Creating the provider

The following provider returns credentials from two certificates:

{% code title="CertificateSecurityTokenCredentialsProvider.cs" %}
```csharp
using System.Security.Cryptography.X509Certificates;
using Microsoft.IdentityModel.Tokens;
using Umbraco.Cms.Api.Common.Security;

namespace MyProject.Security;

public class CertificateSecurityTokenCredentialsProvider : ISecurityTokenCredentialsProvider
{
    private readonly X509Certificate2 _signingCertificate;
    private readonly X509Certificate2 _encryptionCertificate;

    public CertificateSecurityTokenCredentialsProvider(
        X509Certificate2 signingCertificate,
        X509Certificate2 encryptionCertificate)
    {
        _signingCertificate = signingCertificate;
        _encryptionCertificate = encryptionCertificate;
    }

    public IEnumerable<SigningCredentials> GetSigningCredentials()
        => [new X509SigningCredentials(_signingCertificate)];

    public IEnumerable<EncryptingCredentials> GetEncryptionCredentials()
        => [new X509EncryptingCredentials(_encryptionCertificate)];
}
```
{% endcode %}

### Registering the provider

Register the provider with `AddUnique` from a composer, so the provider replaces the default one.

The following composer loads the certificates from PFX files. The file paths and password are read from configuration. When the paths are not configured, the composer does nothing, and the default credentials are used. This keeps local development working without certificates.

{% code title="SecurityTokenCredentialsComposer.cs" %}
```csharp
using System.Security.Cryptography.X509Certificates;
using Umbraco.Cms.Api.Common.Security;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace MyProject.Security;

public class SecurityTokenCredentialsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        var signingCertificatePath = builder.Config["SecurityTokenCredentials:SigningCertificatePath"];
        var encryptionCertificatePath = builder.Config["SecurityTokenCredentials:EncryptionCertificatePath"];
        if (string.IsNullOrEmpty(signingCertificatePath) || string.IsNullOrEmpty(encryptionCertificatePath))
        {
            return;
        }

        var password = builder.Config["SecurityTokenCredentials:CertificatePassword"];

        X509Certificate2 signingCertificate = X509CertificateLoader.LoadPkcs12FromFile(signingCertificatePath, password);
        X509Certificate2 encryptionCertificate = X509CertificateLoader.LoadPkcs12FromFile(encryptionCertificatePath, password);

        builder.Services.AddUnique<ISecurityTokenCredentialsProvider>(
            new CertificateSecurityTokenCredentialsProvider(signingCertificate, encryptionCertificate));
    }
}
```
{% endcode %}

Keep the following in mind when implementing a provider:

* The provider is resolved from the root service provider. It must not depend on scoped services.
* The credentials are read once, when the authorization server options are built. Restart the application to pick up new credentials.
* Return credentials from the provider rather than registering them on the OpenIddict server options, for example with `AddSigningCertificate()`. Credentials registered on the options are used alongside the credentials from the provider, not in place of them.

### Verifying the setup

Request `/.well-known/jwks` from each server. When the shared credentials are in use, every server returns the same signing key. For an X.509 certificate, the `kid` value is the certificate thumbprint.

## Rolling over keys

Each method can return several credentials. This allows you to introduce a new certificate before the current one expires. OpenIddict chooses between certificates based on their validity dates, as described in the [OpenIddict documentation on encryption and signing credentials](https://documentation.openiddict.com/configuration/encryption-and-signing-credentials).

Umbraco reads the credentials once, at startup, and OpenIddict orders them at the same time. A certificate that becomes valid while the application is running is only preferred after the next restart.

All signing keys are published from `/.well-known/jwks`, so clients can validate tokens signed with either certificate during the overlap.

{% hint style="warning" %}
If every signing certificate, or every encryption certificate, has expired or is not yet valid, OpenIddict rejects its configuration when the options are first used. Keep at least one valid certificate of each type in the provider at all times.
{% endhint %}

To roll over a certificate:

1. Return both the current and the new certificate from the provider.
2. Once the new certificate is valid, restart the application on all servers.
3. Remove the old certificate from the provider after it has expired.

## Related articles

* [Umbraco in Load Balanced Environments](../infrastructure-and-ops/server-setup/load-balancing/README.md)
* [Protected Content in the Delivery API](../../develop-with-umbraco/headless-and-apis/content-delivery-api/protected-content-in-the-delivery-api/README.md)
* [Configuring Azure Key Vault](key-vault.md)
