---
versionFrom: 9.0.0
meta.Title: "Package development good practice"
meta.Description: "Information on good practice and common defaults for Umbraco package development"
---

# Good practice and defaults
_This document provides some guides and notes on package development, and good practice that will help you maintain and support your package through multiple releases and versions of Umbraco. These good practices are not prescriptive, but mearly offer a guide as to what we have found works well, and not-so-well, when developing packages for Umbraco._

## App_Plugins
To extend the Umbraco backoffice, a package can provide files (like a `package.manifest` and AngularJS views/controlers) that should be stored within the `App_Plugins` folder. It's recommended to put all files in a subfolder with a unique name, preferrably using the package name, e.g. `App_Plugins\MyPackage`.

Files in the `App_Plugins` folder should be considered immutable, that is they are not something a user of your package should be expecting to change on their site.

The default delivery method for files to the `App_Plugins` folder is via a `.targets` file within a package: this means when a website is built, the files in this folder are copied over from the NuGet cache and any changes a user might have made to these files will be lost. Equally, if the user performs a `dotnet clean` on a solution, all files in the `App_Plugins` folder will be deleted.

If you have files that you expect users of your package to alter you should not place them in the `App_Plugins` folder.

## Views
Views are used to render content on the front end of a website. If your package provides a way for the user to present the content publicly, you should copy these files to the views folder.

As the files will still be copied during build you should ensure your target file doesn't overwrite newer or altered files and doesn't delete files on clean.

_This method isn't perfect and if you do have a package that is heavy on views you might consider building a dotnet template or Razor Class Library (RCL) to contain the views, so they don't pollute your user's solutions._

## License files
Umbraco products store their licenses in `/umbraco/Licences` and it is considered a good location for third party packages that require license files to also store their licence files there.

_The default .gitignore for Umbraco templates will include any files in this folder in a repo (while ignoring most of the rest of the Umbraco folder)._

:::note
The `/umbraco/Licenses` folder does not exist on a fresh installation of Umbraco so you might need to create it before you save your license file to this folder.
:::

## Operating system considerations
Umbraco (version 9 and up) is an ASP.NET Core application and can be ran on multiple operating systems (e.g. Windows, Linux and macOS). When developing packages there are a few things you should be aware of so your package can run on all possible operating systems.

### Case sensitivity 
The Linux and macOS file system is case sensitive (by default), so `App_Plugins/myPackage` is a different location to `app_plugins/MyPACKAGE`. When building your package you should ensure that you always refer to folders and paths in a consistent way.

:::tip
You can adjust the case sensitivity of a Windows folder by running a command against the folder.

```bash
fsutil.exe file queryCaseSensitiveInfo <path>
```
:::

### Well known folders and case sensitivity
Some folders within Umbraco will already exist for all installations, if you access these folders you need to be aware of the case used to ensure you end up in the right place:

| Folder | Note | 
|-|-|
| /App_Plugins | Uppercase `A` and `P` |
| /App_Plugins/[Ll]ang | Uppercase `L` but in later version of Umbraco 9.3+ can be upper or lowercase `L` |
| /Views | Uppercase `V` | 
| /umbraco/Licenses | Lowercase `u` uppercase `L` |
| /config | Lowercase `c` |

:::note
If you create a custom section/tree, Umbraco will also build paths based on the name of that section or tree, these folder paths will also be case sensitive.

For example: if you have a custom tree with the treeAlias of `MyCustomTree` Umbraco will look for files in `App_Plugins\MyCustomTree\backoffice\MyCustomTree\`.
:::

### File/folder locations
You should never hardwire a file or folder location into code if possible. Instead you should either access files using the ASP.NET Core file providers from `IHostingEnvironment` or by using the built-in methods to access well known locations:

#### Temp folder
The location of the Umbraco temp folder can be controlled via configuration and cannot be assumed, you should use the `IHostingEnvironment.LocalTempPath` variable to locate the temp folder. 

```cs
var localTempRoot = Path.GetFullPath(hostingEnvironment.LocalTempPath);
```

#### Relative paths
If you require the path of a folder relative to the site root, you can use the `IHostingEnvironment` methods to map a path:

```cs
var contentRootPath = hostingEnvironment.MapPathContentRoot("~/"); // Full physical path to the content/project root
var webRootPath = hostEnvironment.MapPathWebRoot("~/"); // Full physical path to the web root (served publicly)
var absolutePath = hostEnvironment.ToAbsolute("~/"); // Absolute path to use as URL
```

### Folder access
You should not assume things about the folder structure of a site, and ideally you should not use direct IO commands to access the file system. Within an ASP.NET Core site access to the disk is usually managed with File Providers: you can get access to the file providers from the `IWebHostEnvironment` class.

As an example, if you wanted to read a file called `robots.txt` from the `wwwroot` folder of a site, then in a controller you can use the `WebRootFileProvider` to get to the root of the site and read the file:

```cs
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

:::note
This is the preferred method for file I/O, because not all files served up by a site may in fact be in the wwwroot folder when you expect them to be - this is especially true if the site is using Razor Class Library projects to insert static files.
:::

### Path manipulation
Building folder path strings manually can cause problems when swapping between file systems. Windows uses the backslash character ('\\') to separate folders and files, Linux uses the forward slash ('/').

You should use the .NET `Path` commands wherever possible when building paths to ensure that the correct path is built:

```cs
// WRONG: Don't build paths manually
var myPath = webrootPath + "\robots.txt";

// CORRECT: Build the path using the correct separator for the current file system
var myPath = Path.Combine(webrootPath, "robots.txt");
```

If you do need to build a path manually use `Path.DirectorySeparatorChar` to get the correct separator for the file system.

## Settings
All but the most simple package will probably require some settings to be stored for the users to control and change the behavior of how the package works on a site. Where you store these settings will depend a lot on the nature of the package.

### Property Editors
Property Editors should store their settings as part of their data type in Umbraco. This is the standard way property editors behavior is controlled, it is familar to users and is supported by deployment tools.

### Don't save to appsettings.json
You should not alter `appsettings.json` in code.

Settings in ASP.NET Core are merged from a number of different locations at runtime. You cannot guarantee that `appsettings.json` is the location that a setting is read from and your users may well not want certain settings in that file. You can read settings from the configuration, but you cannot assume they have come from `appsettings.json`.

### Settings locations
There are many options for where you might save your settings and a lot will depend on the nature of your package:

#### Save to database
Settings can be saved to the database, usually in a custom table.

- Pros:
  - Settings will be accessible directly from the database, and not dependent on deployed files on disk.
- Cons:
  - Will require some setup to create the database tables for the settings to live in.
  - The settings will only be available to the specific instance of the site, and any settings will not be deployed between a local, dev or stage site.

#### Save to disk
You could choose to save settings to disk (e.g in the `/config` folder in root of site).

- Pros:
  - Settings will be accessible to the site, and can be included in deployments between sites.
- Cons:
  - You cannot guarantee that the folder or files will be present on a site or that they will be writable.
  - Using your own config means your uses cannot harness the power of the .NET Core options system and move settings to the environment or key stores, meaning sensitive information may end up on disk.

#### Provide user with appsettings.json snippets
You could choose to provide your user with a snippet that they can copy into their appsettings.json file, so settings are stored in the correct location.

- Pro: Allows your users to fully control how and were there settings are stored (eg. secure key vaults).
- Con: Requires the user to edit files on disk to get your settings in place.
