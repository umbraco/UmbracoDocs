---
hidden: true
---

# Application Settings

{% hint style="info" %}
This feature is _only_ available for Umbraco Cloud projects on a **Standard** or **Professional** plan.
{% endhint %}

Umbraco Cloud enables you to toggle a selection of predefined settings for each of the project's environments. A change of an application setting enables you to change one specific behavior of the app service that an environment is running in. The objective of application settings is to empower you with features or functionality that aren't available by default.

You can find this option in **Settings** -> **Advanced** -> **Custom Application Settings**. Currently, the only available setting is the **Enable client certificate loaded from file system**.

## Enable client certificate loaded from file system Explained

If your cloud project needs to load a client certificate (such as an X.509 certificate) at runtime, you can turn on this feature for one or more environments. By turning this feature on for an environment, you will be able to load a client certificate as a file during the run-time of your cloud project.

For more information on loading a certificate from a file, see the [Load certificate from file](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate-in-code#load-certificate-from-file) article in the Microsoft documentation.

{% hint style="info" %}
When toggling the setting, a confirmation prompt is displayed. Enabling/disabling this feature enforces a restart of the environment.
{% endhint %}
