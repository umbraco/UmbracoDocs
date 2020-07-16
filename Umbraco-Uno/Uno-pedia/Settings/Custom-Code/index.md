---
versionFrom: 8.0.0
---

# Custom Code

In Umbraco Uno, it is possible to enable Custom Code, if you are on a Standard or Professional plan.
The way you activate this feature is very straight forward:

1. Navigate to your project in the portal

2. Go to settings

3. Select ***Enable Custom Code***

![this image shows what the menu looks like](images/Enable-Custom-Code.png)

4. You will be taken to a new page with a disclaimer, telling you that once you enable custom code you cannot turn it off again.

5. If you are sure you want to enable custom code then go ahead and click the green button saying ***Enable Custom Code***

![this image shows what the disclimer page looks like](images/warning-page.png)

After Enabling Custom code, you will be able to enter the settings section and the packages section on your Development and Staging environments(not on live).
Furthermore, you will gain access to Git for Development and Staging which will enable you to clone the environments to your local machine.

:::warning
Please be aware that you will stop getting updates for Umbraco Uno, should you choose to enable custom code, and the decision is irreversible once you click enable custom code.
Upgrading to Custom Code, also removes your sendgrid implimentation, meaning that you will have to [manually set up your mail integration](../../../../Umbraco-Cloud/Set-Up/SMTP-settings/index.md) 
:::
