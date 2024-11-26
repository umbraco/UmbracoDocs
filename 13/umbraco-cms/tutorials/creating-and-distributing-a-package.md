# Creating And Distributing A Package

This tutorial will take you through creating a brand new package in Umbraco, distributing it on the [package repository on Our Umbraco](https://our.umbraco.com/packages/), and finally automating the update flow and including it in CI/CD.

{% hint style="info" %}
The content in this article is valid _only_ for Umbraco version 8. For Umbraco version 9 and above, see the [Creating a Package](../extending/packages/creating-a-package.md) article.
{% endhint %}

## Overview

* [Prerequisites](creating-and-distributing-a-package.md#prerequisites)
* [Creating a test site locally](creating-and-distributing-a-package.md#creating-a-test-site-locally)
* [Creating a package from the backoffice](creating-and-distributing-a-package.md#creating-a-package-from-the-backoffice)
* [Creating a draft package on Our](creating-and-distributing-a-package.md#creating-a-draft-package-on-our)
* [Pushing your package to GitHub](creating-and-distributing-a-package.md#pushing-your-package-to-github)
* [Pack up your package locally using UmbPack](creating-and-distributing-a-package.md#pack-up-your-package-locally-using-umbpack)
* [Pushing your package to Our using UmbPack](creating-and-distributing-a-package.md#pushing-your-package-to-our-using-umbpack)
* [Deploy your package using GitHub Actions](creating-and-distributing-a-package.md#deploy-your-package-using-github-actions)
* [Archive older versions on push](creating-and-distributing-a-package.md#archive-older-versions-on-push)

## Prerequisites

To run this tutorial you will need the following:

* Be able to run an Umbraco site locally
* Git + GitHub account
* [Our Umbraco member account](https://our.umbraco.com/member/Signup) with access to upload packages
* UmbPack installed
* Umbraco Package templates installed

To install UmbPack and the Umbraco Package templates you can type these commands in your command line:

```
dotnet tool install --global Umbraco.Tools.Packages --version "0.9.*"
```

{% hint style="info" %}
If it says dotnet is an unknown command then you will need to install the [.NET Core SDK](https://dotnet.microsoft.com/download/dotnet-core) first.
{% endhint %}

```
dotnet new install Umbraco.Tools.Packages.Templates::0.2.5
```

At the time of writing this guide the package templates should be version 0.2.5, but it's recommended you visit the [NuGet page](https://www.nuget.org/packages/Umbraco.Tools.Packages.templates/) and copy the install instructions at the top for the latest version.

## Creating a test site locally

The first step when trying to create a package would be to have an Umbraco site to add something to. So let's set up a site using the Package Templates tool.

If you open a command line tool and type in:

```
dotnet new umbraco-v8-package -h
```

It will show you all the options you have for creating a new Umbraco site + package. For now, you should navigate to the folder you want to add this package in and use this command:

```
dotnet new umbraco-v8-package -n PackageWorkshop -d
```

This will create a new package called `PackageWorkshop`, and add a custom Dashboard for us to use in this tutorial. By default you will also get a GitHub Action added that we will return to later.

After running you will have a folder called `PackageWorkshop`, inside that you will have your site and solution files. So try to open it in Visual Studio or Rider by opening the `PackageWorkshop.sln` file.

Run the site from VS/Rider and go through the installer - you can install with or without starter kit, we do not use the starter kit content in this tutorial.

Once the site is running we are ready to look into creating a package.

### App\_Plugins extensions

One of the most common types of packages are based on App\_Plugins extensions, these extensions are ways to implement custom made versions of backoffice elements. For example dashboards, property editors, content apps, sections, trees, healthchecks, etc.

Other than these backoffice extensions you can also include any c# code you wish in a package, or indeed any other type of file. But first, let's look at one of the most common backoffice extensions.

#### Dashboard

You may have noticed earlier when you created the package site that you added a `-d` option, that has already set up a starting point for creating a dashboard for you. You'll find it here in the PackageWorkshop class library:

![PackageWorkshop class library](images/class-library.png)

However, since these files are not included in the .Site project you can't see the dashboard yet. If you navigate back to the root folder of the PackageWorkshop you will find a gulpfile.js file. If you run the following commands via a CMD prompt you will get a message that it is watching the App Plugins folder.

```
npm install
npm install gulp -g
gulp
```

In your solution, you will see that you now have a copy of the App Plugins folder available. This may be hidden as it's not included in the project by default though.

![Result of the gulp command](images/gulp-watch.png)

The cool thing here is that since it is a watch command, any small changes you may make will trigger a new copy so you can immediately test. Finally let's restart the site so we can see the dashboard in the Content section.

![Custom dashboard](images/dashboard.png)

## Creating a package from the backoffice

So far we haven't attempted anything related to packages. Lots of people add extensions to their sites without ever packaging them up and sharing with others. So let's look at how we can share our brand new dashboard with others.

First things first - let's package up the files we want to share, and then take a short look at the package file structure.

First step is to go to the packages section in the backoffice, then click the `Created` tab in the top right corner of the section. Inside this section there is a `Create package` button - click that.

Now fill out the name at the top, and then all the info in the Package Properties. An example could be:

![Example package info](images/package-info.png)

Next section is the Package Content - we are going to leave it empty for this package, but this is where you can include doc types, content nodes, etc. Very useful for starter kit packages that need to include some starter content.

The next section is Package Files, here under "Path to file" we will find the package folder inside App\_Plugins and select it, additionally the \~/bin/PackageWorkshop.dll file (containing the controllers from the class library).

![Example package files](images/package-files.png)

We can also skip the Package Actions, which is a way to run some code when installing or uninstalling packages, you can read more [in the documentation](https://our.umbraco.com/documentation/Extending/Packages/Package-Actions/)!

Now click create in the bottom right, and after that you can download the zip package.

### Understanding the package structure

If you peek into the zip file of the package we created you will see that all of the files you had are there. But they are not in folders anymore, they are all added in the root of the zip. There is also a new file called `package.xml`:

![zip-files](images/zip-files.png)

The `package.xml` file is the one containing all package metadata, and the file references that ensures Umbraco knows where to place the files when installing a package.

```xml
<?xml version="1.0" encoding="utf-8"?>
<umbPackage>
  <files>
    ...
  </files>
  <info>
    <package>
      <name>PackageWorkshopDashboard</name>
      <version>1.0.0</version>
      <iconUrl></iconUrl>
      <license url="http://opensource.org/licenses/MIT">MIT License</license>
      <url>https://umbraco.com</url>
      <requirements type="Strict">
        <major>8</major>
        <minor>6</minor>
        <patch>2</patch>
      </requirements>
    </package>
    <author>
      <name>Jesper Mayntzhusen</name>
      <website>https://github.com/jmayntzhusen</website>
    </author>
    <contributors></contributors>
    <readme><![CDATA[Dashboard that shows the current server time and date, intended for use in the Package Team package workshop!]]></readme>
  </info>
  <DocumentTypes />
  <Templates />
  <Stylesheets />
  <Macros />
  <DictionaryItems />
  <Languages />
  <DataTypes />
  <Actions />
</umbPackage>
```

This is the format it has - with the files element edited out for now. You can see all the info we added in the package creator in the backoffice is here under the `<info>` element. It also has elements to add DocumentTypes, and many other Umbraco schema items, as well as Package Actions under the `<Actions />` element.

A package.xml file can be super long if you include content and schema elements as they will all be in this one file. Let's take a look at how files are included:

```xml
<?xml version="1.0" encoding="utf-8"?>
<umbPackage>
  <files>
    <file>
      <guid>dashboard.html</guid>
      <orgPath>~/App_Plugins/PackageWorkshop/Dashboard</orgPath>
      <orgName>dashboard.html</orgName>
    </file>
    <file>
      <guid>dashboardController.js</guid>
      <orgPath>~/App_Plugins/PackageWorkshop/Dashboard</orgPath>
      <orgName>dashboardController.js</orgName>
    </file>
    <file>
      <guid>dashboardService.js</guid>
      <orgPath>~/App_Plugins/PackageWorkshop/Dashboard</orgPath>
      <orgName>dashboardService.js</orgName>
    </file>
    <file>
      <guid>package.manifest</guid>
      <orgPath>~/App_Plugins/PackageWorkshop/Dashboard</orgPath>
      <orgName>package.manifest</orgName>
    </file>
    <file>
      <guid>en.xml</guid>
      <orgPath>~/App_Plugins/PackageWorkshop/Dashboard/Lang</orgPath>
      <orgName>en.xml</orgName>
    </file>
    <file>
      <guid>PackageWorkshop.dll</guid>
      <orgPath>~/bin</orgPath>
      <orgName>PackageWorkshop.dll</orgName>
    </file>
  </files>
  ...
</umbPackage>
```

So here you will notice that while we only added the top level folder in the backoffice, it went through that folder and added a `<file>` element for every file found within that folder. And each file has 3 properties - `guid`, `orgPath` & `orgName`.

You don't have to worry too much about guid and orgName, they are references to the file name. Umbraco will automatically rename the file if there are conflicts, since they are stored in a flat structure it is quite likely, for example, lets say you had these two files in your package:

\~/App\_Plugins/PackageWorkshop/Dashboard/main.css \~/App\_Plugins/PackageWorkshop/ContentApp/main.css

Both would have the same name and be thrown in the root of the zip file. This would cause a conflict and Umbraco would rename them to randomly generated names. These names would correspond to the `guid` property, while the `orgName` and `orgPath` would make up the original names. These would be where the package would place and name the file when being installed.

## Creating a draft package on Our

At this point we have a complete package and can push it to [Our Umbraco](https://our.umbraco.com/packages/) which is where the Umbraco package repository is. The packages on that website are also the ones that are featured in the package section of the backoffice.

To create a package on Our, you first need an account on there and the account needs to have a certain level of karma - which can be gained by responding to forum posts.

Once you log in you can go to your [package overview](https://our.umbraco.com/member/profile/packages/) which should look a bit like this:

![Package overview](images/package-overview.png)

Click the "Add package" button and fill out all the information, upload the package and save at the end.

{% hint style="warning" %}
If you don't intend for people to use the package (as in this tutorial), then please don't click the "Go live" button at the final step.
{% endhint %}

Now your package is on Our, and if the "Go live" button is clicked it is visible for all to see.

The next step is to make it a bit simpler to deploy updates to the package. It is perfectly fine to log in here and upload a new version each time. The next steps will show an easier way though.

## Pushing your package to GitHub

If you are creating a package in order to share it with others it is a great idea to also share the source code. It is the open source way.

To share it, and make it easier to manage and deploy updates we will set up a GitHub repository for the package. This tutorial assumes you know what GitHub is, and that you have an account.

Create a fresh repo, with no readme, gitignore or license - do not choose a repository template (set to 'No Template'). On the second screen it will give you a command to push an existing repository to the new GitHub repo, should look like this but with your own user in the link:

```
git remote add origin https://github.com/jmayntzhusen/package-workshop.git
git branch -M main
git push -u origin main
```

If you jump back to your command line in the folder that has the .sln file and the gitignore, you may notice that there is no git repo by default, so let's create one:

```
git init
git checkout -b main
git add .
git commit -m "Initial commit, dashboard package"
```

At this point you have your solution in a local git repository, and we can then use the command from GitHub to push it up:

```
git remote add origin https://github.com/jmayntzhusen/package-workshop.git
git branch -M main
git push -u origin main
```

Now you have it all on GitHub:

![GitHub repo](images/github-repo.png)

## Pack up your package locally using UmbPack

At this point you know how to create a package from the backoffice, upload it to Our and push your changes to GitHub. That's what it takes to create and maintain a package.

If you want to make changes and push a new version you can carry out the following steps:

* Create the new package in the backoffice
* Sync your code to GitHub
* Go to Our and upload a new zip version
* Set that to the current version
* Optionally archive the previous one

However, whilst working this way is definitely possible, and will work for everyone it is pretty time consuming and requires you to do a lot of things in different places. So, let's make it a bit easier.

Instead of going to the Backoffice and creating or updating your package from the package section each time, you can use the UmbPack tool to make smaller changes.

{% hint style="info" %}
Any changes to Umbraco content and schema is a lot easier to do from the backoffice, but if it is file-based UmbPack is quicker.
{% endhint %}

If you have a look back in your solution you will notice there is an almost empty package.xml file in the root:

![Package.xml file in root](images/packagexml.png)

If you open this package.xml file you will notice it has some default values in it, the only new part is under files:

```xml
  <files>
    <folder path="src/Package.Workshop/App_Plugins/Package.Workshop" orgPath="App_Plugins/Package.Workshop" />
    <file path="src/Package.Workshop/bin/release/Package.Workshop.dll" orgPath="bin/Package.Workshop.dll" />
  </files>
```

Here you may notice that compared to your backoffice created package.xml it has not only a file element, but also a folder element. The folder element is not part of the regular package schema, and something we've added in UmbPack which works with the `umbpack pack` command where it runs through the folder and adds each file within it in the final zip.

So the XML above will turn into this, which is compatible with the Umbraco package installer, and is exactly like the same as what you would have got if you had created the package from the backoffice:

```xml
<files>
  <file>
    <guid>Package.Workshop.dll</guid>
    <orgPath>/bin</orgPath>
    <orgName>Package.Workshop.dll</orgName>
  </file>
  <file>
    <guid>dashboard.html</guid>
    <orgPath>/App_Plugins/Package.Workshop/Dashboard</orgPath>
    <orgName>dashboard.html</orgName>
  </file>
  <file>
    <guid>dashboardController.js</guid>
    <orgPath>/App_Plugins/Package.Workshop/Dashboard</orgPath>
    <orgName>dashboardController.js</orgName>
  </file>
  <file>
    <guid>dashboardService.js</guid>
    <orgPath>/App_Plugins/Package.Workshop/Dashboard</orgPath>
    <orgName>dashboardService.js</orgName>
  </file>
  <file>
    <guid>package.manifest</guid>
    <orgPath>/App_Plugins/Package.Workshop/Dashboard</orgPath>
    <orgName>package.manifest</orgName>
  </file>
  <file>
    <guid>en.xml</guid>
    <orgPath>/App_Plugins/Package.Workshop/Dashboard/Lang</orgPath>
    <orgName>en.xml</orgName>
  </file>
</files>
```

Before we try it out using UmbPack, try to run this command in the root of your site:

```
umbpack pack -h
```

The commandline tool will tell you all the options you have when packing up your package. You can a find much more in-depth explanation of the options in the [UmbPack documentation](https://our.umbraco.com/documentation/Extending/Packages/UmbPack/#pack-options).

For now we don't need to worry about the output directory option, we will let UmbPack save it in the current folder. Likewise, with the name and version override, we will let UmbPack use the name and version we specified in the package.xml file. For the package.xml path we will specify the one in the root we used in the previous step, that points to both the dll file and the App\_Plugins folder in the website project.

```
umbpack pack .\package.xml
```

And now we have a zipped version of our package with any new additions in App\_Plugins automatically added and listed in the package.xml of the zip. Now you can make changes and run the above command to have an updated version of the package within seconds.

Next up - let's push this package update to Our from the commandline.

## Pushing your package to Our using UmbPack

To push a package update to Our with UmbPack we need to use the `push` command, so let's have a quick look at the options for that by running:

```
umbpack push -h
```

You will see there are 2 necessary options, an API key and a path to the package zip. Then it is also possible for you to specify the Umbraco versions and dotnet version the package is compatible with, and also to archive old packages and set this as the new current package.

In short - similar options to what you can set on the package upload section on Our when uploading a package manually:

![Our package data](images/our-package-data.png)

So before we can try this out, let's go to Our and create an API key.

### Creating an Our API key

If you head back to Our Umbraco and visit the [package overview](https://our.umbraco.com/member/profile/packages/), then you will notice that there is a button under your package that says "API Keys". Each package api key is tied to that specific package, if you visit the page then you can create keys with a name you can use to differentiate the keys. Once you make a key it will show once, as soon as you refresh or navigate away the key will be gone and you'll have to make a new one if you lose it.

Once you created your key, make sure to copy and paste it somewhere. We will need to use it a few times in the coming steps, remember if you lose it you will have to make a new one.

### Pushing to Our with UmbPack

Now that we have an API key we can try to push our package update to Our Umbraco. This can be done like this:

```
umbpack push .\PackageWorkshopDashboard_1.0.0.zip -k [Api key here]
```

{% hint style="info" %}
If a package with the same name already exists it may give an error. In that case you can run `umbpack pack .\package.xml -v 1.0.1` to create a new version of the package then push it with the above command after editing the path to the new package.
{% endhint %}

An important thing to note with the push command here is that it sets some default values. If these values are not explicitly set it will default to saying your package is compatible with Umbraco v8.5.0, Dotnet 4.7.2 and it's to be set as the new "current" package on Our.

You can edit all of these defaults, and also specify older versions of your package to be archived when pushing new versions. You can read much more about the push options in the [Umbpack documentation](https://our.umbraco.com/documentation/Extending/Packages/UmbPack/#the-push-command).

So at this point we can work on our package locally, build a new version within seconds by running the pack command and then deploy it to Our using the push command.

Not easy enough for you? Let's try automating this entire thing with GitHub Actions then.

## Deploy your package using GitHub Actions

If you think back to the beginning when we set up our sites using the Package Templates you may remember that by default you get a GitHub action installed as well.

If you check out the `~/.github/workflows` folder in your solution, you will see there is a readme file and a build.yml file.

The build.yml file is used by GitHub Actions, which will perform some tasks for you when certain criteria are met. If you haven't worked with continuous integration and deployment (CI/CD) before, then this may seem like magic - but don't worry we will run through the commands.

The build.yml file contains several things, let's have a quick overview:

Line 14-17:

```yml
on:
  push:
    tags:
      - "release/*"
```

This means that when you push a new tag called `release/*` it will run the action, and only in that case.

The action that it performs is what is under `jobs:build:steps`. There is a step that uses UmbPack to create the package using the `pack` command like we did locally on our machines.

```yml
- name: Create Umbraco package file
  run: UmbPack pack ./package.xml -o ${{ env.OUTPUT }} -v ${{ steps.get_version.outputs.VERSION }}
```

{% hint style="info" %}
It sets the version of the package to be what we've set in the release tag based on a previous step.
{% endhint %}

Below this there is another step to push the package to Our, which again is like our approach locally - except now we add the API key as a GitHub secret so it's not public to everyone.

![GitHub secret](images/gh-secret.png)

```yml
- name: Push to Our
  run: umbpack push -k ${{ secrets.UMBRACO_DEPLOY_KEY }} ${{ env.Output }}\PackageWorkshopDashboard_${{ steps.get_tag.outputs.VERSION }}.zip
```

With these 2 commands and a few previous ones setting up the prerequisite build and nuget tools it is now ready to be fully automated.

Ensure you have set a GitHub secret with the name `UMBRACO_DEPLOY_KEY` and the value of the key from Our, and then go to your local solution and uncomment the UmbPack push command in the \~/.github/workflows/build.yml file.

Then make sure it is added and committed locally:

```
git add .
git commit -m "Enable umbpack push in GH action"
git push
```

Your solution and GitHub repo are now in sync, and the umbpack commands in the GitHub action are enabled and ready to run. Final step is to create a release tag and push it to GitHub:

```
git tag release/1.0.0
git push origin release/1.0.0
```

At this point you can go to GitHub and visit the Action tab to see your GitHub action run. When it's completed successfully you can go to your package overview on Our and see the package there.

## Archive older versions on push

If you want to ensure that older versions of your package are archived when you push a new one you can add the archive flag to the push command, a few examples are:

Archiving only the previous current package:

```
-a current
```

Archiving all other packages before adding the new one

```
-a *
```

Archiving all packages named `DashboardPackage` with a version of 1.2.x and 2.2.x:

```
-a DashboardPackage_1.2.*, DashboardPackage_2.2.*
```

In our case we don't expect there to ever be more than 1 "active" version at once, so we'll archive everything else, the final push step will then be:

```yml
- name: Push to Our
  run: umbpack push -k ${{ secrets.UMBRACO_DEPLOY_KEY }} ${{ env.Output }}\PackageWorkshopDashboard_${{ steps.get_tag.outputs.VERSION }}.zip -a *
```
