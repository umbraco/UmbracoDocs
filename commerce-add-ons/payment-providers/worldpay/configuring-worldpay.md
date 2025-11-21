---
description: >-
  Learn how to configure Worldpay in order to implement the integration with
  your Umbraco Commerce installation.
---

# Configure Worldpay

## Step 1: Register with Worldpay

1. Go to [Worldpay Documentation](https://docs.worldpay.com/apis/bg350) and follow the registration instructions.

2. Obtain your **Installation ID** following the documentation.

## Step 2: Enable Payment Responses

1. Follow the [Enable Payment Responses Documentation](https://docs.worldpay.com/apis/bg350/enablepaymentresponses) to enable Payment Responses.
2. Configure the response URL as follows:

```bash
  https://{store_domain}/umbraco/commerce/payment/callback/worldpay-bs350/{payment_method_id}/
```

## Step 3: Enable Enhanced Security

1. Follow the [Enhancing Security with MD5 Documentation](https://docs.worldpay.com/apis/bg350/enhancing-security-with-md5) to configure advanced security.

2. When setting up Enhanced Security, you will be asked to configure an **MD5 secret**. Remember it for later.
