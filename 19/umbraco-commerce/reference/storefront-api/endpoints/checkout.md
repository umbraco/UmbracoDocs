# Checkout

The checkout endpoints provide ways of performing a checkout process against an Order. The Storefront API supports two ways of checking out an order, one using hosted checkout pages, and a more advanced option for inline payment processing.

## Hosted

With the hosted checkout flow it is required that before redirecting to the payment gateway a checkout token should be generated. This token is passed to the pay endpoint to ensure that only the given order can be processed in response to the checkout request. The pay endpoint should be launched in a WebView/iframe with this token which will redirect to the given Orders payment gateway for payment capture. To determine the outcome of the payment developers should monitor the WebView/iframes URL. They will be redirected to the same pay endpoint URL with either a `/completed`, `/canceled` or `/errored` suffix.

{% openapi src="/broken/files/78gbCIN61lMlplqhVvdQ" path="/umbraco/commerce/storefront/api/v1/checkout/{orderId}/token" method="get" %}
[Broken link](/broken/files/78gbCIN61lMlplqhVvdQ)
{% endopenapi %}

{% openapi src="/broken/files/78gbCIN61lMlplqhVvdQ" path="/umbraco/commerce/storefront/api/v1/checkout/{orderId}/pay/{token}" method="get" %}
[Broken link](/broken/files/78gbCIN61lMlplqhVvdQ)
{% endopenapi %}

## Inline

With the inline checkout flow, it is left to the implementing developer to perform payment capture. Before a capture can begin, the order should be initialized using the `initialize` endpoint which prepares the Order for capture. The `initialize` endpoint will return the settings of the Orders selected payment method, along with details of expected metadata needed by the payment provider. Developers can use this data to perform an inline capture and call the `confirm` endpoint when the capture is successful, passing back any metadata captured.

{% openapi src="/broken/files/78gbCIN61lMlplqhVvdQ" path="/umbraco/commerce/storefront/api/v1/checkout/{orderId}/initialize" method="get" %}
[Broken link](/broken/files/78gbCIN61lMlplqhVvdQ)
{% endopenapi %}

{% openapi src="/broken/files/78gbCIN61lMlplqhVvdQ" path="/umbraco/commerce/storefront/api/v1/checkout/{orderId}/confirm" method="post" %}
[Broken link](/broken/files/78gbCIN61lMlplqhVvdQ)
{% endopenapi %}
