
# Troubleshooting deployments

Issues with deployments on Umbraco Cloud often come down to a misunderstanding on how to work with Umbraco Cloud. It is important to always work left to right as mentioned [here](../../deployment/README.md).

There are two ways to deploy on Umbraco Cloud, a deployment that transfers content and media:

1. A Content [Transfer](../../deployment/content-transfer.md) / [Restore](../../deployment/restoring-content/README.md)
1. A [Deployment](../../deployment/cloud-to-cloud.md) that transfers structure files (doc types, data types, templates, dll's, etc.)

There are some common errors associated with both of these. Most of the time it is caused by conflicting [UDA files](../../set-up/power-tools/generating-uda-files.md#what-are-uda-files) between the two environments you are deploying between.

The most common [Deployment](../../deployment/cloud-to-cloud.md) issues are listed below with guides on how to fix them:

* [Collision Errors](structure-error.md)
* [Dependency Exception](dependency-exceptions.md)
* [Colliding Data Types](colliding-datatypes.md)
* [Language Mismatch](language-mismatch.md)
* [Deployment Failed (with no error message)](deployment-failed.md)
* [Changes not being applied](changes-not-being-applied.md)

The most common Content [Transfer](../../deployment/content-transfer.md) / [Restore](../../deployment/restoring-content/README.md) issues are listed below:

* [Schema mismatch](schema-mismatches.md)
* [SQL Timeouts](../../../umbraco-deploy/deploy-settings.md#timeout-issues)
* [Dependency Exception](dependency-exceptions.md)
* [Media path too long](path-too-long-exception.md)

## Issues with .net 7 deployments between local and envs

If your deployment output has build errors targeting a preview / RC version of .NET 7, you can follow these steps to mitigate the issue.

Here is an example of the error:

```json
2022-11-02T08:51:15.8227420Z,An error has occurred during web site deployment.,,0
	2022-11-02T08:51:15.8227420Z,App: C:\Program Files (x86)\dotnet\sdk\7.0.100-rc.1.22431.12\dotnet.dll,,1
	2022-11-02T08:51:15.8383691Z,Architecture: x86,,1
	2022-11-02T08:51:15.8539900Z,Framework: 'Microsoft.NETCore.App'&comma; version '7.0.0-rc.1.22426.10' (x86),,1
	2022-11-02T08:51:15.8696174Z,.NET location: C:\Program Files (x86)\dotnet\,,1
	2022-11-02T08:51:15.8852458Z,,,1
	2022-11-02T08:51:15.8852458Z,The following frameworks were found:,,1
	2022-11-02T08:51:15.9008639Z,  1.0.16 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:15.9164961Z,  1.1.13 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:15.9321217Z,  2.0.9 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:15.9477424Z,  2.1.30 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:15.9633695Z,  2.2.14 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:15.9789895Z,  3.0.3 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:15.9946178Z,  3.1.28 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:16.0102429Z,  3.1.29 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:16.0258680Z,  5.0.15 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:16.0414921Z,  5.0.17 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:16.0414921Z,  6.0.8 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:16.0571182Z,  6.0.9 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App],,1
	2022-11-02T08:51:16.0728022Z,,,1
	2022-11-02T08:51:16.0883709Z,Learn about framework resolution:,,1
	2022-11-02T08:51:16.1039924Z,https://aka.ms/dotnet/app-launch-failed,,1
	2022-11-02T08:51:16.1196189Z,,,1
	2022-11-02T08:51:16.1352444Z,To install missing framework&comma; download:,,1
	2022-11-02T08:51:16.1509492Z,https://aka.ms/dotnet-core-applaunch?framework=Microsoft.NETCore.App&framework_version=7.0.0-rc.1.22426.10&arch=x86&rid=win10-x86,,1
	2022-11-02T08:51:16.1821221Z,You must install or update .NET to run this application.\r\n\r\nApp: C:\Program Files (x86)\dotnet\sdk\7.0.100-rc.1.22431.12\dotnet.dll\r\nArchitecture: x86\r\nFramework: 'Microsoft.NETCore.App'&comma; version '7.0.0-rc.1.22426.10' (x86)\r\n.NET location: C:\Program Files (x86)\dotnet\\r\n\r\nThe following frameworks were found:\r\n  1.0.16 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  1.1.13 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  2.0.9 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  2.1.30 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  2.2.14 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  3.0.3 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  3.1.28 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  3.1.29 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  5.0.15 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  5.0.17 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  6.0.8 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n  6.0.9 at [C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App]\r\n\r\nLearn about framework resolution:\r\nhttps://aka.ms/dotnet/app-launch-failed\r\n\r\nTo install missing framework&comma; download:\r\nhttps://aka.ms/dotnet-core-applaunch?framework=Microsoft.NETCore.App&framework_version=7.0.0-rc.1.22426.10&arch=x86&rid=win10-x86\r\nC:\Program Files (x86)\SiteExtensions\Kudu\98.40824.5897\bin\Scripts\starter.cmd C:\home\SiteExtensions\Umbraco.Cloud.Deployment.SiteExtension.Artifacts.Core\deploy.cmd,,2
2022-11-02T08:51:16.9321330Z,Deployment Failed.,133sa799-q231-c92a-a244-afa18e1c2b1f,0
```

:::note
A future release will mitigate this issue.
:::

### Steps to fix the issue

1. Clone down your Development environment. If you only have a Live environment, then proceed with that  
2. Add a global.json to root of the project. Your structure should look like this:

    ```html
    .git
    src/
    .dockerignore
    .editorconfig
    .gitattributes
    .gitignore
    .umbraco
    global.json
    NuGet.config
    Readme.md
    ```

3. Open the global.json file and add the following:

    ```json
    {
        "sdk": {
        "version": "6.0.401"
        }
    }
    ```

4. Save the file.
5. Add, commit and push the file to the environment.

This will force the Azure build service to target version 6.0.401 of the .net sdk for your project. Your env will be able to deploy again.
You will not need to add the same file to your other environments. As source control will take care of adding it in when you deploy it between your development, staging or live environments.

When you have done the above steps you will no longer see deployment issues with .net 7-preview or rc.
