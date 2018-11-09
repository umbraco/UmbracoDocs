# Handling configuration files

When you are doing your normal development process, you'd just be updating the configuration files in your solution as usual. When you are working with a Baseline setup there are a few things to keep in mind.

When you are deploying updates from the Baseline project to the Child projects, all solvable merge conflicts on configuration files will be solved by using the setting on the Child project. 

That also means that if a file has been changed in both the Baseline and in the Child project, the change from the Baseline won’t be applied on the Child. To have custom settings on the Child project, you should take advantage of the vendor specific transform files. 

On Umbraco Cloud, it is possible to create transform files that will be applied to certain environments by naming them like `web.live.xdt.config` (see [Config-Transforms](../../Set-Up/Config-Transforms/)). This should be used when a Child project needs different settings than the Baseline project. 

It can be achieved by using a configuration file that is specific to the Child Project, naming it like `child.web.live.xdt.config`. This file should only be in the Child projects repository, which can be achieved by creating the file locally, and push it directly to the Child project. Read the [Working locally](../../../Set-Up/Working-Locally) article to learn more about how this is done.

Following this workflow will ensure that when the Child is updated from the Baseline, the settings won’t be overwritten.

This practice is especially important when the Baseline project gets major new functionality, like new code that is dependent on the configuration files or when upgrades are applied.

:::warning
When you need specific configuration on Child projects, you should always use config transforms. Making changes directly to the default config files on the Child project might prevent you from being able to push changes from your Baseline project in the future.
:::

# Examples
Just a few examples of what could be transformed in the child sites. 
## Adding, or updating app settings (i.e. child-appsettings.web.live.xdt.config)

```
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

## Setting the smtp settings for the child project (i.e. child-smtpsettings.web.live.xdt.config)

```
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

## Setting custom rewrite rules for the child project (i.e. child-iisrewrite.web.live.xdt.config)
```
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <system.webServer>
        <rewrite xdt:Transform="InsertIfMissing">
            <rules xdt:Transform="InsertIfMissing">
                <rule xdt:Locator="Match(name)" xdt:Transform="InsertIfMissing" name="Redirects umbraco.io to actual domain" stopProcessing="true">
                    <match url=".*" />
                    <conditions>
                        <add input="{HTTP_HOST}" pattern="^(.*)?.s1.umbraco.io$" />
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

The above could either be added to its own config files, or be split up into one config file pr. setting changed. Umbraco Cloud will run through all config files for the project.
i.e. in one file
- child.web.live.xdt.config

or having multiple files
- child-appsettings.web.live.xdt.config
- child-iisrewrite.web.live.xdt.config
- child-smtpsettings.web.live.xdt.config
