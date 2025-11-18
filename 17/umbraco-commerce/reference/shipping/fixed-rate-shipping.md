---
description: Fixed Rate Shipping in Umbraco Commerce.
---

# Fixed Rate Shipping

Fixed rate shipping in Umbraco Commerce allows you to define a single, fixed shipping rate to apply to an order. This is the simplest of all the shipping calculation options, but is also the least flexible.

## Configuration

1. Go to **Settings** > **Stores** > {Your Store} > **Shipping Methods**.

    ![Shipping Methods](../../media/v14/shipping-methods-list-view.png)

2. Click **Create Shipping Method**.
3. Choose **Basic** as the shipping provider.

    ![Choose Shipping Provider](../../media/v14/shipping-provider-modal.png)

4. Choose **Fixed** as the calculation mode option.

    ![Choose Shipping Calculation Mode](../../media/v14/shipping-provider-config-modal.png)

5. Enter the **Shipping Method Name**, **Alias**, **SKU**, and optional **Tax Rate**.
6. Enter a fixed rate for the shipping method.

    ![Shipping Method Details](../../media/v14/shipping-method-fixed-rate-general-settings.png)

7. Select the countries this shipping method should be allowed in.

    ![Shipping Method Allowed Countries](../../media/v14/shipping-method-fixed-rate-countries.png)

8. Optionally, define a country's specific fixed rate should you wish to have different rates per country.

    ![Shipping Method Country Specific Rates](../../media/v14/shipping-method-fixed-rate-country-prices.png)
9. Click **Save**.
