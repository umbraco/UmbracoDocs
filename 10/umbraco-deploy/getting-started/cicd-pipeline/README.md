---
description: "Steps and examples on how Umbraco Deploy can be integrated into an automated build and deployment pipeline"
---

# Setting up a CI/CD Build and Deployment Pipeline

Once Umbraco Deploy has been installed and the schema data has been generated, a CI/CD build server needs to be set up.

The build server will extract the changes that has been pushed to the repository into your production website that has been connected with Umbraco Deploy.

This is something that can be done in many different ways depending on where your website is hosted and your setup.

Umbraco Deploy does not require the use of any particular build or deployment tools and hence we expect that you should be able to continue using the tool or tools of your choice. Any that have support for .NET website deployments and the running of Powershell scripts. such as Azure DevOps or GitHub Actions, would be appropriate.

Above and beyond the normal steps of a build pipeline for a .NET web application - tasks like NuGet restore, solution build, running of tests etc. - Umbraco Deploy requires three additional steps.

- The license file needs to be deployed into the target environment's `umbraco/Licenses` folder.
- The `.uda` schema files that are written to disk and included in source control, need to be made available in the build artifact that is deployed to the target environment.
- Once the build is complete, the extraction of the updated schema in the target environment needs to be triggered.

The first two steps will be implemented in a similar way.  There will need to be a step added to the pipeline that runs after the main build of the website, to copy the license file and data files into the published build output, such that they are included in the build artifacts that are deployed to the target environment.

The third step needs to run last in the pipeline, once the built web application is deployed to the target environment.  Umbraco Deploy provides a Powershell script that can be used for the purpose of triggering the extraction of the schema information and update of the target Umbraco installation.

## Background on the Schema Extraction Process

Without a CI/CD pipeline step in place to trigger the extraction, following a deployment, the process would need to be carried out manually. This can be done by logging into the backoffice, navigating to _Settings > Deploy_ and triggering the operation via the dashboard.

Behind the scenes what happens here is a marker file being written to disk - in the `/umbraco/Deploy/` folder and with a name of `deploy`.  It’s by monitoring this directory for a file with this name that Umbraco Deploy knows to trigger the extraction.

Umbraco Deploy also provides an HTTPS endpoint that can be called by an authenticated request.  This will write the marker file, which will trigger the extraction.

Umbraco Deploy On-Premises also ships with a Powershell script, that when executed will call the endpoint, which will write the file, and which will trigger the extraction.

So while it may be possible to have the CI/CD step directly write the file or call the endpoint, so long as the build used supports running Powershell scripts this is the method we’d recommend, as it has some necessary error checking and retry logic built-in.

## [Setting up CI/CD pipeline with GitHub Actions](ci-cd-github-actions.md)

Details the setup of a CI/CD pipeline using GitHub Actions.

## [Setting up CI/CD pipeline with Azure DevOps](ci-cd-azure-dev-ops.md)

Details the setup of a CI/CD pipeline using Azure DevOps.
