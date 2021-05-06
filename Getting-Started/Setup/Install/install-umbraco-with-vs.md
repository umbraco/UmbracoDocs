---
versionFrom: 9.0.0
verified-against: alpha-4
state: partial
updated-links: false
---

# Install Umbraco with Visual Studio

_Follow these steps to do a full install of Umbraco using Visual Studio._

:::note
Please note that this article is valid only for Umbraco 9.
:::

## Abbreviated version

- You will get the best results if you use Umbraco's dotnet new templates
  - *For information on how to enable dotnet new templates to appear in Visual Studio check this [link](https://devblogs.microsoft.com/dotnet/net-cli-templates-in-visual-studio/)*
- You will need Visual Studio 2019 updated to version **16.8 at least**
- Go to `File` > `New` > `Project`, search for **Umbraco**
- Choose **Umbraco Project (Umbraco HQ)** then click *Next*
- In the next screen you can choose or specify different parameters but you can leave them all empty/default
- The final step to complete this dialog is to click *Create*
- Use CTRL+F5 to run the project and start the Umbraco installer

## New project

To install Umbraco we first need to install Umbraco's dotnet new templates.
*For more information check the first 2 steps of [Install Umbraco with .NET CLI](install-umbraco-with-templates.md#Install-the-template)*

:::note  
Check that your Visual Studio version is at least 16.8 (`Help` > `About Microsoft Visual Studio`), lower versions do not install the correct NuGet dependencies.  
:::

![Make sure you verify that you are using a compatible version of Visual Studio](images/VS/visual-studio-version-v9.png)

### Create project

Go to **File > New > Project** and search for `Umbraco` in the *Search for templates* field.

![](images/VS/create-project.png)

Once you select **Umbraco Project (Umbraco HQ)** navigate to the next step by clicking *Next*.

### Configure project

In this step, you will be able to give your project and solution a name.

![](images/VS/configure-project.png)

:::note  
Refrain from naming your solution `Umbraco`, as this will cause a namespace conflict with the CMS itself.  
:::

### Additional information

On the next step, you are able to specify some additional parameters like *Target framework*. The rest are optional.

![](images/VS/additional-info.png)

You can then click the *Create* button and your Umbraco Project will be ready for you.

![](images/VS/ready-solution.png)

### Running the site

You can now run the site like you would normally in Visual Studio (using **F5** or the **Debug** button).

Follow the installation wizard and after a few steps and choices you should get a message saying the installation was a success.
