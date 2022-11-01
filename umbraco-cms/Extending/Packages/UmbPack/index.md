---
versionFrom: 7.0.0
versionTo: 8.0.0
versionRemoved: 9.0.0
meta.Title: "UmbPack"
meta.Description: "How to use the UmbPack tool to deploy package versions to Our"
---

# UmbPack

UmbPack is an open source NuGet tool that can deploy packages to Our, and also help you pack your files into a package.

:::note
**Are you using Umbraco 9+?**

As of Umbraco 9, packages can only be installed using NuGet and it is no longer possible to install packages from package zip files.

In order to make your packages available for sites using the latest version of Umbraco, follow our guide on [Creating a NuGet package](../Creating-a-nuget-package/).
:::

## Creating an API key on Our.umbraco.com

Before you can start using the UmbPack tool, you need to create the package on Our. Once it has been set up you will then be able to add new versions of the package zip files using UmbPack.

To create an API key to use with the UmbPack tool you should first log in with your user and go to the [manage packages section](https://our.umbraco.com/member/profile/packages/).
There you will find a button under each package to manage API keys:

![Api keys button](images/apiKeysButton.png)

To generate a key, you need to add a description. When you click "Add" it will show you your key. Be aware that as soon as you refresh the page the key will be gone, and if you lose it you will have to generate a new one.

![Example key](images/exampleKey.png)

Once you copy the key one more step is needed in order to start using it: you must set up the UmbPack tool.

## Installing UmbPack locally

To install the latest version of the tool locally you need to run the following command in a commandline:

```bash
dotnet tool install --global Umbraco.Tools.Packages
```

You will then be able to use it by running `umbpack [command]` in the command line afterwards. More on the commands of the tool below.

## The Init command

The `init` command helps you create a `package.xml` file, which is the file in an Umbraco package that contains all the metadata for a package - things like author info, version compatibility, etc.
The `init` command can be used by typing:

```bash
umbpack init
```

It is usually used to scaffold a `package.xml` file that you can then use with the `pack` command to create an Umbraco package.

Here is an example of what it will look like in the commandline. It will also post back the `package.xml` for verification at the end:

![UmbPack init example](images/umbpackinit.png)

## The Pack command

The `pack` command is used to create an Umbraco zip package from some specified files. It is similar to what would happen if you picked the files via the backoffice.

:::warn
The `pack` command has no way of handling package actions, Umbraco schema and content. If you need any of those you will still have to pick them from the backoffice.
:::

The `pack` command has a few options. The only mandatory one is to point it at either a `package.xml` file or a folder containing a `package.xml` file:

### Example of packing a folder

```bash
umbpack pack C:\Umbraco\Customers\test\Test.Web\App_Plugins\CustomPackage
```

In this example I wanted to pack up the `~App_Plugins/CustomPackage` folder inside the .Web project. Often that is where you will store package files. The tool will ensure it adds all files to the `package.xml` inside the folder so if you continue to develop and add things a new pack will update it.

### Example of packing based on a package.xml file

```bash
umbpack pack C:\Umbraco\Customers\test\package.xml
```

In this example you can imagine I keep a `package.xml` file outside of the project folders, inside the `src` folder of a Visual Studio solution. The benefit here is that it would not be part of the website, but could still be source controlled. Additionally this is a better approach if you want your package to include files outside of a specific folder.

Let's say you have a solution that looks like this:

![Solution setup](images/solutionfiles.png)

There is a .Web project and a .Core project. We have a controller in the .Core project that gets built into a dll in the .Web project, so the package files we would want to include are in the .Web project:

```bash
~/App_Plugins/CustomPackage
~/bin/UmbPackTest.Core.dll
```

In that case you can add a bit of special xml to the `package.xml` file that the UmbPack tool can recognize to include it all in the package files:

```xml
<files>
    <folder path="UmbPackTest.Web/App_Plugins/CustomPackage" orgPath="App_Plugins/CustomPackage" /> 
    <file path="UmbPackTest.Web/bin/UmbPackTest.Core.dll" orgPath="bin/UmbPackTest.Core.dll" />
</files>
```

:::note
`orgPath` is the location it will try to install the package files to. So when doing this from outside the website root you should edit the `orgPath` to be from the root of a new site.
:::

We can specify a folder and a file (or add additional xml elements for additional files), and when you then run the command targetting a `package.xml` file in the root of the solution:

![UmbPack pack command](images/umbpackpack.png)

You will have a zipped version of the package in the location you ran the tool (otherwise you can specify an output location `-o`). And it will have rewritten the file info to be valid package file info:

```xml
<files>
    <file>
        <guid>UmbPackTest.Core.dll</guid>
        <orgPath>/bin</orgPath>
        <orgName>UmbPackTest.Core.dll</orgName>
    </file>
    <file>
        <guid>custompackage.controller.js</guid>
        <orgPath>/App_Plugins/CustomPackage</orgPath>
        <orgName>custompackage.controller.js</orgName>
    </file>
    <file>
        <guid>CustomPackage.html</guid>
        <orgPath>/App_Plugins/CustomPackage</orgPath>
        <orgName>CustomPackage.html</orgName>
    </file>
    <file>
        <guid>package.manifest</guid>
        <orgPath>/App_Plugins/CustomPackage</orgPath>
        <orgName>package.manifest</orgName>
    </file>
</files>
```

### Pack options

The `pack` command has a few options. As described above the mandatory value is a path to a `package.xml` file or a folder containing a `package.xml` file. There are 2 other configurations you can set on the pack command as well though:

`-o` - specifies an output folder. It defaults to the current folder, but you could do something like:

```bash
umbpack pack .\package.xml -o ../MyCustomPackageVersions
```

`-v` - specifies a version for the package. When packing a package it will name it as `{packagename}_{version}.zip`. By default it will take the version from the `package.xml`, but if running in CI/CD for example you may not want to update this value all the time, so you can overwrite it using:

```bash
umbpack pack .\package.xml -v 1.9.9
```

`-n` - specifies a name override for the package. By default the package will automatically generate a name based on the info in your package.xml file. This option allows you to override it yourself with either a full name or using a template. It will not affect the package.xml info, only the zip file name. The template options are:

`{name}` - replaced with the name of the package declared in the package.xml  
`{version}` - replaced with the version of the release declared in the package.xml

Fixed naming:

```bash
umbpack pack .\package.xml -n MyPackageWithBadVersioning_FirstVersion.zip
```

Template naming:

```bash
umbpack pack .\package.xml -n {name}_{version}.zip
```

`-p` - specifies package.xml overrides. You can override any value in the package.xml with your own values when you pack the package. Can be a replacement for `-v` & `-n` as well. You can add any value in your package.xml enclosed by `$` to then replace it with UmbPack. Example:

```xml
<info>
    <package>
      <name>$Name$</name>
      <version>$Version$</version>
```

```bash
umbpack pack .\package.xml -p Name=MyPackage;Version=1.0.0
```

This would pack your package and update your package.xml - note this happens before the automatic naming based on name and version as well. This is especially useful in CI/CD deployments where you may not know all your values before the run.

## The push command

The `push` command requires an API key and a path to your package zip file, so will look something like this:

```bash
umbpack push .\UmbPackTest_1.0.0.zip -k [APIKEY] 
```

However it also contains a few extra options. By default the pushed version will be set as the new current package version. You can change that by via the `-c` flag:

```bash
umbpack push .\UmbPackTest_1.0.0.zip -c false -k [APIKEY]
```

Also when you upload a new package you need to specify which versions it works with. It will default to the latest, but you can specify more with the `-w` flag:

```bash
umbpack push .\UmbPackTest_1.0.0.zip -w v860,v850,v840,v830,v820,v810,v800 -k [APIKEY]
```

You can also specify the compatible DotNetVersion if you would like, it defaults to 4.7.2:

```bash
umbpack push .\UmbPackTest_1.0.0.zip --DotNetVersion=4.5.2 -k [APIKEY]
```

Finally you can specify whether you want any older versions to be listed as archived on Our when you push, this is done using the `-a` flag. By default it will not archive anything, and you can either pass a regex string along or the word `current` to only archive the one that is set to current before your push. You can pass in several space seperated strings, and also use wildcards:

Will only archive the current package:

```bash
umbpack push .\UmbPackTest_1.0.0.zip -k [APIKEY] -a current
```

Will archive all other packages:

```bash
umbpack push .\UmbPackTest_1.0.0.zip -k [APIKEY] -a *
```

Will archive all packages based on a partial match:

```bash
umbpack push .\UmbPackTest_1.0.0.zip -k [APIKEY] -a UmbPackTest_0*
```

Combining several archive patterns:

```bash
umbpack push .\UmbPackTest_1.0.0.zip -k [APIKEY] -a current UmbPackTest_0* UmbPackTest-Assets_0*
```
