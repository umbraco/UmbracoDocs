---
description: >-
  Information on good practices and common defaults for Umbraco package
  development.
---

# Good practice and defaults

This document provides guides and notes on package development. It includes good practice guidelines that will help you maintain and support your package through multiple releases and versions of Umbraco. These good practices are not prescriptive, but offer a guide as to what often works well, and not-so-well, when developing packages for Umbraco.

## Backoffice assets (JS/CSS/HTML)

To extend the Umbraco backoffice, a package can provide files such as `umbraco-package.json` and TypeScript/JavaScript files that should be stored within the `App_Plugins` folder. It's recommended to put all files in a subfolder with a unique name, preferably using the package name, like `App_Plugins\MyPackage`.

For more information on how to extend the Umbraco backoffice, have a look at the [customizing the backoffice documentation](../../customizing/overview.md)

Files in the `App_Plugins` folder will be publicly available on the website even though they are not in the `wwwroot` folder. You should not store sensitive information in the `App_Plugins` folder.

Files in the `App_Plugins` folder should be considered immutable. This means that they are not something a user of your package is expected to change on their site.

The default delivery method for files to the `App_Plugins` folder is via a `.targets` file within a package. This means when a website is built, the files in this folder are copied over from the NuGet cache. When this happens, any changes a user might have made to these files will be lost. Equally, if the user performs a `dotnet clean` on a solution, all files in the `App_Plugins` folder will be deleted.

{% hint style="info" %}
If you have files that you expect users of your package to alter you should not place them in the `App_Plugins` folder.
{% endhint %}

## Views

Views are used to render content on the front end of a website. If your package provides a way for the user to present the content publicly, you should copy these files to the views folder.

As the files will still be copied during build you should ensure your target file does not overwrite newer or altered files. You should also ensure that it doesn't delete files on clean.

{% hint style="info" %}
When you have a package that contains many views you might consider building a dotnet template or Razor Class Library (RCL) instead. By doing this, the files will not pollute your user's solutions.
{% endhint %}

## License files

Umbraco products store their licenses in `/umbraco/Licences`. It is recommended for third-party packages that require license files to also store their license files in this location.

The default `.gitignore` for Umbraco templates will include any files in the `/Licenses` folder while ignoring most of the rest of the Umbraco folder.

{% hint style="info" %}
The `/umbraco/Licenses` folder does not exist on a fresh installation of Umbraco. You need to create it manually before you save your license file to this folder.
{% endhint %}

## Operating system considerations

Umbraco a .NET application and can be run on multiple operating systems (Windows, Linux and macOS). When developing packages there are a few things you should be aware of for your package to run on all possible operating systems.

### Case sensitivity

The Linux and macOS file systems are case-sensitive by default. This means that `App_Plugins/myPackage` is a different location from `app_plugins/MyPACKAGE`. When building your package you should ensure that you always refer to folders and paths in a consistent way.

A good way to ensure consistency is to use constants in your code to define file or folder locations.

{% hint style="info" %}
You can adjust the case sensitivity of a Windows folder by running a command against a newly created/empty folder:

```bash
fsutil.exe file queryCaseSensitiveInfo <path>
```
{% endhint %}

#### Case sensitivity in default files and folders

Some folders within Umbraco will already exist for all installations. If you access these folders, you need to be aware of the case used to ensure you end up in the correct place:

| Folder                 | Note                                                                                  |
| ---------------------- | ------------------------------------------------------------------------------------- |
| /App\_Plugins          | Uppercase `A` and `P`                                                                 |
| /App\_Plugins/\[Ll]ang | Uppercase `L`                                                                         |
| /Views                 | Uppercase `V`                                                                         |
| /umbraco/Licenses      | Lowercase `u` and uppercase `L`                                                       |
| /config                | Lowercase `c`                                                                         |

{% hint style="info" %}
If you create a custom section/tree, Umbraco will build paths based on the name of that section or tree. These folder paths will be case-sensitive.

For example: if you have a custom tree with the `treeAlias` of `MyCustomTree` Umbraco will look for files in `App_Plugins\MyPackage\backoffice\MyCustomTree\`.
{% endhint %}

### File/folder locations

You should never hardwire a file or folder location into code. Instead, it is recommended to follow either of the options below:

* Access files using the ASP.NET Core file providers from `IHostingEnvironment`.
* Use the built-in methods to access well-known locations (see below).

#### Temp folder

The location of the Umbraco temp folder can be controlled via configuration and cannot be assumed. Use the `IHostingEnvironment.LocalTempPath` variable to locate the temp folder.

```csharp
var localTempRoot = Path.GetFullPath(hostingEnvironment.LocalTempPath);
```

#### Relative paths

If you require the path of a folder relative to the site root, you can use the `IHostingEnvironment` method to map a path:

```csharp
// Full physical path to the content/project root
var contentRootPath = hostingEnvironment.MapPathContentRoot("~/");
// Full physical path to the web root (served publicly)
var webRootPath = hostEnvironment.MapPathWebRoot("~/");
// Absolute path to use as URL
var absolutePath = hostEnvironment.ToAbsolute("~/");
```

### Folder/file system access

It is not recommended to assume things about the folder structure of a site or use direct I/O commands to access the file system. Access to the disk within an ASP.NET Core site is usually managed with File Providers. You can access the file providers from the `IWebHostEnvironment` class.

Example: If you want to read `robots.txt` from the `wwwroot` folder, use `WebRootFileProvider` in a controller to get to the root of the site and read the file:

```csharp
public class MyController: UmbracoAuthorizedJsonController
{
    public MyController(IWebHostEnvironment webHostEnvironment)
    {
        var webRootProvider = webHostEnvironment.WebRootFileProvider;

        var myFileInfo = webRootProvider.GetFileInfo("robots.txt");
        if (myFileInfo.Exists)
        {
            using (var stream = myFileInfo.CreateReadStream())
            {
                using(var streamReader = new StreamReader(stream))
                {
                    var text = streamReader.ReadToEnd();
                }
            }
        }
    }
}
```

{% hint style="info" %}
This is the preferred method for file I/O. Not all files served up by a site are placed in the `wwwroot` folder when you expect them to be. This is especially true if the site is using Razor Class Library projects to insert static files.
{% endhint %}

### Path manipulation

Building folder path strings manually can cause problems when swapping between file systems. Windows uses the backslash character ('\\') to separate folders and files while Linux uses the forward slash ('/').

#### Example

On Windows, a file might be located at `d:\website\robots.txt` while on Linux this might look like `/home/website/robots.txt` instead.

You should use the .NET `Path` methods wherever possible when building paths to ensure that the correct path is built:

```csharp
// WRONG: Don't build paths manually
var myPath = webrootPath + "\robots.txt";

// CORRECT: Build the path using the correct separator for the current file system
var myPath = Path.Combine(webrootPath, "robots.txt");
```

If you need to build a path manually, use `Path.DirectorySeparatorChar` instead to get the correct separator for the file system.

## Settings

Most packages will require some settings to be stored for the users to control in order to change the behavior of the package. Where you store these settings will depend a lot on the nature of the package.

### Property Editors

Property Editors should store their settings as part of their Data Type in Umbraco. This is the standard way property editor behavior is controlled while it is familiar to users and supported by deployment tools.

### Do not save to appsettings.json

You should not alter `appsettings.json` via code.

Settings in ASP.NET Core are merged from a number of different locations at runtime. You cannot guarantee that `appsettings.json` is the location that a setting is read from and your users may not want certain settings in that file. You can read settings from the configuration, but you cannot assume they have come from `appsettings.json`.

### Settings locations

There are many options for where you might save your settings and a lot will depend on the nature of your package.

Below you can find pros and cons for different places where you might save the settings for your package.

#### Save to the database

Settings can be saved to the database. Settings can be stored in the database using the Umbraco `IKeyValueService`, and for more complex settings you can use a custom database table.

* Pros:
  * Settings will be accessible directly from the database, and not dependent on deployed files on disk.
* Cons:
  * Setup is required to create the database tables for the settings to live in.
  * The settings will only be available to the specific instance of the site, and any settings will not be deployed between a local, development, or staging site.

#### Save to disk

You can choose to save the settings to disk. As an example, the settings can be saved in the `/config` folder at the root of the site.

* Pros:
  * Settings will be accessible to the site and can be included in deployments between sites.
* Cons:
  * You cannot guarantee that the folder or files will be present on a site or that they will be writable.
  * Using your own config means your users cannot harness the power of the .NET Core configuration system and move settings to environment variables or other key/value stores. This means that sensitive information may end up on disk.

#### Provide the users with appsettings.json snippets

You could choose to provide your users with a snippet they can copy into their `appsettings.json` file. This will ensure that the settings are stored in the correct location.

* Pro: Allows your users to fully control how and where the settings are stored (eg. secure key/value stores).
* Con: Requires the user to edit files on disk to get the settings in place.
