---
versionFrom: 9.0.0
---

# Manual upgrade of Umbraco CMS on Cloud

This article will give you a step-by-step on how to manually upgrade your Umbraco Cloud project to run the latest version of Umbraco CMS.

## Prepare for the upgrade

When upgrading an Umbraco Cloud project manually, the very first step is to [clone down your Cloud Development environment to your local machine](../../Set-Up/Working-Locally/).

Make sure you can run your Cloud project locally and restore content and media. It's important that you check that everything works once the upgrade has been applied and for this, you need to have a clone locally that resembles the Cloud environment as much as possible.

## Get the latest version of Umbraco

To get the latest version of Umbraco you will need to upgrade the site using NuGet.

NuGet installs the latest version of the package when you use the `dotnet add package` command unless you specify a package version:

`dotnet add package Umbraco.Cms --version <VERSION>`

After you have added a package reference to your project by executing the `dotnet add package Umbraco.Cms` command in the directory that contains your project file, run `dotnet restore` to install the package.

You can also update the CMS through the `NuGet Package Manager` in Visual studio:

![NuGet Package Manager](images/Manage_packages.png)

When the command completes, open the **.csproj** file to make sure the package reference was updated:

```xml
<ItemGroup>
  <PackageReference Include="Umbraco.Cms" Version="9.0.1" />
</ItemGroup>
```

## Run the upgrade locally

When you are upgrading the new version of Umbraco with your clone of the Umbraco Cloud project, follow these steps to complete the upgrade:

* Run the project locally
* When the project spins up, you'll be prompted to log in to verify the upgrade
* On the installation screen you need to verify the upgrade:
    ![Verify upgrade](images/upgrade-screen.png)
* Hit **Continue** - this will complete upgrading the database
* The upgrade will finish up
* When it's complete you will be sent to the Umbraco backoffice

Make sure that everything works on the local clone and that you can **run the project without any errors**.

## Push upgrade to Cloud

Before you deploy the upgraded project to the Cloud, it's important that you check if there are any [**dependencies**](../Product-Dependencies) on the new Umbraco version.

Are there dependencies for Umbraco Forms or Umbraco Deploy you need to upgrade these locally, before moving on.

When you've upgraded everything locally, and made sure that everything runs without any errors, you are ready to deploy the upgrade to Umbraco Cloud.

* Stage and commit all changes in Git
* Push the changes to the Cloud environment
* When everything is pushed, head on over to the Umbraco Cloud Portal
* Access the backoffice of the Cloud environment you pushed the upgrade to - Development or Live
* You will again be prompted to log in to complete the database upgrade
* You will be sent to the backoffice once the upgrade is complete

Again it's **important** that you make sure everything runs without any errors before moving on to the next Cloud environment.
