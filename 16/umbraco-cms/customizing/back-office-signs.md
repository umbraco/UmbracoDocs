---
description: Describes how to use sign information provided in management API responses to present additional details to consumers.
---

# BackOffice Signs

When trees, collections and items are presented in the backoffice, additional information can be displayed in the form of signs. Which signs to present will be determined by the management API response, that will be populated with a collection of `signs`.

For example, a document scheduled for future publishing will have the following as part of the trees, collections and item response:

```json
  "signs": [
    {
      "alias": "Umb.ScheduledForPublish"
    }
  ],
```

The server determines which signs are present in the response via the registered collection of [flag providers](../extending/flag-providers.md). A client-side extension point determines how each sign is displayed in the backoffice.

## Displaying a Sign

TBC