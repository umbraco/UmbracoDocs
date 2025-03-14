---
description: Learn how to get your Umbraco packages listed on the Umbraco Marketplace.
---

# Listing Your Package

Do you want to be listed on the official Umbraco Marketplace? Follow this guide to get your package or integration listed on the [Umbraco Marketplace](https://marketplace.umbraco.com).

## Requirements

Your package needs to live up to the following requirements to be listed on the Umbraco Marketplace:

* The `umbraco-marketplace` tag is added to your NuGet package.
* It meets the minimum Umbraco version requirement: **Umbraco 8**

The base package information is then sourced from NuGet, including the package name, icon, authors, description, readme, and project URL.

{% hint style="warning" %}
Please only tag the installable component of your package. For example, if your package `MyPackage` references `MyPackage.Core`, only tag the former.
{% endhint %}

## Additional Package Information

You may choose to add a `umbraco-marketplace.json` file to provide deeper information about your package.

This file must exist in the folder indicated by the project URL in your NuGet specification.

For example, if your project URL is `https://mypackage.com`, we will look for the file at `https://mypackage.com/umbraco-marketplace.json`.

If your project URL is your GitHub repository we will check the root of the default branch, or a deeper link if provided.

It is also possible to use a single website for multiple packages. In this case, create a JSON file for each package, suffixed with the package ID.

For example, if your package ID is `My.Package`, we will look for `https://mypackage.com/umbraco-marketplace-my.package.json`.

### Custom "README" information

We have implemented an import for a custom "README" file for the Umbraco Marketplace. This can be used if you want to display different information here than on nuget.org.

By default, we will import and display the "README" content made available as part of the NuGet package. However, if we find a file by the name of `umbraco-marketplace-readme.md` in the same location as the `umbraco-marketplace.json` file, we will import and display that instead.

We will look for an import a file with a package-specific name, e.g. `umbraco-marketplace-readme-my.package.md`.

### JSON Schema

In order for the additional package information to be imported, the file contents need to match the JSON schema we expect.

The [schema for the JSON file is available](https://marketplace.umbraco.com/umbraco-marketplace-schema.json) which is illustrated and described as follows. All values are optional and can be empty or omitted.

```json
    {
      "$schema": "https://marketplace.umbraco.com/umbraco-marketplace-schema.json",
      "AddOnPackagesRequiredForUmbracoCloud": [],
      "AlternateCategory": "",
      "AuthorDetails": {
        "Name": "",
        "Description": "",
        "Url": "",
        "ImageUrl": "",
        "Contributors": [
          {
            "Name": "",
            "Url": ""
          }
        ],
        "SyncContributorsFromRepository": true|false
      },
      "Categories": "",
      "Description": "",
      "DiscussionForumUrl": "",
      "DocumentationUrl": "",
      "LicenseTypes": [ "" ],
      "IssueTrackerUrl": "",
      "IsSubPackageOf": "",
      "PackageType": "",
      "PackagesByAuthor": [],
      "RelatedPackages": [
        {
          "GroupTitle": "",
          "PackageId": "",
          "Description": ""
        }
      ],
      "Screenshots": [
        {
          "ImageUrl": "",
          "Caption": ""
        }
      ],
      "Tags": [],
      "Title": "",
      "VersionDependencyMode": "",
      "VersionSpecificPackageIds": [
        {
          "UmbracoMajorVersion": 8,
          "PackageId": ""
        }
      ],
      "VideoUrl": ""
    }
```

### Description of each element

| **Element**                                      | **Data Type**    | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ------------------------------------------------ | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  |
| **AddOnPackagesRequiredForUmbracoCloud**         | String array     | Provides a collection of package IDs defining additional packages necessary for install to use the package on Umbraco Cloud. For example, when using `Umbraco.Forms`, `Umbraco.Forms.Deploy` is required.                                                                                                                                                                                                                           |
| **AlternateCategory**                            | String value     | The name of a second, alternate category as defined on the marketplace website. The package will be displayed under this category, as well as the main one selected.                                                                                                                                                                                                                                                                |
| **AuthorDetails.Name**                           | String value     | The name of the package developer(s). If the name is provided, it will be used in preference to the value retrieved from the NuGet package's Authors field.                                                                                                                                                                                                                                                                         |
| **AuthorDetails.Description**                    | String value     | A short description of the package developer. One or two sentences is recommended.                                                                                                                                                                                                                                                                                                                                                  |
| **AuthorDetails.Url**                            | String value     | A URL to the package developer's blog, profile or company website.                                                                                                                                                                                                                                                                                                                                                                  |
| **AuthorDetails.ImageUrl**                       | String value     | A URL to a headshot or avatar image for the package developer (`.png` or `.jpg`). To use an existing GitHub avatar, use `https://github.com/{username}.png`                                                                                                                                                                                                                                                                         |
| **AuthorDetails.Contributors**                   | Array of objects | A collection of key contributors can also be provided, each having a required name and an optional URL.                                                                                                                                                                                                                                                                                                                             |
| **AuthorDetails.SyncContributorsFromRepository** | Boolean value    | If contributors are not explicitly provided, a GitHub repository is available in the 'RepositoryUrl' of the NuGet package. This option is set to `true`; the contributors will be synchronized from the GitHub repo.                                                                                                                                                                                                                |
| **Category**                                     | String value     | The name of a single category as defined on the marketplace website. The package will be displayed under this category on the website.                                                                                                                                                                                                                                                                                              |
| **Description**                                  | String value     | The package description. If omitted, the Description defined in the NuGet package details will be used. A short paragraph of text is recommended.                                                                                                                                                                                                                                                                                   |
| **DocumentationUrl**                             | String value     | A URL to a the documentation related to the package.                                                                                                                                                                                                                                                                                                                                                                                |
| **DiscussionForumUrl**                           | String value     | A URL to a discussion forum related to the package.                                                                                                                                                                                                                                                                                                                                                                                 |
| **IssueTrackerUrl**                              | String value     | A URL to an issue tracker related to the package.                                                                                                                                                                                                                                                                                                                                                                                   |
| **IsSubPackageOf**                               | String value     | The NuGet package ID of a "parent" package, allowing for packages with multiple subtle variations to be displayed under a single listing.                                                                                                                                                                                                                                                                                           |
| **LicenseTypes**                                 | Array of strings | The types of license available for the package.                                                                                                                                                                                                                                                                                                                                                                                     |
| **LookingForContributors**                       | Boolean value    | Set to true if you'd like your package indicated on the Marketplace as looking for contributors to help with development or support.                                                                                                                                                                                                                                                                                                |
| **LookingForMaintainer**                         | Boolean value    | Set to true if you are looking to move away from supporting your package and would welcome someone stepping forward as a new maintainer.                                                                                                                                                                                                                                                                                            |
| **PackageType**                                  | String value     | The type of package.                                                                                                                                                                                                                                                                                                                                                                                                                |
| **PackagesByAuthor**                             | String array     | A collection of NuGet package IDs for packages that are built by the same author and are also listed on the Umbraco Marketplace. If this information isn't provided, the display of packages by the same author will be derived from the package owners specified for the NuGet package.                                                                                                                                            |
| **RelatedPackages**                              | Object array     | A collection of complementary packages that are also listed on the Umbraco Marketplace. Each element should contain the package ID along with a short description amd group title (both optional). The idea of the description is to provide additional context of why the two packages work well together. The group title can be used to group the related packages (see below for details).                                      |
| **Screenshots**                                  | Object array     | A collection of screenshots for displaying on the package details page. Each element should consist of a URL to the image file and a short caption.                                                                                                                                                                                                                                                                                 |
| **Tags**                                         | String array     | One or more package owner-defined tags for the package. Multiple word tags are supported, e.g. "property editor".                                                                                                                                                                                                                                                                                                                   |
| **Title**                                        | String value     | The package title. If omitted, if a title is defined in the NuGet package details this will be used. Otherwise, the package ID itself is displayed.                                                                                                                                                                                                                                                                                 |
| **VersionDependencyMode**                        | String value     | The version dependency mode for the package.                                                                                                                                                                                                                                                                                                                                                                                                                |
| **VersionSpecificPackageIds**                    | Object array     | If a developer has created their package for older Umbraco versions under a different package ID, they can be listed here. Each element should contain an integer value for the Umbraco major version and the associated NuGet package ID.                                                                                                                                                                                          |
| **Video URL**                                    | String value     | A URL to a video for embedding.                                                                                                                                                                                                                                                                                                                                                                                                     |

### Categories

When defining categories for your package, they need to match one of the following:

* Analytics & Insights
* Artificial Intelligence
* Campaign & Marketing
* Commerce
* Developer Tools
* Editor Tools
* Headless
* PIM & DAM
* Search
* Themes & Starter Kits
* Translations

### License Types

When defining the License Type for your package, use one of the following values:

* Free
* Purchase
* Subscription

### Package Type

When defining the Package Type for your package, use one of the following values:

* Package
* Integration

An "Integration" provides a connection between Umbraco and a third-party service that a customer has an account with. All other add-ons are considered as a "Package", which is also the default when nothing is specified for this value.

### Version Dependency Mode

When defining the Version Dependency Mode for your package, use one of the following values:

* Default
* SemVer

Your Umbraco package will either have a direct or an indirect dependency on Umbraco, which will be reported via NuGet. We use this, across all versions of your package, to determine the minimum and maximum supported versions of Umbraco.

In most cases, we take what we retrieve from NuGet and present that unaltered on the Marketplace.

There is currently one exception though. Many packages are listed with a minimum version of Umbraco as a dependency, but no maximum. Strictly this means the package claims to support not only the minimum selected, but any subsequent major versions of Umbraco too. For major releases with minimal breaking changes, such as Umbraco 9 through 13, this is likely correct. So there is no problem in reporting this compatibility on the website.

With the introduction of Umbraco 14 though, and the significant breaking change of the new backoffice, this is no longer likely to be true. We assume if a package has a minimum version or 13 or less, and an unlimited maximum, that it won't support Umbraco 14. And that's what we'll show on the Marketplace.

For any package that makes backoffice customization, this is almost certainly correct.

Some packages though have no user interface component, and will likely work in Umbraco 14 without modification. If that's the case for you, there are two options:

- Release a new version with a minimum dependency on Umbraco 14, or a maximum exclusive dependency on Umbraco 15.
- Set this option in the `umbraco-marketplace.json` file to `SemVer`
    - Via this setting you are indicating that we should take what is defined in NuGet as strictly correct. And as such, we'll import the unlimited maximum and report the package as working on any major version of Umbraco according to the semantic version range.

### Related Packages

When providing a list of related packages, you have the option to organize them into separate groups, each with a title.

When a group title is provided, the package, and subsequent ones that don't have a title assigned, will be presented within a group. If a later package has a group title, that will start a new group.

The example below will be rendered as two separate groups, each with two packages:


```json
"RelatedPackages": [
    {
      "PackageId": "Package.One",
      "GroupTitle": "Group One"
    },
    {
      "PackageId": "Package.Two",
    },
    {
      "PackageId": "Package.Three",
      "GroupTitle": "Group Two"
    },
    {
      "PackageId": "Package.Four",
    }
  ],
```

`Package.One` and `Package.Two` will be part of Group One, while `Package.Three` and `Package.Four` will be part of Group Two.

### Video URL

When defining the Video URL for your package, use one of the following formats:

* `https://www.youtube.com/embed/{videoId}`
* `https://www.youtube.com/watch?v={videoId}`
* `https://player.vimeo.com/video/{videoId}`

### Validation

Want to check how the Umbraco Marketplace parses your package? [Try the validation tools](https://marketplace.umbraco.com/validate).

## Synchronization With NuGet and Package Owner Data

The schedule for retrieving the latest information from NuGet and any further information provided by the package owners is as follows:

| **Operation**                                     | **Schedule**                                        |
| ------------------------------------------------- | --------------------------------------------------- |
| **Scan NuGet for new tagged packages**            | Every 24 hours at 0400 (Coordinated Universal Time) |
| **Refresh the information on the known packages** | Every 2 hours                                       |
| **Refresh the NuGet download counts**             | Every 1 hour                                        |

If you can't wait, it's possible to trigger the process for a single package by making an HTTP `POST` request to `https://functions.marketplace.umbraco.com/api/InitiateSinglePackageSyncFunction`.

The request should include a `Content-Type` header of `application/json` and a body of:

```json
{
  "PackageId": "MyPackage"
}
```

This endpoint is throttled such that only one request a minute can be made per package ID.

## Feedback

If you run into any issues with listing your package, please file an issue on the [Issue Tracker](https://github.com/umbraco/Umbraco.Marketplace.Issues/issues/).

We will periodically send details of updates made to registered package developers.

If you aren't currently receiving these updates from Umbraco you can [sign up for this newsletter](https://umbraco.activehosted.com/f/6).
