---
description: >-
  Learn how to configure QuickPay in order to implement the integration with
  your Umbraco Commerce installation.
---

# Configure QuickPay

## Sign up & Sign in

If you haven't done so yet, head over to the [QuickPay portal](https://manage.quickpay.net/create-user) to register for a QuickPay account.

![QuickPay Signup](../media/quickpay/quickpay\_signup.png)

Or [login to the QuickPay portal](https://manage.quickpay.net/) if you already have an account.

![The login form to the QuickPay portal.](../media/quickpay/quickpay\_signin.png)

## Step 2: API Keys

In order for Umbraco Commerce to communicate with QuickPay securely we need to retrieve a series of API keys used for authentication.

The keys can be found under **Settings > Integration** in the QuickPay portal.

You will need the following keys:

- Private key
- Api key of the API user
- Merchant id
- Agreement id

![QuickPay Integration Keys](../media/quickpay/quickpay\_portal.png)

## Step 3: Webhook

In order for QuickPay to notify Umbraco Commerce of a successful transaction, QuickPay makes use of webhook technology. This enables sending notifications of changing transaction statuses directly between the two platforms.

Webhooks ensure that Umbraco Commerce will always be notified of status changes, even if the customer decides not to return to the store.

Registration of webhook notifications is handled as part of the payment request using the Umbraco Commerce callback URL.

The following is an example of such a callback URL:

```
https://{store_domain}/umbraco/commerce/payment/callback/quickpay-checkout/{payment_method_id}/
```

When using this, be sure to replace the parameters in the curly brackets with the corresponding values taken from your store.
