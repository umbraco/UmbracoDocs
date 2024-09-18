---
hidden: true
---

# Copy of Working with Linux/macOS

One of the features built into Umbraco Cloud is the ability to work locally with your Umbraco site. This can be done without having a Windows machine with a local web server installed on it. This enables people on macOS or Linux-based OS to use their favorite editor to modify code in their Umbraco Cloud site.

## The Solution

1.  On the Umbraco Cloud portal, go to your project and clone the site using your favorite Git client.

    <figure><img src="../.gitbook/assets/image (15).png" alt="Clone project down"><figcaption><p>Clone project down</p></figcaption></figure>
2.  Configure a SQL Server connection string using `ConnectionStrings` in `appsettings.json` or `appsettings.Development.json` (the `launchSettings.json` configures the local instance to run as 'Development'):

    ```json
    "ConnectionStrings": {
        "umbracoDbDSN": ""
    }
    ```
3.  Additionally, it's recommended to configure the local instance to install unattended with the following settings in `appsettings.Development.json`:

    ```json
    {
    "Umbraco": {
        "CMS": {
        "Unattended": {
            "InstallUnattended": true,
            "UnattendedUserName": "",
            "UnattendedUserEmail": "",
            "UnattendedUserPassword": ""
        }
        }
    }
    }
    ```

{% hint style="info" %}
The UserName, Email, and Password are optional properties and _only_ needed if you want to set up a local backoffice user. You can use your Umbraco Id to sign in to the backoffice.
{% endhint %}

1.  On the terminal, navigate to `src/UmbracoProject` folder and run the following commands to start the project:

    ```
    dotnet build
    dotnet run
    ```
2. When running the site for the first time, the database schema is automatically inserted into the database (with `"InstallUnattended": true` in `appsettings.Development.json`), so the site starts up ready for use.
