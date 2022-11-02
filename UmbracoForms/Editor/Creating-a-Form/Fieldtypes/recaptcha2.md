---
versionFrom: 7.0.0
versionTo: 10.0.0
---

# reCAPTCHA V2

In Umbraco Forms, reCAPTCHA V2 comes out of the box to help you to protect your site from spam, malicious people, and so on.

## Enabling reCAPTCHA V2

Follow these steps to enable reCAPTCHA V2 in Umbraco Forms:

1. Go to the **Forms** section in the backoffice.
2. Find the form that should have **ReCAPTCHA v2** enabled.
3. Add a new question and select **ReCAPTCHA v2** as its answer type.
4. Make sure the field is set as  **Mandatory**.
5. Configure ReCAPTCHA settings in the `appSettings.json` file to include public and private keys:

```json
"Umbraco"{
    "Forms": {
      "FieldTypes": {
        "Recaptcha2": {
            "PublicKey": "",
            "PrivateKey": ""
          }
        }
      }
   }
```

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).

## For version 8.x and below

You can configure your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

```xml
<setting key="RecaptchaPublicKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG" />
<setting key="RecaptchaPrivateKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG-" />
```

![reCAPTCHA v2](images/recaptcha2-v9.png)

For information on how to use reCAPTCHA in the best possible way on your website, see the [reCAPTCHA V2 Documentation](https://developers.google.com/recaptcha/docs/display).
