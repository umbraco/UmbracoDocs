---
description: Learn how to migrate a Vendr solution to Umbraco Commerce.
---

# Migrate a Vendr solution to Umbraco Commerce

This guides provides a step-by-step approach to migrating a default Vendr solution to Umbraco Commerce.

## Key changes

Before outlining the exact steps, there are a few key changes to be aware of.

These changes will dictate the steps to take in the process of migrating to Umbraco Commerce.

### Project, Package, and Namespace changes

| Vendr | Umbraco Commerce |
| ----- | ---------------- |
| Vendr.Common | Umbraco.Commerce.Common |
| Vendr.Core | Umbraco.Commerce.Core |
| Vendr.Infrastructure | Umbraco.Commerce.Infrastructure |
| Vendr.Persistence | Umbraco.Commerce.Persistence |
| Vendr.Persistence.Sqlite | Umbraco.Commerce.Persistence.Sqlite |
| Vendr.Persistence.SqlServer | Umbraco.Commerce.Persistence.SqlServer |
| Vendr.Umbraco | Umbraco.Commerce.Cms |
| Vendr.Umbraco.Web | Umbraco.Commerce.Cms.Web |
| Vendr.Web | Umbraco.Commerce.Web |
| Vendr.Web.UI | Umbraco.Commerce.Web.StaticAssets |
| Vendr.Umbraco.Startup | Umbraco.Commerce.Startup |
| Vendr | Umbraco.Commerce |

### C# Class changes

* Namespace changes as documented above.
* All classes containing the `Vendr` keyword are now updated to `UmbracoCommerce`.
  * Examples: `IVendrApi` is now `IUmbracoCommerceApi` and `AddVendr()` is now `AddUmbracoCommerce()`.

### JavaScript changes

* All `vendr` modules have changed to `umbraco.commerce` modules.
* All `vendr` prefixed directives, services and resources are new prefixed with `uc`.
* All `vendr` prefixed events now follow this format: `Umbraco.Commerce.{target}.{action}`.

### UI Changes

* All static UI assets are served via a Razor Compiled Library (RCL) and are no longer found in the `App_Plugins` folder.
* The folder within `App_Plugins` still exists for the static assets that are user configurable.
* The folder with `App_Plugins` has been renamed from `Vendr` to `UmbracoCommerce`.
* UI Config files have changed from `.js` files to `.json`.

## Migration steps

### Step 1: Replace dependencies

In this first step, we will be replacing all existing Vendr dependencies with Umbraco Commerce dependencies.

1. Remove any installed Vendr packages (including Payment Providers).

```bash
dotnet remove package Vendr
```

2. Take a backup of any Vendr specific templates and config files you will want to reuse.
3. Delete the Vendr `App_Plugins` folder.

```bash
rmdir App_Plugins\Vendr
```

4. Install `Umbraco.Commerce`.

```bash
dotnet add package Umbraco.Commerce
```

5. Install Umbraco Commerce packages including any payment providers previously removed.
6. Reapply any backed up config files in their new `App_Plugins` location.
7. Move any backed up templates into the `~/Views/UmbracoCommerce/Templates/` folder.
8. Rename any config files with a `.json` file extension rather than the previous `.js` [^1]
9. Compile your project against .NET 7.0.

### Step 2: Update namespaces and entity names

Based on the [Key Changes](#key-changes) outlined above update all Vendr references to the new Umbraco Commerce alternatives. Ensure you update any Views/Partials that also reference these.

## Step 3: Update the database

In this step, we will cover updating the database for Umbraco Commerce.

1. Backup your database
2. Rename database tables using either of the following queries:

THIS WILL BE ADDED TO A TAB ON GITBOOK:
  * Sql Server
    ```sql
    sp_rename vendrCurrency, umbracoCommerceCurrency;
    sp_rename vendrTaxClass, umbracoCommerceTaxClass;
    sp_rename vendrStock, umbracoCommerceStock;
    sp_rename vendrOrderStatus, umbracoCommerceOrderStatus;
    sp_rename vendrEmailTemplate, umbracoCommerceEmailTemplate;
    sp_rename vendrPaymentMethod, umbracoCommercePaymentMethod;
    sp_rename vendrShippingMethod, umbracoCommerceShippingMethod;
    sp_rename vendrCountry, umbracoCommerceCountry;
    sp_rename vendrRegion, umbracoCommerceRegion;
    sp_rename vendrCurrencyAllowedCountry, umbracoCommerceCurrencyAllowedCountry;
    sp_rename vendrPaymentMethodAllowedCountryRegion, umbracoCommercePaymentMethodAllowedCountryRegion;
    sp_rename vendrPaymentMethodCountryRegionPrice, umbracoCommercePaymentMethodCountryRegionPrice;
    sp_rename vendrPaymentMethodPaymentProviderSetting, umbracoCommercePaymentMethodPaymentProviderSetting;
    sp_rename vendrShippingMethodAllowedCountryRegion, umbracoCommerceShippingMethodAllowedCountryRegion;
    sp_rename vendrShippingMethodCountryRegionPrice, umbracoCommerceShippingMethodCountryRegionPrice;
    sp_rename vendrTaxClassCountryRegionTaxRate, umbracoCommerceTaxClassCountryRegionTaxRate;
    sp_rename vendrDiscount, umbracoCommerceDiscount;
    sp_rename vendrDiscountCode, umbracoCommerceDiscountCode;
    sp_rename vendrOrder, umbracoCommerceOrder;
    sp_rename vendrOrderProperty, umbracoCommerceOrderProperty;
    sp_rename vendrOrderLine, umbracoCommerceOrderLine;
    sp_rename vendrOrderLineProperty, umbracoCommerceOrderLineProperty;
    sp_rename vendrGiftCard, umbracoCommerceGiftCard;
    sp_rename vendrOrderAppliedDiscountCode, umbracoCommerceOrderAppliedDiscountCode;
    sp_rename vendrOrderAppliedGiftCard, umbracoCommerceOrderAppliedGiftCard;
    sp_rename vendrStoreAllowedUserRole, umbracoCommerceStoreAllowedUserRole;
    sp_rename vendrStoreAllowedUser, umbracoCommerceStoreAllowedUser;
    sp_rename vendrFrozenPrice, umbracoCommerceFrozenPrice;
    sp_rename vendrGiftCardProperty, umbracoCommerceGiftCardProperty;
    sp_rename vendrActivityLog, umbracoCommerceActivityLog;
    sp_rename vendrOrderPriceAdjustment, umbracoCommerceOrderPriceAdjustment;
    sp_rename vendrOrderAmountAdjustment, umbracoCommerceOrderAmountAdjustment;
    sp_rename vendrProductAttribute, umbracoCommerceProductAttribute;
    sp_rename vendrProductAttributeValue, umbracoCommerceProductAttributeValue;
    sp_rename vendrTranslatedValue, umbracoCommerceTranslatedValue;
    sp_rename vendrProductAttributePreset, umbracoCommerceProductAttributePreset;
    sp_rename vendrProductAttributePresetAllowedAttribute, umbracoCommerceProductAttributePresetAllowedAttribute;
    sp_rename vendrOrderLineAttribute, umbracoCommerceOrderLineAttribute;
    sp_rename vendrPrintTemplate, umbracoCommercePrintTemplate;
    sp_rename vendrExportTemplate, umbracoCommerceExportTemplate;
    sp_rename vendrStoreEntityTag, umbracoCommerceStoreEntityTag;
    sp_rename vendrMigrations, umbracoCommerceMigrations;
    sp_rename vendrStore, umbracoCommerceStore;
    ```
  * SQLite
    ```sql
    ALTER TABLE vendrCurrency RENAME TO umbracoCommerceCurrency;
    ALTER TABLE vendrTaxClass RENAME TO umbracoCommerceTaxClass;
    ALTER TABLE vendrStock RENAME TO umbracoCommerceStock;
    ALTER TABLE vendrOrderStatus RENAME TO umbracoCommerceOrderStatus;
    ALTER TABLE vendrEmailTemplate RENAME TO umbracoCommerceEmailTemplate;
    ALTER TABLE vendrPaymentMethod RENAME TO umbracoCommercePaymentMethod;
    ALTER TABLE vendrShippingMethod RENAME TO umbracoCommerceShippingMethod;
    ALTER TABLE vendrCountry RENAME TO umbracoCommerceCountry;
    ALTER TABLE vendrRegion RENAME TO umbracoCommerceRegion;
    ALTER TABLE vendrCurrencyAllowedCountry RENAME TO umbracoCommerceCurrencyAllowedCountry;
    ALTER TABLE vendrPaymentMethodAllowedCountryRegion RENAME TO umbracoCommercePaymentMethodAllowedCountryRegion;
    ALTER TABLE vendrPaymentMethodCountryRegionPrice RENAME TO umbracoCommercePaymentMethodCountryRegionPrice;
    ALTER TABLE vendrPaymentMethodPaymentProviderSetting RENAME TO umbracoCommercePaymentMethodPaymentProviderSetting;
    ALTER TABLE vendrShippingMethodAllowedCountryRegion RENAME TO umbracoCommerceShippingMethodAllowedCountryRegion;
    ALTER TABLE vendrShippingMethodCountryRegionPrice RENAME TO umbracoCommerceShippingMethodCountryRegionPrice;
    ALTER TABLE vendrTaxClassCountryRegionTaxRate RENAME TO umbracoCommerceTaxClassCountryRegionTaxRate;
    ALTER TABLE vendrDiscount RENAME TO umbracoCommerceDiscount;
    ALTER TABLE vendrDiscountCode RENAME TO umbracoCommerceDiscountCode;
    ALTER TABLE vendrOrder RENAME TO umbracoCommerceOrder;
    ALTER TABLE vendrOrderProperty RENAME TO umbracoCommerceOrderProperty;
    ALTER TABLE vendrOrderLine RENAME TO umbracoCommerceOrderLine;
    ALTER TABLE vendrOrderLineProperty RENAME TO umbracoCommerceOrderLineProperty;
    ALTER TABLE vendrGiftCard RENAME TO umbracoCommerceGiftCard;
    ALTER TABLE vendrOrderAppliedDiscountCode RENAME TO umbracoCommerceOrderAppliedDiscountCode;
    ALTER TABLE vendrOrderAppliedGiftCard RENAME TO umbracoCommerceOrderAppliedGiftCard;
    ALTER TABLE vendrStoreAllowedUserRole RENAME TO umbracoCommerceStoreAllowedUserRole;
    ALTER TABLE vendrStoreAllowedUser RENAME TO umbracoCommerceStoreAllowedUser;
    ALTER TABLE vendrFrozenPrice RENAME TO umbracoCommerceFrozenPrice;
    ALTER TABLE vendrGiftCardProperty RENAME TO umbracoCommerceGiftCardProperty;
    ALTER TABLE vendrActivityLog RENAME TO umbracoCommerceActivityLog;
    ALTER TABLE vendrOrderPriceAdjustment RENAME TO umbracoCommerceOrderPriceAdjustment;
    ALTER TABLE vendrOrderAmountAdjustment RENAME TO umbracoCommerceOrderAmountAdjustment;
    ALTER TABLE vendrProductAttribute RENAME TO umbracoCommerceProductAttribute;
    ALTER TABLE vendrProductAttributeValue RENAME TO umbracoCommerceProductAttributeValue;
    ALTER TABLE vendrTranslatedValue RENAME TO umbracoCommerceTranslatedValue;
    ALTER TABLE vendrProductAttributePreset RENAME TO umbracoCommerceProductAttributePreset;
    ALTER TABLE vendrProductAttributePresetAllowedAttribute RENAME TO umbracoCommerceProductAttributePresetAllowedAttribute;
    ALTER TABLE vendrOrderLineAttribute RENAME TO umbracoCommerceOrderLineAttribute;
    ALTER TABLE vendrPrintTemplate RENAME TO umbracoCommercePrintTemplate;
    ALTER TABLE vendrExportTemplate RENAME TO umbracoCommerceExportTemplate;
    ALTER TABLE vendrStoreEntityTag RENAME TO umbracoCommerceStoreEntityTag;
    ALTER TABLE vendrMigrations RENAME TO umbracoCommerceMigrations;
    ALTER TABLE vendrStore RENAME TO umbracoCommerceStore;
    ```

3. Swap Vendr property editors for Umbraco Commerce property editors:

```sql
UPDATE umbracoDataType
SET propertyEditorAlias = REPLACE(propertyEditorAlias, 'Vendr.', 'Umbraco.Commerce.')
WHERE propertyEditorAlias LIKE 'Vendr.%'
```

4. Swap Vendr variants editor for the Umbraco Commerce variants editor in the block list data entry:

```sql
UPDATE umbracoPropertyData
SET textValue = REPLACE(textValue, 'Vendr.VariantsEditor', 'Umbraco.Commerce.VariantsEditor')
WHERE textValue LIKE '%Vendr.VariantsEditor%';
```

5. Swap Vendr price/amount adjustments to Umbraco Commerce price/amount adjustments:

```sql
UPDATE umbracoCommerceOrderPriceAdjustment
SET type = REPLACE(type, 'Vendr.', 'Umbraco.Commerce.')
WHERE type LIKE '%Vendr.%';
UPDATE umbracoCommerceOrderAmountAdjustment
SET type = REPLACE(type, 'Vendr.', 'Umbraco.Commerce.')
WHERE type LIKE '%Vendr.%';
```

6. Update template paths:

```sql
UPDATE umbracoCommerceEmailTemplate
SET templateView = REPLACE(templateView, '/App_Plugins/Vendr/templates/email', '/Views/UmbracoCommerce/Templates/Email')
WHERE templateView LIKE '%/Vendr/%';
UPDATE umbracoCommercePrintTemplate
SET templateView = REPLACE(templateView, '/App_Plugins/Vendr/templates/print', '/Views/UmbracoCommerce/Templates/Print')
WHERE templateView LIKE '%/Vendr/%';
UPDATE umbracoCommerceExportTemplate
SET templateView = REPLACE(templateView, '/App_Plugins/Vendr/templates/email', '/Views/UmbracoCommerce/Templates/Export')
WHERE templateView LIKE '%/Vendr/%';
```

7. Update the migrations log:

```sql
UPDATE umbracoCommerceMigrations
SET migration = REPLACE(migration, 'Vendr.', 'Umbraco.Commerce.')
WHERE migration LIKE 'Vendr.%';
```

8. Update the activity logs:

```sql
UPDATE umbracoCommerceActivityLog
SET eventType = REPLACE(eventType, 'vendr/', 'commerce/')
WHERE eventType LIKE 'vendr/%';
```

### Step 4: Finalizing the migration

1. Delete any obj/bin folders in your projects to ensure a clean build.
2. Recompile all projects and ensure all dependencies are restored correctly
3. Change license files - TBD
4. Update any payment gateways that uses a global webhook:

```none
https://{site_url}/umbraco/commerce/payment/callback/{payment_provider_alias}/{payment_method_id}/
```

5. Run the project.

Before moving on to migrating the pakcages and payment providers, it is recommended to ensure everything works as expected.

## Migrate Umbraco Commerce Checkout

Throught the following steps we will migrate the Checkout package from Vendr to Umbraco Commerce.

### Step 1: Backup

1. Make a backup of any custom templates and Umbraco Commerce UI configuration files.
2. Make a note of all configuration values on the Vendr.Checkout checkout node.

### Step 2: Uinstall Vendr.Checkout

1. Delete Vendr.Checkout generated checkout nodes.
  * Checkout
    * Customer Information
    * Shipping Method
    * Payment Method
    * Review Order
    * Process Payment
    * Order Confirmation
2. Delete all Vendr.Checkout generated Document Types.
  * [Vendr Checkout] Page
    * [Vendr Checkout] Checkout Page
    * [Vendr Checkout] Checkout Step Page
3. Delete all Vendr.Checkout generated Data Types.
  * [Vendr Checkout] Step Picker
  * [Vendr Checkout] Theme Color Picker
4. Uninstall the Vendr.Checkout nuget package:

```bash
dotnet remove package Vendr.Checkout
```

5. Delete any remaining `~/App_Plugins/VendrCheckout` files and folders.

### Step 3: Install Umbraco.Commerce.Checkout

1. Install the Umbraco.Commerce.Checkout package

    ```bash
    dotnet add package Umbraco.Commerce.Checkout
    ```

2. Locate the Umbraco Commerce Checkout dashboard in the Settings section
3. Click the "install" button to reinstall the Checkout components into the previous location.

### Step 4: Reapply custom changes

1. Copy any custom configuration files back into the solution. 
2. Copy any custom Views in to the `~/Views/UmbracoCommerceCheckout/` folder.

## Migrate Custom Payment Providers

Through the following steps we will migrate payment providers used for Vendr into Umbraco Commerce.

### Step 1: Replace dependencies

1. Remove any installed Vendr packages

```bash
dotnet remove package Vendr.Core
```

2. Install the `Umbraco.Commerce` packages for the payment providers.

```bash
dotnet add package Umbraco.Commerce.Core
```

3. Update any namespace references.
4. Update project framework to `net7.0`.

### Step 2: Update implementations

The final step in the migration is to update all abstract async methods exposed by the base class. It needs to be updated to accept an additional `CancellationToken cancellationToken = default` parameter as the final method argument. Your Integrated Development Environment (IDE) should provide feedback on all the methods that have been updated.

[^1]: Vendr previously used the `.js` file extension to serve JSON files without having to configure a new `.json` mimetype on the server. This is no longer necesarry in Umbraco Commerce so we can now use the correct `.json` file extension.
