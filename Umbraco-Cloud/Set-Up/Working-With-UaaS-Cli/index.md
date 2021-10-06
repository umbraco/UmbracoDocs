---
versionFrom: 9.0.0
---

# Working with Mac

One of the features built into Umbraco Cloud is the ability to work locally with your Umbraco site - without having a Windows machine with a local web server installed on it. This enables people on Mac or Linux based OS to use their favorite editor to modify code in their Umbraco Cloud site.

## The Mac Solution

To work with Mac:

1. On the Umbraco Cloud portal, go to your project and clone the site using your favorite Git client.
    ![Clone Project](images/clone-project.png)

2. Configure a SQL Server connection string using `ConnectionStrings` in `appsettings.json` or `appsettings.Development.json` (the `launchSettings.json` configures the local instance to run as 'Development'):

    ```json
    "ConnectionStrings": {
        "umbracoDbDSN": ""
    }
    ```

3. Additionally, it's recommended to configure the local instance to install unattended with the following settings in `appsettings.Development.json`:

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

:::note
The UserName, Email, and Password are optional properties and *only* needed if you want to setup a local backoffice user. You can use your Umbraco Id to sign-in to the backoffice.
:::

4. On the termial, navigate to `src/UmbracoProject` folder and run the following commands to start the project:

    ```cli
    dotnet build
    dotnet run
    ```

5. When running the site for the first time, the database schema is automatically inserted into the database (with `"InstallUnattended": true` in `appsettings.Development.json`), so the site starts up ready for use.
