---
description: Instructions on installing Umbraco on various platforms using various tools.
---

# Installation

## Install Umbraco using CLI

The fastest way to get the latest version of Umbraco up and running is using the command line (CLI).

1. Open your command line.
2. Install the Umbraco templates:

```bash
dotnet new install Umbraco.Templates::13.*`
```

e.g.

```bash
dotnet new install Umbraco.Templates::13.8.1`
```

3. Create a new project:

```bash
dotnet new umbraco --name MyProject
```

4. Navigate to the newly created project folder. It will be the folder containing the `.csproj` file:

```bash
cd MyProject
```

5. Build and run the newly created Umbraco site:

```bash
dotnet run
```

6. The console will output a message similar to: `[10:57:39 INF] Now listening on: https://localhost:44388`
7. Open your browser and navigate to that URL.
8. Follow the instructions to finish up the installation of Umbraco.

{% hint style="info" %}
Members of the Umbraco Community have created a website that makes the installation of Umbraco a lot easier for you. You can find the website at [https://psw.codeshare.co.uk](https://psw.codeshare.co.uk). On the website, you can configure your options to generate the required script to run. Click on the Install Script tab to get the commands you need to paste into the terminal. This tab also includes the commands for adding a starter kit or unattended install which creates the database for you.
{% endhint %}

## Alternative Methods for Installing Umbraco

There are numerous ways to install Umbraco. Below, you can find links to different installation methods that will help you easily install and set up Umbraco projects.&#x20;

### [.NET CLI installation](install-umbraco-with-templates.md)

.NET CLI, included with the .NET Software Development Kit (SDK), can be used to install or uninstall .NET templates from NuGet. This can be done by using the `dotnet new` command on any OS. The underlying Template Engine enables the creation of custom templates which make new project bootstrapping much faster. With a few steps you can have an Umbraco project running without the need for a code editor.

### [Visual Studio installation](visual-studio.md)

Visual Studio is used to write native code and managed code supported by .NET and many others. Its built-in tools provide the ability to develop and execute applications for any platform. Developers will be able to install Umbraco without ever having to leave Visual Studio.

### [Run Umbraco on IIS](iis.md)

Learn how to run an already installed local installation of Umbraco.

### [VS Code installation](install-umbraco-with-vs-code.md)

Visual Studio Code is an editor with an embedded webserver (through the IIS Express extension). A fast way to get you up and running with Umbraco.

### [Installing Nightly Builds](installing-nightly-builds.md)

From Umbraco v9 and above you can use the Nightly Builds to get the latest version to use and test before it is released. Learn how to install the Nightly builds to get started.

### [Running Umbraco on Linux/macOS](running-umbraco-on-linux-macos.md)

Since Umbraco 9 it has been possible to run Umbraco CMS natively on Linux or macOS High Sierra. To get Umbraco running you will need to follow some steps.

### [Install Umbraco unattended](unattended-install.md)

Use the Unattended installs when spinning up Umbraco instances on something like Azure Web Apps to avoid having to run through the installation wizard.
