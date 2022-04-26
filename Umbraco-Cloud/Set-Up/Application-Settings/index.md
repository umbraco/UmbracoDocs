---
versionFrom: 7.0.0
versionTo: 9.0.0
---

# Custom Application Settings

:::note
This feature is *only* available for Umbraco Cloud projects on a **Standard** or **Professional** plan.
:::

Umbraco Cloud enables you to toggle a selection of predefined settings for each of the project's environments.
A change of an application setting enables you to change one specific behavior of the app service that an environment is running in. The objective of application settings is to empower you with features or functionality that aren't available by default.

Currently, the only setting that is available is the _enable client certificate loaded from file system_.

## Enable client certificate loaded from file system Explained
If your cloud project needs to load a client certificate (such as a X.509 certificate) at runtime you can turn on this feature for one or more environments.
By turning this feature on for an environment you will be able to load a client certificate as a file during run-time of your cloud project.

![Enable Client Certificate](Images/EnableClientCertificateLoadedFromFileSystem.gif)

You can find more information on loading a certificate from a file [here](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate-in-code#load-certificate-from-file).

:::note
When toggling the setting you will be met by a confirmation prompt. An enabling/disabling of this feature will enforce a restart of the environment.
:::
