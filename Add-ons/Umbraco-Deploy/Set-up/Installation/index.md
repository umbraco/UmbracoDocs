---
versionFrom: 8.0.0
---

# Installing Umbraco Deploy

In this article we will cover the steps in order for you to install Umbraco deploy on a brand new website.

We will cover how to install Umbraco deploy and set up Umbraco deploy on your website as well as how you can set up a CI/CD build server using Github actions to run the deployment process.

## Prerequisites

* Umbraco 8

* Visual studio 2017 v15.9.6 or later

* Git and Github repository

* CI/CD or Build Server that supports executing Powershell

* SQL Server Database

## Installing Umbraco Deploy on a new site

In this guide we will show how you can install Umbraco Deploy on a brand new site and set up Umbraco Deploy using Github actions

:::note
Do note that in this guide we are hosting the site on Azure Web Apps and using Github actions to set up the CI/CD build server, however you are free to choose the hosting provider and CI/CD pipeline that you prefer,
as long as it supports executing Powershell scripts
:::

## Installation steps

1. set up Git repository and Umbraco project
2. Install Umbraco Deploy via NuGet
3. Generate Umbraco Deploy API Key
4. Add the key in the app settings appSettings
5. Configure the UmbracoDeploy.config
6. Configure your CI/CD build server

### Set up Git repository and Umbraco project

The first step to get Umbraco Deploy up and running is to set up a  Github repository which will act as our environment where we will set up a CI/CD pipeline that will run the build server to Azure Web and new Umbraco project through Visual [studio](https://our.umbraco.com/documentation/Getting-Started/Setup/Install/install-umbraco-with-nuget).

When setting up the Github repository add a Gitignore file using the Visual Studio template once we have installed the Umbraco project we will add some Umbraco and Umbraco deploy specific files that we want to get ignored.

Once the Github repository have been created, clone it down to your local machine.

Once it have been cloned down install the Umbraco project in the repository folder so it will be picked up by Git.

Once the project have been created in the repository, run the project and install Umbraco 8 run through the installer with a Custom SQL connection string to a local database.

Once the installation is done, navigate to the data folder using a command prompt and run an echo > deploy which will trigger the UDA schema to be installed

### Installing and setting up Umbraco Deploy

When we have installed our umbraco project in the Github repository, we can go ahead and install Umbraco Deploy in our project.

To install Umbraco deploy, in Visual Studio, go to the NuGet Package Manager and search for "UmbracoDeploy" and install it in the Visual Studio solution.

Once the installation have finished You might notice a new file in your config folder called UmbracoDeploy.config. This files tells the deployment engine where to deploy to, it knows which environment you’re currently on (for example local or staging) and chooses the next environment in the list to deploy to.

Once Umbraco Deploy have been installed, to be able to use it in the project we will need to add the following AppSetting to the Web.Config of the project:

```
<add key="Umbraco.Deploy.ApiKey" value="YourAPIKeyHere" /> 
```

In the AppSetting we need to populate the value with with your own Deploy API Key.

The following code snippet can be used to generate a random key, using a tool like LinqPad:
```
public string GetRandomKey(int bytelength)
{
   byte[] buff = new byte[bytelength];
   RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
   rng.GetBytes(buff);
   StringBuilder sb = new StringBuilder(bytelength * 2);
   for (int i = 0; i < buff.Length; i++)
       sb.Append(string.Format("{0:X2}", buff[i]));
   return sb.ToString();
}
```

This same setting/key must be used on each environment for the same website.

::note
We strongly advise to generate different keys for different websites
:::

Once the AppSetting and API key have been added, it is now time to configure our environments in the UmbracoDeploy.config which is used to define the environments that we have for our Umbraco Deploy installation.




## Installing Umbraco Deploy on existing site

<!--![clone dialog](images/umbraco-deploy-config.png)

**Note**: you’re free to update the “name” attribute to make it clearer in the interface where you’re deploying to. So if you want to name “Development” something like “The everything-goes area” then you can do that and it will be shown when deploying to that environment.
-->


This problem is a bit tricky to spot.

the only indication is that changes you made on the source environment are not being applied, even though the deployment was complete.

Although when pushing from local you might get a warning message