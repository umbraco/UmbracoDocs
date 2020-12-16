---
meta.Title: "Configuring a load balanced site"
meta.Description: "This describes some more advanced techniques and configuration that you can use when load balancing"
versionFrom: 8.6.4
---

# Configuring a load balanced site

## Server Configuration

Your server configuration will differ greatly dependant on to what extent you synchronize files between the servers. Below the three approaches are outlined:

1. [Azure Web Apps](file-system-replication.md#mixture-of-standalone--synchronised) - _You use cloud based auto-scaling appliances like [Microsoft's Azure Web Apps](https://azure.microsoft.com/en-us/services/app-service/web/)_
2. [File Replication](file-system-replication.md#synchronised-file-system) - _Each server hosts copies of the load balanced website files and a file replication service is running to ensure that all files on all servers are up to date_
3. [Centralized file share](file-system-replication.md#synchronised-file-system) - _The load balanced website files are located on a centralized file share (SAN/NAS/Clustered File Server/Network Share)_

[Full documentation on configuring file system replication can be found here](file-system-replication.md).

### Machine Key

You will need to use a custom machine key so that all your machine key level encryption values are the same on all servers. Without this you will end up with view state errors, validation errors and encryption/decryption errors since each server will have its own generated key.

:::warning
Be aware that any site that doesn't have a machine key and gets one added will need to reset all member and user passwords as their encryption is dependant on it!
:::

Here are a couple of tools that can be used to generate machine keys:

* [Machine key generator on betterbuilt.com](http://www.betterbuilt.com/machinekey/)
* [Machine key generator on developerfusion.com](https://www.developerfusion.com/tools/generatemachinekey/)

You need to update your web.config accordingly, note that the validation/decryption types may be different for your environment depending on how you've generated your keys.

Umbraco offers the opportunity to auto generate a machine key during the installation steps so this may already exist:

```xml
<configuration>
  <system.web>
    <machineKey decryptionKey="Your decryption key here"
                validationKey="Your Validation key here"
                validation="SHA1"
                decryption="AES" />
  </system.web>
</configuration>
```

### Session State

If you use SessionState in your application, or are using the default TempDataProvider in MVC (which uses SessionState). Then you will need to configure your application to use the SqlSessionStateStore or an alternative provider (see [the Microsoft documentation](https://msdn.microsoft.com/en-us/library/aa478952.aspx) for more details).

### Logging

Umbraco 8+ uses Serilog for logging. When load balancing Umbraco consideration should be given as to how the log files from each server will be accessed. 

There are many Serilog Sinks available and one of these may be appropriate to store logs for all servers in a central repository such as Azure Application Insights or Elmah.io.

See [SeriLog Provided Sinks](https://github.com/serilog/serilog/wiki/Provided-Sinks) for more info.

### Testing

Your staging environment should also be load balanced so that you can see any issues relating to load balancing in that environment before going to production.

You'll need to test this solution **a lot** before going to production. You need to ensure there are no windows security issues, etc... The best way to determine issues is have a lot of people testing this setup and ensuring all errors and warnings in your application/system logs in Windows are fixed.

Ensure to analyze logs from all servers and check for any warnings and errors.

## Specifying a Master Scheduling server

It is recommended to configure an explicit master scheduling server since this reduces the amount of complexity that the [master election](index.md#scheduling-and-master-election) process performs.

The recommended approach would be to add an app setting in web.config with the server role that you can transform between the web apps:

```xml
<add key="Umbraco.ServerRole" value="master"/>
```

Then add a composer specifying the serverrole based on that app setting:

```csharp
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;
using Umbraco.Core.Sync;

namespace UmbracoLoadBalancingTraining.Common
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class ServerRegistrarComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.SetServerRegistrar(new LoadBalancedServerRegistrar(composition.Logger));
        }
    }

    public class LoadBalancedServerRegistrar : IServerRegistrar
    {
        private readonly IProfilingLogger logger;

        public LoadBalancedServerRegistrar(IProfilingLogger logger)
        {
            this.logger = logger;
        }

        public IEnumerable<IServerAddress> Registrations
        {
            get { return Enumerable.Empty<IServerAddress>(); }
        }

        public ServerRole GetCurrentServerRole()
        {
            var serverRole = ConfigurationManager.AppSettings["Umbraco.ServerRole"];

            if(!serverRole.IsNullOrWhiteSpace() && serverRole == "master")
            {
                logger.Info<LoadBalancedServerRegistrar>("Detected Umbraco.ServerRole app setting. Setting the role to Master");
                return ServerRole.Master;
            }

            logger.Info<LoadBalancedServerRegistrar>("Detected no Umbraco.ServerRole app setting. Setting the role to Replica.");
            return ServerRole.Replica;

        }

        public string GetCurrentServerUmbracoApplicationUrl()
        {
            // NOTE: If you want to explicitly define the URL that your application is running on,
            // this will be used for the server to communicate with itself, you can return the
            // custom path here and it needs to be in this format:
            // http://www.mysite.com/umbraco

            return null;
        }
    }
}

```

Now your front-end servers will always be deemed 'Replica' servers and will not attempt any master election or task scheduling.

Your master server will always be deemed the 'Master' and will always be the one that executes all task scheduling.

## Front-end servers - Read-only database access

:::note
This description pertains ONLY to Umbraco database tables
:::

In some cases infrastructure admins will not want their front-end servers to have write access to the database.
By default front-end servers will require write full access to the following tables:

* `umbracoServer`
* `umbracoNode`

This is because by default each server will inform the database that they are active and more importantly it is
used for task scheduling. Only a single server can execute task scheduling and these tables are used for servers
to use a master server election process without the need for any configuration. So in the case that a front-end
server becomes the master task scheduler, **it will require write access to all of the Umbraco tables**.

In order to have read-only database access configured for your front-end servers, you need to implement
the [Explicit master scheduling server](#explicit-master-scheduling-server) configuration mentioned above.

Now that your front-end servers are using your custom `LoadBalancedServerRegistrar` class, they will always be deemed 'Replica' servers and will not attempt any master election or task scheduling. Because you are no longer using the default `DatabaseServerRegistrar` they will not try to ping the umbracoServer table.

## Controlling how often the load balancing instructions from the database are processed and pruned

During start up the `DatabaseServerMessengerOptions` can be adjusted to control how often the load balancing instructions from the database are processed and pruned.

You'll need to create an [Composer](../../../../Implementation/Composing/index.md) to set the messenger options

```csharp
public void Compose(Composition composition)
{
    composition.SetDatabaseServerMessengerOptions(factory =>
    {
        var options = DatabaseServerRegistrarAndMessengerComposer.GetDefaultOptions(factory);
        options.DaysToRetainInstructions = 10;
        options.MaxProcessingInstructionCount = 1000;
        options.ThrottleSeconds = 25;
        options.PruneThrottleSeconds = 60;
        return options;
    });
}
```

Options:

* DaysToRetainInstructions - The number of days to keep instructions in the database; records older than this number will be pruned.
* MaxProcessingInstructionCount - The maximum number of instructions that can be processed at startup; otherwise the server cold-boots (rebuilds its caches)
* ThrottleSeconds - The number of seconds to wait between each sync operations
* PruneThrottleSeconds - The number of seconds to wait between each prune operation
