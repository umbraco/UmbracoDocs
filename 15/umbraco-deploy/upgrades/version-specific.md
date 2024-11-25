---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco Deploy.
---

# Version Specific Upgrade Details

This article provides specific upgrade documentation for migrating to Umbraco Deploy version 15.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 15 of Umbraco Deploy has a minimum dependency on Umbraco CMS core of `15.0.0`. It runs on .NET 9.

### Breaking changes

Version 15 contains breaking changes. The breaking changes appear in areas related to extending Deploy to support additional entities and property editors. For reference though, the full details are listed here:

#### Async methods

Asynchronous methods have been added to the following interfaces:
- `IPropertyTypeMigrator`:
  - `MigrateAsync(...)`

These methods all have a default implementation that forwards the calls to the synchronous methods (to maintain backwards compatibility). The synchronous methods have been obsoleted and Deploy will now always call the new asynchronous methods. Implementations should be updated to start using those instead.

- `PropertyTypeMigratorBase` and `GridPropertyTypeMigratorBase`: the synchronous `Migrate(...)` method is obsoleted and causes a compiler error when directly invoked (to avoid potential deadlocks, because it forwards to the asynchronous method using `GetAwaiter().GetResult()`);
- All property type migrator implementations inheriting from the above base classes have been updated to use the asynchronous methods as well.

#### Removed `AcceptInvalidCertificates` setting

The `AcceptInvalidCertificates` setting previously configured the `ServicePointManager` to accept all certificates. However, this class is [obsoleted in .NET 9 and no longer affects `HttpClient`](https://learn.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager?view=net-9.0).

Deploy uses a type of client to make HTTP requests between environments and this client can be configured to accept any certificate:

```csharp
builder.Services.AddHttpClient<DeployHttpClient>().ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
{
  // Only use this for testing purposes or if you have other security in place (e.g. only allow environments to connect over an internal network)
  ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
});
```

### Dependencies

* Umbraco CMS dependency was updated to `15.0.0`.

## Legacy version-specific upgrade notes

You can find the version-specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/upgrades/version-specific.md).
