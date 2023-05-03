---
title: Configuring Mollie
description: Documentation for the Mollie (One Time) payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

## Sign up & Sign in

If you haven't done so yet, head on over to [mollie.com/signup](https://mollie.com/signup) to register for a Mollie account.

![Mollie sign up](/media/screenshots/mollie/mollie_signup.png)

Or, if you already have an account, you can head over to [https://www.mollie.com/dashboard/login](https://www.mollie.com/dashboard/login) to sign in to your account.

![Mollie sign in](/media/screenshots/mollie/mollie_signin.png)

## API Keys

In order for Vendr to communicate with Mollie securely we will need to retrieve a series of API keys that Vendr can use to authenticate with.

In the sidebar, click the **Developers** heading and then the **API keys** sub heading. On the right hand side you will find your **Live API key** and your **Test API key** displayed. Note these down as we will need to enter them into the Vendr UI shortly.

![Mollie API keys](/media/screenshots/mollie/mollie_api_keys.png)

## Payment Methods

Before you can accept any payments in Mollie, you'll need to setup at least one payment method. 

In the sidebar, click the **Settings** heading and then the **Website profiles** sub heading. On the right hand side you will find your sites profile displayed. 

![Mollie website profiles](/media/screenshots/mollie/mollie_website_profiles.png)

In the site profile panel, click the **Payment methods** row to display the various payment methods you can enable. In the list displayed, make sure at least on of them is enabled (please note, enabling a payment method may require additional details to be entered).

![Mollie payment methods](/media/screenshots/mollie/mollie_payment_methods.png)

## Test & Live Mode

When viewing your orders in the Mollie dashboard, you can switch between test and live mode via the **Test mode** toggle switch in the top right hand corner of the orders view accessed via the **Orders** heading in the sidebar.

![Mollie test mode](/media/screenshots/mollie/mollie_test_mode.png)