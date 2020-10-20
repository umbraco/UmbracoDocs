---
versionFrom: 7.0.0
---

# Troubleshooting deployments

Issues with deployments on Umbraco Cloud often comes down to a misunderstanding on how to work with Umbraco Cloud. It is very important to always work left to right as mentioned [here](../../Deployment).

There are two ways to deploy on Umbraco Cloud, a deployment which transfers content and media:
1. A Content [Transfer](../../Deployment/Content-Transfer) / [Restore](../../Deployment/Restoring-content)
1. A [Deployment](../../Deployment/Cloud-to-Cloud) that transfers structure files (doc types, data types, templates, dll's, etc.)

There are some common errors associated with both of these, most of the time it is caused by conflicting [UDA files](../../Set-Up/Power-Tools/generating-uda-files/#what-are-uda-files) between the two environments you are deploying between.

The most common [Deployment](../../Deployment/Cloud-to-Cloud) issues are listed below with guides on how to fix them:

* [Duplicate Dictionary Items](Duplicate-Dictionary-Items)
* [Collision Errors](Structure-Error)
* [Dependency Exception](Dependency-Exceptions)
* [Colliding Data Types](Colliding-Datatypes)
* [Type Not Found](Type-Not-Found)
* [Language Mismatch](Language-Mismatch)


The most common Content [Transfer](../../Deployment/Content-Transfer) / [Restore](../../Deployment/Restoring-content) issues are listed below:
* [Schema mismatch](Schema-Mismatches)
* [SQL Timeouts](../../Deployment/Deploy-Settings/#timeout-issues)
* [Dependency Exception](Dependency-Exceptions)
* [Media path too long](Path-too-long-exception)
* [An existing connection was forcibly closed by the remote host](Connection-Forcibly)


### Issues when using third party packages

If you experience problems when using third party packages on Umbraco Cloud there is a chance they are not compatible with Umbraco Cloud. Packages that add custom editors will need a Value Connector set up to work with Umbraco Deploy. Some of the most used packages out there have been included in the Community driven Umbraco Deploy Contrib project. You can include the Contrib dll in your project to help with a lot of them.

To see a list of packages covered look [here](https://github.com/umbraco/Umbraco.Deploy.Contrib).
To see examples of how Value Connectors are made look [here](https://github.com/umbraco/Umbraco.Deploy.ValueConnectors).
