# Checkout Flow

Current section showcases the process of setting up a checkout flow for your store using the package `Umbraco.Commerce.Checkout`. You can read more about this in [this](https://docs.umbraco.com/umbraco-commerce-packages/checkout/installation) section of the official documentation.

You can of course implement your own custom checkout flow, for this direction [`Umbraco Commerce DemoStore`](https://github.com/umbraco/Umbraco.Commerce.DemoStore) can be the perfect starting point.

Upon installation, a new workspace called `Umbraco Commerce Checkout` will be available in the `Settings` section.

![checkout-workspace](../images/checkout/checkout-workspace.png)

Once you have specified the root node for the checkout pages to be installed, you will get a confirmation message,

![checkout-installation](../images/checkout/checkout-installation.png)

then the checkout pages will be added to your shop:

![checkout-pages](../images/checkout/checkout-pages.png)

Once the checkout page properties have been set to your requirements, we can publish it with its descendants.

![checkout-page-properties](../images/checkout/checkout-page-properties.png)

Each of the six checkout steps comes with two settings, one for adding a short name and the other to specify the type.

![checkout-steps](../images/checkout/checkout-steps.png)


## Proceeding to Checkout

On the cart page, when selecting to proceed to checkout, you will be redirected to the checkout wizard.

![proceed-to-checkout](../images/checkout/proceed-to-checkout.png)

Here are the steps that you'll need to cover:

* Customer Information

Fill out customer details, billing and shipping addresses.

![customer-information](../images/checkout/customer-information.png)

* Shipping Method

Select a shipping method.

![shipping-method](../images/checkout/shipping-method.png)

* Payment Method

Select a payment method.

![payment-method](../images/checkout/payment-method.png)

* Review Order Details

![review-order-details](../images/checkout/review-order-details.png)

* Payment

During this step, you might encounter an error like this

``Value cannot be null. (Parameter 'context.Settings.ContinueUrl')``

The message is self explanatory, translating into a missing value for the `Continue Url` on the selected payment method.

To address this, go ahead and copy the URL to the checkout order confirmation page and paste it in the `Continue URL` field of the payment method.

![continue-url](../images/checkout/continue-url.png)

* Confirmation

![order-confirmation](../images/checkout/order-confirmation.png)

The order will then be saved and available in the Backoffice:

![order-details-backoffice](../images/checkout/order-details-backoffice.png)

You can change the status, send an email confirmation, edit customer details or add notes to the order.
