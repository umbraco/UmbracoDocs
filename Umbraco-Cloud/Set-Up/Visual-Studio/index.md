#Visual Studio Setup

This page describes how to setup your Visual Studio solution to work with an Umbraco Cloud Project.

##The Visual Studio Solution
We currently recommend using a Visual Studio solution with a Website Project for the Umbraco site (coming from the cloned git repository from the Umbraco Cloud Project), and a Class Library Project for the code that will be created for the Umbraco site. This can be MVC Controllers, WebApi Controllers, Surface Controllers or data access plus whatever else you might need to write code for.

Below is a screenshot of how the Projects should be configured. Here we use the following naming conventions: `*.Web` for the Umbraco website and `*.Core` for the accompanying code.

![Visual Studio Project setup](images/vs-project-setup.png)

##Generate a Visual Studio Solution
Manually creating and configuring a Visual Studio solution with the right Projects can take a bit of time, so we have made a little command line tool that will generate the correct solution for you.
Download the UaaS.cmd tool from [umbra.co/uaas-cmd](https://umbra.co/uaas-cmd) and save it to a folder where you want to place the Visual Studio solution.

**Note:** this is just a recommended setup. If you don't like the setup then you can play with it and make it your own. There's nothing magic about this setup, it is just adding a few files to your Umbraco Cloud website to give you a flying start to begin working with Visual Studio. If you want to name things differently or set up your VS solution differently then that's up to you. What follows is a recommendation and not the only way to work with Visual Studio.

![](images/cmd-in-empty-folder.png)

Before running the UaaS.cmd tool you will need the git clone url for your Umbraco Cloud Project. So go to the Project in the Portal and copy the url from "Connect my machine".

![](images/connect-my-machine.png)

Running the UaaS.cmd tool will download the latest Visual Studio generator (waasp.exe) and then prompt you to enter the git clone url for your Project.
Then enter the "Namespace", which will be the name of the Visual Studio solution and thus the namespace for the solution as well.

If you haven't cloned the repository before or don't have a [git credentials manager](https://github.com/Microsoft/Git-Credential-Manager-for-Windows) installed you will be asked to enter the username and password for the Umbraco Cloud Project (these are the same credentials as you use to access the Portal and the Umbraco backoffice).

![](images/cmd-clone.png)

Once its done running the tool will have created a Visual Studio solution file `*.sln` and two Projects. The one called `*.Web` contains the Umbraco site that was (git) cloned from your Project. The `*.Core` is a Class Library that you can use for your code, as mentioned above.
Both projects are configured with the nuget packages for Umbraco using the version that corresponds to the site cloned from Umbraco Cloud.

The result should look something like this within the folder where the UaaS.cmd tool ran:

![](images/generated-solution.png)  

You can now open the solution in Visual Studio and hit F5 to start the site directly from Visual Studio.

##The Git repositories
One thing to notice about this setup is that you will get two git repositories just as you get two projects. The site cloned from your Umbraco Cloud Project will be contained within a git repository that is connected to your Project on Umbraco Cloud. Whenever you want to deploy changes to your (remote) Umbraco Cloud site you should commit everything within the `*.Web` folder, which is where the git repository for Umbraco as a Serivce is also located.

Going up one level to where the `*.sln` file is located you will notice a `.git` folder, which is the second git repository. You should use this repository for all the code you write as well as the solution and project files for Visual Studio.

So think of everything within the `*.Web` folder as your deployment repository, and everything surrounding that folder as your source code repository. The Umbraco Cloud repository (within the `*.Web` folder) will not (and should not) be committed to the other git repository.

You can easily connect the source code repository to your own git repository host (like github, bitbucket, gitlab or Visual Studio Team Services).
From the command line you can use the following git command: `git remote add origin https://github.com/user-account/repository-name.git`

##What's next?
Now that you've added your own touch to your site, and thoroughly tested of course, you're ready to deploy to your Umbraco Cloud development site (the destination might vary depending on the plan you chose). 
The key thing to remember is that you'll commit anything that is required by your site to the local git repository and will not commit source or project files. That means you'll add .dll files to the git repository (which is found within the `*.Web` Project), which is typically something you wouldn't do with a source code repository.

For more details about working with Visual Studio with your Umbraco Cloud setup please refer to the ["Working with Visual Studio"](../Working-With-Visual-Studio/) documentation.

Once you have everything your site will need commited you can follow the [deployment workflow](../../Deployment/) to complete the deployment.
