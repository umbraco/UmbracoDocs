---
versionFrom: 8.0.0
meta.Title: "2-factor authentication on Umbraco Cloud"
meta.Description: "This article shows you how you can enable 2-factor authentication for when you log in to the Umbraco Cloud Portal."
---

# 2-factor authentication on Umbraco Cloud

On Umbraco Cloud, you can add 2-factor authentication for your Umbraco Cloud account.

You can use email, phone, or an authenticator app when logging in to the Umbraco Cloud Portal.

## Enabling 2-factor authentication

2-factor authentication can be enabled when editing your Umbraco Cloud profile.

To enable 2-factor-authentication follow these steps:

1. Go to your profile on Umbraco Cloud.
2. Choose **Edit Profile** in the Profile Settings section.
3. Choose the desired 2-factor authentication.
4. Follow the steps shown to enable 2-factor authentication.

### Email authentication

With email authentication, you will get an email with a code that you need to enter when you log in to the Umbraco Cloud portal.

![Email authentication](images/email-auth.png)

### Authenticator App

You have the option to use an Authenticator App when logging in to the Umbraco Cloud Portal.

You can use the Microsoft Authenticator App for both iOS and Android or any other authenticator app of your choice.

![Authenticator app](images/auth-app.png)

### Phone Authentication

You have the option to use your phone when you log in to the Umbraco Cloud portal.
You can choose to receive an text message with a code or a call to log you in.

:::note
Before deactivating your old phone number, please make sure to update the phone number used for your 2-factor-authentication.
Changing the phone number used for 2FA will require verification through the old number.
:::

![Phone authentication](images/Phone-auth.png)

## Disabeling 2-factor authentication

You can always disable 2-factor authentication from your profile.

To disable 2-factor authentication for your user, you will need to use the authentication method that you had enabled to disable it again.

If you had phone authentication enabled, it will then need to be used to disable it again.

The same is the case for email authentication.
