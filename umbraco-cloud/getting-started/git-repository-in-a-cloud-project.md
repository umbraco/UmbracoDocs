# Repositories in a Cloud Project

Each Umbraco Cloud project can have multiple environments: Mainline and Flexible Environments. Each environment has its own git repository that is hosted on Umbraco’s Cloud platform.

{% hint style="info" %}
Umbraco Cloud repositories are only deployment repositories and should not be used as source code repositories.
{% endhint %}

Ideally, your Umbraco Cloud setup should look like this:

* [A source control repository with your own code](git-repository-in-a-cloud-project.md#a-source-control-repository-with-your-own-code)
* [A Umbraco Cloud source control repository with the locally cloned Umbraco project](git-repository-in-a-cloud-project.md#a-git-umbraco-cloud-source-control-repository-with-the-locally-cloned-umbraco-project)

## A source control repository with your own code

Source control is a way to control changes to files and directories. You can keep a record of changes and revert to specific versions of a file in the event you would like to back up to an earlier time. A source control repository is used as the single source of truth that has the latest version of your project source code with all the git branches.

There are different source code management tools that you can use such as GitHub, Git, GitLab, Apache Subversion (SVN), Mercurial, etc.

{% hint style="info" %}
An example of how to use GitLab for setting up automatic deployments can be found on the [online Umbraco Community magazine Skrift.io](https://skrift.io/issues/using-gitlab-bidirectional-mirroring-azure-devops-release-pipelines-to-auto-deploy-into-umbraco-cloud/).
{% endhint %}

{% tabs %}
{% tab title="Umbraco 10+" %}
The external Git repository can be used to store the entire source code of your project. Additionally, the Umbraco Cloud project must have all your source code too. You can no longer store dll files in your Umbraco Cloud project.
{% endtab %}

{% tab title="Legacy Umbraco 7 and 8" %}
You need to put your custom code in a different source control repository of your choice. You can use the source control repository to store the custom models, controllers, class libraries, CS code etc as the Umbraco Cloud Git repository can only store the dll files of your C# files.
{% endtab %}
{% endtabs %}

## A source control repository with the locally cloned Umbraco project

It is recommended to create a Cloud project with at least two environments: a Live environment including one extra mainline environment. Work with a local copy of the site by cloning down the left-most environment. This repository is different from your source control repository.

Once you're happy with the results or wish to see how your website has progressed, you push the changes back to the Cloud. If everything is working as expected, deploy your changes to the Live environment.

{% tabs %}
{% tab title="Umbraco 10+" %}
### Code Deployment Summary

![Umbraco Cloud Overview](images/UCP.png)

In the above diagram, the Umbraco Git repository contains the source code of a class library CS project.

With this setup, once you commit your code in the Umbraco Cloud Git repository, your C# source code is built by Umbraco Cloud and then deployed to the `wwwroot` folder.

### Disadvantages of using an Umbraco Cloud Project repository as a source code repository

* We only guarantee to maintain and keep the `master` branch. If there are any other branches, they might be removed without any notification causing data loss.
* You will need to commit your frontend artifacts as the build pipeline only builds dlls from your C# code.
{% endtab %}

{% tab title="Legacy Umbraco 7 and 8" %}
### Code Deployment Summary

<figure><img src="../.gitbook/assets/UCP_v8.png" alt=""><figcaption><p>Umbraco cloud overview Legacy versions</p></figcaption></figure>

In the above diagram, the external git repository contains the source code of a class library CS project, if you had a class library project that was used in your Cloud project.

With this setup, you commit your changes twice. Once to commit your code in your source control and the other commit to the Umbraco Cloud Git repository to deploy your website. Your source code is not hosted on Umbraco Cloud but only your cloned project will be in the Umbraco Cloud Git Repository. Your code is built and compiled into the cloned project and then pushed to Umbraco Cloud. Thus updating the site with your latest code changes.

### Disadvantages of using an Umbraco Cloud Project repository as a source code repository

* We only guarantee to maintain and keep the `master` branch. If there are any other branches, they might be removed without any notification causing data loss.
* You will always need to commit your dll files.
{% endtab %}
{% endtabs %}
