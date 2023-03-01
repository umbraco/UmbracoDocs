---
versionFrom: 7.0.0
versionTo: 8.0.0
---

# Config Transforms

In this article you can learn how to use config transform files to apply environment specific configuration and settings to your Umbraco Cloud project.

<iframe width="800" height="450" title="How to use config transforms on Umbraco Cloud" src="https://www.youtube.com/embed/SBDRR9CNvdY" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## What are Config Transforms?

Config Transforms are a way to transform your config files without changing the actual config file.

To transform a config file, you need to create a new file in the same folder with the following naming convention: `{config-file name}.{environment}.xdt.config`.

If you want to do a transform on your `Web.config` file for the Live environment of your project, the config transform you need to create will look like this:

`Web.live.xdt.config`

The `{environment}` part needs to be replaced with the target environment, for which there are currently 3 possibilities for each project:

1. `development`
2. `staging`
3. `live`

This file needs to be created on a local clone of your project, as this will ensure that the file is added to the project repository.

When the file is deployed to the Live environment the transforms will be applied to the `Web.config` file in the `wwwroot` folder. In the case that you also have a Development and/or Staging environment, the `Web.live.xdt.config` will **only** transform the `Web.config` on the Live environment.

For each deploy, the Umbraco Cloud engine searches for all of the `.{environment}.xdt.config` files in your site and applies the transforms. This means you can transform any config file, for example `~/config/Dashboard.config` by creating a `~/config/Dashboard.live.xdt.config` file. Make sure the transform file follows the naming convention and it exists in the same folder as the config file you want to transform.

:::note
Using config transforms to remove and/or add sections to config files is currently only possible for the `Web.config` file.
:::

## Syntax and testing

When creating config transforms you need to follow these three rules:

1. Use the correct file-naming convention
2. Place the transform file in the same folder as the file you want to transform
3. Follow the correct [Config Transform syntax](https://msdn.microsoft.com/en-us/library/dd465326)

Before applying the config transform files to your environments we recommend that you run a test using this tool: [Webconfig Transformation Tester](https://elmah.io/tools/webconfig-transformation-tester/)

Using the tool will let you test whether the transform file transforms your config files correctly. The tool can be used for all config files.

## Examples

Rewrite rules are often something you only want to apply to your Live environment. To avoid the rewrites being applied to your Development and/or Staging environments, you can create a transform file to apply the rewrite rules to your Live environment only.

Here is an example of how that config transform would look:

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <system.webServer>
        <rewrite xdt:Transform="InsertIfMissing">
            <rules>
                <rule xdt:Locator="Match(name)" xdt:Transform="InsertIfMissing" name="Redirects umbraco.io to actual domain" stopProcessing="true">
                    <match url=".*" />
                    <conditions>
                        <add input="{HTTP_HOST}" pattern="^(.*)?.euwest01.umbraco.io$" />
                        <add input="{HTTP_HOST}" pattern="^(.*)?.s1.umbraco.io$" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
                        <add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins" />
                        <add input="{REQUEST_URI}" negate="true" pattern="localhost" />
                    </conditions>
                    <action type="Redirect" url="http://swato.dk/{R:0}" appendQueryString="true" redirectType="Permanent" />
                </rule>
            </rules>
        </rewrite>
    </system.webServer>
</configuration>
```

This config transform will add a new `<rule>` to `<configuration><system.webServer><rewrite><rules>`. The `xdt:Transform` attribute is used to tell the system what to transform. In this case the value is `InsertIfMissing`, which means it will add the section if it's not already in the config file. In order to be able to identify the correct section the `xdt:Locator` attribute is used to *match* the value of the `name` attribute.

## The default Umbraco Cloud config transform

Umbraco Cloud projects Comes by default with a config transform called `https.web.live.xdt.config`.

This config transform is used to ensure that the live site will be running via HTTPS and force redirects from HTTP to HTTPS.

It does so by setting the "umbracoUseSSL" setting to true, which will tell the Umbraco Backoffice to serve URLs via HTTPS
and it adds a redirect rule that will force the site to run via HTTPS, except for when running localhost.

To disable the forced HTTPS, simply remove this file from your repository. This is not advised, as all domains
on Umbraco Cloud will be running HTTPS, as a certificate will be issued for custom domains by the Automatic TLS feature, and all [alias].euwest01.umbraco.io domains will already be protected.

## Forced transforms

Whenever you deploy changes to any of your environments we force some config transforms to help make sure optimal settings are set for your website.

### Web.config forced transforms

These are the transforms we do on the root `Web.config` file regardless of the custom transforms you might have specified above, we enforce these transforms always.

On live environments only:

- We set `debug="false"` on the `compilation` node in `system.web`
- We set `mode="RemoteOnly"` on the `customErrors` node in `system.web`

On all other Cloud environments:

- We set `debug="true"` on the `compilation` node in `system.web`
- We set `mode="Off"` on the `customErrors` node in `system.web`
- We set `waitChangeNotification="3" maxWaitChangeNotification="10"` on the `httpRuntime` node in `system.web`
- We set `numRecompilesBeforeAppRestart="50"`  on the `compilation` node in `system.web`
- We set the smtp `host=""` if the host was set to `127.0.0.1`

:::note
For the `compilation debug` and the `customErrors mode` there is a toggle in the Umbraco Cloud portal to temporarily toggle the opposite setting. This will change the debug/customErrors mode until the next deploy to this environment. On each deploy the forced transforms will be performed again.
:::

![Toggle debug mode](images/toggle-debug.png)

## Baseline config transforms

It is possible to apply config transforms for specific child sites from a baseline. For more info see [Baseline Configuration Files documentation](https://our.umbraco.com/documentation/Umbraco-Cloud/Getting-Started/Baselines/Configuration-files/)

## Including transforms in Umbraco packages

For package developers it can be useful to add a config transform that needs to happen on each environment. As an example, let's say we're making a package called **EnvironmentColor**. You want to set an AppSetting in `Web.config` to a different color in each environment. It could be be `red` for the Live environment, `orange` for Staging and `yellow` for Development.

We need to create 3 transform files named after the package. A good convention is to use your company name and the package name to make sure that there won't be any clashes on the filenames. We'll use the name **AcmeEnvironmentColor**:

- `~/AcmeEnvironmentColor.Web.development.xdt.config`
- `~/AcmeEnvironmentColor.Web.staging.xdt.config`
- `~/AcmeEnvironmentColor.Web.live.xdt.config`

Again, these types of prefixed files can be placed next to any other file so if you also need to transform `~/config/Dashboard.config` specifically for your package, then you can create three transform files for that as well, e.g.:

- `~/config/AcmeEnvironmentColor.Dashboard.development.xdt.config`
- `~/config/AcmeEnvironmentColor.Dashboard.staging.xdt.config`
- `~/config/AcmeEnvironmentColor.Dashboard.live.xdt.config`

:::note
Keep in mind that a misconfigured config transform may block Data Extraction on your project. Please see [here](../../Troubleshooting/Deployments/Changes-Not-Being-Applied) for more details.
:::
