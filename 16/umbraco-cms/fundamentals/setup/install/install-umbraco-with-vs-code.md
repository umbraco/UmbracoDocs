# Install using Visual Studio Code

Follow these steps to set up an Umbraco project with VS Code. The benefit of using VS Code is that it is super quick to get up and running.

## Installing and setting up VS Code

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/) and download VS Code for free.
2. Once installed, launch VS Code.
3.  Click the extensions menu at the bottom on the left side. Then search for **C#** and install it.

    ![VS Code install extension](../../../.gitbook/assets/Marketplace.jpg)

## Creating your Umbraco project

Follow the [Templates Guide](install-umbraco-with-templates.md) to create your project folder.

## Configure VS Code to run the Umbraco project

Open your project folder in VS Code, your project will look something like this:

![Fresh Umbraco installation](../../../.gitbook/assets/VS_Code_Explorer.png)

Now we need to tell VS Code how to run your project.

Open the command palette, you can use the shortcut `Ctrl+Shift+P`, and type in `Tasks: Configure` and select the `Tasks: Configure Task` option:

![Configure task option](<../../../.gitbook/assets/ConfigureTask (1).png>)

Select "Create task.json from template"

![Create task from template](<../../../.gitbook/assets/TaskJsonFromTemplate (1).png>)

Now select ".NET Core" as your template.

![Create .NET Core Template](<../../../.gitbook/assets/NetcoreTemplate (1).png>)

After this VS Code will have created a folder called `.vscode` that contains a file called `tasks.json`, it's this file that tells VS Code how to build your project.

Now that we've told VS Code how to build your project, we need to tell it how to launch it. VS Code can do this for you. First, select the little play button in the left side menu, and then select the "create a launch.json file" link.

![Creating launch.json file](../../../.gitbook/assets/Create_LaunchJson_file.jpg)

This will prompt a menu to appear, select **.NET 5+ and .NET Core**:

![Prompt Menu](<../../../.gitbook/assets/Prompt_Menu (1).jpg>)

{% hint style="info" %}
If **.NET 5+ and .NET Core** is missing in the drop-down menu:

1. Press **Ctrl + Shift + P** (on Windows/Linux) or **Cmd + Shift + P** (on macOS) to open the Command Palette.
2. Search for the command `.NET: Generate Assets for Build and Debug`.\
   This command will generate the necessary assets for building and debugging your .NET application.
{% endhint %}

Now you'll see a green play button appear with a dropdown where ".NET Core Launch (web)" is selected.

![Green play button options](<../../../.gitbook/assets/Dropdown_option (1).jpg>)

If you navigate to the Files section, a new `launch.json` file is created in the `.vscode` folder. When you press F5, the `launch.json` file tells VS Code to build your project, run it, and then open a browser .

![launch.json file](<../../../.gitbook/assets/launchJson (1).jpg>)

With that, you're ready to run the project! Press F5, or click the little green play button in the **Run and Debug** section to run your brand new Umbraco site locally.

## Umbraco Web Installer

This section continues from where we left off but covers the installation and configuration of Umbraco inside your web browser when you run Umbraco for the first time.

You will see the install screen where you will need to fill in some data before Umbraco can be installed.

![Web Installer - Lets Get Started](../../../.gitbook/assets/Install_Umbraco.jpg)

When the installer is done, you will be logged into the backoffice.

<figure><img src="../../../.gitbook/assets/dashboard-v8 (1).PNG" alt=""><figcaption></figcaption></figure>

Congratulations, you have installed an Umbraco site!

{% hint style="info" %}
You can log into your Umbraco site by entering the following into your browser: http://yoursite.com/umbraco/.
{% endhint %}
