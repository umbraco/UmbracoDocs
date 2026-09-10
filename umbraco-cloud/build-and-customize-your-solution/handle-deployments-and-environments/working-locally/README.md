---
description: >-
  This article explains how you can work with a local clone of your Umbraco
  Cloud project. The tutorial works with both Windows and Mac.
---

# Working with a Local Clone

{% hint style="info" %}
This article covers the initial clone of an Umbraco Cloud project and the first-time local setup. The cloned repository uses a SQLite database provided by Umbraco Cloud.
{% endhint %}

## Tools

You need the following tools to work with a local clone of your Umbraco Cloud project:

* Git needs to be installed on your computer to clone down the project and push your changes up to Cloud.
  * Use a command line tool (Git Bash or the terminal) or one of these Git GUI clients:
    * [Fork](https://git-fork.com/)
    * [SourceTree](https://www.sourcetreeapp.com/)
    * [GitKraken](https://www.gitkraken.com/)
* An IDE like [Microsoft Visual Studio](https://www.visualstudio.com/) or [JetBrains Rider](https://www.jetbrains.com/rider), for running the project on your local machine.
* The [.NET SDK version that matches your projects](https://docs.umbraco.com/umbraco-cms/get-started/installation/requirements) Umbraco CMS version.

{% hint style="info" %}

In the root of your local repository, you'll find a `Readme.md` file with details about the project structure and build process on Umbraco Cloud.

{% endhint %}

## Video Tutorial

{% embed url="https://www.youtube.com/embed/ZDuD9cl-iUc?rel=0" %}
Learn how to clone your Umbraco Cloud project and work with it locally.
{% endembed %}

## Cloning an Umbraco Cloud Project

To clone an Umbraco Cloud project, follow these steps:

1. Click **Clone** on the environment you want to work with locally.

<div align="center"><figure><img src="../../../.gitbook/assets/work-locally-clone-env.png" alt="Clone project option"><figcaption><p>Click "Clone" on a Cloud environment to copy the clone URL.</p></figcaption></figure></div>

The clone URL is now in your clipboard.

2. Paste the clone URL into your preferred Git Client.

If you are using a command line tool, use the following command:

```bash
git clone <Git clone URL>
```

{% hint style="info" %}

If this is the first time you're cloning a Cloud project to your machine, you will be prompted to login using Umbraco ID.

{% endhint %}

Once the repository has been cloned, you have a folder with files for your Umbraco Cloud project. This is your local repository containing everything you need to work locally with your Cloud project.

The screenshot below shows the project folder structure of a default Cloud environment.

![Cloned Project](../../../.gitbook/assets/work-locally-project-folder.png)

## Running the site Locally

Use a command line tool of your choice for the following steps. You can also refer to the `Readme.md` file found in the repository.

1. Open the command line tool in the newly cloned repository.
2. Run the following command:

```bash
cd src/UmbracoProject
```

3. Build and run the project:

```bash
dotnet build
dotnet run
```

The terminal output will show the application starting up and will include localhost URLs which you can use to browse to your local Umbraco site.

![Terminal Output](../../../.gitbook/assets/work-locally-terminal-output.png)

{% hint style="info" %}

Set up a developer certificate and run the website under HTTPS.

If you don't have a developer certificate already, run the following command:

```bash
dotnet dev-certs https --trust
```

{% endhint %}

The first time the Cloud project is run locally, you will see the **Restore from Umbraco Cloud** screen. If the cloned environment has Umbraco Deploy metadata files, they are automatically extracted with the option to restore content from Cloud to the local installation.

![clone dialog](../../../.gitbook/assets/work-locally-restore-screen.png)

Click **Restore** to restore your site's content if any. Wait until this process is completed as it also creates the local SQLite database for your site.

## Solution files and multiple .NET projects

When working locally, you can use whichever IDE you prefer. Refer back to the [Tools](#tools) section for recommendations.

1. Locate the `UmbracoProject.csproj` file in the repository.
2. Open it in your preferred IDE to start working locally with your Cloud project.

You can create content, add media, and write your custom code. When you're ready to deploy your changes make sure to have a look at the [deployments](../deployment/) documentation.

{% hint style="info" %}
If you have more than "a few" media items, see our recommendations for working with [Media on Umbraco Cloud](../media/).
{% endhint %}

### Adding a Solution File to your Cloud Project

Add a solution file to collaborate effectively on a Cloud project. This allows for adding additional .NET projects to your solution.

To add a solution file to your repository, you can do it using either of the following tools:

* [The Command Line](./#using-the-command-line)
* [Visual Studio](./#using-visual-studio)
* [Rider](./#using-rider)

#### Using the Command Line

Use a command line tool to follow these steps:

1. Navigate to the root of your repository.
2. Create the solution file using the following command:

```bash
dotnet new sln --name <MyAwesomeSolution>
```

3. Add your `UmbracoProject.csproj` file to the solution:

```bash
dotnet sln add src/UmbracoProject/UmbracoProject.csproj
```

#### Using Visual Studio

1. Open the `UmbracoProject.csproj` project in Visual Studio.
2. Select the solution in the Explorer.
3. Save the solution file using the **Save as** option.
4. Provide a **File name** to create the solution file in the folder that you specified.

{% hint style="info" %}
When creating a solution file, place it at the root of the git repository.
{% endhint %}

#### Using Rider

1. Open Rider.
2. Click on **New Solution**.
3. Select the **Empty Solution** template.
4. Give the solution a name, and ensure it's saved at the root of your repository.
5. Ensure that Rider does not create a directory for the solution.
6. Click **Create**.

The next step is to add your Cloud project's .NET project to the solution.

7. Right-click the solution in the Explorer pane.
8. Select **Add > Existing project...**.
9. Locate and open the `UmbracoProject.csproj` file in your repository.

### Adding Additional .NET Projects to Your Solution

{% hint style="info" %}

When creating new .NET projects alongside the default .NET project (`UmbracoProject.csproj`), add them to the `src` folder in the git repository.

{% endhint %}

To add additional .NET projects to your solution, you can do it using either of the following tools:

* [Command Line](./#command-line-1)
* [Visual Studio](./#visual-studio)
* [Rider](./#rider)

#### Command Line

Run the following commands to add additional .NET projects to your solution:

```bash
dotnet new classlib --name MyAdditionalProject.Web --output src/MyAdditionalProject.Web
dotnet sln add ./src/MyAdditionalProject.Web/MyAdditionalProject.Web.csproj
```

#### Visual Studio

1. Open the `UmbracoProject.csproj` project in Visual Studio.
2. Select the solution in the Explorer
3. Right-click the solution and choose **Add > New Project...**.
4. Add a class library to your solution using the latest .NET SDK.

Once the Class library (`.Core`) has been added, you can see the project(s) that have been added in Solution Explorer.

#### Rider

1. Open the solution in Rider.
2. In the **Explorer** pane, right-click the solution.
3. Select **Add** > **New Project...**.
4. Choose **Class Library** as the project type and configure the project name.
5. Set the location to the `src/` folder in your repository.
6. Click **Create**.

## Renaming the Project Files and Folders

To rename your Umbraco Cloud project files and folder, do the following:

1. Navigate to the `.umbraco` file at the root of the repository and view the following:

```csharp
[project]
base = "src/UmbracoProject"
csproj = "UmbracoProject.csproj"
```

The `base` property provides the folder location which contains the application and the `csproj` property is the name of the `.csproj` file.

1. Rename the `UmbracoProject` directory and `.csproj` file.
2. Update the `.umbraco` file with the new name and any C# code namespaces reflecting the name of your .NET project.
3. Add additional Class Library projects that are referenced by the Umbraco application `.csproj` file if you prefer to organize your code.
4. Clear the `bin` and `obj` folders in your repository to prevent any build errors.

For example: Rename `UmbracoProject.csproj` to `MyAwesomeProject.Web.csproj` and have one or more additional class library projects such as `MyAwesomeProject.Code.csproj`

```csharp
[project]
base = "src/MyAwesomeProject.Web"
csproj = "MyAwesomeProject.Web.csproj"
```

{% hint style="info" %}
It's a good practice to update the namespaces in the `Program.cs` and `_ViewImports.cshtml` files to ensure consistent naming throughout your solution.
{% endhint %}
