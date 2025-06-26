# April 2022

## [Enable client certificates from file system](../../../project-settings/application-settings.md)

If your project needs to load a client certificate (like an X.509 certificate) at runtime you can turn on this feature for your environments. By turning this feature on for an environment, you will be able to load a client certificate as a file. Which happens during the run-time of your cloud project.

![Enable client certificate load from file system](../../../set-up/images/EnableClientCertificateLoadedFromFileSystem.gif)

## Tweaks and improvements

During March and April, we have provided a lot of small improvements to the Umbraco Cloud Portal. Too many to mention, however you will find the highlights in the list below.

* Display the time of creation for environments (_now presented on the “Overview” page of the project_)
* Restrict access to function when environments are changing (_to avoid actions on environments that are being created, deleted, or modified_)
* Ordering Umbraco Logs correctly by date (_the logs and errors log of cloud projects were not always listed chronologically_)
* Always display a link to the error page for environments on the project page (_and not exclusively when the project has new errors_).
* Better user guidance when visiting the project page before accepting the project invite.
* Only show usage warnings for cloud projects on Starter or Standard cloud plans (_as these are less relevant to projects on a Professional and Enterprise plan_)
* Ensure cloud project name is part of email subjects (_to ease the overview of received mails for the technical contacts_)
