---
versionFrom: 8.0.0
---

# reCAPTCHA V3

You need to configure your site keys adding your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

```xml
<setting key="RecaptchaV3SiteKey" value="..." />
<setting key="RecaptchaV3PrivateKey" value="..." />
```

You can create your keys by [logging into your reCAPTCHA account](https://www.google.com/recaptcha/).
