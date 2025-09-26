---
description: Describes how to use sign information provided in management API responses to present additional details to consumers.
---

# BackOffice Signs

When trees, collections and items are presented in the backoffice, additional information can be displayed in the form of Signs. Which Signs to present will be determined by the Sign Manifest.

A Sign can utilize conditions in the same way as other Extensions or it can be bound to a Flag coming from the Management API.

For example, a Document scheduled for future publishing will have a Flag defined as part of trees, collections and item response:

```json
  "flags": [
    {
      "alias": "Umb.ScheduledForPublish"
    }
  ],
```

The server determines which signs are present in the response via the registered collection of [flag providers](../extending/flag-providers.md). A client-side extension point determines how each sign is displayed in the backoffice.

## Displaying a Sign

TBC