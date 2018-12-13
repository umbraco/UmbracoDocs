# Recaptcha

![Recaptcha2](images/recaptcha2.png)

You need to configure your site keys adding your public and private keys in the `UmbracoForms.config` file located in `~/App_Plugins/UmbracoForms/`:

```xml
<setting key="RecaptchaPublicKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG" />
<setting key="RecaptchaPrivateKey" value="sHZZenninFziVUV9TN24FqhwZvc2b4e8BLrG-" />
```

You can create your keys by [logging into your Recaptcha account](https://www.google.com/recaptcha/).

**Note**: Don't forget to make the recatpcha field mandatory.