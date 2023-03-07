---
description: >-
  Learn how to manually upgrade the Umbraco Deployversion used on your Umbraco
  Cloud project.
---

# Manual upgrade of Umbraco Deploy

This article will give you a step-by-step on how to manually upgrade the deployment engine used on your Umbraco Cloud project.

## Prepare for the upgrade

When upgrading an Umbraco Cloud project manually, the very first step is to [clone down your Cloud Development environment to your local machine](../../set-up/working-locally.md).

Make sure you can run your Cloud project locally and restore content and media. It's important that you check that everything works once the upgrade has been applied and for this, you need to have a clone locally that resembles the Cloud environment as much as possible.

## Get the latest version of Umbraco

To get the latest version of Umbraco Deploy you will need to upgrade the site using NuGet. The main package to install is Umbraco.Deploy.Cloud. This has dependencies on other components of Umbraco Deploy that will be imported automatically.

If using Umbraco Forms in your installation, you should also update the Umbraco.Deploy.Forms package reference,

NuGet installs the latest version of the package when you use the dotnet add package command unless you specify a package version:

`dotnet add package Umbraco.Deploy.Cloud --version <VERSION>` `dotnet add package Umbraco.Deploy.Forms --version <VERSION>`

After you have added a package reference to your project by executing the commands above in the directory that contains your project file, run `dotnet restore` to install the packages.

You can also update the Umbraco Deploy through the NuGet Package Manager in Visual studio:

![NuGet Package Manager](../../../10/umbraco-forms/installation/images/Manage\_packages.png)

When the command completes, open the `.csproj` file to make sure the package reference was updated:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Deploy.Cloud" Version="9.0.1" />
  <PackageReference Include="Umbraco.Deploy.Forms" Version="9.0.1" />
</ItemGroup>
```

Make sure that everything works on the local clone and that you can **run the project without any errors**.

<details>

<summary>Manually Upgrade Umbraco Deploy Legacy versions 7 and 8</summary>
  If you are on Umbraco 7 or Umbraco 8, follow the steps below to manually upgrade Umbraco Deploy to a later version of your project.
1.   Download the latest version of Umbraco Deploy here: [http://nightly.umbraco.org/?container=umbraco-deploy-release](https://nightly.umbraco.org/?container=umbraco-deploy-release)
    Check [Product Dependencies](https://docs.umbraco.com/umbraco-cloud/product-upgrades/product-dependencies) to be sure you download the correct version of Deploy
    
2.   Unzip the file on your computer
    
3.   Copy/Paste the files from the unzipped folder to your local project folder
    You should not overwrite the following files:
```
    Config/UmbracoDeploy.config
    Config/UmbracoDeploy.Settings.config
```
4.   Run the project locally - make sure it runs without any errors

5.   Commit and deploy the changes to the Cloud environment

6.   Again, make sure everything runs without errors before deploying to the next Cloud environment

</details>

## Push upgrade to Cloud

When you've upgraded everything locally, and made sure that everything runs without any errors, you are ready to deploy the upgrade to Umbraco Cloud.

* Stage and commit all changes in Git
* Push the changes to the Cloud environment
* When everything is pushed, head on over to the Umbraco Cloud Portal
* Make sure everything runs without errors before deploying to the next Cloud environment
