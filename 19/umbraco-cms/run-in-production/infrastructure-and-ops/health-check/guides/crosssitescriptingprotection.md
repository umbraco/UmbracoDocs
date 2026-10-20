# Health check: Cross-site scripting Protection (X-XSS-Protection header)

{% hint style="warning" %}
This header is non-standard and should not be used. Instead, it is recommended to use a [Content Security Policy (CSP)](./contentsecuritypolicy.md) header.

For more information about the X-XSS-Protection header, and why it should not be used, see [MDN web docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection).
{% endhint %}

## How to fix this health check

This health check can be fixed by ensuring no middleware adds the header.
