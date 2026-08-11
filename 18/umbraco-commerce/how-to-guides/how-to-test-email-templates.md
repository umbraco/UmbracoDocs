---
description: Learn how to test your email templates.
---

# Test Your Email templates

Want to see how your email templates look before sending them to the real customers? Umbraco Commerce 16.2.0 supports testing your email templates.

{% hint style="info" %}
As of now, only templates under the **Cart**, **Order**, **Gift Card**, and **Discount** categories can be tested using the steps below.
{% endhint %}

## Steps

1. Go to _Umbraco Backoffice_ > _Settings_.
2. Select a store name.
3. Navigate to the _Email Templates_ section.
4. Open the template you want to test.

![Email Template Details screen in Umbraco backoffice](../.gitbook/assets/0.email-template-details.png)

5. Click the _Send Test Email_ button.
6. Fill in the fields in the modal, and **make sure that the recipient is a test email address**.

![The "Send Test Email" modal](../.gitbook/assets/1.send-test-email-modal.png)

![Order entity picker in the "Send test email" modal](../.gitbook/assets/2.order-entity-picker.png)

7. Click the _Send_ button.

An email with the information you provided will be sent to the test email address shortly.
