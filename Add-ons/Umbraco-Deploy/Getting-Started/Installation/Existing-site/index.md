---
versionFrom: 8.0.0
---

# Installing Umbraco Deploy

In this article, we will cover the steps in order for you to install Umbraco deploy on your already existing website with content

We will cover how to install Umbraco deploy and set up Umbraco deploy on your website and how you can generate the UDA files, as well as show an example as to how it can be set up as a CI/CD build server using Github actions to run the deployment on a website set up with Azure web Apps.

## Prerequisites

* Umbraco 8

* Visual studio 2017 v15.9.6 or later

* Copy of your production site's database

* Copy of views, css and scripts folder from production

* Git and a repository

* CI/CD or Build Server that supports executing Powershell

* SQL Server Database

## How to install Umbraco Deploy on an existing project

In this guide we will show how you can install Umbraco Deploy on your already existing website.

## Installation steps

1. [Create copy of database and download views,css and scripts files from your production site](#Install-Umbraco-Deploy-on-Existing-site)
2. [Set up Git repository and new Umbraco project](#Set-up-Git-repository-and-Umbraco-project)
3. [Install Umbraco Deploy via NuGet](#Installing-and-setting-up-Umbraco-Deploy)
4. [Configure CI/CD build server](#Setting-up-CI/CD-build-server-with-Github-actions)

## Install Umbraco Deploy on Existing site

To install Umbraco Deploy on an already existing site there is some additional steps that needs to be done to make sure that Umbraco Deploy can run with your website.

Since on an existing Umbraco website, there is already created document types, templates and data-types with ID's in the database, you will need to make sure that they are in sync between the different environments that you want to add.

The first step is to take a copy of the production site's database, when Deploy is installed then the ID's will be identical between the production site and the environments you add.

The next step is to make sure to download your view folder, css and scripts folder so you will have your view files and styles from your production website.

When the production database and the view, css and script files have been copied down, we can now start to set up a git repository and a new Umbraco project.

### Set up Git repository and Umbraco project

The next step is to set up a repository which will act as one of our environment and a empty Umbraco project.

For Umbraco Deploy to be able to work a CI/CD pipeline from the repositpry which will run the build server to your hosted website.

a new Umbraco project needs to be installed through Visual [studio](https://our.umbraco.com/documentation/Getting-Started/Setup/Install/install-umbraco-with-nuget).

When setting up a repository add a Gitignore file using the Visual Studio template.
Once the Umbraco project is installed we will add some Umbraco and Umbraco deploy specific files that we want to ignore when we deploy.

Clone down  the repository to your local machine.

When it have been cloned down install the clean Umbraco project in the repository folder so it will be tracked by Git.

Once the project have been created, run the project and install Umbraco 8, when promted to choose a database make sure to use the copy of your production website

When Umbraco have been installed in the repository add the view, css and script folder from your production website as well.

make sure to commit the files to so they are ready to be pushed up once a CI/CD pipeline have been set up.

After the Umbraco files have been commited add the following files to the Gitignor so that they will not be picked up by Git when we are deploying and commit it to the repository as well:

```none
**/App_Data/*
!**/App_Data/packages
**/media/*

# Umbraco deploy specific
**/data/deploy*
```

### Installing and setting up Umbraco Deploy

When Umbraco have been installed in a repository, we can go ahead and install Umbraco Deploy in the project.

To install Umbraco deploy, in Visual Studio, go to the NuGet Package Manager and search for "UmbracoDeploy" and install it in the Visual Studio solution.

Once the installation have finished You might notice a new file in your config folder called UmbracoDeploy.config. This files tells the deployment engine where to deploy to, it knows which environment you’re currently on (for example local or staging) and chooses the next environment in the list to deploy to.

To be able to use Umbraco Deploy in the project we will need to add the following AppSetting to the Web.Config of the project:

```xml
<add key="Umbraco.Deploy.ApiKey" value="YourAPIKeyHere" /> 
```

In the AppSetting we need to populate the value with with our own Deploy API Key.

The following code snippet can be used to generate a random key, using a tool like LinqPad

```C#

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

Once the AppSetting and API key have been added, it is now time to configure the environments in the UmbracoDeploy.config which is used to define the environments that we have for an Umbraco Deploy installation.

The Config file will look something like this:

```xml

<?xml version="1.0" encoding="utf-8"?>
<environments xmlns="urn:umbracodeploy-environments">
  <environment type="development" 
    name="Development" 
    id="00000000-0000-0000-0000-000000000000">http://development/
  </environment>
  <environment type="staging"
    name="Staging" 
    id="00000000-0000-0000-0000-000000000000">http://staging/
   </environment>
  <environment type="live" 
    name="Live" 
    id="00000000-0000-0000-0000-000000000000">http://live/
  </environment>
</environments>


```

You will need to generate a unique GUID Id for each environment, this can be done in Visual studio or how you prefer to do it.

The “Type” is for informational purposes in the backoffice but in most cases will be the same (lowercased) value of the Name.

The URLs for each environment needs to be accessible by the other environments over **HTTPS**.

:::note you’re free to update the “name” attribute to make it clearer in the interface where you’re deploying to. So if you want to name “Development” something like “The everything-goes area” then you can do that and it will be shown when deploying to that environment.
:::

Once the installation is done, navigate to the backoffice go to the deploy dashboard in the settings section:

![Deploy section](images/Deploy-section.png)

run the  **```Schema Deployment From Data Files```** operation which will trigger the UDA schema to be generated based of our database from production:

 ![Schema Deployment From Data Files](images/Deploy-operation.png)

 Once the deployment operation have finished,  take a look in either your git client or in the data > revision folder, you can now see that that it have generated the UDA-files based on our schema in the database:

 ![Generated UDA files](images/Generated-uda-files.png)

Umbraco Deploy have now been installed on the project, go ahead and commit the files to the repository.

Make sure to not push the files up yet as a CI/CD build server will first need to be set up and connected to the repository.

When pushing the commit up the build server will run and build our solution into where you are hosting your website.

### Set up CI/CD build server

Once Umbraco Deploy have been installed and the meta data have been generated, a CI/CD build server needs to be set up.

THis can be done in many different ways depeding of where your website is hosted.

Umbraco Deploy will work out of the box with any CI/CD or Build Server that supports executing Powershell (which will be all build servers that support .NET) like Azure DevOps or Github actions.

Once the build server have been set up you can now start creating content and sync it between your website and environments, make sure to follow the proper [deployment workflow](../../../Deployments).

Once Meta data is created the changes will be picked up in Git and, once done with making changes, the files can be committed and deployed to a repository, once the build server is started it will extract the changes that was pushed to the repository into your production website that have been connected with Umbraco Deploy.

This will only deploy the meta data, transfer of content and media will need to be done from the backoffice of your project using the queue for transfer [feature](../Content-Transfer).
