# Technology

## Overview

Umbraco Cloud is built on a modern, cloud-native technology stack designed to simplify your development workflow, automate deployment, and ensure reliable, scalable hosting. This section provides a comprehensive overview of the key technologies that power your Cloud projects — from version control and cloud infrastructure to deployment automation and developer tools.

### Version Control with Git

At the core of every Umbraco Cloud project is a Git repository, which securely tracks your changes. When you create a project, a Git repo is automatically set up, enabling you to:

* Collaborate safely with your team through branching and merging.
* Roll back to previous versions if needed.
* Trigger automatic deployments when changes are pushed.

For more information, see the [Repositories in a Cloud Project](repositories-in-a-cloud-project.md) article.

### Cloud Infrastructure

Umbraco Cloud is hosted on Microsoft Azure, providing scalable, secure, and resilient infrastructure. This means your projects benefit from the same robust platform trusted by enterprises worldwide, without the burden of managing servers or manual configurations.

#### What infrastructure powers Umbraco Cloud?

Umbraco Cloud runs on Microsoft Azure and uses Cloudflare for optimization and security. It includes:

* Automatic backups with point-in-time restore for data safety.
* TLS certificates for secure HTTPS connections.
* Built-in firewalls and network-level security.
* Environment-level access controls, allowing staging or development to be blocked from public access.

For more information, see the [Project Settings](../../build-and-customize-your-solution/set-up-your-project/project-settings/) article.

### Automated Deployments and Continuous Integration

Umbraco Cloud includes an integrated CI/CD pipeline that automates the deployment of your site whenever you push changes to Git. This means:

* Each commit triggers a build and deployment to your project’s environments (Development, Staging, Production).
* Deployments are fast, reliable, and consistent, reducing manual errors.
* You can easily promote changes through environments, ensuring quality control before going live.

For more information, see the [Umbraco CI/CD Flow](../../build-and-customize-your-solution/handle-deployments-and-environments/umbraco-cicd/) article.

### Developer Tools: Power Tools (Kudu) and Diagnostics

To help you manage and troubleshoot your Cloud projects, Umbraco Cloud integrates Power Tools powered by Kudu, an advanced Azure service. With these tools, you can:

* Inspect deployment logs and diagnose failed builds.
* Access your environment’s file system and process information.
* Run scripts and commands remotely.

For more information, see the [Power Tools (Kudu)](../../optimize-and-maintain-your-site/monitor-and-troubleshoot/power-tools/) article.

### Performance Enhancements: CDN Caching and Optimization Settings

Umbraco Cloud ensures exceptional performance and stability, whether it’s business as usual or during high-demand periods. With built-in caching, scalable resources, and seamless integrations, your digital experiences remain responsive and reliable under any circumstances.

For more information, see the [CDN Caching and Optimization Settings](../../optimize-and-maintain-your-site/optimize-performance/manage-cdn-caching.md) article.
