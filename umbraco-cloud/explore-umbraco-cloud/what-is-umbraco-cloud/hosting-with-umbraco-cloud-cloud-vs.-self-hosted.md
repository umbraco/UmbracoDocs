---
description: >-
  A quick overview of how Umbraco Cloud provides secure, scalable, and fully
  managed hosting.
---

# Hosting with Umbraco Cloud: Cloud vs. Self-Hosted

Umbraco Cloud offers fully managed hosting for your Umbraco projects, leveraging Microsoft Azure. This means you don’t have to worry about setting up infrastructure, servers, or deployment pipelines. Everything is included and optimized for running Umbraco projects at scale.

Choosing between **Umbraco Cloud** and **self-hosted Umbraco** depends on your project's requirements, team setup, and compliance needs. Here's a breakdown to help you make a decision:

| Feature                     | Umbraco Cloud                          | Self-Hosted Umbraco                                   |
| --------------------------- | -------------------------------------- | ----------------------------------------------------- |
| **Hosting infrastructure**  | Managed by Umbraco on Azure            | Managed by you (Azure, Amazon Web Services (AWS), on-prem, etc.) |
| **Setup Time**              | Minimal, creates a project in minutes  | Manual configuration is required                      |
| **Upgrades (CMS + Deploy)** | Automated and guided                   | Manual updates needed                                 |
| **Deployments**             | Built-in workflows via Umbraco Deploy  | Custom pipeline setup needed                          |
| **Upgrades and Backups**    | Automatic and included                 | Manual or via custom setup                            |
| **CI/CD Support**           | Built-in automated deployments         | Custom pipelines (e.g., Azure DevOps, GitHub Actions) |
| **Monitoring and logging**  | Integrated dashboards and logs         | Must integrate with external tools                    |
| **Security and Compliance** | Web Application Firewall (WAF), HTTPS, Multi-Factor Authentication (MFA), ISO-certified hosting | Your responsibility                                   |
| **Support**                 | Included with selected plans           | Community or third-party support                      |

## Shared vs. Dedicated Hosting

Umbraco Cloud offers:

* **Shared Hosting** (default): Your site runs in an isolated environment on shared infrastructure that is optimized for performance and security.
* **Dedicated Resources**: Available for high-traffic or security-sensitive projects with full tenant isolation. For a full overview of configuration and pricing, refer to the [Dedicated Resources page](https://umbraco.com/products/umbraco-cloud/dedicated-resources/)

&#x20;For plan-level details, see the [Umbraco Cloud Plans](https://umbraco.com/products/umbraco-cloud/pricing/).

## When to Choose Umbraco Cloud

Choose **Umbraco Cloud** if you want to:

* Launch quickly with minimal infrastructure setup.
* Automate deployments, upgrades, and backups.
* Focus on building solutions, not managing servers.
* Collaborate smoothly across teams with built-in workflows.
* Receive support and platform updates directly from Umbraco HQ.
* Align with best practices for security, scaling, and deployment.

#### Ideal for

* Digital agencies
* Internal development teams
* MVPs and large-scale web projects needing quick iteration and long-term stability

## When to Choose Self-Hosted Umbraco

Choose **self-hosted** Umbraco if you:

* Require complete control over your hosting and stack.
* Must adhere to specific security, legal, or compliance requirements.
* Have in-house DevOps expertise and want to tailor CI/CD workflows.
* Need integration with private networks or legacy systems.
* Prefer a different cloud provider or on-premises setup.

### **Ideal for**

* Enterprises with strict governance
* Custom architecture requirements
* Projects with highly specialized hosting needs

## Resources

* [Umbraco Cloud Overview](https://umbraco.com/products/umbraco-cloud/)
* [Security on Umbraco Cloud](../../build-and-customize-your-solution/set-up-your-project/security/)
* [CI/CD on Umbraco Cloud](../../build-and-customize-your-solution/handle-deployments-and-environments/umbraco-cicd/)
