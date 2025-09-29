# Streamlining Local Development

In this section we discuss some additional steps you can carry out to streamline your local development workflow.

## Creating Git Hooks

Working in a team, it's common for developers to pull code from source control to update their local environment with the latest Umbraco schema.

They can do this by starting up the website, navigating to the _Settings > Deploy_ dashboard and triggering a data extraction.

We can automate this step using a [git hook](https://www.atlassian.com/git/tutorials/git-hooks).

When working with Umbraco Cloud, this step is configured automatically for you when you clone and run your project the first time. If working with Umbraco Deploy On-Premise, you can set it up yourself.

The process works by using the marker file Umbraco Deploy uses to trigger an update of the Umbraco schema from the `.uda` files from source control.

If a file named `deploy-on-start` is found in the `/umbraco/Deploy` folder, an update will run automatically when the site starts up.

Therefore, if we ensure that the file is created every time the source code is pulled from the remote repository, we can automate the update.

To do this, carry out the following steps:

* Find the `.git` folder within your solution root.
  * It might be a hidden folder, so if you don't see it, make sure your file browser is configured to show hidden files and folders.
* Within that you'll find a `hooks` folder, and inside that, a file called `post-merge.sample`.
* Rename the file to remove the `.sample` extension and open it in a text editor.
* Apply the following text and save the file (amending the path to the web project as appropriate for your solution structure):

```
#!/bin/sh
echo > src/UmbracoProject/umbraco/Deploy/deploy-on-start
```

* Run a `git pull origin <branchname>`.
* Start up the website and you should find the Umbraco schema update has been triggered.
