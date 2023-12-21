# Install using Visual Studio Code

Follow these steps to set up an Umbraco project with VS Code. The benefit of using VS Code is that it is super quick to get up and running.

## Installing and setting up VS Code

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/) and download VS Code for free.
2. Once installed, launch VS Code.
3.  Click the extensions menu at the bottom on the left side. Then search for **C#**, install it then press reload.

    ![VS Code install extension](../../../../../10/umbraco-cms/fundamentals/setup/install/images/VsCode/VsCodeExtension.png)

## Creating your Umbraco project

Follow the [Templates Guide](install-umbraco-with-templates.md) to create your project folder.

## Configure VS Code to run the Umbraco project

Open your project folder in VS Code, your project will look something like this:

![Fresh Umbraco installation](../../../../../10/umbraco-cms/fundamentals/setup/install/images/VsCode/netcoreStructure.png)

Now we need to tell VS Code how to run your project.

Open the command palette, you can use the shortcut `Ctrl+Shift+P`, and type in `Tasks: Configure` and select the `Tasks: Configure Task` option:

![Configure task option](../../../../../10/umbraco-cms/fundamentals/setup/install/images/VsCode/ConfigureTask.png)

Select "Create task.json from template"

![Create task from template](../../../../../10/umbraco-cms/fundamentals/setup/install/images/VsCode/TaskJsonFromTemplate.png)

Now select ".NET Core" as your template.

![Create .NET Core Template](../../../../../10/umbraco-cms/fundamentals/setup/install/images/VsCode/NetcoreTemplate.png)

After this VS Code will have created a folder called `.vscode` that contains a file called `tasks.json`, it's this file that tells VS Code how to build your project.

Now that we've told VS Code how to build your project, we need to tell it how to launch it. VS Code can do this for you. First, select the little play button in the left side menu, and then select the "create a launch.json file" link.

![Creating launch.json file](../../../../../10/umbraco-cms/fundamentals/setup/install/images/VsCode/creatingLaunchFile.png)

This will prompt a menu to appear, select:

<figure><img src="../../../../../10/umbraco-cms/fundamentals/setup/install/images/VsCode/NetcoreTask.png" alt=""><figcaption></figcaption></figure>

Now you'll see a green play button appear with a dropdown where ".NET Core Launch" is selected. If you navigate to the files section again, you'll see that another file has been created in the `.vscode` folder, this one is called `launch.json`, it's this file that tells VS Code, to build your project, run it, and then open a browser when you press F5.

With that, you're ready to run! Press F5, or click the little green play button in the "Run and Debug" section to run your brand new Umbraco site locally.

## Umbraco Web Installer

This section continues from where we left off but covers the installation and configuration of Umbraco inside your web browser when you run Umbraco for the first time.

You will see the install screen where you will need to fill in some data before Umbraco can be installed.

Depending on the database configuration you've chosen you will have the following options:

1. If you've installed the template with `-ce` flag, to enable SqlCE, you only need to fill out your information and click "Install". The installer will then take care of the rest.
2. If you've enabled SqlCE, but still want to change the database type, click "Change Database".
3. If you didn't enable SqlCE, you will see a "Next" button instead of "Install", which will take you to an extra step where you can configure your database.

![Web Installer - Lets Get Started](../../../../../10/umbraco-cms/fundamentals/setup/install/images/installer.png)

When the installer is done you will automatically be logged into the backoffice.

<figure><img src="../../../../../10/umbraco-cms/fundamentals/setup/install/images/VsCode/dashboard-v8.PNG" alt=""><figcaption></figcaption></figure>

Congratulations, you have installed an Umbraco site!

{% hint style="info" %}
You can log into your Umbraco site by entering the following into your browser: http://yoursite.com/umbraco/.
{% endhint %}
