---
meta.Title: "Installing Umbraco Plumber"
meta.Description: "Here you can find information about how to install Umbraco Plumber"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Installing Umbraco Plumber

In this article, we will cover the steps required to install Umbraco Plumber on your website.

## Prerequisites

- [Umbraco Installation](../../../Fundamentals/Setup/Install/index.md)
- [Microsoft Visual Studio](https://visualstudio.microsoft.com/)

## Umbraco Plumber Installation

There are different ways to install Umbraco Plumber:

- [.Net CLI](#net-cli-installation)
- [Visual Studio](#visual-studio-installation)

### .Net CLI Installation

To install the Umbraco Plumber package (Plumber.Workflow), follow these steps:

1. Run the following command to add a package reference to your Umbraco project:

    ```cli
    dotnet add package Plumber.Workflow --version 10.0.1
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
4. Select the latest version from the Version drop-down and click Install.
   ![VS Installation](images/VS_Installation.png)
5. Once the package is installed, open the **.csproj** file to make sure the package reference is updated:

    ```cli
    <ItemGroup>
        <PackageReference Include="Plumber.Workflow" Version="10.0.1" />
    </ItemGroup>
    ```

## Using Umbraco Plumber

Once the installation is completed, you will see the following in the Umbraco Backoffice:

- A **Workflow** Dashboard:

    ![Workflow dashboard](images/Workflow_dashboard.png)

- A **Workflow** section:

    ![Workflow section](images/Workflow_section.png)
