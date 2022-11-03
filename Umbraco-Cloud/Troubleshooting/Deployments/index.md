---
versionFrom: 7.0.0
versionTo: 10.0.0
---

# Troubleshooting deployments

Issues with deployments on Umbraco Cloud often come down to a misunderstanding on how to work with Umbraco Cloud. It is very important to always work left to right as mentioned [here](../../Deployment).

There are two ways to deploy on Umbraco Cloud, a deployment that transfers content and media:

1. A Content [Transfer](../../Deployment/Content-Transfer) / [Restore](../../Deployment/Restoring-content)
1. A [Deployment](../../Deployment/Cloud-to-Cloud) that transfers structure files (doc types, data types, templates, dll's, etc.)

There are some common errors associated with both of these, most of the time it is caused by conflicting [UDA files](../../Set-Up/Power-Tools/generating-uda-files/#what-are-uda-files) between the two environments you are deploying between.

The most common [Deployment](../../Deployment/Cloud-to-Cloud) issues are listed below with guides on how to fix them:

* [Collision Errors](Structure-Error)
* [Dependency Exception](Dependency-Exceptions)
* [Colliding Data Types](Colliding-Datatypes)
* [Language Mismatch](Language-Mismatch)
* [Deployment Failed (with no error message)](Deployment-Failed)
* [Changes not being applied](Changes-Not-Being-Applied)  

The most common Content [Transfer](../../Deployment/Content-Transfer) / [Restore](../../Deployment/Restoring-content) issues are listed below:

* [Schema mismatch](Schema-Mismatches)
* [SQL Timeouts](../../Deployment/Deploy-Settings/#timeout-issues)
* [Dependency Exception](Dependency-Exceptions)
* [Media path too long](Path-too-long-exception)
* [An existing connection was forcibly closed by the remote host](Connection-Forcibly)

## Issues when using third-party packages

If you experience problems when using third-party packages on Umbraco Cloud there is a chance they are not compatible with Umbraco Cloud. Packages that add custom editors will need a Value Connector set up to work with Umbraco Deploy. Some of the most used packages out there have been included in the Community driven Umbraco Deploy Contrib project. You can include the Contrib dll in your project to help with a lot of them.

To see a list of packages covered look [here](https://github.com/umbraco/Umbraco.Deploy.Contrib).

## Issues with .net 7 deployments between local and envs.

If you are experiencing an issue where in your deployment output you are seeing build errors targeting a preview / RC version of .net 7 then you can follow these steps to mitigate the issue. 
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
### steps to fix the issue
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