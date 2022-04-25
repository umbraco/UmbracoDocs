---
versionFrom: 7.0.0
---

# Custom Application Settings

Umbraco Cloud enables you to turn on/off a selection of predefined settings for each of the project's environments.
A change of an application setting enables you to change one specific behavoir of the app service that an environment is running in. The objective with application settings are to empower you with feature or functionality that isn't available by default.

Currently the only setting that currently is available is the _enabling of client certificate from the filesystem_.

## Enable filesystem certificates Explained
If your cloud project needs to load a client certificate at runtime such as a X.509 client certificate you can turn on this feature for the environments were you need this.
By enabling the setting XXX for an environment you will be able to load a client certificate as a file during run-time of your cloud project.

  << PICTURE TO ADD >>

You can find more information on loading a certificate from a file [here](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate-in-code#load-certificate-from-file).
