---
versionFrom: 9.0.0
---

# Working with Visual Studio and Umbraco 9 on Umbraco Cloud

In this article you will learn how to work with Visual studio and Umbraco 9 on a Umbraco Cloud project on your local machine, you will also learn 

## Get started with Visual Studio

The first step to get started working with Umbraco 9 and Visual studio is to clone down your project from Umbraco Cloud.

This can be done by following the [Working Locally guide](../Working-Locally) for Umbraco Cloud.

Once you have cloned down your project you will get a folder with the name you gave the project, with the files for your Umbraco Cloud project.

![Umbraco 9 files](images\V9-files.png)

With the files in place you can now navigate to your project folder and make sure to go to src/UmbracoProject, here you will find the files for your Umbraco installation.

You will notice that in the folder there is a csproj-file called: `UmbracoProject.csproj`:

![Umbraco 9 files](images\V9-project-file.png)

Opening this file will open up yor project in visual studio and you can start building and running your solution and start working with Visual studio.

### Adding a Solution file

Working with Visual Studio you will likely want a solution file, so you and your team can easily work with the Umbraco Cloud project from within Visual Studio and have the option to add additional projects.

From the terminal of your choice navigate to the root of the git repository for your Umbraco Cloud project, and enter the following command.

```Text
dotnet new sln --name MyAwesomeSolution
```

:::tip
When creating a solution file we recommend that you place it in the root of the git repository.
:::

If you want to add additional projects to your solution, you can do that from the command line as well using the following `dotnet new` command

```Text
dotnet new classlib --name MyAwesomeProject.Web --output src/MyAwesomeProject.Web
dotnet sln add .\src\MyAwesomeProject.Code\MyAwesomeProject.Code.csproj
dotnet sln add .\src\MyAwesomeProject.Web\MyAwesomeProject.Web.csproj
```

:::tip
 When creating new projects along side the default UmbracoProject, we recommend that they are added to the src folder in the git repository.
:::

### Renaming the project file and folder

At the Root of the project there is a file called .Umbraco which contains the following:

```Text
[project]
base = "src/UmbracoProject"
csproj = "UmbracoProject.csproj"
```

These two properties help inform us the folder location which contains the application and the second is the name of the .csproj file to build.

You can rename the folder and .csproj file to whatever you want, you may also want to update any C# code namespaces to reflect the name of your project.

In addition to this you are able to add additional Class Library projects that are referenced by the Umbraco application .csproj file, if you prefer to organise your code that way.

An examoke could be to rename `UmbracoProject.csproj` to `MyAwesomeProject.Web.csproj` and have one or more additional class library projects such as `MyAwesomeProject.Code.csproj`

```Text
[project]
base = "src/MyAwesomeProject/MyAwesomeProject.Web"
csproj = "MyAwesomeProject.Web.csproj"
```

We also recommend that you update the Namespace in the `Program.cs`, `Startup.cs` and the `_ViewImports.cshtml` files, So the naming is consistent throughout your project structure. 

Once updated you will need to clear out the bin and obj folders locally to avoid build errors. When you are done, commit the changes and push them to Cloud, and that's it.
