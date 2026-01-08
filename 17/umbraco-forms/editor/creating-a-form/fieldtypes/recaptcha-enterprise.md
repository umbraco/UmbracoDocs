# reCAPTCHA Enterprise

In Umbraco Forms, reCAPTCHA Enterprise comes out of the box.

reCAPTCHA Enterprise allows you to verify if an interaction is legitimate without any user interaction.

## Enabling reCAPTCHA Enterprise

Follow these steps to enable reCAPTCHA Enterprise in Umbraco Forms:

1. Go to the **Forms** section in the backoffice.
2. Find the form that should have **ReCAPTCHA Enterprise** enabled.
3. Add a new question and select **ReCAPTCHA Enterprise with Score** as its answer type.
4. Make sure the field is set as **Mandatory**.
5. Configure reCAPTCHA settings in the `appSettings.json` file to include `SiteKey`, `ApiKey` and `ProjectId`:

```json
"Umbraco": {
    "Forms": {
        "FieldTypes": {
            "RecaptchaEnterprise": {
                "SiteKey": "",
                "ApiKey": "",
                "ProjectId": "",
            }
        }
    }
}
```

You can create your keys by logging into your [reCAPTCHA account](https://www.google.com/recaptcha/).
