---
description: >-
  Detailed steps on how to migrate the Checkout package from Vendr to Umbraco
  Commerce.
---

# Migrate Umbraco Commerce Checkout

Throughout the following steps, we will migrate the Checkout package from Vendr to Umbraco Commerce.

1. Make a backup of any custom templates and Vendr UI configuration files.
2. Make a note of all configuration values on the Vendr.Checkout Checkout node.
3. Delete Vendr.Checkout generated checkout nodes.
   * Checkout
     * Customer Information
     * Shipping Method
     * Payment Method
     * Review Order
     * Process Payment
     * Order Confirmation
4. Delete all Vendr.Checkout generated Document Types.
   * \[Vendr Checkout] Page
     * \[Vendr Checkout] Checkout Page
     * \[Vendr Checkout] Checkout Step Page
5. Delete all Vendr.Checkout generated Data Types.
   * \[Vendr Checkout] Step Picker
   * \[Vendr Checkout] Theme Color Picker
6. Uninstall the Vendr.Checkout Nuget package:

```bash
dotnet remove package Vendr.Checkout
```

7. Delete any remaining files and folders in the `~/App_Plugins/VendrCheckout` directory.
8. Install the Umbraco.Commerce.Checkout package:

```bash
dotnet add package Umbraco.Commerce.Checkout
```

9. Locate the Umbraco Commerce Checkout dashboard in the Settings section
10. Click the "Install" button to reinstall the Checkout components in the previous location.
11. Copy any custom configuration files back into the solution.
12. Copy any custom Views into the `~/Views/UmbracoCommerceCheckout/` folder.
