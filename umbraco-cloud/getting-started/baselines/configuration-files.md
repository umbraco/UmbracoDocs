# Handling configuration files

{% hint style="warning" %}
This is currently not possible on projects that run Umbraco 9 and above.

We are working on making it available for Umbraco Cloud projects using version 9 and above.
{% endhint %}

When you are doing your normal development process, you'd be updating the configuration files in your solution as usual. When you are working with a Baseline setup there are a few things to keep in mind.

When you are deploying updates from the Baseline project to the Child projects, all solvable merge conflicts on configuration files will be solved by using the setting on the Child project.

That also means that if a file has been changed in both the Baseline and in the Child project, the change from the Baseline won’t be applied to the Child. To have custom settings on the Child project, you should take advantage of the vendor-specific transform files.

On Umbraco Cloud, it is possible to create transform files that will be applied to certain environments by naming them like `web.live.xdt.config` (see [Config-Transforms](../../set-up/config-transforms.md)). This should be used when a Child project needs different settings than the Baseline project.

It can be achieved by using a configuration file that is specific to the Child Project, naming it like `child.web.live.xdt.config`. This file should only be in the Child projects repository, which can be achieved by creating the file locally and pushing it directly to the Child project. Read the [Working locally](../../set-up/working-locally.md) article to learn more about how this is done.

Following this workflow will ensure that when the Child is updated from the Baseline, the settings won’t be overwritten.

This practice is especially important when the Baseline project gets major new functionality, like new code that is dependent on the configuration files or when upgrades are applied.

{% hint style="warning" %}
When you need a specific configuration on Child projects, you should always use config transforms. Making changes directly to the default config files on the Child project might prevent you from being able to push changes from your Baseline project in the future.
{% endhint %}

## Examples

Here is a few examples of what could be transformed in the child sites.

## Adding or updating appsettings

{% code title="child-appsettings.web.live.xdt.config" %}

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <appSettings xdt:Transform="InsertIfMissing">
        <!-- Updates the value of the appSetting called owin:appStartup -->
        <add key="owin:appStartup" value="MyCustomOwinStartup" xdt:Locator="Match(key)" xdt:Transform="SetAttributes(value)" />
        <!-- Adds the appsetting MyOwnAppSetting, if it isn't already there -->
        <add key="MyOwnAppSetting" value="AmazingValue" xdt:Locator="Match(key)" xdt:Transform="InsertIfMissing" />
        <!-- Ensures a custom value is there and set to a certain value (remove and add) -->
        <add key="MyOwnAppSetting2" xdt:Locator="Match(key)" xdt:Transform="RemoveAll" />
        <add key="MyOwnAppSetting2" value="AmazingValue2" xdt:Locator="Match(key)" xdt:Transform="InsertIfMissing" />
    </appSettings>
</configuration>
```

{% endcode %}

## Setting the Simple Mail Transfer Protocol (SMTP) settings for the child project

{% code title="child-smtpsettings.web.live.xdt.config" %}

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <system.net xdt:Transform="InsertIfMissing">
        <mailSettings xdt:Transform="InsertIfMissing">
            <smtp xdt:Transform="RemoveAll" />
            <smtp from="abc@def.com" xdt:Transform="InsertIfMissing">
                <network host="smtp.sendgrid.com" userName="abc" password="def" />
            </smtp>
        </mailSettings>
    </system.net>
</configuration>
```

{% endcode %}

## Setting custom rewrite rules for the child project

{% code title="child-iisrewrite.web.live.xdt.config" %}

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <system.webServer>
        <rewrite xdt:Transform="InsertIfMissing">
            <rules xdt:Transform="InsertIfMissing">
                <rule xdt:Locator="Match(name)" xdt:Transform="InsertIfMissing" name="Redirects umbraco.io to actual domain" stopProcessing="true">
                    <match url=".*" />
                    <conditions>
			<add input="{HTTP_HOST}" pattern="^(.*)?.euwest01.umbraco.io$" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins" />
                        <add input="{REQUEST_URI}" negate="true" pattern="localhost" />
                    </conditions>
                    <action type="Redirect" url="http://childdomain.dk/{R:0}" appendQueryString="true" redirectType="Permanent" />
                </rule>
            </rules>
        </rewrite>
    </system.webServer>
</configuration>
```

{% endcode %}

The above could either be added to its config files or be split up into one config file per setting. Umbraco Cloud will run through all the config files for the project.

* `child.web.live.xdt.config`

or having multiple files

* `child-appsettings.web.live.xdt.config`
* `child-iisrewrite.web.live.xdt.config`
* `child-smtpsettings.web.live.xdt.config`
