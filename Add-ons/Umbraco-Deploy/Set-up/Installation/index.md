---
versionFrom: 8.0.0
---

# Installing Umbraco Deploy

In this article we will cover the steps in order for you to install Umbraco deploy on a brand new website.

We will cover how to install Umbraco deploy and set up Umbraco deploy on your website as well as how you can set up a CI/CD build server using Github actions to run the deployment process.

## How Umbraco Deploy works

Umbraco Deploy works by serializing non-content Umbraco items (called “Schema” items) to disk. These serialized files are located in the folder ~/data in the root of your website.

These items are entities like Content Types, Media Types, Data Types, etc.

These files must be committed to Source control (i.e. Git). Umbraco Deploy works by “extracting” this serialized information back into your Umbraco installation. This is done by Deployment Triggers when a deployment is sent to a target environment.

For example, when working locally you might create a new Content Type, this will automatically create a new on-disk file in the ~/data folder which is the serialized version of the new Content Type. You would commit this file to your repository and push this change to your hosted source control (i.e. GitHub).

When you want this deployed to your next upstream environment (i.e. staging), you would trigger your CI/CD process or Build Server (i.e. Azure DevOps) which will push the changes to your development environment and once the build deployment completes successfully, a Deployment Trigger would be executed as an HTTPS request to your target environment which will extract all changes found in the ~/data folder into the Umbraco target environment.

![Deploy workflow](images/Deploy_concept.png)

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

1. Set up Git repository and new Umbraco project
2. Install Umbraco Deploy via NuGet
3. Generate Umbraco Deploy API Key
4. Add the key in the app settings appSettings
5. Configure UmbracoDeploy.config
6. Configure CI/CD build server

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

```xml
<add key="Umbraco.Deploy.ApiKey" value="YourAPIKeyHere" /> 
```

In the AppSetting we need to populate the value with with your own Deploy API Key.

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

Once the AppSetting and API key have been added, it is now time to configure our environments in the UmbracoDeploy.config which is used to define the environments that we have for our Umbraco Deploy installation.

The Config file will look something like this like this:

```xml

<?xml version="1.0" encoding="utf-8"?>
<environments xmlns="urn:umbracodeploy-environments">
    <environment type="development"
                 name="Development"
                 id="00000000-0000-0000-0000-000000000000">
        https://helloworld.dev.azurewebsites.net
    </environment>
    <environment type="staging"
                 name="Staging"
                 id="00000000-0000-0000-0000-000000000000">
        https://helloworld.staging.azurewebsites.net
    </environment>
    <environment type="live"
                 name="Live"
                 id="00000000-0000-0000-0000-000000000000">
        https://helloworld.azurewebsites.net
    </environment>
</environments>


```

You will need to generate a unique GUID Id for each environment, this can be done in Visual studio or how you prefer to do it.

The “Type” is for informational purposes in the back office but in most cases will be the same (lowercased) value of the Name.

THe URL's for each environment need to be accessible by the other environments over **HTTPS**.

:::note you’re free to update the “name” attribute to make it clearer in the interface where you’re deploying to. So if you want to name “Development” something like “The everything-goes area” then you can do that and it will be shown when deploying to that environment.
:::

Once the config have been set up with the correct information we can now go ahead and make sure that the the source control are including our files in the ~/data folder of your web application.

This can be done by going to the Data folder of the project and create a test UDA file, and then check in either your Git GUI or in the command promt and verify whether the test file is being tracked

![Test UDA file](images/test-UDA.png)

We can see that the file have been created and it is being tracked by Git and we are all set and we can go ahead and delete the test file.

Now Umbraco Deploy have been installed on our local machine and project, we can now go ahead and commit the files to our repository.

However make sure to not push the files up just yet.

We will need to set up a CI/CD build server and connect it to our Github repository, which when we push our commit up will run and build our solution into our website in Azure.

### Setting up CI/CD build server in Github actions

In this tutorial we will show how you can set up a CI/CD build server using Github actions.

We will not cover how you can set up the site itself as this is beyond this guide.

To set up the build server in Azure Web Apps, we need to go to the Azure portal go to the website that we have been set up.

From there we need to go and set up the build server.

In the Azure portal we go to the overwiev of the website that have been set up.

From here we need to go to the Deployment section and under there find the Deployment section

![Azure deployments](images/Deployment-center.png)

In the deployment center we can set up the CI/CD build server, and in this example we are going to set up our build server by using Github actions, however you are able to set up the build server however you want as long as it supports executing powershell scripts.

In the deployment center, go to the settings section, choose which source and build provider we will use.

We choose Github and then we can see we get some different options for the set up:

![Build server clen](images/Build-server-clean.png)

And then we need to choose the Organization which we created our Github repository under, once we choose that we can see the repositories that we have under that Organization.

Then we can go ahead and choose the repository and which branch that we want the build server to build into.

Below we can as well see which runtime stack and version we are running, and in this example we are running .NET and ASP.NET Version 4.8.

Once the information have been added we can go ahead and preview the file and see that we will get a YAML file that will be used for the build server

![Workflow configuration](images/workflow-preview.png)

We can go ahead and save the workflow once we are done setting it up.

Once it have been saved the website and the Github repository have now been connected.

If we go back to the Github repository we can see that a new folder have been created called Workflows:

![Workflows](images/workflows.png)

Inside the folder we find that a new YAML file have been created with the settings that we added in the Azure portal called "main_Jonathan-Deploy-App.yml" in this case.

Now we will need to configure the file so that it works with our Umbraco projects.

The first thing that needs to be done is to in your Git GUI is to make a pull from your repository, so that you will get the YAML file on your local machine.

we now have the file on our local machine, which means that we can go ahead configure it so it will work with our Umbraco Deploy installation.

now we have to set up the file so that it looks something like this:

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

Now we can go ahead and push our files from our local machine to our Git repository, which then will trigger the deployment and extract our files into our hosted website in Azure and update Umbraco with the necessary changes.



<!--## Installing Umbraco Deploy on existing site-->

