# Upgrading Umbraco Workflow

This article shows how to manually upgrade Umbraco Workflow to run the latest version. Umbraco Workflow displays a prompt in the **Workflow** section when a new version is available.

{% hint style="info" %}
If you are migrating from Plumber to Umbraco Workflow, see the [Migrate from Plumber to Workflow](migrating-workflow.md) article.
{% endhint %}

## Get the latest version of Umbraco Workflow

You must upgrade to the closest [Long-term Support (LTS) major](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/) version before upgrading to the latest version. For Umbraco Workflow 18, the closest long-term support version is Umbraco Workflow 17. Once the project is on version 17, you can move on to 18.

To get the latest version of Umbraco Workflow, you can upgrade using either of the two options:

* [NuGet](upgrading.md#nuget)
* [Visual Studio](upgrading.md#visual-studio)

### NuGet

*   NuGet installs the latest version of the package when you use the `dotnet add package Umbraco.Workflow` command unless you specify a package version:

    `dotnet add package Umbraco.Workflow --version <VERSION>`
* Run `dotnet restore` to install the package.

### Visual Studio

* Go to `Tools` -> `NuGet Package Manager` -> `Manage NuGet Packages for Solution...` in Visual Studio, to upgrade Umbraco Workflow:
* Select **Umbraco.Workflow**.
*   Select the latest version from the **Version** drop-down and click **Install**.

    ![NuGet Package Manager](../.gitbook/assets/VS_Installation-v14.png)
*   Open the **.csproj** file to make sure the package reference is updated:

    ```xml
    <ItemGroup>
      <PackageReference Include="Umbraco.Workflow" Version="14.x.x" />
    </ItemGroup>
    ```
