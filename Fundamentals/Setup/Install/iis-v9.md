---
meta.Title: "Local IIS with Umbraco 9"
meta.Description: "This article describes how to run an Umbraco 9 site on a local IIS server."
versionFrom: 9.0.0
---

# Local IIS with Umbraco 9

This is a quick guide on getting your Umbraco 9 website running locally on IIS.

The guide will assume you already have IIS configured and know your way around it, as well as having a local website you wish to host.

## Setting up prerequisites

First, you need to ensure you have "Development time IIS support installed". To check this, go to the Visual Studio installer, click modify and check on the right side under "ASP.NET and web development":

![Checking the IIS module exists](images/iis-module.png)

Once that is installed you should set up a new IIS site - and make sure to add the hostname to your hosts file as well. Here is my setup for an example:

![IIS site example](images/iis-site.png)

:::note
For the path you want to point it at the root of your site - where the `.csproj` file is.
:::

## Add new launch profile

At this point you can go to your Visual Studio solution of the site and in the `Properties` folder there is a `launchSettings.json` file, that looks like this:

```json
{
  "iisSettings": {
    "windowsAuthentication": false,
    "anonymousAuthentication": true,
    "iisExpress": {
      "applicationUrl": "http://localhost:40264",
      "sslPort": 44360
    }
  },
  "profiles": {
    "IIS Express": {
      "commandName": "IISExpress",
      "launchBrowser": true,
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    },
    "Umbraco.Web.UI.NetCore": {
      "commandName": "Project",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      },
      "applicationUrl": "https://localhost:44360;http://localhost:40264"
    }
  }
}
```

You can add a new profile called IIS, and point it at your local domain. Here it is with my example domain:

```json
{
  "iisSettings": {
    "windowsAuthentication": false,
    "anonymousAuthentication": true,
    "iis": {
      "applicationUrl": "https://testsite.local",
      "sslPort": 0
    },
    "iisExpress": {
      "applicationUrl": "http://localhost:40264",
      "sslPort": 44360
    }
  },
  "profiles": {
    "IIS Express": {
      "commandName": "IISExpress",
      "launchBrowser": true,
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    },
    "IIS": {
      "commandName": "IIS",
      "launchBrowser": true,
      "launchUrl": "https://testsite.local",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    },
    "Umbraco.Web.UI.NetCore": {
      "commandName": "Project",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      },
      "applicationUrl": "https://localhost:44360;http://localhost:40264"
    }
  }
}
```

At this point IIS will be added to the launch profiles, and you can run the site from Visual Studio by choosing IIS in the dropdown:

![Launch profiles](images/launchprofiles.png)

And finally the site is running from your local IIS:

![Local IIS site](images/voila.png)

## Alternative IIS Setup with Deploy
If you need to manually deploy you solution to another server like staging or production, it might be helpful to know some further details about IIS configuration.

You can find all the details in Mircosoft's documentation for Asp.Net Core IIS hosting. But here are some key points:

### IIS Application pool
Compared to *.Net Framework* websites IIS works more like a revers proxy. The application pool e.g. needs to use unmanaged code.

![IIS Application Pool](images/iis-app-pool-core.png)

### EnvironmentVariables in ApplicationHost.config
You see *.Net 5 / Core* have less *GUI* modules for configuration:

![IIS Website Configuration](images/iis-core-website-confi.png)

In the *Management* section you find the *Configuration Editor*:

![IIS Configuration Editor](images/iis-environmentVariables.png)

One section is of particular interest.
- In the first, left hand dropdown list (*Section:*) choose: system.webServer/aspNetCore section.
- In the second, right hand dropdown list (*From:*) choose: `ApplicationHost.config <location path='[YOUR-SITENAME]'>`. This ensures your settings get stored in a machine specific file and not the website's web.config. The web.config might end in a public repository and should not contain sentitive data like ConnectionStrings or SMTP configuration with username and password. And by default the web.config will be overwritten during publish process.

For line *environmentVariables* open the next dialog to add environment variables. These work similar to the *launchSettings*. E.g. you can define ASPNETCORE_ENVIRONMENT and create an `appSettings.[ASPNETCORE_ENVIRONMENT].json` file. Or even better create environment variables for sensitive settings like passwords. There are to differences to `launchSettings.json` configuration:
- Variable names need to change the object-dot-structur form json by replacing dots by double underscore `__`
- escaped backslashes `\\` e.g. `serverName\\databaseInstanceName` are preplaced by single backslash `\`

### Publish website
You can use i.e. folder or ftp publishing to get all the files you need for your website hosting. In Visual Studio right click on umbraco web project of the *Solution Explorer* and choose *Publish...* command.
![Publish...](images/contextmenu-publish-command.jpg)
### Hosting Bundle
On your development machine you normally get the latest .Net SDKs when you update your Visual Studio IDE. But on a hosting server you might have not the right framework installed. In general you have to install so called hostng bundles for .Net Core. Find details on:
- https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/hosting-bundle
- https://dotnet.microsoft.com/download/dotnet/
