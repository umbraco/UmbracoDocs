# Health check: Cross-site scripting Protection (X-XSS-Protection header)

_This header is non-standard and should therefore not be used_

Fore more information about the X-XSS-Protection header, and why it shouldn't be used, see [MDN web docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection).

## How to fix this health check

This health check can be fixed by ensuring that no middleware adds the header.
