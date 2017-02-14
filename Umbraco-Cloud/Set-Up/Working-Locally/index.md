#Working with a local clone of an Umbraco Cloud site
To work with a local copy of your site you'll need to use Windows and have a local web server installed (like WebMatrix). If you're not using Windows you can still work with your site's files (Templates, Css, JS, etc...) but you'll need to deploy these to your development site before you can "see" your updates. If you are using Windows, read on for how to work locally.

From the Umbraco Cloud portal copy your development environments git repository endpoint using the *Connect my machine* option and then clone the site using your favorite Git client. We like [SourceTree](http://www.sourcetreeapp.com/) or [Git Extensions](http://gitextensions.github.io). 
Here are the steps to clone your site (**We'll use SourceTree in this example.**):

1. Click the Connect my machine button to get the Clone project dialog.
    ![Connect my machine](images/connect-my-machine.jpg)

2. Copy the Clone Url from the portal for your dev environment
    ![clone dialog](images/clone-this-project.jpg)

3. From SourceTree select Clone/New and paste the Url in the Source Path box
    ![clone dialog](images/addrepo.jpg)

4. Set your Destination Path to where you keep your local work
5. You’ll be prompted to log in, use the same credentials as you use for Umbraco Cloud.
6. Click Clone

Now you have an exact copy of your Umbraco Cloud dev site locally.

We like to use Microsoft WebMatrix when working locally, but you can use Visual Studio or another development tool or web server of course. When you run your local site for the first time you’ll be prompted to restore your site's content. Wait until this process completes as it also creates the local SqlCE database for your site.

![clone dialog](images/restorecontent.jpg)

That's it! Now you can work with your site locally just as with any other umbraco site. You can create content, add media, even create your own custom code. When you're ready to deploy your changes make sure to have a look at the [deployments](../../Deployment/) documentation.

Note: If you have more than "a few" media items see our recommendations for working with [media in Umbraco Cloud](../Media/).
