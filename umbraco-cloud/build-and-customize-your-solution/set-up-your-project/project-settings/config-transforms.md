---
description: >-
  Configuration files can be transformed to match requirements on different
  Umbraco Cloud environments.
---

# Config Transforms

In this article, you will find examples of applying environment-specific configuration to your Umbraco Cloud project.

Common configuration files, like the `web.config` and `appSettings.json` files on your Umbraco Cloud project will be used as examples.

## What are Config Transforms?

Config Transforms are a way to transform your config files without changing the actual config file.

To transform a config file, you need to create a new file in your project with the following naming convention: `{config-file name}.{environmentAlias}.config`.

{% hint style="info" %}
**Legacy Umbraco**

If your project is on Umbraco 7 and 8 the naming convention is the following: `{config-file name}.{environmentAlias}.xdt.config.` Find more details on this in the [Legacy Documentation](https://github.com/umbraco/UmbracoDocs/blob/legacy-cloud/Umbraco-Cloud/Set-Up/Config-Transforms/index.md).
{% endhint %}

To transform your `appSetttings.json` file for an environment with the alias "Live", create a config transform that looks like this:

`appSettings.Live.json`

The `{environmentAlias}` part needs to be replaced with the target environments alias. The environment aliases is fetched from the environment variable named `DOTNET_ENVIRONMENT`.

You can find and manage the value of the `DOTNET_ENVIRONMENT` environment variable through the **Advanced** settings in the **Configuration** section of the Cloud Portal.

Create the files in your local project clone to ensure it's added to the repository.

When the file is deployed to the Live environment, the transforms will be applied to the `appSettings.json` file in the `Root` of your project. In the case that you have mutliple mainline environments, the `appSettings.Live.json` will **only** transform the `appSettings.json` on the Live environment.

{% hint style="info" %}
If you don't have a web.config you will need to create one locally as well.
{% endhint %}

For each deployment, the Umbraco Cloud engine searches for all of the `.{environment}.json` files in your site and apply the transforms.

{% hint style="info" %}
Using config transforms to remove and/or add sections to config files is currently only possible for the `Web.config` file.
{% endhint %}

{% hint style="warning" %}
Be aware that a misconfigured config transform may [block Data Extraction on your project](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/deployments/changes-not-being-applied.md).
{% endhint %}

## Syntax and testing

When creating config transforms you need to follow these three rules:

1. Use the correct file-naming convention.
2. Place the transform file in the same folder as the file you want to transform.
3. Follow the correct [Config Transform syntax](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/transform-webconfig?view=aspnetcore-5.0).

Before applying the config transform files to your environments, we recommend running a test using this tool: [Webconfig Transformation Tester](https://elmah.io/tools/webconfig-transformation-tester/).

Using the tool will let you test whether the transform file transforms your config files correctly. The tool can be used for all config files.

## Examples (web.config)

Rewrite rules are often something you only want to apply to your Live environment. To avoid the rewrites being applied to other mainline environments, create a transform file to apply the rewrite rules only to the Live environment.

Here is an example of how that config transform would look:

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
	<system.webServer>
		<rewrite>
			<rules>
				<rule xdt:Transform="Insert" name="Redirects umbraco.io to actual domain" stopProcessing="true">
					<match url=".*" />
					<conditions>
						<add input="{HTTP_HOST}" pattern="^(.*)?.euwest01.umbraco.io$" />
						<add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
						<add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
						<add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins" />
						<add input="{REQUEST_URI}" negate="true" pattern="localhost" />
					</conditions>
					<action type="Redirect" url="https://mycustomwebsite.com/{R:0}" appendQueryString="true" redirectType="Permanent" />
				</rule>
			</rules>
		</rewrite>
	</system.webServer>
</configuration>
```

{% hint style="info" %}
The snippet requires a `web.config` file with a matching structure; otherwise, the config transform (and subsequently, the deployment) may fail.
{% endhint %}

This config transform will add a `<rule>` to `<system.webServer><rewrite><rules>`. The `xdt:Transform` attribute is used to tell the system what to transform. In this case, the value is `Insert`, which means it will add the section if it's not already in the config file.
