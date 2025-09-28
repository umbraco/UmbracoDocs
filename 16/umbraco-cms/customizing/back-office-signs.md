---
description: Describes how to use sign information provided in management API responses to present additional details to consumers.
---

# BackOffice Signs

When trees, collections and items are presented in the backoffice, additional information can be displayed in the form of Signs.

A Backoffice sign is a client-side extension point that determines how each sign is displayed in the backoffice.

A Sign can utilize conditions in the same way as other Extensions or it can be bound to a Flag coming from the Management API.

For example, a Document scheduled for future publishing will have a Flag defined as part of trees, collections and item response:

```json
  "flags": [
    {
      "alias": "Umb.ScheduledForPublish"
    }
  ],
```

A Flag can be the determinant for a Sign by declaring the `forEntityFlags` as part of its Manifest.

Example:
```json
...
forEntityFlags: "Umb.ScheduledForPublish",
...
```

Using this binding lets the server determine which signs are present in the response via the registered collection of [flag providers](../extending/flag-providers.md).

## Displaying a Sign

TBC
