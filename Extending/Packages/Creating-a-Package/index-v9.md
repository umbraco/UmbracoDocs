---
versionFrom: 9.0.0
v8-equivalent: "https://github.com/umbraco/UmbracoDocs/blob/main/Extending/Packages/Creating-a-Package/index.md"
verified-against: alpha-3
state: partial
updated-links: false
---

# Creating a Package

The goal of this tutorial will be to take something that extends Umbraco and create it as a package. The tutorials starting point will be creating a package out of the dashboard from the [Creating a Custom Dashboard tutorial](../../../Tutorials/Creating-a-Custom-Dashboard/index.md). The process will be the same for most packages so feel free to follow along with something else.

## Creating a package in the backoffice

If you have something you want to make into a package, you can do so through the Umbraco backoffice.

First go to the `Packages` section and select `Created` in the top right corner. Next, choose the `Create package` button.

![Buttons to select for creating a package in the backoffice](images/creating-package-menu.png)

On the `Create package` page there are 4 sections each with different information to fill out. Some of the info is mandatory, most of it is not. First of all you should give the package a name at the top - we will call our dashboard the same as in the [tutorial](../../../Tutorials/Creating-a-Custom-Dashboard/index.md): `Custom Welcome Dashboard`.

### The Package Properties section

This section contains mostly meta data about the package and the creator. We will fill in the following things:

| Property | Value | Note |
| -------- | ----- | ---- |
| Url | https://umbraco.com | This URL will be shown as the package's URL when others install it. It will likely be a Github repository, or similar. |
| Version | 1.0.0 | This is automatically set to 1.0.0 but can be changed as appropriate. |
| Icon Url | _Blank_ | Not a mandatory value, but will appear as the package's icon in different places in the backoffice if set. |
| Umbraco version | 9.0.0 | This will automatically select the Umbraco version you are currently using and is set as the compatible version for the package. |
| Author | Your name | Here you get to take credit for your awesome work! |
| Author URL | Your website or maybe a link to your Twitter profile | This will be linked to from the author name when displayed in the backoffice. |
| Contributors | _Blank_ | Here you can add the names of other contributors if you have any. |
| License | MIT License | Will be set to MIT by default. Please consider how you want your package licensed. If in doubt when deciding an open-source license there are [good resources available](https://choosealicense.com/licenses/). |
| License URL | http://opensource.org/licenses/MIT | Will be set to the URL for the MIT license and can be changed as needed. |
| Package readme | This will add a dashboard to your content section. <br> <br>The dashboard will show each user the most recent nodes they have saved. | This will be shown when someone looks at the package in the packages dashboard. |

### The Package Content section

This section is used to determine which things the package should contain. We will fill in the following things:

| Property | Value | Note |
| -------- | ----- | ---- |
| Content | _Empty_ | Here you can include content - e.g. if you want to create a starter kit. Not relevant for this package though. |
| Document Types | _Empty_ | Similar to the Content picker above. It is important to note that if you include content you will need to also pick all its dependencies in this and the next steps for them to be packaged together! |
| Templates | _Empty_ | See `Document Types` above |
| Stylesheets | _Empty_ | These will come from the wwwroot/css folder. If you have stylesheets you want to include from other locations you can do so at a later step. |
| Macros | _Empty_ | See `Document Types` above |
| Languages | _Empty_ | See `Document Types` above - all text is hardcoded or within our own lang folder in this package, so this is not needed |
| Dictionary | _Empty_ | See `Document Types` above |
| Data Types | _Empty_ | See `Document Types` above |

### The Package Files section

In this section you will be able to select all of your own custom files. We will start with the `Path to file` option.

Since everything in our Dashboard is from the same folder in `App_Plugins`, we can select the folder and it will include all items inside that folder:

![Selecting the files you want in your package](images/select-files-for-package.png)

We will leave the `Package options view` selector empty, but in case you were wondering you can select an HTML file here that will show up as package options. Here is an example from the package [Articulate](https://github.com/Shazwazza/Articulate/tree/master/src/Articulate.Web/App_Plugins/Articulate/BackOffice/PackageOptions):

![Gif of Articulates use of Package options](images/package-options.gif)

### The Package Actions section

Here you can add package actions. There are a number of [default package actions](./package-actions.md) and you can also create your own [custom package actions](./custom-package-actions.md)

Finally after filling out all the info we can select `Create` to create the package. We will download it, in order to take a closer look at what it contains in the generated zip file.

## Inspecting a package zip

When you download and then open the zip package you will find that it looks like this:

![Content of a zip package](images/zip-package.png)

The 5 highlighted files contained in the package are the ones that we created in the [Creating a Custom Dashboard tutorial](../../../Tutorials/Creating-a-Custom-Dashboard/index.md). However, there is another file here called `package.xml` - so let's take a look at that. It looks like this:

```xml
<?xml version="1.0" encoding="utf-8"?>
<umbPackage>
  <files>
    <file>
      <guid>customwelcomedashboard.controller.js</guid>
      <orgPath>~/App_Plugins/CustomWelcomeDashboard</orgPath>
      <orgName>customwelcomedashboard.controller.js</orgName>
    </file>
    <file>
      <guid>customwelcomedashboard.css</guid>
      <orgPath>~/App_Plugins/CustomWelcomeDashboard</orgPath>
      <orgName>customwelcomedashboard.css</orgName>
    </file>
    <file>
      <guid>package.manifest</guid>
      <orgPath>~/App_Plugins/CustomWelcomeDashboard</orgPath>
      <orgName>package.manifest</orgName>
    </file>
    <file>
      <guid>WelcomeDashboard.html</guid>
      <orgPath>~/App_Plugins/CustomWelcomeDashboard</orgPath>
      <orgName>WelcomeDashboard.html</orgName>
    </file>
    <file>
      <guid>en-US.xml</guid>
      <orgPath>~/App_Plugins/CustomWelcomeDashboard/lang</orgPath>
      <orgName>en-US.xml</orgName>
    </file>
  </files>
  <info>
    <package>
      <name>Custom Welcome Dashboard</name>
      <version>1.0.0</version>
      <iconUrl></iconUrl>
      <license url="http://opensource.org/licenses/MIT">MIT License</license>
      <url>https://github.com/umbraco/customwelcomedashboard</url>
      <requirements type="Strict">
        <major>9</major>
        <minor>0</minor>
        <patch>0</patch>
      </requirements>
    </package>
    <author>
      <name>Jesper Mayntzhusen</name>
      <website>https://jesper.com</website>
    </author>
    <contributors></contributors>
    <readme><![CDATA[This will add a dashboard to your content section. 

The dashboard will show each user the most recent nodes they have saved.]]></readme>
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

You will notice that the values for each of the fields we provided are found inside this XML file. Each file has an `orgPath` element associated with it - this is where the file will be moved to when the package is installed. So, don't worry if you organised your package in folders and they are not visible in this structure within the zip archive.

:::warning
It is very important to get the list of files included correct, as all dependencies are required for the package features to work.
On the other hand everything included here will be deleted on uninstall, so you also have to make sure not to include unnecessary things!
:::
