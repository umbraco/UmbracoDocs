---
description: >-
  Use flexible environments to create a separate workflow along side the
  left-to-right deployment approach in Umbraco Cloud.
---

# Flexible Environments

Flexible Environments allow users to create and manage environments outside the regular left-to-right deployment flow. This enhancement provides flexibility in orchestrating code and content workflows, empowering developers and content editors to work in a way that best suits their needs.

While the mainline environments use a horizontal deployment flow, flexible environments work differently. A flexible environment is added to an existing mainline environment and only deploys to and from that environment. Get an overview of the different types of environments in the [Environments](environments.md) article.

![A Cloud project set up with two mainline environments and one flexible environment](../getting-started/images/cloud-environments.png)

The image above shows a project setup including two mainline environments and one flexible environment attached to the left-most mainline environment.

With Flexible Environments, teams can create environments as needed, allowing for more efficient and tailored workflows.

This feature enables:

* **Parallel development and testing**: Developers can create isolated environments for different features, bug fixes, or client-specific work without impacting the main development branch.
* **Custom workflow orchestration**: Teams can define custom flows of code and content deployment rather than being restricted to a linear left-to-right approach.
* **Easier hotfixes and feature releases**: Urgent fixes can be deployed directly without being blocked by unfinished work in other environments.
* **Improved Content Management**: Content editors can create, test, and validate content changes without depending on a specific environment.

## How it works

* A flexible environment is added and connected to a single mainline environment.
* Developers can develop and build features in the flexible environment without affecting the mainline environment.
* Once a feature is complete, it can be merged back into the mainline environment and become part of regular deployment flow.
* When changes are made to the mainline environment, they must be pulled into the flexible environment before changes can be pushed.

Learn more about the deployment process in the [Deployments](../build-and-customize-your-solution/handle-deployments-and-environments/deployment/) section.

Learn more about handling merge Conflicts in Flexible Environments in the [Troubleshooting](../monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/deployments/merge-conflicts-on-flexible-environments.md) section.

## Project Prerequisites

Before you can add a Flexible environment to your project, the following prerequisites must be met:

* Uses Umbraco Version 10 or greater.
* Uses Deploy Version Greater than 10.4.1, 13.3.0, 14.2.0 or greater.

### Limitations

* Only one flexible environment is available.
* Flexible environments are available only for projects paid with credit cards or credits.
* Flexible Environments are not available for Heartcore projects.

## Plans and Availability

<table><thead><tr><th width="117">Plan</th><th width="116" data-type="number">Environments</th><th width="167" data-type="checkbox">Flexible Environments</th><th>Environment Combinations Examples</th></tr></thead><tbody><tr><td>Starter</td><td>2</td><td>false</td><td><em>QA + Production</em></td></tr><tr><td>Standard</td><td>3</td><td>true</td><td><em>Flexible + QA + Production</em><br><em>Development + QA + Production</em></td></tr><tr><td>Professional</td><td>4</td><td>true</td><td><em>Flexible + Development + QA + Production</em></td></tr></tbody></table>
