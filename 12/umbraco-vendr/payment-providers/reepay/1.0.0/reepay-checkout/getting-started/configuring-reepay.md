---
title: Configuring Reepay
description: Documentation for the Reepay Checkout (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Sign up & Sign in

If you haven't done so yet, head on over to [signup.reepay.com](https://signup.reepay.com) to register for a Reepay account.

![Reepay sign up](/media/screenshots/reepay/reepay_signup.png)

Or, if you already have an account, you can head over to [admin.reepay.com](https://admin.reepay.com/) to sign in to your account.


![Reepay sign in](/media/screenshots/reepay/reepay_signin.png)


## API Keys

In order for Vendr to communicate with Reepay securely we will need to generate a series of API keys that Vendr can use to authenticate with.

In the sidebar, click the **Developers** heading and then the **API credentials** sub heading. You can here find the public and private API keys or generate new keys.

![Reepay API Keys](/media/screenshots/reepay/reepay_api_keys.png)

You'll need to generate API keys for both test and live modes, so be sure to run through this process twice, once with test mode enabled, and once with live mode enabled. 

Once you have both sets of API keys, be sure to note them down as we will need to enter them into the Vendr UI shortly.

## Webhook 

In order for Reepay to notify Vendr of a successful transaction, Reepay makes use of webhook technology to directly send notifications of the changing statuses of a transaction. By using webhooks it ensures that the system will always be notified of these status changes, even if the customer decides not to return to the store once a transaction is complete.

To register a webhook, in the sidebar, click the **Developers** heading and then the **Webhooks** sub heading. At the top of the page click the **Configuration** button and next click **Add URL** button and enter the Vendr callback URL as follows (replacing the parameters in curly brackets with the corresponding values taken from your store):

````bash
https://{store_domain}/umbraco/vendr/payment/callback/reepay-checkout/{payment_method_id}/
````

![Reepay Webhook](/media/screenshots/reepay/reepay_webhook.png)

From the **Configuration** overlay in the **Event types** list select the following event types:

* `invoice_settled`
* `invoice_authorized`

Note the webhook secret can also be found here, which is used in the payment provider to being able to communicate with the webhook in Reepay.

Click **Save** button at bottom in overlay to register the details for the webhook.