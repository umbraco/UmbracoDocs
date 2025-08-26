---
description: Learn how to migrate a Vendr solution to Umbraco Commerce.
---

# Migrate from Vendr to Umbraco Commerce

This guide provides a step-by-step approach to migrating a default Vendr solution to Umbraco Commerce.

{% hint style="warning" %}
Upgrade to the latest version of Vendr before continuing with the migration.

You can upgrade your installation by installing the [latest version](https://www.nuget.org/packages/Vendr/) on top of the existing one.
{% endhint %}

You can find details on migrating the Checkout package as well as custom Payment Providers in the [Further Migrations section](./#further-migrations) of this article.

## Key changes

Before outlining the exact steps, there are a few key changes to be aware of.

These changes will dictate the steps to take in the process of migrating to Umbraco Commerce.

### Project, Package, and Namespace changes

| Vendr                       | Umbraco Commerce                       |
| --------------------------- | -------------------------------------- |
| Vendr.Common                | Umbraco.Commerce.Common                |
| Vendr.Core                  | Umbraco.Commerce.Core                  |
| Vendr.Infrastructure        | Umbraco.Commerce.Infrastructure        |
| Vendr.Persistence           | Umbraco.Commerce.Persistence           |
| Vendr.Persistence.Sqlite    | Umbraco.Commerce.Persistence.Sqlite    |
| Vendr.Persistence.SqlServer | Umbraco.Commerce.Persistence.SqlServer |
| Vendr.Umbraco               | Umbraco.Commerce.Cms                   |
| Vendr.Umbraco.Web           | Umbraco.Commerce.Cms.Web               |
| Vendr.Web                   | Umbraco.Commerce.Web                   |
| Vendr.Web.UI                | Umbraco.Commerce.Web.StaticAssets      |
| Vendr.Umbraco.Startup       | Umbraco.Commerce.Cms.Startup           |
| Vendr                       | Umbraco.Commerce                       |

<details>

<summary>C# Class changes</summary>

* Namespace changes as documented above.
* All classes containing the `Vendr` keyword are now updated to `UmbracoCommerce`.
  * Examples: `IVendrApi` is now `IUmbracoCommerceApi` and `AddVendr()` is now `AddUmbracoCommerce()`.

</details>

<details>

<summary>JavaScript changes</summary>

* All `vendr` modules have changed to `umbraco.commerce` modules.
* All `vendr` prefixed directives, services, and resources are now prefixed with `uc`.
* All `vendr` prefixed events now follow this format: `Umbraco.Commerce.{target}.{action}`.

</details>

<details>

<summary>UI Changes</summary>

* All static UI assets are served via a Razor Compiled Library (RCL) and are no longer found in the `App_Plugins` folder.
* The folder within `App_Plugins` still exists for the static assets that are user configurable.
* The folder with `App_Plugins` has been renamed from `Vendr` to `UmbracoCommerce`.
* UI Config files have changed from `.js` files to `.json`.

</details>

## Step 1: Replace dependencies

In this first step, we will be replacing all existing Vendr dependencies with Umbraco Commerce dependencies.

1. Remove any installed Vendr packages (including Payment Providers):

```bash
dotnet remove package Vendr
```

2. Take a backup of any Vendr-specific templates and config files you will want to reuse:
3. Delete the Vendr `App_Plugins` folder:

```bash
rmdir App_Plugins\Vendr
```

4. Install `Umbraco.Commerce`:

```bash
dotnet add package Umbraco.Commerce
```

5. Install Umbraco Commerce packages including any payment providers previously removed.
6. Reapply any backed-up config files in their new `App_Plugins` location.
7. Move any backed-up templates into the `~/Views/UmbracoCommerce/Templates/` folder.
8. Rename any config files with a `.json` file extension rather than [the previous `.js`](#user-content-fn-1)[^1].
9. Compile your project against .NET 7.0.

## Step 2: Update namespaces and entity names

Based on the [Key Changes](./#key-changes) outlined above update all Vendr references to the new Umbraco Commerce alternatives. Ensure you update any Views/Partials that also reference these.

## Step 3: Update the database

In this step, we will cover updating the database for Umbraco Commerce.

1. Backup your database
2. Rename database tables using the following query:

{% tabs %}
{% tab title="SQL Server" %}
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
{% endtab %}

{% tab title="SQLite" %}
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
{% endtab %}
{% endtabs %}

3. Swap Vendr property editors for Umbraco Commerce property editors:

```sql
UPDATE umbracoDataType
SET propertyEditorAlias = REPLACE(propertyEditorAlias, 'Vendr.', 'Umbraco.Commerce.')
WHERE propertyEditorAlias LIKE 'Vendr.%'
```

4. Swap the Vendr variants editor for the Umbraco Commerce variants editor in the block list data entry:

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
SET templateView = REPLACE(templateView, '/App_Plugins/Vendr/templates/export', '/Views/UmbracoCommerce/Templates/Export')
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

## Step 4: Finalizing the migration

1. Delete any obj/bin folders in your projects to ensure a clean build.
2. Recompile all projects and ensure all dependencies are restored correctly
3. Delete the existing Vendr license files in the `umbraco\Licenses` folder.
4. Add your new Umbraco.Commerce license key to the `appSettings.json` file:

```json
"Umbraco"" {
  "Licenses": {
    "Umbraco.Commerce": "YOUR_LICENSE_KEY"
  }
}
```

5. Update any payment gateways that use a global webhook:

```none
https://{site_url}/umbraco/commerce/payment/callback/{payment_provider_alias}/{payment_method_id}/
```

6. Run the project.

It is highly recommended to ensure everything works as expected, before moving on to migrating packages and custom payment providers.

## Further Migrations

If you have been using the Vendr Checkout package, you will need to follow some additional steps to migrate this package to Umbraco Commerce. Follow the link below for a complete guide:

{% content-ref url="migrate-umbraco-commerce-checkout.md" %}
[migrate-umbraco-commerce-checkout.md](migrate-umbraco-commerce-checkout.md)
{% endcontent-ref %}

Any custom payment providers used with Vendr also need to be migrated to Umbraco Commerce. Follow the link below to find detailed steps on how to perform this migration:

{% content-ref url="migrate-custom-payment-providers.md" %}
[migrate-custom-payment-providers.md](migrate-custom-payment-providers.md)
{% endcontent-ref %}

## Common Issues

### DB Migration Issue Due to Column Constraints

Some users have reported issues running the Umbraco Commerce migrations resuling in an error along the lines of:

````
SqlException: The object 'remainingAmount_default' is dependent on column 'remainingAmount'.
ALTER TABLE ALTER COLUMN remainingAmount failed because one or more objects access this column.
Umbraco.Commerce.Persistence.Migrations.DbUpUmbracoCommerceMigrationsRunner.MigrateUp()
````

The issue generally revolves around the default constraints not having the expected name. To resolve this you should identify the table and the problematic constraint and manually drop the constraint:

```sql
ALTER TABLE [dbo].[umbracoCommerceGiftCard]
DROP CONSTRAINT remainingAmount_default;
```

This will remove the constraint allowing the migrations to run which should re-add the constraints with the correct name.

[^1]: Vendr previously used the `.js` file extension to serve JSON files without having to configure a new `.json` mime-type on the server. This is no longer necessary in Umbraco Commerce so we can now use the correct `.json` file extension.
