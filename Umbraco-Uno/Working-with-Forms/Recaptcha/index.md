---
versionFrom: 8.0.0
---
# Recaptcha and Umbraco Uno

When you're using the *Recaptcha* forms option in Umbraco Uno, you will need to follow a few extra steps, in order to configure the feature.

The steps are outlined below:

1. Open a browser and navigate to https://www.google.com/recaptcha/admin/create
2. Fill the form and submit it
3. Copy the **site key** and **secret key**
4. Head into the backoffice of your Umbraco Uno site
5. Locate the Settings page
6. Click the elipsies and choose to create an instance of **Forms**
7. Copy and paste your site key into the field called "Recaptcha public key"
8. Save and publish the Forms settings content node

![How to find a create a Forms page under Settings](images/forms-recaptcha.png)