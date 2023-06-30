---
description: Learn about the recommended development environment to extend Umbraco.
---

# Setup Your Development Environment

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Required Software

Make sure you have the following installed on your machine:

* .NET 8
* Node.js 18.16

## IntelliSense

### Package manifests

The main configuration for extensions is loaded through package manifests. There is a number of ways to work with them including getting IntelliSense. Please make sure you have read the article [Package Manifest](package-manifest/) to learn more about this.

### Backoffice

Extensions for the Backoffice are written in JavaScript/TypeScript. When working with them, there is a way to get IntelliSense by looking installing our node package, which has everything you need:

1. Make sure you are working in an npm workspace by typing the command `npm init`
2.  Install the node package called @umbraco-cms/backoffice by running the command `npm install -D @umbraco-cms/backoffice`



If you are working with a prerelease of Umbraco, make sure to use the [MyGet registry](https://www.myget.org/feed/umbracoprereleases/package/npm/@umbraco-cms/backoffice) to find the proper version, for example, this command will give you the typings for version 14.0.0--preview001:

```
npm install -D --registry https://www.myget.org/F/umbracoprereleases/npm @umbraco-cms/backoffice@14.0.0--preview001
```
