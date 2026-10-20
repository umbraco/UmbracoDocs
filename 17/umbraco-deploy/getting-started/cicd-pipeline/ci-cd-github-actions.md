---
description: >-
  Steps and examples on how to setup a build and deployment pipeline for Umbraco
  Deploy using GitHub Actions.
---

# GitHub Actions

{% hint style="info" %}
This example shows how you can set up a CI/CD build server using GitHub Actions in Azure Web Apps.

Setting up the site itself is not covered here, as this is beyond this documentation.
{% endhint %}

The following steps will take you through setting up a build server in Azure Web Apps. Go to the Azure portal and find the empty website that you have set up and want to connect to.

1. Go to the Deployment Center.

![Azure deployments](<../../.gitbook/assets/Deployment-center (1).png>)

In the Deployment Center, you can set up the CI/CD build server. This example sets up the build server using GitHub Actions. It is possible to set up the build server however you want as long as it supports executing Powershell scripts.

2. Go to the Settings tab.
3. Choose which source and build provider to use.
   * In this case, choose GitHub.

![Build server clean](../../.gitbook/assets/Build-server-v10.png)

4. Choose the Organization which you created the GitHub repository under.
5. Choose the repository that was set up earlier in this guide.
6. Select which branch you want the build server to build into.

The runtime stack and version being used can be seen here. In this example, .NET Version 6.0 is used.

Once the information has been added, preview the YAML file that will be used for the build server:

![Workflow configuration](../../.gitbook/assets/workflow-preview-v10.png)

7. Save the workflow.

The website and the GitHub repository are now connected.

Going back to the GitHub repository, a new folder has been created called Workflows:

![Workflows](<../../.gitbook/assets/workflows (1).png>)

Inside the folder, the YAML file has been created with the default settings from the Azure Portal. The file will need to be configured so it fits into your set up.

8. Pull down the new file and folder, so you can work with the YAML file on your local machine.
9. Configure it to work with your Umbraco Deploy installation.

When it have been configured it will look something like this:

```yaml
# Docs for the Azure Web Apps Deploy action: https://github.com/Azure/webapps-deploy
# More GitHub Actions for Azure: https://github.com/Azure/actions
name: Build and deploy ASP.Net Core app to Azure Web App - Jonathan-deploy-v10
on:
  push:
    branches:
      - main
  workflow_dispatch:
jobs:
  build:
    runs-on: windows-latest
    steps:
      - name: Checkout the git repository
        uses: actions/checkout@v3
      - name: Setup dotnet 6
        uses: actions/setup-dotnet@v2
        with:
          dotnet-version: '6.0.x'
      - name: Build with dotnet
        working-directory: 'Jonathan-Deploy-V10'
        run: dotnet build --configuration Release
      - name: Publish with dotnet
        working-directory: 'Jonathan-Deploy-V10'
        run: dotnet publish -c Release -o ${{env.DOTNET_ROOT}}/myapp
        
      - name: Upload artifact for deployment job
        uses: actions/upload-artifact@v4
        with:
          name: .net-app
          path: ${{env.DOTNET_ROOT}}/myapp
  deploy:
    runs-on: windows-latest
    needs: build
    environment:
      name: 'Production'
      url: ${{ steps.deploy-to-webapp.outputs.webapp-url }}
    env:
      deployBaseUrl: https://jonathan-testing-deploy-v10.testsite.net
      umbracoDeployReason:  DeployingMySite
    steps:
      - name: Download artifact from build job
        uses: actions/download-artifact@v4
        with:
          name: .net-app
      - name: Deploy to Azure Web App
        id: deploy-to-webapp
        uses: azure/webapps-deploy@v2
        with:
          app-name: 'Jonathan-Deploy-V10'
          slot-name: 'Production'
          publish-profile: ${{ secrets.AZUREAPPSERVICE_PUBLISHPROFILE_ABC78A5A9E9FG07F87E8R5G9H9J0J7J8 }}
          package: .
      - name:  Run Deploy Powershell - triggers deployment on remote env
        shell: powershell
        run: .\TriggerDeploy.ps1 -InformationAction:Continue -Action TriggerWithStatus -ApiSecret ${{ secrets.deployApiSecret }} -BaseUrl  ${{ env.deployBaseUrl }} -Reason  ${{ env.umbracoDeployReason }} -Verbose       
```

{% hint style="info" %}
This is only an example of how you can set up the CI/CD pipeline for Umbraco Deploy. It is possible to set it up in a way that works for you and your preferred workflow.
{% endhint %}

Also add the License file and `TriggerDeploy.ps1` file in an item group in the `csproj` file:

```
<ItemGroup>
<Content Include="umbraco/Licenses/umbracoDeploy.lic" CopyToOutputDirectory="Always"/>
<Content Include="TriggerDeploy.ps1" CopyToOutputDirectory="Always"/>
</ItemGroup>
```

As well as enabling Unattended install in the **appsettings.json** file so Umbraco installs automatically:

```
{
  "Umbraco": {
    "CMS": {
      "Unattended": {
        "InstallUnattended": true
      }
    }
  }
}
```

Before the build can work, set up the generated API key to work with the build server in GitHub Actions.

1. Open your GitHub repository.
2. Navigate to Settings.
3. Go to the Secrets tab.
4. Select "New repository secret".
5. Call the new secret **"DEPLOYAPISECRET"**.
6. Add the API secret from the `appsettings.json` file (replace `ApiSecet` with `ApiKey` in the script and use the corresponding value if you're using the deprecated API key setting instead).
7. Save the secret.

Commit the configured YAML file and push up all the files to the repository.

Go to GitHub where you will now be able to see that the CI/CD build has started running:

![Deployment build started](<../../.gitbook/assets/Deploying-meta-data (1).png>)

The build server will go through the steps in the YAML file, and once it is done the deployment have gone through successfully:

![Deployment Complete](<../../.gitbook/assets/deployment-complete (1).png>)

You can now start creating content on the local machine. Once you create something like a Document Type, the changes will get picked up in Git.

When you're done making changes, commit them and deploy them to GitHub. The build server will run and extract the changes into the website in Azure.

This will only deploy the schema data for the local site to your website.

You will need to transfer content and media from the backoffice on your local project using the [queue for transfer feature](../../deployment-workflow/content-transfer.md).
