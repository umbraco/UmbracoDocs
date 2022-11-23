---
meta.Title: "Installing Umbraco Plumber"
description: "Here you can find information about how to install Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Installing Umbraco Plumber

In this article, we will cover the steps required to install Umbraco Plumber on your website.

## Prerequisites

- [Umbraco Installation](../../../Fundamentals/Setup/Install/index.md)
- [Microsoft Visual Studio](https://visualstudio.microsoft.com/)

## Video Tutorial

<iframe width="800" height="450" title="Installing Umbraco Plumber" src="https://www.youtube.com/embed/w2GnZrEpufg?rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Umbraco Plumber Installation

There are different ways to install Umbraco Plumber:

- [.Net CLI Installation](#net-cli-installation)
- [Visual Studio Installation](#visual-studio-installation)

### .Net CLI Installation

To install the Umbraco Plumber package (Plumber.Workflow), follow these steps:

1. Run the following command to add a package reference to your Umbraco project:

    Umbraco version 10:

    ```cli
    dotnet add package Plumber.Workflow --version 10.0.1
    ```

    Umbraco version 8 or 9:

    ```cli
    dotnet add package Plumber.Workflow --version 2.1.8
    ```

2. Restart the web application using the following command:

    ```cli
    dotnet run
    ```

### Visual Studio Installation

To install via Visual Studio, follow these steps:

1. Open your project in Visual Studio.
2. Go to **Tools** -> **NuGet Package Manager** -> **Manage NuGet Packages for Solution...**.
3. Browse for **Plumber.Workflow**.
4. Select the appropriate version from the Version drop-down depending on the Umbraco version you are using.
5. Click Install.
   ![VS Installation](images/VS_Installation.png)
6. Once the package is installed, open the **.csproj** file to make sure the package reference is added:

  ```xml
  <ItemGroup>
    <PackageReference Include="Plumber.Workflow" Version="10.x.x" />
  </ItemGroup>
  ```

## Using Umbraco Plumber

Once the installation is completed, you will see the following in the Umbraco Backoffice:

- A Workflow Dashboard:

    ![Workflow dashboard](images/Workflow_dashboard.png)

- A Workflow section:

    ![Workflow section](images/Workflow_section.png)
