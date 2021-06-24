---
versionFrom: 7.0.0
versionTo: 9.0.0
---

# reCAPTCHA V2

You need to configure your site keys adding your public and private keys in the `appSettings.json` file:

```json
"Forms": {
      "Recaptcha2": {
        "PublicKey": "",
        "PrivateKey": ""
      }
}

```

![reCAPTCHA v2](images/recaptcha2-v9.png)

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).

:::note
Ensure to select the **Mandatory** field while adding the **Recaptcha2** to your Form.
:::
