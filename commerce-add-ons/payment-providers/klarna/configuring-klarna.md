---
description: >-
  Learn how to configure Klarna in order to implement the integration with your
  Umbraco Commerce installation.
---

# Configure Klarna

## Step 1: Sign up & Sign in

When working with Klarna, you'll need to sign up for a live and a developer account.

### Sign up for a live account

1. Open the [Klarna site](https://www.klarna.com/).
2. Navigate to the **Klarna for Business** section.
3. Sign up as a **Seller**.

![The interface when signing up for a Klarna live account.](../media/klarna/get\_started.png)

### Sign up for a developer account

1. Open the [Klarna developer portal](https://developers.klarna.com/documentation/testing-environment/).
2. Select your region to request a developer account.

![The interface when signing up for a Klarna developer account.](../media/klarna/developer\_signup.png)

{% hint style="info" %}
Both sign-up processes can take a while. Be sure to sign up well in advance of going live.
{% endhint %}

### Get your credentials

1. Sign in to the two platforms mentioned below
   * **Live** - [https://auth.eu.portal.klarna.com/](https://portal.klarna.com/?utm\_source=klarnacom\&utm\_campaign=/uk/business/merchant-support/login-merchant-portal/\&utm\_medium=referral\&utm\_content=klarnacom-link)
   * **Developer** - [https://playground.eu.portal.klarna.com/](https://playground.eu.portal.klarna.com/)
2. Continue following the steps in this article, for each portal.

![The Klarna Login screen.](../media/klarna/sign\_in.png)

## API Credentials

Once you are signed in to the Klarna portal(s), follow the steps below to get your API Credentials.

1. Click the **Settings** option at the bottom of the menu on the left-hand side.
2. Select the **Klarna API Credentials** heading.

![Overview of the Klarna developer portal.](../media/klarna/developer\_portal.png)

3. Select **Generate new Klarna API Credentials.**
4. Click **Create Credentials** in the dialog that follows.

You'll be presented with a username and password that you'll need to note down for later use.

![The dialog where you create your Klarna API credentials.](../media/klarna/generate\_credentials.png)

![The dialog that presents your Klarna credentials.](../media/klarna/credentials.png)

## Viewing / Managing Orders

When you start taking orders, you'll be able to view and manage your Klarna orders directly from the portal.

* Navigate to the **Orders** section linked to from the menu on the left-hand side.

![Overview of Klarna orders.](../media/klarna/orders.png)

![Overview over how an order looks like in the Klarna portal.](../media/klarna/order.png)
