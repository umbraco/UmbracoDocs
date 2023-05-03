---
title: Configuring Adyen
description: Documentation for the Adyen Checkout (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Sign up & Sign in

If you haven't done so yet, head on over to [adyen.com/signup](https://www.adyen.com/signup) to register for a Adyen account.

![Adyen sign up](/media/screenshots/adyen/adyen_signup.png)

Or, if you already have an account, you can head over to [ca-live.adyen.com/ca/ca/login.shtml](https://ca-live.adyen.com/ca/ca/login.shtml) to sign in to your account.


![Adyen sign in](/media/screenshots/adyen/adyen_signin.png)

## API Keys

In order for Vendr to communicate with Adyen securely we will need to generate an API key that Vendr can use to authenticate with.

## Webhook 

In order for Adyen to notify Vendr of a successful transaction, Adyen makes use of webhook technology to directly send notifications of the changing statuses of a transaction. By using webhooks it ensures that the system will always be notified of these status changes, even if the customer decides not to return to the store once a transaction is complete.

To register a webhook switch to the account ending with **ECOM** and then select **Account > Server Communication**. From the list at Standard Notification click the **Add** button on the right or edit an exiting Standard Notification. Enter the Vendr callback URL as follows (replacing the parameters in curly brackets with the corresponding values taken from your store):

````
https://{store_domain}/umbraco/vendr/payment/callback/adyen-checkout/{payment_method_id}/
````

![Adyen Webhook](/media/screenshots/adyen/adyen_webhook.png)
