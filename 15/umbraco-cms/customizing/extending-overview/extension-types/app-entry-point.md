---
description: The App Entry Point extension type is used to run some JavaScript code before the user is logged in.
---

# App Entry Point

This manifest declares a single JavaScript file that will be loaded and run when the Backoffice starts. Additionally, the code will also run on the login screen.

It performs the same function as the `backofficeEntryPoint` extension type, but the difference is that this runs before the user is logged in. Use this to initiate things before the user is logged in or to provide things for the Login screen.

Read more about `backofficeEntryPoint` to learn how to use it:

{% content-ref url="./backoffice-entry-point.md" %} . {% endcontent-ref %}
