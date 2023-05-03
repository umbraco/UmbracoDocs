---
title: Configuring PayPal
description: Documentation for the PayPal payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Sign up & Sign In  

To use the PayPal provider you will need to sign up for a Business PayPal account. If you haven't created one yet, head on over to [https://www.paypal.com](https://www.paypal.com/) and click the **Sign Up** button in the top corner to create an account, making sure to choose **Business Account** as the account type.

![PayPal Business Account Signup](/media/screenshots/paypal/signup_business_account.png)

In addition to the live PayPal account, if you wish to test your system before go live, you will also need to sign up for a set of Sandbox accounts. To do this, you will first need to sign into a valid PayPal account (this doesn't have to be the final live account, any account will do) and then head on over to [https://developer.paypal.com/developer/accounts/](https://developer.paypal.com/developer/accounts/).

![PayPal Sandbox Accounts](/media/screenshots/paypal/sandbox_accounts.png)

From here you can view and modify any existing Sandbox accounts you have. If there aren't any Sandbox accounts created for you, click the **Create Account** to create both a business and personal set of accounts.

![Create PayPal Sandbox Accounts](/media/screenshots/paypal/create_sandbox_accounts.png)

With Sandbox accounts created, in the **Managed Accounts** column, select **View/Edit account** for each account and note down both their **Email-ID** and **Password**.

![PayPal Sandbox Account Details](/media/screenshots/paypal/sandbox_account_details.png)

## Create a PayPal App

In order for Vendr to perform actions in your PayPal account on your behalf, we need to create a PayPal App. In fact, we'll need to create two, one for the Sandbox account and one for our Live account. 

We create an App via the PayPal Developer Portal at [https://developer.paypal.com/developer/applications/](https://developer.paypal.com/developer/applications/).

![PayPal Apps](/media/screenshots/paypal/applications.png)

From here, we create our two apps by toggling the **Sandbox\Live** toggle buttons, and clicking the **Create App** button to create an App for each environment. 

In the **Create New App** screen, give your app a name, and for the Sandbox App, choose the **Sandbox Business Account** to associated the App with and click the **Create App** button to create the App and be sent to the App details screen.

![Create PayPal App](/media/screenshots/paypal/create_application.png)

From the App details screen, note down the **Client ID** then click the **Show** link below the **Secret** heading, and note down the **Secret** displayed.

![PayPal App Details](/media/screenshots/paypal/application_details.png)

### Webhooks

On this same screen, you will then want to scroll down to the **Webhooks** section and click the **Add Webhook** button to create a new Webhook.

![PayPal App Webhooks](/media/screenshots/paypal/webhooks.png)

For the webhook, you'll want to provide the URL where the webhook notifications should be sent, which is a Vendr specific URL as follows (replacing the parameters in curly brackets with the corresponding values taken from your store):

````bash
https://{store_domain}/umbraco/vendr/payment/callback/paypal-checkout-onetime/{payment_method_id}/
````

You'll also want to select the **Event Types** to be notified of, for which you'll want to check the following options by checking the appropriate checkboxes next to those options and then clicking the **Save** button at the bottom.

* Checkout order approved
* Checkout order completed
* Payment authorization voided
* Payment capture completed
* Payment capture denied
* Payment capture pending
* Payment capture refunded
* Payment capture reversed

![Create PayPal App Webhook](/media/screenshots/paypal/sandbox_webhook.png)

Once created, in the webhooks list, be sure to take a not of the **Webhook ID** of the webhook as we'll need this to verify webhook notifications later.

![PayPal App Webhooks](/media/screenshots/paypal/webhooks2.png)

As previously mentioned, you will need to create an App and webhook configuration for both Sandbox and Live environments. For the Live environment, this must be setup under the account that will be accepting the payments.