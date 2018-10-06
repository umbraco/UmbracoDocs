# Visual Studio Setup

This page describes how to setup your Visual Studio solution to work with an Umbraco Cloud Project.
In this article you will find:

 - [Generate a Visual Studio Solution](#generate-a-visual-studio-solution)
 - [The Git repositories](#the-git-repositories)
 - [What's next?](#whats-next)
 - [Working with Visual Studio](#working-with-visual-studio)
 - [Git - what should be committed](#git---what-should-be-committed)
 - [Setup for new team members](#setup-for-new-team-members)
 - [Working with NuGet](#working-with-nuget)

## The Visual Studio Solution
If you're writing a lot of custom code (or just like Intellisense), we recommend using a Visual Studio solution with a Website Project for the Umbraco site (coming from the cloned git repository from the Umbraco Cloud Project), and a Class Library Project for the code that will be created for the Umbraco site. This can be MVC Controllers, WebApi Controllers, Surface Controllers or data access plus whatever else you might need to write code for.

Below is a screenshot of our recommendation on how the Projects should be configured. Here we use the following naming conventions: `*.Web` for the Umbraco website and `*.Core` for the accompanying code.

![Visual Studio Project setup](images/vs-project-setup.png)

## Generate a Visual Studio Solution
Manually creating and configuring a Visual Studio solution with the right Projects can take a bit of time, so we have made a little command line tool that will set the solution up for you.
Download the UaaS.cmd tool from [umbra.co/uaas-cmd](https://umbra.co/uaas-cmd) and place it in the folder you want the solution in.

**Note:** this is just a recommended setup. If you don't like the setup then you can play with it and make it your own. There's nothing magic about this setup, it is just adding a few files to your Umbraco Cloud website to give you a flying start to begin working with Visual Studio. What follows is a recommendation and not the only way to work with Visual Studio.

![](images/cmd-in-empty-folder.png)

Before running the UaaS.cmd tool you will need the git clone url for your Umbraco Cloud Project. So go to the Project in the Portal and copy the url from "Connect my machine".

![](images/connect-my-machine.png)

Running the UaaS.cmd tool will download the latest Visual Studio generator (waasp.exe) and then prompt you to enter the git clone url for your Project.
Then enter the "Namespace", which will be the name of the Visual Studio solution and thus the namespace for the solution as well.

If you haven't cloned the repository before or don't have a [git credentials manager](https://github.com/Microsoft/Git-Credential-Manager-for-Windows) installed you will be asked to enter the username and password for the Umbraco Cloud Project (these are the same credentials as you use to access the Portal and the Umbraco backoffice).

![](images/cmd-clone.png)

Once its done running the tool will have created a Visual Studio solution file `*.sln` and two Projects. The one called `*.Web` contains the Umbraco site that was (git) cloned from your Project. The `*.Core` is a Class Library that you can use for your custom code, as mentioned above.
Both projects are configured with the NuGet packages for Umbraco using the version that corresponds to the site cloned from Umbraco Cloud.

The result should look something like this within the folder where the UaaS.cmd tool ran:

![](images/generated-solution.png)  

You can now open the solution in Visual Studio and hit F5 to start the site directly from Visual Studio.

## The Git repositories
One thing to notice about this setup is that you will get two git repositories just as you get two projects. The site cloned from your Umbraco Cloud Project will be contained within a git repository that is connected to your Project on Umbraco Cloud. Whenever you want to deploy changes to your (remote) Umbraco Cloud site you should commit everything within the `*.Web` folder, which is where the git repository for Umbraco Cloud is also located.

Going up one level to where the `*.sln` file is located you will notice a `.git` folder, which is the second git repository. You should use this repository for all the code you write as well as the solution and project files for Visual Studio.

So think of everything within the `*.Web` folder as your deployment repository, and everything surrounding that folder as your source code repository. The Umbraco Cloud repository (within the `*.Web` folder) will not (and should not) be committed to the other git repository.

## What's next?
Now that you've added your own touch to your site, and thoroughly tested of course, you're ready to deploy to your Umbraco Cloud development site (the destination might vary depending on the plan you chose). 
The key thing to know is that your custom code from the `*.Core` project will be built into a .dll file in your `*.Web` project that you can then push up to the Cloud repository.

Once you have everything your site will need committed you can follow the [deployment workflow](../../Deployment/) to complete the deployment.

## Working with Visual Studio
As mentioned in the previous section, you will start with two Projects in Visual Studio - A project called `*.Web` with the Umbraco site (from Umbraco Cloud) configured as a Website project, and a project called `*.Core` configured as a class library for all of your code.

_So what goes where?_

Anything that is used within Umbraco like plugins and configuration should by default be placed in the `*.Web` project. Here is a list of other elements that you want to place in the Website project:

* Website assets like css, JavaScript and related images
* Views, Partial Views and Partial View Macros
* Configuration (web.config and all the Umbraco specific or related config files in ~/Config/)
* Usercontrol ascx-files
* Plugins (typically located in App_Plugins)
* Meta data (the files that Umbraco Deploy uses in the ~/Data/Revision/ folder)

Media files will also be placed under the `*.Web` folder and you will be able to see these through Visual Studio, because a Website projects shows all files on disk by default. Media files from the /media/ folder should not be committed to the git repository, but more on that in the next section about 'What should be committed'.

We recommend placing all your code in the `*.Core` project (instead of, for example, using App_Code for that). This includes, but is not limited to:

* Controllers for MVC, Web Api
* Controllers for Umbraco Plugins, Surface, API
* Models and ViewModels
* Data Access (the `*.Core` project references Umbraco so you can use the Umbraco datalayer as needed)
* Extensions methods

### Using Umbraco namespaces in your `*.Core` project
In order to use Umbraco's features in your `*.Core` project, you have to add references to the DLLs in your `*.Web/bin`.

You can do this by simply right-clicking on **References** and selecting **Add Reference**. Browse and select the DLLs you'd like to use and then hit **OK**. Don't forget to build.

![](images/references.gif)

## Git - what should be committed

When working with this solution setup it's important to remember that you have one git repository for your source code, and one within the `*.Web` folder for committing and deploying your changes to Umbraco Cloud.

The cloned git repository from Umbraco Cloud comes with its own `.gitignore` so files that should NOT be committed are already handled. As a rule of thumb all files that are required to run the Umbraco site should be committed to the git repository in the `*.Web` folder and deployed to Umbraco Cloud. This includes assemblies (`*.dll`). 

For the `*.Core` part of the solution as well as the solution file and default `.gitignore` file you commit that to the source code repository. You should ideally set a remote for this git repository to your own git host like GitHub, BitBucket or Visual Studio Team Services.

These are the files and folders you typically want to commit in your own source code repository:

* The project and code files in `*.Core`
* The solution file `*.sln`
* `.gitignore`
* UaaSClone.cmd (used for re-establishing the `*.Web` folder with the git repository from Umbraco Cloud)

## Setup for new team members

When you are working in a team you will have additional people that will use this same setup, but they will only clone your source code repository from your GitHub, Bitbucket or Visual Studio Team Services account. In doing so they will, by default, not get the `*.Web` folder and the Umbraco site, because that part is not contained within the source code repository. 
So to make it easy to get up and running we added a `UaaSClone.cmd`, which can be run after cloning the source code repository.
Running this command line tool will clone the Umbraco Cloud repository to the right folder, and set up Visual Studio for them.

## Working with NuGet

Some Umbraco packages are available on NuGet and you can install NuGet packages into the `*.Web` project to add functionality to your site. Remember, this is just a normal Visual Studio solution so you can work with NuGet packages exactly like you're used to, install them in the project where you need them. You should always install any NuGet packages you need in the `*.Web` project in order for them to work in your website and deploy to your other environments.

For example, if you need to program something in your `*.Core` project and you depend on a NuGet package for the code you're writing, you should install that NuGet package in both:

- Install it in `*.Core` so you can write the code you need against the library you working with (obtained from NuGet)
- Also install it in `*.Web` so that the library files also end up in your website and your compiled code works there as well
