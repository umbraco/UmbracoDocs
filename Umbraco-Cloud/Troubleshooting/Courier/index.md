# Troubleshooting with Courier

Umbraco Courier is the engine running Umbraco Cloud projects that has been created before May 2017 and have not yet been upgraded to Umbraco Deploy.

On this page you can find troubleshooting guides that you should use when your project is using Umbraco Courier.

## How do I know which engine my project is using?

In the Umbraco Cloud Portal you can see which engine each environment is using.

The environment in the image below is using Courier version 3.1.6

![Courier Version](images/version-courier.png)

## Troubleshooting guides

* Schema mismatch when transferring content and/or media
* Structure Errors

## Upgrading to Umbraco Deploy

Umbraco Deploy is the successor for Umbraco Courier. All new projects on Umbraco Cloud is using the Deploy engine, which is a new and much improved engine that will ensure even smoother deployments between your Umbraco Cloud environments.

There are two roads you can take, in order to upgrade your project to use the latest Umbraco Deploy engine:

1. Use the auto-upgrader on the Development environment in the Umbraco Cloud portal
    * This will upgrade your project to run the latest of everything
    ![Semi Automatic Upgrade](images/auto-upgrade.png)
2. Upgrade from [Courier to Deploy](../Moving-From-Courier-to-Deploy) manually