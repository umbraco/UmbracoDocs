---
versionFrom: 7.0.0
versionTo: 10.0.0
---

# reCAPTCHA V2

You need to configure your site keys adding your public and private keys.

## For version 9

You can configure the settings in `appSettings.json` file:

```json
"Umbraco": {
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

## For version 8.x and below

You can configure your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

```xml
<setting key="RecaptchaPublicKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG" />
<setting key="RecaptchaPrivateKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG-" />
```

![reCAPTCHA v2](images/recaptcha2-v9.png)

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).

:::note
Ensure to select the **Mandatory** field while adding the **Recaptcha2** to your Form.
:::
