# reCAPTCHA V3

In Umbraco Forms, reCAPTCHA V3 comes out of the box.

reCAPTCHA v3 allows you to verify if an interaction is legitimate without any user interaction.

## Enabling reCAPTCHA V3

Follow these steps to enable reCAPTCHA V3 in Umbraco Forms:

1. Go to the **Forms** section in the backoffice.
2. Find the form that should have **ReCAPTCHA v3** enabled.
3. Add a new question and select **ReCAPTCHA v3 with Score** as its answer type.
4. Make sure the field is set as **Mandatory**.
5. Configure ReCAPTCHA settings in the `appSettings.json` file to include public and private keys:

```json
"Umbraco": {
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

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).
