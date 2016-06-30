#Working With Visual Studio

This section shows you how to work with an Umbraco as a Service site setup in Visual Studio using the approach outlined in ["Visual Studio"](../Visual-Studio/). If you haven't already setup your Umbraco as a Service site in a Visual Studio solution then please refer to the ["Visual Studio"](../Visual-Studio/) setup page.

##Getting started
As mentioned in the previous section about the Visual Studio setup, using the recommended approach, you will start with two Projects in Visual Studio - A project called `*.Web` with the Umbraco site (from Umbraco as a Service) configured as a Website project, and a project called `*.Core` configured as a class library for all of your code.

_So what goes where?_

Anything that is used within Umbraco like plugins and configuration should by default be placed in the `*.Web` project. Here is a list of other elements that you want to place in the Website project:

* Website assets like css, javascript and related images
* Views, Partial Views and Partial View Macro
* Configuration (web.config and all the umbraco specific or related config files)
* Usercontrol ascx-files
* Plugins (typically located in App_Plugins)
* Meta data (the files that Umbraco Deploy serializes to disk for Document Types, Data Types, Media Types, Member Types, Member Groups, Templates and currently also Dictionary Items)

Media files will also be placed under the `*.Web` folder and you will be able to see these through Visual Studio, because a Website projects shows all files on disk by default. Media files from the /media/ folder should not be committed to the git repository, but more on that in the section.

For the `*.Core` project this is where you place all your code. This includes, but is not limited to:

* Controllers for MVC, Web Api
* Controllers for Umbraco Plugins, Surface, API
* Models and ViewModels
* Data Access (the `*.Core` project references Umbraco so you can use the Umbraco datalayer as needed)
* Extensions methods

You can of course add additional projects to the Visual Studio solution when needed. The only thing you must remember is to add that new project as a dependency to the `*.Web` project, so the assembly output is copied to the website's bin folder.

Once you have added a new project to the solution right-click on the solution in Visual Studio and select "Properties". This brings up the Solution Property Pane where you can select dependencies as shown below:

![](images/solution-dependencies.png)  

##Git - what should be committed

When working with this solution setup its important to remember that you have one git repository for your source code, and one within the `*.Web` folder for committing and deploying your changes to Umbraco as a Service.

The cloned git repository from Umbraco as a Service comes with its own `.gitignore` so files that should NOT be committed are already handled. As a rule of thumb all files that are required to run the Umbraco site should be committed to the git repository in the `*.Web` folder and deployed to Umbraco as a Service. This includes assemblies (`*.dll`). Please note that its especially important to commit the files under the `*.Web/data/` folder as these files are the serialized versions of the meta data (Document Types, Data Types, Media Types, Member Types, Member Groups, Templates and currently also Dictionary Items) for the site.

For the `*.Core` part of the solution as well as the solution file and default `.gitignore` file you commit that to the source code repository. You should ideally set a remote for this git repository to your own git host like Github, Bitbucket or Visual Studio Team Services.

These are the files and folders you typically want to commit in your own source code repository:

* The project and code files in `*.Core`
* The solution file `*.sln`
* `.gitignore`
* UaaSClone.cmd (used for re-establishing the `*.Web` folder with the git repository from Umbraco as a Service)

##Setup for new team members

When you are working in a team you will have additional people that will use this same setup, but they will only clone your source code repository from your Github, Bitbucket or Visual Studio Team Services account.
In doing so they will, by default, not get the `*.Web` folder and the umbraco site, because that part is not contained within the source code repository. So to make it easy to get up and running we added a `UaaSClone.cmd`, which can be run after cloning the source code repository.
Running this command line tool will clone the Umbraco as a Service repository to the right folder, so the Visual Studio setup remains valid. 
