---
versionFrom: 8.0.0
versionTo: 10.0.0
---

# reCAPTCHA V3

reCAPTCHA V3 comes with Umbraco Forms out-of-the-box

## Enabling reCAPTCHA V3

First step to enable reCAPTCHA, it needs to be added as a field to your Umbraco Form:

1. Go to the forms section in the backoffice
2. Find the form that should have ReCAPTCHA enabled

You can configure the settings in the `appSettings.json` file:

```json
"Umbraco"{
    "Forms": {
      "FieldTypes": {
        "Recaptcha3": {
            "SiteKey": "",
            "PrivateKey": ""
          }
        }
      }
   }
```

You need to configure your site keys by adding your public and private keys.

When adding the field to your form, you can select whether or not to save the scores calculated by reCAPTCHA as a value in the form submission, using the _Save score_ setting.

## For version 8.x and below

You can configure your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

```xml
<setting key="RecaptchaV3SiteKey" value="..." />
<setting key="RecaptchaV3PrivateKey" value="..." />
```

![reCAPTCHA v2](images/recaptcha3-v9.png)

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).

:::note
Ensure to select the **Mandatory** field while adding the **Recaptcha3** to your Form.
:::
