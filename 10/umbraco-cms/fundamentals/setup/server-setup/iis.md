---
meta.Title: Hosting v9+ in IIS
description: Information on hosting Umbraco v9+ on IIS
---

# Hosting Umbraco in IIS

## Configuring IIS for .NET 5

* Install the [".NET Core Runtime"](https://dotnet.microsoft.com/en-us/download/dotnet/) and download the **Hosting Bundle**. Ensure you download the correct .NET version as per the [requirements](../requirements.md).
* Once you have the hosting bundle installed and have restarted IIS (`net stop was /y` followed by `net start w3svc`), create a site in IIS as you would for a v8 site, however you need to ensure that ".NET CLR version" is set to "No Managed Code" for the Application Pool.

![IIS Application Pool](images/iis-app-pool-core.png)

### Publish website for manual deployment to IIS

You can use the dotnet CLI to compile and collate all files required for hosting

```none
dotnet publish -o ../deployment-artefacts -f net5.0
```

Alternatively you can use folder or ftp publishing in Visual Studio to compile and collate all required files to for the application to run.

In Visual Studio right click on Umbraco web project in the _Solution Explorer_ and choose _Publish..._ command.

![Publish...](images/contextmenu-publish-command.jpg)

{% hint style="info" %}
**Deploy a website for automated deployment with Azure DevOps to IIS**

You can use the [IIS Release task in Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/pipelines/release/deploy-webdeploy-iis-deploygroups) to deploy your website to your Web Server. This task is a wrapper for `MSDeploy.exe` and can be configured as preferred.
{% endhint %}

### Environment Variables in ApplicationHost.config

In the _Management_ section you find the _Configuration Editor_:

![IIS Website Configuration](images/iis-core-website-config.png)

One section is of particular interest:

* In the first, left hand dropdown list (_Section:_) choose: `system.webServer/aspNetCore` section.
* In the second, right hand dropdown list (_From:_) choose: `ApplicationHost.config <location path='[YOUR-SITENAME]'>`. This ensures your settings will be stored in a machine specific file and not the website's web.config. The web.config might end in a public repository and should not contain sensitive data like Connection Strings or SMTP configuration with username and password. Additionally by default the web.config will be overwritten during each publish processes.

![IIS Configuration Editor](images/iis-environment-variables.png)

Find the line named _environmentVariables_ and open the dialog to add environment variables. These work similar to the _launchSettings_. E.g. you can define `ASPNETCORE_ENVIRONMENT` and create an `appSettings.[ASPNETCORE_ENVIRONMENT].json` file. Or even better create environment variables for sensitive settings like passwords. There are some differences to `launchSettings.json` configuration:

* Variable names need to change the object structure form JSON by combining the segments with double underscore `__` e.g. `ConnectionStrings__umbracoDbDSN`
* escaped backslashes `\\` e.g. `serverName\\databaseInstanceName` are replaced by single backslash `\` e.g. `DATABASESERVER123\SQL2017`

### IIS Hosting models

IIS can host .NET 5 applications using 2 different hosting models

* [In-process (default)](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/in-process-hosting?view=aspnetcore-5.0)
* In-process hosting runs an .NET 5 app in the same process as its IIS worker process
* [Out-of-process](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/out-of-process-hosting?view=aspnetcore-5.0) - to enable this model you need to edit your .csproj file and add:

```js
<PropertyGroup>
  <AspNetCoreHostingModel>OutOfProcess</AspNetCoreHostingModel>
</PropertyGroup>
```

Out-of-process .NET 5 apps run in a separate from the IIS worker process. The module controls the management of the Kestrel server and requests are proxied between them.
