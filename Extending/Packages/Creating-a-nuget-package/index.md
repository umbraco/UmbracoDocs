---
versionFrom: 8.0.0
versionTo: 8.0.0
meta.Title: "Creating a Nuget version of an Umbraco package"
meta.Description: "A guide to creating a Nuget version of an Umbraco package"
---

# Creating a NuGet version of a package

:::note
This tutorial is for Umbraco 8 - however, a lot of the things covered here will be the same or similar in Umbraco 7. For  Umbraco 9 or higher, check the instructions in [Creating a Package article](../Creating-a-Package/index.md).
:::

The goal of this tutorial is to take something that extends Umbraco and create a NuGet Package for it. Like the [Creating a Package](../Creating-a-Package/index.md) tutorial we are using the [Creating a Custom Dashboard Tutorial](../../../Tutorials/Creating-a-Custom-Dashboard/index.md) as a starting point.

NuGet is the standard package manager for .NET projects. More information about NuGet and how it works can be found on the [Microsoft documentation pages for NuGet](https://docs.microsoft.com/en-us/nuget/what-is-nuget).

## NuGet package files

NuGet packages are zip files that follow a specified structure and contain a few predefined files, that tell the consuming application how to extract and install the package.

You don't need to know the internal structure of a NuGet package to create one. You can use the NuGet Command Line Interface (CLI): [nuget.exe](https://www.nuget.org/downloads) to create your package.

You can also create NuGet packages manually using the [NuGet Package Explorer](https://github.com/NuGetPackageExplorer/NuGetPackageExplorer), although this method is harder to automate than using the command line tools.

## Create a `.nuspec` file

A `.nuspec` file is an xml file that tells NuGet how to create a NuGet package. It contains basic information about a package, and dependencies that your package might require and a list of files to include as part of the NuGet package.

The [full specification of a nuspec file](https://docs.microsoft.com/en-us/nuget/reference/nuspec) can be found within the NuGet documentation.

To create a `.nuspec` file for your package, create an empty `.txt` file and change the extension to `.nuspec`. This file should be saved at the root of your package folder structure.
e.g. `myCustomWelcome.txt` renamed to `myCustomWelcome.nuspec`

Below is an example `.nuspec` file that might be used to create a package for the [Creating a Custom Dashboard tutorial](../../../Tutorials/Creating-a-Custom-Dashboard/index.md).

```xml
<?xml version="1.0"?>
<package xmlns="http://schemas.microsoft.com/packaging/2011/10/nuspec.xsd">
  <metadata>
    <id>CustomWelcomeDashboard</id>
    <version>1.0.0</version>
    <authors>Umbraco User</authors>
    <owners>Umbraco user</owners>
    <projectUrl>https://github.com/umbraco/customwelcomedashboard</projectUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <description>This will add a dashboard to your content section</description>
    <releaseNotes><![CDATA[1.0.0 Initial release]]></releaseNotes>
    <copyright>Copyright 2019</copyright>
    <tags>umbraco, umbraco-cms</tags>
    <dependencies>
      <dependency id="WindowsAzure.ServiceBus" version="6.0.0" />
    </dependencies>
  </metadata>
  <files>
    <file src="bin\release\CustomWelcomeDashboard.dll" target="lib\net462" />
    <file src="App_Plugins\CustomWelcomeDashboard\**\*.*" target="content\App_Plugins\CustomWelcomeDashboard" />
  </files>
</package>
```

:::note
Unlike an Umbraco Package, a NuGet package can reference other packages your code might be dependent on, as a rule you don't need to include packages that are part of the main Umbraco installation.
:::

## Creating the package

Once you have a `.nuspec` file you can use the NuGet CLI to create the NuGet package.

An example command to create your package may look like this:

```bash
nuget pack myCustomWelcome.nuspec -version 1.0.0 
```

There are multiple arguments you can pass on the command line to the NuGet command.  More information in the [NuGet documentation](https://docs.microsoft.com/en-us/nuget/reference/nuget-exe-cli-reference).

The `-version` parameter allows you to replace the version number in the nuspec file with the one specified, this means you can build new versions of your package without having to change the .nuspec file each time.

:::note
Once you have successfully ran the nuget pack command you will have a file in the format `PackageName.VersionNumber.nupkg`. This is your nuget package file.
:::

## Publishing the package

To allow other people to use your package you will need to publish it to a public NuGet repository. The most common repository is at <https://nuget.org>.

There is comprehensive documentation on [How to publish a NuGet package](https://docs.microsoft.com/en-us/nuget/nuget-org/publish-a-package) in the official NuGet Documentation.
