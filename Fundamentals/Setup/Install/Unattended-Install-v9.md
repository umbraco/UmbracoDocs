---
versionFrom: 9.0.0
verified-against: alpha-4
state: partial
updated-links: false
---

# Unattended Installs

In some cases, you might need to install one or multiple Umbraco instances automatically without having to run through the installation wizard to configure the instance.

You can use the **Unattended installs** feature to allow for quick installation and set up of Umbraco instances on something like Azure Web Apps.

This article will give you the details you need to install Umbraco unattended.

## Get clean install of Umbraco

In order to get a clean instance of Umbraco either follow our installation guide for how to [Install an Umbraco project template](./install-umbraco-with-templates.md/#InstallUmbracowith.NETCLI) or download a zip file directly from [Downloads](https://our.umbraco.com/download).

## Configure your database

As you will not be running through the installation wizard when using the unattended installs feature, you need to manually tell Umbraco which database to use.

* Set up and configure a new database - see [Requirements](../Requirements/#hosting) for details.
* Add the connection string using configuration.

Example in appsettings.json

```json
{
  "ConnectionStrings": {
    "umbracoDbDSN": "server=localhost;database=UmbracoUnicore;user id=sa;password='P@ssw0rd'"
  }
}
```

## Enable the unattended installs feature

The unattended installs feature is disabled by default and in order to enable it, you need to add the following JSON object to a JSON configuration source.

```json
{
  "Umbraco": {
    "CMS": {
      "Unattended": {
        "InstallUnattended": true,
        "UnattendedUserName": "FRIENDLY_NAME",
        "UnattendedUserEmail": "EMAIL",
        "UnattendedUserPassword": "PASSWORD"
      }
    }
  }
}
```

Remember to set the value of `InstallUnattended` to `true`.

Alternatively you may set your configuration with Environment Variables or other means. Learn more about this in the [Microsoft .Net Core config documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-5.0#environment-variables).

The keys for this would then be as follows:

```none
Umbraco__CMS__Unattended__InstallUnattended
Umbraco__CMS__Unattended__UnattendedUserName
Umbraco__CMS__Unattended__UnattendedUserEmail
Umbraco__CMS__Unattended__UnattendedUserPassword
```

## Initialize the unattended install

After completing the steps above you can now initialize the installation by booting up the Umbraco instance.

Once it has completed, you should see the following when visiting the frontend of the site.

![Frontend of Umbraco site installed using the unattended installs feature](images/Unattended/final-screen.png)

## Configuration options

Depending on your preferences, you can use any type of configuration to specify the connection string and login information, as well as enable unattended install. With the extending configuration functionality, it is possible to read from all kinds of sources. One example can be using a JSON file or environment variables.

**Program.cs** has a condition, which if met, an *appsettings.Local.json* file will be added and configured as a configuration source.

```c#
#if DEBUG
  .ConfigureAppConfiguration(config
    => config.AddJsonFile(
      "appsettings.Local.json",
      optional: true,
      reloadOnChange: true))
#endif
```

Having intellisense will help you to easily add your connection string and information needed for the unattended install.

```json
{
    "ConnectionStrings": {
        "umbracoDbDSN": "server=localhost;database=UmbracoUnicore;user id=sa;password='P@ssw0rd'"
    },
    "Umbraco": {
        "CMS": {
            "Unattended": {
                "InstallUnattended": true,
                "UnattendedUserName": "FRIENDLY_NAME",
                "UnattendedUserEmail": "EMAIL",
                "UnattendedUserPassword": "PASSWORD"
            }
        }
    }
}
```

## More support

We have added support for unattended installs with Name, Email and Password, and Connection String as CLI params, which are also available in Visual Studio. There you can fill in your information as follows:

### CLI

```powershell
dotnet new umbraco -n MyNewProject --FriendlyName "Friendly User" --Email user@email.com --Password password1234 --ConnectionString "Server=(localdb)\\Umbraco;Database=MyDatabase;Integrated Security=true" --version 9.0.0
```

### Visual Studio

![Set up unattended install through Visual Studio](images/Unattended/VS-unattended-install.png)
