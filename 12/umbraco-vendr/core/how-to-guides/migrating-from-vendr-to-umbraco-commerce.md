---
title: Migrating a Vendr solution to Umbraco Commerce
description: How-To Guide to migrate a Vendr solution to Umbraco Commerce
---

## Key Changes

Before outlining the exact steps, it's worth knowing a few key changes that have been made which will dictate the steps to take.

### Project / Package / Namespace Changes

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

### C# Class Changes
* Namespace changes as documented above
* All classes containing the `Vendr` keyword are now updated to `UmbracoCommerce`
  > ie: `IVendrApi` is now `IUmbracoCommerceApi`, `AddVendr()` is now `AddUmbracoCommerce()` etc

### JavaScript Changes
* All `vendr` modules have changed to `umbraco.commerce` modules
* All `vendr` prefixed directives + services + resource are new prefixed `uc`
* All `vendr` prefixed events now follow the format `Umbraco.Commerce.{target}.{action}`

### UI Changes
* All static UI assets are now surved via a Razor Compiled Library (RCL) and so are no longer found in the `App_Plugins` folder.
* The `App_Plugins` folder still exists for the static assets that are user configurable
* The `App_Plugins` folder has been renamed from `Vendr` to `UmbracoCommerce`
* UI Config files have changed from `.js` files to `.json`

## Core Migration Steps

### Step 1: Replace Vendr dependencies with Umbraco Commerce dependencies

* Remove any installed Vendr packages (including Payment Providers)
    ```
    dotnet remove package Vendr
    ```

* Delete the Vendr `App_Plugins` folder (backup any Vendr templates / config files you'll want to reuse)
    ```
    rmdir App_Plugins\Vendr
    ```

* Install the `Umbraco.Commerce` packages (including Payment Providers)
    ```
    dotnet add package Umbraco.Commerce
    ```

* Reapply any backed up config files in their new `App_Plugins` location.
* Move any backed up templates into `~/Views/UmbracoCommerce/Templates/` folder
* Rename any config files with a `.json` file extension rather than the previous `.js`
* If your project is not already compiling against .NET 7.0 you should also update your package accordingly to do so

### Step 2: Update all namespaces / entity names

* Based on the map / C# changes oulined in [Key Changes](#key-changes) update all references to the old Vendr namespaces / entities, updating them to the new Umbraco Commerce alternatives (ensure you update any Views / Partials that also reference these)

## Step 3: Update database

* Backup your database
* Rename database tables
  * Sql Server
    ```
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
    ````
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
    ````

* Swap Vendr property editors for Umbraco Commerce property editors

    ```
    UPDATE umbracoDataType
    SET propertyEditorAlias = REPLACE(propertyEditorAlias, 'Vendr.', 'Umbraco.Commerce.')
    WHERE propertyEditorAlias LIKE 'Vendr.%'
    ```

* Swap Vendr variants editor for the Umbraco Commerce variants editor in the block list data entry

    ```
    UPDATE umbracoPropertyData
    SET textValue = REPLACE(textValue, 'Vendr.VariantsEditor', 'Umbraco.Commerce.VariantsEditor')
    WHERE textValue LIKE '%Vendr.VariantsEditor%';
    ```

* Swap Vendr price / amount adjustments to Umbraco Commerce price / amount adjustments

    ```
    UPDATE umbracoCommerceOrderPriceAdjustment
    SET type = REPLACE(type, 'Vendr.', 'Umbraco.Commerce.')
    WHERE type LIKE '%Vendr.%';
    UPDATE umbracoCommerceOrderAmountAdjustment
    SET type = REPLACE(type, 'Vendr.', 'Umbraco.Commerce.')
    WHERE type LIKE '%Vendr.%';
    ```

* Update template paths

    ```
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

* Update migrations log

    ```
    UPDATE umbracoCommerceMigrations
    SET migration = REPLACE(migration, 'Vendr.', 'Umbraco.Commerce.')
    WHERE migration LIKE 'Vendr.%';
    ```

* Update activity logs

    ```
    UPDATE umbracoCommerceActivityLog
    SET eventType = REPLACE(eventType, 'vendr/', 'commerce/')
    WHERE eventType LIKE 'vendr/%';
    ```

### Step 4: Clear obj / bin folders
* Delete any obj / bin folders in your projects to ensure a clean build.

### Step 5: Recompile all projects
* Recompile all projects and ensure all dependencies are restored correctly

### Step 6: Change license files?
* TBD

### Step 7: Update payment gateways
* Any payment gateway with a global webhook (like Stripe) update the webhook URL to:

    ```
    https://{site_url}/umbraco/commerce/payment/callback/{payment_provider_alias}/{payment_method_id}/
    ```

### Step 8: Run the project
* Launch the project and everything should have crossed over

## Umbraco Commerce Checkout Migration Steps

### Step 1: Backup
* Backup any custom templates / Umbraco Commerce UI config files
* Make a note of all config values on the Vendr.Checkout checkout node

### Step 2: Uinstall Vendr.Checkout
* Delete Vendr.Checkout generated checkout nodes
* Delete all Vendr.Checkout generated doc types
* Delete all Vendr.Checkout generated data types
* Uninstall Vendr.Checkout nuget package
    ```
    dotnet remove package Vendr.Checkout
    ```
* Delete any remaining `~/App_Plugins/VendrCheckout` files / folders

### Step 3: Install Umbraco.Commerce.Checkout
* Install the Umbraco.Commerce.Checkout package
    ```
    dotnet add package Umbraco.Commerce.Checkout
    ```
* In the settings section, locate the Umbraco Commerce Checkout dashboard and reinstall into previous location

### Step 4: Reapply any custom changes
* Copy any custom configs back 
* Copy any custom Views to `~/Views/UmbracoCommerceCheckout/`

## Payment Provider Migration Steps

### Step 1: Replace Vendr dependencies with Umbraco Commerce dependencies

* Remove any installed Vendr packages
    ```
    dotnet remove package Vendr.Core
    ```

* Install the `Umbraco.Commerce` packages (including Payment Providers)
    ```
    dotnet add package Umbraco.Commerce.Core
    ```
* Updated any namespace references
* Update project framework to `net7.0`

### Step 2: Update implementations

* Update all async methods to accept an additional `CancellationToken` parameter
