---
versionFrom: 8.0.0
---

# Installing Umbraco Deploy

In this article, we will cover the steps in order for you to install Umbraco deploy on a brand new website.

We will cover how to install Umbraco deploy and set up Umbraco deploy on your website as well as show an example as to how it can be set up as a CI/CD build server using Github actions to run the deployment on a website set up with Azure Web Apps.

## Prerequisites

* Visual studio 2017 v15.9.6 or later

* SQL Server Database

## How to install Umbraco Deploy

In this guide we will show how you can install Umbraco Deploy and set up a build server using Github actions to deploy your content.

:::note
In this example we are hosting the site on Azure Web Apps, using Github actions to set up the CI/CD build server, however you are free to choose the hosting provider and CI/CD pipeline that you prefer,
as long as it supports executing Powershell scripts it will work with Umbraco Deploy.
:::

## Installation steps

1. [Set up Git repository and new Umbraco project](#Set-up-Git-repository-and-Umbraco-project)
2. [Install Umbraco Deploy via NuGet](#Installing-and-setting-up-Umbraco-Deploy)
3. [Configure CI/CD build server](#Setting-up-CI/CD-build-server-with-Github-actions)

### Set up Git repository and Umbraco project

The first step to get Umbraco Deploy up and running is to set up a  Github repository which will act as our environment where we will set up a CI/CD pipeline that will run the build server to Azure Web Apps and new Umbraco project through [Visual Studio](https://our.umbraco.com/documentation/Getting-Started/Setup/Install/install-umbraco-with-nuget).

1. Set up a Github repository with a .gitignore file using the Visual Studio template.
2. Clone down the repository to your local machine.
3. Create a new Visual Studio project in the repository folder.
4. Install Umbraco CMS through NuGet - `Install-Package UmbracoCms`.
5. Run the project.
6. Choose to use a custom SQL connectionstring pointing to your local database.
7. Commit the files to so they are ready to be pushed up once we have set up the build server.

After the Umbraco files have been committed add the following lines to the .gitignore so that they will not be picked up by Git when we are deploying.

```none
**/App_Data/*
!**/App_Data/packages
**/media/*

# Umbraco deploy specific
**/data/deploy*
```

Make sure that the updates to the .gitignore file are also committed.

### Installing and setting up Umbraco Deploy

When Umbraco has been installed in a repository, we can go ahead and install Umbraco Deploy in the project.

To install Umbraco deploy in Visual Studio, you can either go to the NuGet Package Manager and search for ```UmbracoDeploy.OnPrem``` or run ```Install-Package UmbracoDeploy.OnPrem``` via the Package Manager.

Once the installation has finished you might notice a new file in your `/config` folder called `UmbracoDeploy.config`. This files tells the deployment engine where to deploy to. It knows which environment you’re currently on (for example local or staging) and it will choose the next environment in the list to deploy to.

When Umbraco Deploy has been installed, to be able to use it in the project you will need to add the following `appSetting` to the `web.config` of the project:

```xml
<add key="Umbraco.Deploy.ApiKey" value="YourAPIKeyHere" /> 
```

The `Umbraco.Deploy.ApiKey` value needs to be replaced with your own Deploy API key.

The following code snippet can be used to generate a random key, using a tool like LinqPad.

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

This same Deploy API key must be used on each environment for the same website.

:::note
We strongly recommend to generate different keys for different websites.
:::

Once the `appSetting` and API key have been added, it is now time to configure the environments in the `UmbracoDeploy.config` file.

The config file will look like this:

```xml

<?xml version="1.0" encoding="utf-8"?>
<environments xmlns="urn:umbracodeploy-environments">
  <environment type="development" 
    name="Development" 
    id="00000000-0000-0000-0000-000000000000">
      http://development/
  </environment>
  <environment type="staging"
    name="Staging" 
    id="00000000-0000-0000-0000-000000000000">
      http://staging/
   </environment>
  <environment type="live" 
    name="Live" 
    id="00000000-0000-0000-0000-000000000000">
      http://live/
  </environment>
</environments>


```

You will need to generate a unique GUID for each environment. This can be done in Visual Studio:

1. Open "Tools".
2. Select "Create GUID".
3. Use the Registry Format.
4. Copy the GUID into the `id` value.
5. Generate a "New GUID" for each environment you will be adding to your setup.

The `type` value is for informational purposes in the backoffice but in most cases will be the same (lowercased) value of the Name.

The URLs for each environment needs to be accessible by the other environments over **HTTPS**.

:::note You're free to update the `name` attribute to make it clearer in the interface where you're deploying to. So, if you want to name “Development” something like “The everything-goes area” then you can do that and it will be shown when deploying to that environment.
:::

Once the configuration has been set up with the correct information we can now go ahead and make sure that the source control is including our files in the `~/data` folder of our Umbraco project.

This can be done by going to the `~/data/revision` folder of the project and create a test UDA file, and then check in either your Git GUI or in the command line and verify whether the test file is being tracked.

:::tip
If you do not see a `/data` folder in the root of your project, you might need to start up the project first.
:::

![Test UDA file](images/test-UDA.png)

We can see that the file has been created and it is being tracked by Git and we can go ahead and delete the test file.

Now that Umbraco Deploy has been installed on the project, we can go ahead and commit the files to the repository.

**Do not push the files up yet** as a CI/CD build server will first need to be set up and connected to our a repository.

#### Include your Umbraoc Deploy license file

Before moving on to setting up the build server, make sure that your license is included in your project.

The file needs to be placed in the `/bin` folder.

### Setting up CI/CD build server with Github actions

:::note
In this example we will show how you can set up a CI/CD build server using Github Actions in Azure Web Apps.

We will not cover how you can set up the site itself as this is beyond this documentation.
:::

To set up the build server in Azure Web Apps, we need to go to the Azure portal and find the empty website that we have set up and want to connect to.

1. Go to the Deployment Center.

![Azure deployments](images/Deployment-center.png)

In the Deployment Center we can set up the CI/CD build server. In this example we are going to set up our build server by using Github Actions. You can set up the build server however you want as long as it supports executing powershell scripts.

2. Go to the Settings tab.
3. Choose which source and build provider to use.
    * In this case we want to choose Github.

![Build server clean](images/Build-server-clean.png)

4. Choose the Organization which you created our Github repository under.
5. Choose the repository that was set up earlier in this guide.
6. Select which branch that we want the build server to build into.

We can also see which runtime stack and version we are running. In this example we are running .NET and ASP.NET Version 4.8.

Once the information has been added we can go ahead and preview the file. We will get a YAML file that will be used for the build server:

![Workflow configuration](images/workflow-preview.png)

7. Save the workflow.

The website and the Github repository are now connected.

If we go back to the Github repository we can see that a new folder have been created called Workflows:

![Workflows](images/workflows.png)

Inside the folder, we find that a new YAML file has been created with the default settings that was added in the Azure Portal. In this case, this file will need to be configured so it fits into your set up.

8. Pull down the new file and folder, so you can work with the YAML file on your local machine.
9. Configure it to work with our Umbraco Deploy installation.

When it have been configured it will look something like this:

```yaml
name: Build and deploy ASP app to Azure Web App - Jonathan-deploy-live

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  build-and-deploy:
    runs-on: 'windows-latest'
    
    env:
      deployBaseUrl: https://helloworld.azurewebsites.net
      umbracoDeployReason:  DeployingMySite
  
    steps:
    - uses: actions/checkout@master

    - name: Setup MSBuild path
      uses: microsoft/setup-msbuild@v1.0.2

    - name: Setup NuGet
      uses: NuGet/setup-nuget@v1.0.5

    - name: Restore NuGet packages
      run: nuget restore
      working-directory: 'Deploy-testing'

    - name: Publish to folder - two parent folders up back at root of our repo
      working-directory: 'Deploy-testing'
      run: msbuild /nologo /verbosity:m /t:Build /t:pipelinePreDeployCopyAllFilesToOneFolder /p:_PackageTempDir="..\..\published\"
      
    - name: Copy License File
      shell: powershell
      run: xcopy /S /Q /Y /F ".\Deploy-testing\Deploy-testing\bin\umbracoDeploy.lic" ".\published\bin\"
      
    - name: Deploy to Azure Web App
      uses: azure/webapps-deploy@v2
      with:
        app-name: 'Jonathan-deploy'
        slot-name: 'production'
        publish-profile: ${{ secrets.AzureAppService_PublishProfile_04d3dd3154c64469aad82d1986996781 }}
        package: published
        
    - name:  Run Deploy Powershell - triggers deployment on remote env
      working-directory: 'Deploy-testing\Deploy-testing'
      shell: powershell
      run: .\TriggerDeploy.ps1 -InformationAction:Continue -Action TriggerWithStatus -ApiKey ${{ secrets.deployApiKey }} -BaseUrl  ${{ env.deployBaseUrl }} -Reason  ${{ env.umbracoDeployReason }} -Verbose       
```

:::note
This is an example of how you can set up the CI/CD pipeline for Umbraco Deploy. However there are many ways that this can be done and it is possible to set it up in a way that works for you and your preferred workflow.
:::

Before the build can work, we will need to set up the API key that we generated earlier to work with the build server in Github Actions.

1. Open your Github repository.
2. Navigate to Settings.
3. Go to the Secrets tab.
4. Select "New repository secret".
5. Call the new secret **"DEPLOYAPIKEY"**.
6. Add the API key from the `appSetting` for Umbraco Deploy in the `web.config`.
7. Save the secret.

We can now go ahead and commit the configured YAML file and push up all the files to the repository.

Go to Github where you will now be able to see that the CI/CD build has started running:

![Deployment build started](images/Deploying-meta-data.png)

The build server that has been set up will go through the steps in the YAML file and once it is done we can see that the deployment have gone through succesfully:

![Deployment Complete](images/deployment-complete.png)

You can now start creating content on the local machine. Once you create something like a Document Type, the changes are getting picked up in Git and.

When you're done making changes, you can commit them and deploy them to Github which again, will run the build server you have set up and then extract the changes into the website that you have set up in Azure.

This will only deploy the meta data for our local site to your website, to transfer content and media you will need to do so from the backoffice on your local project using the [queue for transfer feature](../Content-Transfer).
