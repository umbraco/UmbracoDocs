# Config Transforms

In this article you can learn how to use config transform files to apply environment specific configuration and settings to your Umbraco Cloud project.

<iframe width="800" height="450" src="https://www.youtube.com/embed/YkF2FotjWDk?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## What are Config Transforms?

Config Transforms are a way to transform your config files without changing the actual config file.

To transform a config file, you need to create a new file in the same folder with the following naming convention: `{config-file name}.{environment}.xdt.config`.

If you want to do a transform on your `web.config` file for the Live environment on your project, the config transform you need to create will look like this:

`web.live.xdt.config`

The `{environment}` part needs to be replaced with the target environment, for which there's currently 3 possibilities for each project:

1. `development`
2. `staging`
3. `live` 

This file needs to be created on a local clone of your project, as this will ensure that the file is added to the project repository.

When the file is deployed to the Live environment the transforms will be applied to the `web.config` file in the `wwwroot` folder. In the case that you also have a Development and/or Staging environment, the `web.live.xdt.config` will **only** transform the `web.config` on the Live environment.

For each deploy, the Umbraco Cloud engine searches for all of the `.{environment}.xdt.config` files in your site and apply the transforms. This means you can transform any config file, for example `~/config/Dashboard.config` by creating a `~/config/Dashboard.live.xdt.config` file. Just make sure the transform file follows the naming convention and it exists in the same folder as the config file you want to transform.

**Note**: Using config transforms to remove and/or add sections to config files is currently only possible for the `web.config` file.

## Syntax and testing

When creating config transforms you need to follow these three rules:

1. Use the correct file-naming convention
2. Place the transform file in the same folder as the file you want to transform
3. Follow the correct [Config Transform syntax](https://msdn.microsoft.com/en-us/library/dd465326)

Before applying the config transform files to your environments we recommend that you run a test using this tool: [Webconfig Transformation Tester](https://webconfigtransformationtester.apphb.com/)

Using the tool will let you test whether the transform file transforms your config files correctly. The tool can be used for all config files.

## Examples

Rewrite rules are often something you only want to apply to your Live environment. To avoid the rewrites being applied to your Development and/or Staging environments, you can create a transform file to apply the rewrite rules to your Live environment only.

Here is an example of how that config transform would look:

```
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
    <system.webServer>
        <rewrite>
            <rules>
                <rule xdt:Locator="Match(name)" xdt:Transform="InsertIfMissing" name="Redirects umbraco.io to actual domain" stopProcessing="true">
                    <match url=".*" />
                    <conditions>
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

## Forced transforms

Whenever you deploy changes to any of your environments we force some config transforms to help make sure optimal settings are set for your website. 

### Web.config forced transforms

These are the transforms we do on the root `web.config` file regardless of the custom transforms you might have specified above, we enforce these transforms always.

On live environments only:

- We set `debug="false"` on the `compilation` node in `system.web` 
- We set `mode="RemoteOnly"` on the `customErrors` node in `system.web`

On all other environments:

- We set `debug="true"` on the `compilation` node in `system.web` 
- We set `mode="Off"` on the `customErrors` node in `system.web`
- We set `waitChangeNotification="3" maxWaitChangeNotification="10"` on the `httpRuntime` node in `system.web` 
- We set `numRecompilesBeforeAppRestart="50"`  on the `compilation` node in `system.web` 
- We set the smtp `host=""` if the host was set to `127.0.0.1`


Note that for the `compilation debug` and the `customErrors mode` there is a toggle in the Umbraco Cloud portal to temporarily toggle the opposite setting. This will change the debug/customErrors mode until the next deploy to this environment on each deploy the forced transforms will be performed again.

![Toggle debug mode](images/toggle-debug.png)

## Baseline config transforms
It is possible to apply config transforms for specific child sites from a baseline. For more info see [Baseline Configuration Files documentation](https://our.umbraco.com/documentation/Umbraco-Cloud/Getting-Started/Baselines/Configuration-files/)

## Including transforms in Umbraco packages
For package developers it can be useful to add a config transform that needs to happen on each environment, for example if you're making a package called uPaintItBlack where you want to set an AppSetting in web.config. The AppSetting in `development` should be _a red door_ so you set the AppSetting value to `"red"`. On `staging` it should be _a green sea_ so you set the AppSetting to `"green"` (or to _a deeper `"blue"`_). Of course on `live` you've painted it black so you set it to `"black"`. 

In that case you can make 3 transform files, the filename needs to start with something that's specific to your plugin, it can be any word, for example `RollingStones` or `uPaintItBlack`:

- `~/uPaintItBlack.web.development.xdt.config`
- `~/uPaintItBlack.web.staging.xdt.config`
- `~/uPaintItBlack.web.live.xdt.config`

Again, these type of prefixed files can be placed next to any other file so if you also need to transform `~/config/Dashboard.config` specifically for your plugin then you can create `~/config/uPaintItBlack.Dashboard.{environment}.xdt.config`.