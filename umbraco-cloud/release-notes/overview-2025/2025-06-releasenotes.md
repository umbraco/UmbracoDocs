# June 2025

## Key Takeaways
* **Hostname Monitoring** – Get notified when your hostnames do not behave as expected, directly from the Cloud Portal.
* **CI/CD v2 with target environment support** – You can now specify a development or flexible environment by name when deploying from pipelines.

## Hostname Monitoring
Hostname Monitoring is now available on Umbraco Cloud, giving you better visibility and control over your environment setup.

This feature automatically pings your hostnames from one of the supported regions and verifies that the response is as expected. If a hostname does not respond as expected, you will see it directly in the Cloud Portal. 
This helps you quickly identify and resolve issues that could affect your site’s availability.

## CI/CD v2 with target environment support
Version 2 of the Umbraco Cloud CI/CD feature introduces support for specifying which environment to deploy to. This makes it easier to set up automated deployments from pipelines to your Cloud environments.

Currently, target environments must be either the default development environment or a flexible environment. Deployment to the Live or Staging environments is not yet supported.

Learn more in the [CI/CD on Umbraco Cloud](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/umbraco-cicd) article.
