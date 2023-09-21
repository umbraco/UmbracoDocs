---
description: Learn about the recommended development environment to extend Umbraco.
---

# Setup Your Development Environment

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Required Software

Make sure you have the following installed on your machine:

* **.NET 8**
* **Node.js 18.16**

{% hint style="info" %}
Tip: use nvm (Node Version Manager for [Windows](https://github.com/coreybutler/nvm-windows) or [Mac/Linux](https://github.com/nvm-sh/nvm)
{% endhint %}

## Package Setup

### App\_Plugins

Extensions will go into a folder called `App_Plugins`. If you don't have this folder, you can create it at the root of your Umbraco project.

### Dependencies

* Install the node package called @umbraco-cms/backoffice by running the command `npm install -D @umbraco-cms/backoffice`

If you are working with a prerelease of Umbraco, make sure to use the [MyGet registry](https://www.myget.org/feed/umbracoprereleases/package/npm/@umbraco-cms/backoffice) to find the proper version. For example, this command will give you the typings for version `14.0.0--preview001`:

```
npm install -D --registry https://www.myget.org/F/umbracoprereleases/npm @umbraco-cms/backoffice@14.0.0--preview001
```

