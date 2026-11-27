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

The `{environmentAlias}` part needs to be replaced with the target environment's alias. The environment alias is fetched from the environment variable named `DOTNET_ENVIRONMENT`.

You can find and manage the value of the `DOTNET_ENVIRONMENT` environment variable through the **Advanced** settings in the **Configuration** section of the Cloud Portal.

Create the files in your local project clone to ensure it's added to the repository.

When the file is deployed to the Live environment, the transforms will be applied to the `appSettings.json` file in the `Root` of your project. In the case that you have multiple mainline environments, the `appSettings.Live.json` will **only** transform the `appSettings.json` on the Live environment.

{% hint style="info" %}
If you don't have a web.config you will need to create one locally as well.
{% endhint %}

For each deployment, the Umbraco Cloud engine searches for all of the `.{environment}.json` files in your site and apply the transforms.

{% hint style="info" %}
Using config transforms to remove and/or add sections to config files is currently only possible for the `Web.config` file.
{% endhint %}

{% hint style="warning" %}
Be aware that a misconfigured config transform may [block Data Extraction on your project](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/deployments/config-tranform-failing.md).
{% endhint %}

## Syntax and testing

When creating config transforms you need to follow these three rules:

1. Use the correct file-naming convention.
2. Place the transform file in the same folder as the file you want to transform.
3. Follow the correct [Config Transform syntax](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/transform-webconfig?view=aspnetcore-5.0).

Before applying the config transform files to your environments, we recommend running a test using this tool: [Webconfig Transformation Tester](https://elmah.io/tools/webconfig-transformation-tester/).

Using the tool will let you test whether the transform file transforms your config files correctly. The tool can be used for all config files.
