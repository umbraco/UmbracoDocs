---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: Installing and uninstalling Umbraco packages
meta.Description: How to install a package, and remove a package from a solution
---

# Installing and Uninstalling Packages

## Installing packages

In the Umbraco Backoffice, there is a **Packages** section which can be used to browse community-made packages for the CMS. From version 9 of Umbraco, it is only possible to add packages to via NuGet.

![Backoffice - Packages section](images/backoffice-packages-section.png)

Navigating to a specific package in the section will present you with an overview of the package, as well as an install snippet for NuGet CLI.

![Backoffice - Starter Kit package](images/backoffice-packages-section-package.png)

The packages can be installed by using:

* NuGet Package Manager in Visual Studio
* Package Manager Console in Visual Studio
* .NET CLI (usually accessible from the terminal/command prompt of your system)

For example, to install TheStarterKit package for the CMS the command would be:

`dotnet add package Umbraco.TheStarterKit`

Navigating to the Package Manager in Visual Studio is more visual, and gives you an overview of already installed packages.

![Visual Studio - nuget packages manager](images/nuget-installing-options.png)

The Package Manager has an integrated search function that allows you to find any public NuGet package and install it on the project.

![Visual Studio - finding The Starter Kit](images/nuget-package-in-manager.png)

Once the package has been installed, it will show up under the **Packages** section in the backoffice, under **Installed** tab.

![Backoffice - installed packages](images/backoffice-installed-packages.png)

## Uninstalling packages

Uninstalling packages is not always as straightforward as installing them.

In this section we will provide two examples on uninstalling a package - The Starter Kit and SEO Checker.

### Uninstalling packages like The Starter Kit

The Starter Kit provides you with a boilerplate solution to build upon. The package installs Document Types, Templates, media, content, and everything else needed to set up a small website. There is little custom code/functionality involved, and that is usually the case for such (starter kit/starter websites) packages.

To uninstall a package, either run a command like

`dotnet remove package Umbraco.TheStarterKit`

in the CLI or use the visual interface of NuGet Package Manager.

![Visual Studio - uninstalling via Package Manager](images/uninstalling-via-nuget-package-manager.png)

It is recommended to clean the solution after removing any package. This can be done by right-clicking the project in Visual Studio and choosing the _Clean_ option, or using the `dotnet clean` command.

![Visual Studio - clean solution](images/vs-cleaning-solution.png)

#### Removing package leftovers from the backoffice

With packages like The Starter Kit, the process does not end there. While the package is gone, content - and everything else needed for the website - is still available in the backoffice. To fully remove this kind of package, additional steps are needed.

**Remove Content provided by the package**

There is no universal way to tell what content comes from a package, and what content is custom-made. In the content section, delete individual nodes accordingly. If the goal is to fully remove the package and clean the site, all the content can be removed (and the recycle bin emptied).

![Backoffice - removing content](images/removing-content.png)

**Remove Media provided by the package**

Similar to Content, Media also might have to be removed.

![Backoffice - removing media](images/removing-media.png)

**Remove Document Types**

Document Types can be removed from the **Settings** section. If fully removing the package, all Document Types can be deleted, as there are no default Document Types in a clean-slate Umbraco installation.

![Backoffice - removing document types](images/removing-document-types.png)

**Removing Data Types**

As opposed to Document Types, there are some Data Types that are available out of the box when Umbraco is installed. It is not recommended to remove them. The safe approach is to delete any item that starts with a Document Type prefix and includes multiple dashes. That is the default naming convention for new configurations of Data Types (e.g. Blog - How many posts should be shown - Slider)

![Backoffice - removing data types](images/removing-datatypes.png)

**Removing Templates**

No templates are available out of the box in a new installation. If cleaning up after a package, it would be okay to delete all that are present

![Backoffice - removing templates](images/removing-templates.png)

**Removing Partial Views**

Out of the box, there are a few views available in the _blocklist_ and _grid_ folders. Everything else can theoretically be removed.

![Backoffice - removing partial views](images/removing-partials.png)

#### Cleaning leftover files on disk

Some packages might reference other items. For example, installing The Starter Kit also adds `Bergmania.OpenStreetMap` to your project. That component will show up as installed in the backoffice even after uninstalling the NuGet package.

![Backoffice - Packages section - leftover dependency](images/installed-package-leftovers-backoffice.png)

In many cases, custom dashboards, editors, and scripts are left in the `App_Plugins` folder after a package has been uninstalled via NuGet. These files also have to be deleted manually.

![Visual Studio - App Plugins leftover files](images/app-plugins-starterkit.png)

{% hint style="info" %}
Please note this particular guide targets a specific package. There are many packages out there, and each one is different. The exact steps presented here might not work the exact same way for all the packages, though the general approach should still apply.
{% endhint %}

### Uninstalling packages like SEO Checker

More advanced packages that add functionality on top of Umbraco usually rely on providing custom, compiled code. That being said, many of such packages also implement custom sections, dashboards, editors, and views.

In this example, we will be using SEO Checker which allows developers of the site to add custom properties to Document Types used to track search engine optimization practices.

An example use case of SEO Checker property on a Document Type, as presented in the Content section:

![SEO Checker in content](images/seochecker-content-section.png)

To uninstall SEO Checker from a website, the first step would be removing the package via a dotnet command (or Package Manager):

`dotnet remove package SEOChecker`

After that, cleaning the solution is recommended.

![Visual Studio - clean solution](images/vs-cleaning-solution.png)

#### Cleaning leftover files on disk

While uninstalling the package would remove most of the custom code, `App_Plugins` folder has to be cleaned manually.

![SEO Checker files in App Plugins](images/seochecker-app-plugins.png)

Removing _seochecker_ folder from `App_Plugins` will clean up the leftover backoffice section and dashboards.

#### Consequences of removing packages

If any content on the website relies on having a custom Property Editor or a data source installed, those specific properties will fall back to using a `label` Data Type with the previously saved content converted to a string.

In the case of SEO Checker the custom property added from the package would look like this after all the package files have been removed:

![SEO Checker in Content after removing the package](images/seochecker-after-removal.png)

Depending on the packages used and the implementation, frontend rendering of content coming from custom editors, or any frontend functionality dependent on external code, might not work correctly. It is recommended to inspect the frontend of the site after removing any packages.
