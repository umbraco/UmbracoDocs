# June 2025

## Key Takeaways
* **Hostname Monitoring** – Get notified when your hostnames do not behave as expected, directly from the Cloud Portal.
* **CI/CD v2 with target environment support** – You can now specify a development or flexible environment by name when deploying from pipelines.
* **Managing `DOTNET_ENVIRONMENT` environment variable** - You can now view and edit the `DOTNET_ENVIRONMENT` environment variable on Cloud Portal.

## Hostname Monitoring
Hostname Monitoring is now available on Umbraco Cloud, giving you better visibility and control over your environment setup.

This feature automatically pings your hostnames from one of the supported regions and verifies that the response is as expected. If a hostname does not respond as expected, you will see it directly in the Cloud Portal. 
This helps you quickly identify and resolve issues that could affect your site’s availability.

## CI/CD v2 with target environment support
Version 2 of the Umbraco Cloud CI/CD feature introduces support for specifying which environment to deploy to. This makes it easier to set up automated deployments from pipelines to your Cloud environments.

Currently, target environments must be either the default development environment or a flexible environment. Deployment to the Live or Staging environments is not yet supported.

Learn more in the [CI/CD on Umbraco Cloud](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/umbraco-cicd) article.

## Managing `DOTNET_ENVIRONMENT` environment variable
It is now possible to view and edit the `DOTNET_ENVIRONMENT` variable on Cloud Portal. This can be done through navigating to the Advanced settings under the Configuration section.

This feature gives you more control over the configuration of your Umbraco Cloud environment. By specifying a custom `DOTNET_ENVIRONMENT` value, you can load different environment-specific settings per environment.