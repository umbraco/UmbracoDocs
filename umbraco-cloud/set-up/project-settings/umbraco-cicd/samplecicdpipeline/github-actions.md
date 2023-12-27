---
description: >-
  This section provides a step-by-step guide to setting up a CI/CD pipeline in
  GitHub Actions using the provided sample bash scripts.
---

# GitHub Actions using Bash scripts

## Setting up the pipeline in GitHub Actions

Before setting up the pipeline in Azure DevOps, make sure that the steps in the [Configuring a CI/CD pipeline](./) are done.

The pipeline is defined in a main YAML file and includes some steps that call custom shell scripts to interact with the Umbraco Cloud API.

You can download the GitHub Actions sample scripts below:

{% file src="../../../images/GithubActionsCICDFiles.zip" %}
sample scripts for Github actions
{% endfile %}

The zip file includes the following files:

* DeploymentGitHub Action workflow pipeline `main.yaml`
* Create new deployment `create_deployment.sh`
* Upload zip package for deployment `upload_package.sh`
* Start Deployment `start_deployment.sh`
* Get deployment status: `get_deployment_status.sh`

### Steps on how to set up GitHub Actions Pipeline

1. Create a repository in [GitHub](https://github.com/) this will be an empty repository at this stage.
2. Clone the repository to your local machine.
3. Go to the Actions section in GitHub.
4.  Click "_set up a workflow yourself"_ to set up a new workflow. This will create an empty `main.yml` file.

    <figure><img src="../../../../.gitbook/assets/image (5).png" alt=""><figcaption><p>"<em>set up a workflow yourself" on GitHub</em></p></figcaption></figure>
5. Copy the contents of the `main.yml` file paste it into the new file and commit the changes.
6. Pull the git repository and you will see a folder called `.github` with a folder called workflows. Inside this folder, you will find the `main.yml` file.
7. Open the file in VS Code or another editor and look at the contents. You will notice references to a  `UMBRACO_CLOUD_PROJECT_ID` and `UMBRACO_CLOUD_API_KEY`. You can get these from the Advanced section inside the project settings for your Umbraco Cloud project.
8. Go to the GitHub repository, and click on the Settings section,
9.  Expand secrets and variables in the left-hand menu titled Security and click on Actions.

    <figure><img src="../../../../.gitbook/assets/image (6).png" alt=""><figcaption><p>Security and Actions menu GitHub</p></figcaption></figure>
10. Create a Secret called `UMBRACO_CLOUD_API_KEY` with the value from the Umbraco Portal > Settings > Advanced section.
11. Create a variable with the name `UMBRACO_CLOUD_PROJECT_ID` and the value from the Umbraco Portal > Settings > Advanced section.
12. Go to your local folder where the workflows folder is.
13. Create a folder called scripts.
14. Add the 4 scripts from the zip file:

* `create_deployment.sh`
* `upload_package.sh`
* `start_deployment.sh`
* `get_deployment_status.sh`

13. Give permission for these scripts to be able to run within the workflows > scripts folder using the following commands in the Command Line:

* `git update-index --chmod=+x create_deployment.sh`
* `git update-index --chmod=+x upload_package.sh`
* `git update-index --chmod=+x start_deployment.sh`
* `git update-index --chmod=+x get_deployment_status.sh`

{% hint style="info" %}
Ensure you run **git add name-of-file.sh** before running the above commands to add untracked files to the git index.
{% endhint %}

14. Commit all the changes and push it up to GitHub and the pipeline will fail.
15. Copy the files from your Umbraco Cloud local Development repository and paste them into the GitHub local repository (don't copy over the git folder).
16. Push all of the changes up to your GitHub repository.
17. Go to actions and follow the building of the project.

Once the has finished successfully it will deploy to your Development Umbraco Cloud site.
