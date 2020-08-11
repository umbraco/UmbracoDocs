---
versionFrom: 8.0.0
---

# Reset admin password

There is one default admin user in any Umbraco installation. This is the first user of the system.

While there are multiple blogposts and even a [package](https://our.umbraco.com/packages/developer-tools/umbraco-admin-reset/) to reset the password of the admin user. There is an [official way](https://twitter.com/Shazwazza/status/1141594930550206464) to reset credentials from your lost admin password.

## Step one: Clear the configuration status in the web.config

The first step is to clear the configuration status in the `web.config` file. This is done to trigger the installation wizard.

That means that in your web.config file the appsettings should look like this:

```csharp
<appSettings>
    <add key="Umbraco.Core.ConfigurationStatus" value="" />
</appSettings>
```

## Step two: Update the database

Open the database and go to the `umbracoUser` database table.
Search the user where the column id equals `-1`.

Clear the field, and change the content of the `userpassword` field to `default`.

## Step Three: Run the installer

If you now open your browser and surf to the website, you will see that the installer launches. Enter your new details, and you are good to go.  

:::warning
Make sure you protect a production websites from being highjacked as anyone will be able to reset the password during the last step.
This does also work if your site is in an upgrading state.
:::
