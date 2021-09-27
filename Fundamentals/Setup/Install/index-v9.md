---
versionFrom: 9.0.0
verified-against: rc-003
state: complete
updated-links: true
meta.Title: "Installing Umbraco"
meta.Description: "Instructions on installing Umbraco on various platforms using various tools."
---

# Installation

The easiest way to get the latest version of Umbraco up and running is with the CLI.

1. Open your command line
2. Install the Umbraco templates with `dotnet new -i Umbraco.Templates`
3. Run `dotnet new umbraco --name MyProject` to create a new project
4. Enter the project folder, it will be the folder containing the `.csproj` file
5. Run and build your project using `dotnet run`
6. The console will output a message similar to: `[10:57:39 INF] Now listening on: https://localhost:44388`
7. Open your browser and navigate to that url
8. Follow instructions on the installer

Below you'll find some in-depth tutorials on the different ways to install Umbraco.

## [VS Code installation](install-umbraco-with-vs-code-v9.md)

Visual Studio Code is an editor with an embedded webserver (through the IIS Express extension). A fast way to get you up and running with Umbraco.

### [Run Umbraco on IIS](iis-v9.md)

Learn how to run an already installed local installation of Umbraco 9.

## [.NET CLI installation](install-umbraco-with-templates.md)

.NET CLI, included with the .NET SDK, can be used to install or uninstall .NET templates from NuGet using the `dotnet new` command on any OS. The underlying Template Engine enables the creation of custom templates which make new project bootstrapping much faster. With a few steps you can have an Umbraco project running without the need for a code editor.

## [Visual Studio installation](visual-studio.md)

Visual Studio is used to write native code and managed code supported by .NET and many others.
Its built-in tools provide the ability to develop and execute applications for any platform. Developers will be able to install Umbraco without ever having to leave Visual Studio.

## [Install Umbraco unattended](Unattended-Install-v9.md)

Use the Unattended installs when spinning up Umbraco instances on something like Azure Web Apps to avoid having to run through the installation wizard.
