---
versionFrom: 8.0.0
---

# reCAPTCHA V3

You need to configure your site keys by adding your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

```xml
<setting key="RecaptchaV3SiteKey" value="..." />
<setting key="RecaptchaV3PrivateKey" value="..." />
```

![reCAPTCHA v2](images/recaptcha3-v9.png)

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).

:::note
Ensure to select the **Mandatory** field while adding the **Recaptcha2** to your Form.
:::
