---
title: How to block payments from non billing country sources
description: Documentation for the Stripe Checkout payment provider for Vendr, the eCommerce solution for Umbraco v8+
---

Out of the box, Stripe already implements a lot of security features for you, making payments safe and secure by default, however you may have a need to provide additional security steps of your own. 

One such example, especially if you are based in the EU selling digital goods, would be the requirement to capture two forms of proof of a customers location for VAT purposes. One recommended way of doing this is to capture the customers billing country, and bank country, and ensure these are both the same. Thankfully, the Stripe payment provider is setup to make this straight forward to setup.

## Step 1 - Capture the customers billing country

The first step will be to ensure you are capturing the customers billing address or more specifically, the billing address country. We will assume you have already learnt to do this based on the core Vendr documentation.

## Step 2 - Pass the billing country to Stripe

Thankfully there is nothing for you to do in this step. As long as you have populated your orders billing country, then the Stripe payment provider will automatically send the country to Stripe using custom meta data on the transactions customer entity. The only important thing to know here is that this will be passed via a meta data entry on the Stripe customer with the key `billingCountry`, with the value of the two letter ISO code of the given country.

## Step 3 - Sign up for Radar for Fraud Teams

In order to configure custom Radar rules you will need to sign up for the [Radar for Fraud Teams](https://stripe.com/gb/radar/fraud-teams) added feature. This does incur an additional fee per transaction, however the added security should far out way the minimal expense.

To enable **Radar for Fraud Teams**, log into your Stripe dashboard, and navigate to the **Settings > Product Settings > Radar Settings** section.

![Stripe Product Settings](../../media/stripe/stripe_product_settings.png)

From there you can enable the feature, allowing us to define custom Radar rules.

![Stripe Radar for Fraud Teams Setting](../../media/stripe/stripe_radar_for_fraud_teams.png)

## Step 4 - Setup a Stripe Radar rule

With the **Radar for Fraud Teams** feature enabled, navigate to the **Radar > Rules** section and in the **Then, when should a payment be blocked?** panel, click the **Add rule** button to add a new rule.

In the dialog that is displayed, enter the following rule:

```
Block if ::customer:billingCountry:: != :card_country:
```

![Stripe Radar for Fraud Teams Setting](../../media/stripe/stripe_block_country_rule2.png)

Finally, click the **Test rule** button to test the rule and then the **Add and enable** button add the rule to the list of block rules.

![Stripe Radar blocking rules](../../media/stripe/stripe_block_rules2.png)

{% hint style="info" %}
The rule test may fail when you click the **Test rule** button due to there being no transaction with the given meta data being attached to them, however you should be able to continue regardless.
{% endhint %}