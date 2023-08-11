---
description: Instructions on installing Umbraco on various platforms using various tools.
---

# Installation

The easiest way to get the latest version of Umbraco up and running is by using the command line (CLI).

{% hint style="info" %}
These instructions will give you the latest stable release of Umbraco. If you are looking to install the latest preview, please refer to [Installing Preview Builds](installing-preview-builds.md).
{% endhint %}

1. Open your command line
2. Install the Umbraco templates with `dotnet new install Umbraco.Templates`
3. Run `dotnet new umbraco --name MyProject` to create a new project
4. Enter the project folder. It will be the folder containing the `.csproj` file
5. Run and build your project using `dotnet run`
6. The console will output a message similar to: `[10:57:39 INF] Now listening on: https://localhost:44339`
7. Open your browser and navigate to that URL in the console
8. Follow the instructions on the installer
