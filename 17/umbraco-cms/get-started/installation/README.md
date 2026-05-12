---
description: Instructions on installing Umbraco on various platforms using various tools.
---

# Installation

{% hint style="warning" %}
**Before you begin**

Ensure your environment meets the [System Requirements](requirements.md). You must have the latest [.NET SDK](https://dotnet.microsoft.com/download) installed and a compatible database ready.
{% endhint %}

## Quick Start: Install using CLI

The fastest way to get the latest version of Umbraco up and running is by using the command line (CLI).

1. Open your command line.
2. Install the Umbraco templates:

```bash
dotnet new install Umbraco.Templates
```

3. Create a new project:

```bash
dotnet new umbraco --name MyProject
```

{% hint style="info" %}
New projects created with this template use [Central Package Management (CPM)](https://learn.microsoft.com/en-us/nuget/consume-packages/central-package-management) by default. NuGet package versions are managed centrally in a `Directory.Packages.props` file created at the project root, rather than in the individual `.csproj` file. If you later add additional projects, you can move the `Directory.Packages.props` file to the solution root and version all dependencies in one place.
{% endhint %}

4. Navigate to the newly created project folder. It will be the folder containing the `.csproj` file:

```bash
cd MyProject
```

5. Build and run the newly created Umbraco site:

```bash
dotnet run
```

6. The console will output a message similar to: `[10:57:39 INF] Now listening on: https://localhost:44388`

{% hint style="info" %}
It is recommended to set up a developer certificate and run the website under HTTPS. If that has not yet been configured, run the following command:

```console
dotnet dev-certs https --trust
```
{% endhint %}

7. Open your browser and navigate to that URL.
8. Follow the instructions to finish up the installation of Umbraco.

{% hint style="info" %}
Members of the Umbraco Community have created a website that makes the installation of Umbraco a lot easier for you. You can find the website at [https://psw.codeshare.co.uk](https://psw.codeshare.co.uk). On the website, you can configure your options to generate the required script to run. Click on the Install Script tab to get the commands you need to paste into the terminal. This tab also includes the commands for adding a starter kit or unattended install which creates the database for you.
{% endhint %}

## Alternative Installation Methods

Choose the path that best fits your development environment and workflow.

| Method | Best For | Description |
| :--- | :--- | :--- |
| **[.NET CLI installation](install-umbraco-with-templates.md)** | All Platforms / Power Users | Detailed CLI commands for managing templates, custom project bootstrapping, and advanced NuGet options. |
| **[Visual Studio](visual-studio.md)** | Windows / Full IDE | The standard wizard-based setup for developers who prefer a full IDE experience on Windows. |
| **[Visual Studio Code](install-umbraco-with-vs-code.md)** | Lightweight / Cross-platform | A streamlined setup for developers using Visual Studio Code on macOS, Linux, or Windows. |
| **[Docker Compose](running-umbraco-on-docker-locally.md)** | Containerization | Spin up Umbraco and its database dependencies quickly in a consistent, isolated environment. |
| **[IIS & Local Hosting](iis.md)** | Windows Server | Guidance for hosting and running your local installation on Internet Information Services. |
| **[Linux / macOS](running-umbraco-on-linux-macos.md)** | Unix-based Native | Specific environment configurations and steps for running Umbraco natively on non-Windows systems. |
| **[Unattended Install](unattended-install.md)** | Automation & CI/CD | An automation-friendly setup—ideal for Azure Web Apps, build pipelines, and rapid deployments. |
| **[Nightly Builds](installing-nightly-builds.md)** | Early Adopters | Get early access to the latest "bleeding edge" features and fixes before the official release. |