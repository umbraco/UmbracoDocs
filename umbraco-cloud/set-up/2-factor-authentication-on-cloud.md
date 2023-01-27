---
description: >-
  This article shows you how you can enable 2-factor authentication for when you
  log in to the Umbraco Cloud Portal or the Umbraco Backoffice.
---

# 2-factor authentication

On Umbraco Cloud, you can add 2-factor authentication for your Umbraco Cloud account.

You can use email, phone, or an authenticator app when logging in to the Umbraco Cloud Portal or the Umbraco Backoffice.

{% hint style="info" %}
You will not be prompted to authenticate your backoffice login if you have already done it for the portal. This is because both logins use the same centralized login service.
{% endhint %}

## Enabling 2-factor authentication

2-factor authentication can be enabled when editing your Umbraco Cloud profile.

To enable 2-factor-authentication follow these steps:

1. Go to your profile on Umbraco Cloud.
2. Choose **Edit Profile** in the Profile Settings section.
3. Choose the desired 2-factor authentication.
4. Follow the steps shown to enable 2-factor authentication.

### Email authentication

You will get an email with a code that you need to enter when logging in through the Umbraco Cloud portal or the backoffice.

![Email authentication](images/email-auth.png)

### Authenticator App

You have the option to use an Authenticator App when logging in to the Umbraco Cloud Portal or the Umbraco Backoffice.

You can use the Microsoft Authenticator App for both iOS and Android or any other authenticator app of your choice.

![Authenticator app](images/auth-app.png)

### Phone Authentication

You have the option to use your phone when you log in to the Umbraco Cloud portal or the Umbraco Backoffice. You can choose to receive an text message with a code or a call to log you in.

{% hint style="info" %}
Before deactivating your old phone number, please make sure to update the phone number used for your 2-factor-authentication. Changing the phone number used for 2FA will require verification through the old number.
{% endhint %}

![Phone authentication](../release-notes/images/Phone-auth.png)

## Disabeling 2-factor authentication

You can always disable 2-factor authentication from your profile.

To disable 2-factor authentication for your user, you will need to use the authentication method that you had enabled to disable it again.

If you had phone authentication enabled, it will then need to be used to disable it again.

The same is the case for email authentication.
