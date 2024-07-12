---

meta.Title: "Umbraco Packages"
description: "A package extends the functionality of Umbraco to provide additional functionality to editors, developers, site visitors, and all other types of users of Umbraco."
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

A package that can be categorized as a Schema Extension will extend the default Umbraco Schema. Schema in this sense refers to things like Data Types, Property Editors, Document Types and Media Types. By extending Umbraco with packages such as [Umbraco Commerce](https://docs.umbraco.com/umbraco-commerce) editors are given greater capabilities when they are populating their content pages.

#### Management Extensions

A Management Extension package helps you manage your site, and provides information to the users. Management extensions typically contain custom sections or dashboards to facilitate site management. [Diplo God Mode](https://marketplace.umbraco.com/package/diplo.godmode) is an example of a comprehensive management extension package with additional tools and information.

#### Starter Kits

Starter kits are, as the name suggests, a package that helps you set up a starter version of whatever you want to build. Most starter kit packages are for starting a website, and include schema like Document Types and Templates as well as content nodes and media. There are also some specialized starter kits, for example for creating a blog. Umbraco HQ has released their [own starter kit](https://www.nuget.org/packages/Umbraco.TheStarterKit), that creates a small site with the most commonly used features.

#### Content Apps

Content apps are almost like dashboards for content nodes that are intended to display node specific information. A good example of this is the [Preflight](https://marketplace.umbraco.com/package/preflight.umbraco) content app. It shows you readability scores for your written content, directly on each content node.

#### Integration extensions

This type of package can be a lot of things, and can include a number of the other package types. They are generally integrating a larger system into Umbraco. A good example could be an e-commerce package such as [UCommerce](https://marketplace.umbraco.com/package/ucommerce.umbraco8), that includes an entire webshop module for Umbraco.

## [Types of Packages](types-of-packages.md)

Packages for Umbraco 10 and above are installed as NuGet packages.

## [Creating a Package](creating-a-package.md)

This short tutorial will teach you how to create a package in the Umbraco backoffice. It will also give a quick overview of what a generated package will contain.

## [Language file for packages](language-files-for-packages.md)

Package authors who would like their UI to be multi-lingual can include their own set of language files as part of their package distribution.

## [Listing a Package on the Umbraco Marketplace](listing-on-marketplace.md)

Once you've created a package make it available on the Umbraco Marketplace to share it with the community.

## [Packages on Umbraco Cloud](packages-on-umbraco-cloud.md)

Things you should know if you are developing for Umbraco Cloud.

## [Maintaining Packages](maintaining-packages.md)

Some guidance on how to maintain your package after release.

## [An Example Package Repository](example-package-repository.md)

There are many ways to build and deploy your package to NuGet. You will likely have your own approach for organizing a solution and preferred tools for build and deployment.

If you are looking for inspiration to follow form some tried and tested packages, read more here.
