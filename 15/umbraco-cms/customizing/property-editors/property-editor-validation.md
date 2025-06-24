---
description: >-
  Property validation can be handled in three ways. The recommended approach is
  to implement both client-side and server-side validation.
---

# Property Editor Validation

### Server-Side Validation

Server-side validation is a must, as it is the only method that can guarantee the validity of stored values when publishing.

[Read more about adding server-side validation here](../../tutorials/creating-a-property-editor/adding-server-side-validation.md).

### Client-Side Form Control Validation

Client-side form control validation is the native approach to validating input in the browser. However, it only works if the property editor is visible or has been interacted with during the session.

To implement this, read the article about the [Form Control Mixin here](../foundation/validation/form-control-mixin.md).

### Implement Workspace Validation

The client-side validation system also supports validation that goes beyond a single form control.

This allows you to create validations based on multiple factors or implement more advanced rules than a specific property editor can provide.

To learn more, see the  `custom-validation-workspace-context` example located in the code Repository [here](https://github.com/umbraco/Umbraco-CMS/tree/v16/dev/src/Umbraco.Web.UI.Client/examples/custom-validation-workspace-context).
