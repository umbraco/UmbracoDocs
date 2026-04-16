# reCAPTCHA V2

In Umbraco Forms, reCAPTCHA V2 comes out of the box to help you to protect your site from spam, malicious people, and so on.

## Enabling reCAPTCHA V2

Follow these steps to enable reCAPTCHA V2 in Umbraco Forms:

1. Go to the **Forms** section in the backoffice.
2. Find the form that should have **ReCAPTCHA v2** enabled.
3. Add a new question and select **ReCAPTCHA v2** as its answer type.
4. Make sure the field is set as **Mandatory**.
5. Configure ReCAPTCHA settings in the `appSettings.json` file to include public and private keys:

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

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).
