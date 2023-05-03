---
title: Configuring Stripe
description: Documentation for the Stripe Checkout payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Sign up & Sign in

If you haven't done so yet, head on over to [dashboard.stripe.com/register](https://dashboard.stripe.com/register) to register for a Stripe account.

![Stripe sign up](../media/stripe/stripe_signup.png)

Or, if you already have an account, you can head over to [dashboard.stripe.com/login](https://dashboard.stripe.com/login) to sign in to your account.


![Stripe sign in](../media/stripe/stripe_signin.png)

## Test & Live mode

When you are logged into the Stripe dashboard it is important to know that there are two modes you can view data / perform tasks under. These are **Test** mode and **Live** mode. As you might imagine, test mode allows you to perform test transactions to ensure your solution is setup correctly, and live mode is where real life transactions will take place.

To switch between test and live mode you use the **View test data** toggle switch located in the dashboard sidebar. When in test mode the toggle switch will change colour, and you will see a **test data** header bar appear above the data panel on the right hand side.

![Stripe Test Mode](../media/stripe/stripe_test_mode.png)

For each of these modes we will need to configure multiple settings as documented below.

## API Keys

In order for Vendr to communicate with Stripe securely we will need to generate a series of API keys that Vendr can use to authenticate with.

In the sidebar, click the **Developers** heading and then the **API keys** sub heading. On the right hand side you will find your **Publishable key** displayed. To view your **Secret key**, click the **Reveal test/live key token** button.

![Stripe API Keys](../media/stripe/stripe_api_keys.png)

You'll need to generate API keys for both test and live modes, so be sure to run through this process twice, once with test mode enabled, and once with live mode enabled. 

Once you have both sets of API keys, be sure to note them down as we will need to enter them into the Vendr UI shortly.

## Webhook 

In order for Stripe to notify Vendr of a successful transaction, Stripe makes use of webhook technology to directly send notifications of the changing statuses of a transaction. By using webhooks it ensures that the system will always be notified of these status changes, even if the customer decides not to return to the store once a transaction is complete.

To register a webhook, in the sidebar, click the **Developers** heading and then the **Webhooks** sub heading. On the right hand side, click the **Add Endpoint** button and enter the Vendr callback URL as follows (replacing the parameters in curly brackets with the corresponding values taken from your store):

````
https://{store_domain}/umbraco/vendr/payment/callback/stripe-checkout/{payment_method_id}/
````

![Stripe Webhook](../media/stripe/stripe_webhook.png)

From the **Version** dropdown you can leave this set as **Your current version** and then in the **Events to send** dropdown select the following event types:

* `checkout.session.completed`
* `review.closed`

Click **Add endpoint** to create the webhook endpoint registration and you should now be sent to the webhook details screen.

![Stripe Webhook Details](../media/stripe/stripe_webhook_details2.png)

Finally, from this screen, locate the **Signing secret** section and click the **Click to reveal** button to display the webhook signing secret. Be sure to take note of this as we will need this later so that we can validate webhook requests.

![Stripe Webhook Signing Secret](../media/stripe/stripe_webhook_signing_secret.png)

As per the API keys, be sure to perform this task twice, once for test mode, and once for live mode, keeping note of the different signing secret keys.