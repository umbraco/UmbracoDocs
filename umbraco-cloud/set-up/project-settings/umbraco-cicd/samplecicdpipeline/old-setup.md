# Configuring a CI/CD pipeline (old sample)

The following two steps should have been completed before continuing here:

- [Pick an Umbraco Cloud project to use](README.md#setting-up-an-umbraco-cloud-project)
- [Activate the CI/CD Flow feature](README.md#obtaining-the-project-id-and-api-key)

## Cloning the Umbraco Cloud Repository

To get started with your local development, you'll need to [clone the repository](https://docs.umbraco.com/umbraco-cloud/set-up/working-locally) of the environment you intend to work with. Once cloned, make a copy of it in a new folder. In this example, we'll create a new folder named `local-cicd-demo-site` for the local repository by using Gitbash. The copy will be used in either Azure DevOps or GitHub actions repository.

```sh
# Clone the development environment repository
git clone https://scm.umbraco.io/euwest01/your-cloud-project-alias.git

# Copy the repository to a new local folder
cp -r your-cloud-project-alias local-cicd-demo-site
```

{% hint style="info" %}
If you use the command line (cmd) to clone the project then you can use `copy -r` instead of `cp -r` to make a copy of the folder.
{% endhint %}

This will set up your local workspace, allowing you to work on the project before pushing changes back to the Umbraco Cloud repository.

### Reconfiguring Git Remotes

After cloning the Umbraco Cloud repository, it's essential to remove its remote settings so that you can link it to your own or your company's repository.

In the below example, we'll be using an Azure DevOps-hosted repository as the new origin.

Follow the steps below to reset the Git remote from the root folder of `local-cicd-demo-site`:

```sh
# Reset the Git remote to point to the new Azure DevOps repository
git remote set-url origin https://company-repository-name@dev.azure.com/company-repository-name/azuredevops-project-name/_git/azuredevops-project-name
```

{% hint style="info" %}
You can get the origin link from your [Azure DevOps project repository](https://learn.microsoft.com/en-us/azure/devops/repos/git/clone?view=azure-devops\&tabs=visual-studio-2022): Repos -> under “Clone to your computer” choose “HTTPS” and then copy the link. `SSH` can also be used if preferred.
{% endhint %}

By executing this command, you'll disconnect the local repository from the Umbraco Cloud repository and connect it to your own or your company's Azure DevOps repository or GitHub Actions. This allows you to manage your project within your own version control system.

### Optional: Renaming the Master Branch to Main

If you prefer to use the term "main" instead of "master" for your primary branch, you can rename it with the following commands:

```sh
# Rename the 'master' branch to 'main'
git branch -m master main

# Push the newly renamed 'main' branch to the remote repository
git push -u origin main
```

By executing these commands, you'll rename the local 'master' branch to 'main' and update the remote repository to reflect this change. This is an optional step but aligns with the industry trend towards more inclusive language.

Once the Umbraco Cloud project has been set up, it is time to set up a CI/CD pipeline.

* [Azure DevOps (using Bash scripts)](azure-devops-old.md)
* [GitHub Actions (using Bash scripts)](github-actions-old.md)
