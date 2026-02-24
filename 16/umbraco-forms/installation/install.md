---
description: This article covers two ways to install Umbraco Forms.
---

# Installing Umbraco Forms

Install Umbraco Forms following either of the two guides:

* [Via NuGet](install.md#installation-via-nuget), or
* [Via a Terminal](install.md#installing-using-the-terminal).

## Prerequisites

An Umbraco CMS website set up locally or in a development environment.

## Installation via NuGet

To install Umbraco Forms using NuGet in Visual Studio, follow these steps:

1. Open the project in Visual Studio.
2. Go to **Tools** -> **NuGet Package Manager** -> **Manage NuGet Packages for Solution**.
3. Select the **Browse** tab.
4. Search for `Umbraco.Forms`.
5. Select the package.
6. Choose the project you want to install it into.
7. Install the latest stable version of the package.

## Installing using the terminal

You can also install Umbraco Forms using a terminal. Follow these steps:

1. Open a terminal of your choice.
2. Navigate to the folder containing your Umbraco CMS project.
3. Install the `Umbraco.Forms` NuGet package with the following command:

```console
dotnet add package Umbraco.Forms
```

4. Build and run your project.

## Start Building Forms

Once the installation is complete and the site is running, you will see a **Forms** section in the Umbraco backoffice similar to the screen below:

![Create form](../.gitbook/assets/start-with-forms-v14.png)

The next step is to [configure the license](the-licensing-model.md).

## Using Forms

For details on creating and managing forms, see the [Editor Documentation](../editor/creating-a-form/).
