# Storefront API Checkout Endpoints

The checkout endpoints provide ways of performing a checkout process against an Order. The Storefront API supports two ways of checking out an order, one using hosted checkout pages, and a more advanced option for inline payment processing.

## Hosted

With the hosted checkout flow it is required that before redirecting to the payment gateway a checkout token should be generated. This token is passed to the pay endpoint to ensure that only the given order can be processed in response to the checkout request. The pay endpoint should then be launched in a WebView with this token which will then redirect to the given Orders payment gateway for payment capture. To determine the outcome of the payment developers should monitor the WebViews URL which will be redirected to the same pay endpoint URL with either a `/completed`, `/canceled` or `/errored` suffix.

{% swagger src=".gitbook/assets/storefront_swagger.json" path="/umbraco/commerce/storefront/api/v1/checkout/{orderId}/token" method="get" %}
[storefront_swagger.json](.gitbook/assets/storefront_swagger.json)
{% endswagger %}

{% swagger src=".gitbook/assets/storefront_swagger.json" path="/umbraco/commerce/storefront/api/v1/checkout/{orderId}/pay/{token}" method="get" %}
[storefront_swagger.json](.gitbook/assets/storefront_swagger.json)
{% endswagger %}

## Inline

With the inline checkout flow it is left to the implementing developer to perform payment capture. Before a capture can begine, the order should be initialized using the `initialize` endpoint which prepare the Order for capture. To aid developers, the `initialize` endpoint will return the settings of the given Orders selected payment method, along with details of any expected meta data needed by the payment provider. Developers can then use this data to perform an inline capture opperation and then call the `confirm` endpoint when the capture is successull, passing back any meta data captured.

{% swagger src=".gitbook/assets/storefront_swagger.json" path="/umbraco/commerce/storefront/api/v1/checkout/{orderId}/initialize" method="get" %}
[storefront_swagger.json](.gitbook/assets/storefront_swagger.json)
{% endswagger %}

{% swagger src=".gitbook/assets/storefront_swagger.json" path="/umbraco/commerce/storefront/api/v1/checkout/{orderId}/confirm" method="post" %}
[storefront_swagger.json](.gitbook/assets/storefront_swagger.json)
{% endswagger %}