---
description: "Information on the unattended settings section"
---

# Unattended

This settings lets you configure the unattended install & upgrade settings. This is a feature that allows Umbraco to install without using the UI. If you don't intended to use this feature, you don't need to configure this.

It's important to know that the install feature will only work if there is a connection string configured pointing to an empty database. A configuration for unattended install & upgrade can look something like:

```json
{
  "$schema": "https://json.schemastore.org/appsettings.json",

  "ConnectionStrings": {
    "umbracoDbDSN": "Server=.;Database=DocsSite;Integrated Security=true"
  },
  "Umbraco": {
    "CMS": {
      "Unattended": {
        "InstallUnattended": true,
        "PackageMigrationsUnattended": true,
        "UpgradeUnattended": true,
        "UnattendedUserName": "A.N. Other",
        "UnattendedUserEmail": "AN@Other.com",
        "UnattendedUserPassword": "APasswordMeetingRequirements"
      }
    }
  }
}
```

This will automatically install Umbraco to the `DocsSite` database on the local SQL server, and will also automatically upgrade whenever there is an upgrade to install.

It is generally not recommended to keep user credentials in config files, therefore we recommend using environment variables to configure these settings.

Let's go through the settings one by one

## Install unattended

Umbraco will only automatically install if this is set to true, and if there is a connection string pointing to an empty database.

## Upgrade unattended

If this is set to true, Umbraco will automatically run the upgrade migrations once the site has been upgraded.

## Unattended user name

This setting is used to specify the user name of the default admin user.

## Unattended email

This setting is used to specify the email address of the default admin user.

## Unattended user pass

This setting is used to specify the password of the default admin user.

### Package migrations unattended

Gets or sets a value indicating whether unattended package migrations are enabled.

This is true by default.
