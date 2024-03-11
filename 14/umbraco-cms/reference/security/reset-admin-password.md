# Reset admin password

There is one default admin user in any Umbraco installation. This is the first user of the system.

## Step one: Clear the connection string status in configuration

The first step is to clear the connection string to the database in the configuration. This is done to trigger the installation wizard.

That means that in your appsettings configuration files it should look like this:

```json
{
  "ConnectionStrings": {
    "umbracoDbDSN": ""
  }
}
```

{% hint style="warning" %}
**Note that configuration can be read from many sources**

Remember to check this connection string is not provided through environment variables or other configuration sources.
{% endhint %}

## Step Two: Run the installer

If you now open your browser and surf to the website, you will see that the installer launches.
Enter your new details, and use the original connection string. You are good to go.

{% hint style="warning" %}
Make sure you protect a production websites from being highjacked as anyone will be able to reset the password during the last step.
This does also work if your site is in an upgrading state.
{% endhint %}
