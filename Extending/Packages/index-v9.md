---
versionFrom: 9.0.0
v8-equivalent: "https://github.com/umbraco/UmbracoDocs/blob/main/Extending/Packages/index.md"
verified-against: alpha-3
state: complete
updated-links: true
---

# Packages

## What is a Package?

A package extends Umbraco to provide additional functionality to editors, developers, site visitors, and all other types of users of Umbraco. It can impact one or more of these groups of people depending on the type of package.

An Umbraco Package can be many things, but is generally characterized by:

- Adding or extending functionality in the Umbraco CMS
- Empowering people to do more and/or do things more efficiently
- Engaging community members in collaboration and sharing
- Solving real life problems
- Inspiring people on what Umbraco can be made capable of

### Categories of packages

Packages provide a wide variety of functionality, and can often span multiple categories. In general, though, the functionality they provide fall into these main groups:

- [Schema Extensions](#schema-extensions)
- [Management Extensions](#management-extensions)
- [Starter Kits](#starter-kits)
- [Content Apps](#content-apps)
- [Integration Extensions](#integration-extensions)

#### Schema Extensions

A package that can be categorised as a Schema Extension will extend the default Umbraco Schema. Schema in this sense refers to things like Data Types, Property Editors, Document Types and Media Types. By extending Umbraco with packages such as [Our.Umbraco.GMaps](https://our.umbraco.com/packages/backoffice-extensions/ourumbracogmaps-google-maps-for-umbraco-8/) editors are given greater capabilities when they are populating their content pages.

#### Management Extensions

A Management Extension package helps you manage your site, and provides information to the users. Management extensions can be made of many different parts, but often they include custom sections or dashboards for you to manage something.
A good example of a management extension package is [Diplo God Mode](https://our.umbraco.com/packages/developer-tools/diplo-god-mode/) which gives you a lot of extra info and tools to manage your site.

#### Starter Kits

Starter kits are, as the name suggests, a package that helps you set up a starter version of whatever you want to build. Most starter kit packages are for starting a website, and include schema like Document Types and Templates as well as content nodes and media. There are also some quite specialised starter kits, for example for creating a blog. Umbraco HQ has released their [own starter kit](https://our.umbraco.com/packages/starter-kits/the-starter-kit/), that creates a small site with the most commonly used features.

#### Content Apps

:::note
Content Apps are only available from Umbraco 8
:::

Content apps are almost like dashboards for content nodes that are intended to display node specific information. A good example of this is the [Preflight](https://our.umbraco.com/packages/backoffice-extensions/preflight-content-health-checks-for-umbraco-8/) content app. It shows you readability scores for your written content, directly on each content node.

#### Integration extensions

This type of package can be a lot of things, and can include a number of the other package types. They are generally integrating a larger system into Umbraco. A good example could be an e-commerce package such as [UCommerce](https://our.umbraco.com/packages/website-utilities/ucommerce/), that includes an entire webshop module for Umbraco.

## [Types of Packages](./package-types.md)

There are two common types of package for Umbraco: Package zip files and NuGet Packages.

## [Creating a Package](./creating-a-package.md)

This short tutorial will teach you how to create a package in the Umbraco backoffice. It will also give a quick overview of what a generated package will contain.

## [Creating a NuGet Package](./creating-a-nuget-package.md)

This short tutorial will teach you how to create a NuGet package for your Umbraco code.

## [Package Actions](./package-actions.md)

Package actions are actions you want to trigger when your package gets installed. 

## [Uploading a Package to Our](./uploading-to-our.md)

Once you've created a package upload it on Our to share it with the community.

## [UmbPack](UmbPack/index.md)

 Dotnet tool for packing and deploying packages to Our. Can be used to automate updates to packages.

## [Packages on Umbraco Cloud](./packages-on-Umbraco-Cloud.md)

Things you should know if you are developing for Umbraco Cloud.

## [Maintaining Packages](./maintaining-packages.md)

Some guidance on how to maintain your package after release.
