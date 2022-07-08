---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Install Umbraco with Visual Studio Code

Follow these steps to set up an Umbraco project with VS Code. The benefit of using VS Code is that it is super quick to get up and running.

## Installing and setting up VS Code

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/) and download VS Code for free.

2. Once installed, launch VS Code.

3. Click the extensions menu at the bottom on the left side. Then search for **C#**, install it then press reload.

    ![VS Code install extension](images/VsCode/VsCodeExtension.png)

## Creating your Umbraco project

Follow the [Templates Guide](install-umbraco-with-templates.md) to create your project folder.

## Configure VS Code to run the Umbraco project

Open your project folder in VS Code, your project will look something like this:

![Fresh Umbraco installation](images/VsCode/netcoreStructure.png)

Now we need to tell VS Code how to run your project.

Open the command palette, you can use the shortcut `Ctrl+Shift+P`, and type in `Tasks: Configure` and select the `Tasks: Configure Task` option:

![Configure task option](images/VsCode/ConfigureTask.png)

Select "Create task.json from template"

![Create task from template](images/VsCode/TaskJsonFromTemplate.png)

Now select ".NET Core" as your template. 

![Create .NET Core Template](images/VsCode/NetcoreTemplate.png)

After this VS Code will have created a folder called `.vscode` that contains a file called `tasks.json`, it's this file that tells VS Code how to build your project.

Now that we've told VS Code how to build your project, we need to tell it how to actually launch it, luckily VS Code can also do this for you. First, click the little play button in the left side menu, and then click the "create a launch.json file" link.

![Creating launch.json file](images/VsCode/creatingLaunchFile.png)

This will prompt a menu to appear, select:

![Nectore launch task](images/VSCode/NetcoreTask.png)

Now you'll see a green play button appear with a dropdown where ".NET Core Launch" is selected. If you navigate to the files section again, you'll see that another file has been created in the `.vscode` folder, this one is called `launch.json`, it's this file that tells VS Code, to build your project, run it, and then open a browser when you press F5.

With that, you're ready to run! Press F5, or click the little green play button in the "Run and Debug" section to run your brand new Umbraco site locally.

## Umbraco Web Installer

This section continues from where we left off but covers the installation and configuration of Umbraco inside your web browser when you run Umbraco for the first time.

1. You will see the install screen. If you've installed the template with `-ce` flag, to enable SqlCE, you only need to fill out your information and click "Install", the installer will take care of the rest. If you've enabled SqlCE, but still want to change the database type, click "Customize". If you didn't enable SqlCE, you will see a "Next" button instead of "Install", which will take you to an extra step where you can configure your database.

    ![Web Installer - Lets Get Started](images/VsCode/installer-v9.png)

2. When the installer is done you will automatically be logged into the backoffice.

    ![Web Installer - Install Complete](images/VsCode/dashboard-v8.png)

3. Celebrate - you're all done!

Congratulations, you have installed an Umbraco site!

:::note
You can log into your Umbraco site by entering the following into your browser: http://yoursite.com/umbraco/.
:::
