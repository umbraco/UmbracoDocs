---
description: Describes the checks Umbraco will do on startup to determine the availability of the database, and how this behavior can be customized.
---

# Database Availability Checks

When Umbraco boots it will check for a configured database and, if found, verify that a connection can be made.

The default behavior is to check five times with a one second delay between attempts. If, after that, a connection cannot be established, Umbraco will fail with a `BootFailedException`.

## Implementing Custom Behavior

For projects in development with the potential for misconfigured database settings, this is likely a reasonable approach to take.

In production, when you have stable configuration, you may prefer to override the behavior to better handle cases where your hosting infrastructure might restart.

We support this by abstracting the default behavior behind the `IDatabaseAvailabilityCheck` interface found in the `Umbraco.Cms.Infrastructure.Persistence` namespace.

You can implement your own version of this interface and register it via a composer. This is shown in the following, stub example:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Infrastructure.Persistence;

public class MyDatabaseAvailabilityCheckComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IDatabaseAvailabilityCheck, MyDatabaseAvailabilityCheck>();
    }
}

internal class MyDatabaseAvailabilityCheck : IDatabaseAvailabilityCheck
{
    public bool IsDatabaseAvailable(IUmbracoDatabaseFactory databaseFactory)
    {
        // Provide your custom logic to check database availability, wait as required, and return true once a connection is established.
        return true;
    }
}

```

For reference and inspiration, the default implementation can be found [here](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Infrastructure/Persistence/DefaultDatabaseAvailabilityCheck.cs).

