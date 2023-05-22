---
title: Configuring DIBS
description: >-
  Learn how to configure DIBS in order to implement the integration with your
  Umbraco Vendr installation.
---

# Configure DIBS

This article contains detailed steps on how to configure your DIBS D2 account. This needs to be done before you can start using the payment provider with your Umbraco Vendr implementation.

## Step 1: Sign up & Sign in

The very first step is to register for a DIBS D2 account. This can be done on [tech.dibspayment.com/D2](tech.dibspayment.com/D2/).

Do you already have an account, you can head over to [payment.architrade.com/login/login.action](https://payment.architrade.com/login/login.action) to **sign in**.

![The DIBS login page.](../media/dibs/d2/dibs-d2\_signin.png)

## Step 2: Control MD5 keys

The following steps assume that you are signed in to your DIBS account.

1. Click **Integration -> MD5 Keys** in the menu to the left.
2. Check the Perform MD5 control checkbox.
3. Click Update.

![Overview DIBS D2 MD5 keys on the DIBS platform.](../media/dibs/d2/dibs-d2\_md5-keys.png)

## Step 3: Return values

1. Click on the **Integration -> Return values** menu item.
2. Check the following items:
   * _Order ID_
   * _Paytype_
   * _Card number with last four digits unmasked_
   * _All fields exclusive of card information response._

![Overview of the DIBS D2 Return values on the DIBS platform.](../media/dibs/d2/dibs-d2\_return-values.png)

### Step 4: Create an API user

1. Click **Setup -> User Setup -> API users**.
2. Create a new API user.

![The dialog for creating a new API User on the DIBS platform.](../media/dibs/d2/dibs-d2\_api-user.png)
