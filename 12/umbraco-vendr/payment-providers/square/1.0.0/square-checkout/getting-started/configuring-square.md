---
title: Configuring Square
description: Documentation for the Square Checkout payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Sign up & Sign in

If you haven't done so yet, head on over to [https://squareup.com/signup](https://squareup.com/signup) to register for a Square account.

![Square sign up](/media/screenshots/square/signup.png)

Or, if you already have an account, you can head over to [https://squareup.com/login](https://squareup.com/login) to sign in to your account.

![Square sign in](/media/screenshots/square/login.png)


## App Configuration

In order for Vendr to communicate with Square we must first create an App in the Square portal which will provide us with credentials that Vendr can use to authenticate with.

In the sidebar, click the **Apps** heading and then the **Create APP** button providing a name for the app to create.

![Square Dashboard](/media/screenshots/square/dashboard_apps.png)

![Square Apps](/media/screenshots/square/create_app.png)

Next to your app in the apps list, click the **Manage** button and then the **View App Dashboard** button to access the apps dashboard.

![Square App Dashboard](/media/screenshots/square/view_app_dashboard.png)

From the app dashboard, click the **Credentials** heading in the sidebar and note down your application ID's and access tokens for both your live and sandbox environments.

![Square Credentials](/media/screenshots/square/app_credentials.png)

## Webhook 

In order for Square to notify Vendr of a successful transactions, Square makes use of webhook technology to directly send notifications of the changing statuses of a transaction. By using webhooks it ensures that the system will always be notified of these status changes, even if the customer decides not to return to the store once a transaction is complete.

To register a webhook, in the sidebar of the app dashboard, click the **Webhooks** heading and then the **Add Webhook** button. In the dialog that is displayed, give your webhook a name and enter the Vendr callback URL as follows (replacing the parameters in curly brackets with the corresponding values taken from your store):

````bash
https://{store_domain}/umbraco/vendr/payment/callback/square-checkout-onetime/{payment_method_id}/
````

![Square Webhook](/media/screenshots/square/add_webhook.png)

From the **Event** list select the following event types:

* `payment.updated`

Click **Save** button at bottom in overlay to register the details for the webhook.

With the webhook created, click the view the details of the webhook in the webhooks list and click the **Show** link next to the **SIGNATURE KEY** to view the webhooks signing secret. Note this down along with the API credentials from earlier as you'll need these in the [Configuring Umbraco](../configuring-umbraco/) section.

![Square Webhook Signing Key](/media/screenshots/square/webhook_signing_key.png)