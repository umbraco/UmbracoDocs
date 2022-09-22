---
versionFrom: 8.0.0
versionTo: 10.0.0
---

# reCAPTCHA V3

In Umbraco Forms reCAPTCHA V3 comes out-of-the-box to help you to protect your site from spam, malicious people and so on.

## Enabling reCAPTCHA V3

Follow these steps to enable reCAPTCHA V3 in Umbraco Forms:

1. Go to the **Forms** section in the backoffice.
2. Find the form that should have ReCAPTCHA  enabled
3. Add a new question using **ReCAPTCHA v3 with Score**
4. Make sure the field is set as  **Mandatory**.
5. Configure ReCAPTCHA settings in the `appSettings.json` file:

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

5. Configure site keys by adding your public and private keys.

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).

## For version 8.x and below

You can configure your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

```xml
<setting key="RecaptchaV3SiteKey" value="..." />
<setting key="RecaptchaV3PrivateKey" value="..." />
```

![reCAPTCHA v2](images/recaptcha3-v9.png)

Once reCAPTCHA V3 has been enabled make sure to consult the [reCAPTCHA V3 Documentation](https://developers.google.com/recaptcha/docs/v3) for how to leverage it in the best possible way on your website.
