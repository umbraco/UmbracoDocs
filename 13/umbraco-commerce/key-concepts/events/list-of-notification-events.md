---
description: Hooking into notification events within Umbraco Commerce.
---

# List of Notification Events

## Umbraco.Commerce.Cms.Web.Events.Notification

### Configuration Parsing Events

| **Event** | **Description** |
|---|---|
| AnalyticsDashboardConfigParsingNotification | **OBSOLETE:** Use the `AnalyticsDashboardConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the analytics dashboard configuration, allowing developers to modify or extend the configuration settings before they were applied. |
| CartEditorConfigParsingNotification | **OBSOLETE:** Use the `CartEditorConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the cart editor configuration, allowing developers to customize or extend the configuration settings before they were applied. |
| CartListConfigParsingNotification | **OBSOLETE:** Use the `CartListConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the cart list configuration, allowing developers to modify or extend the configuration settings before they were applied. |
| OrderEditorConfigParsingNotification | **OBSOLETE:** Use the `OrderEditorConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the order editor configuration, allowing developers to customize or extend the configuration settings before they were applied. |
| OrderListConfigParsingNotification | **OBSOLETE:** Use the `OrderListConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the order list configuration, allowing developers to modify or extend the configuration settings before they were applied. |

### Rendering Events

| **Event** | **Description** |
|---|---|
| ActivityLogEntriesRenderingNotification | Triggered when activity log entries are being rendered. Allows customization or modification of the log entries before display. |
| StoreActionsRenderingNotification | Triggered when store actions are being rendered. Allows customization or modification of the actions before display. |

### Searching Events

| **Event** | **Description** |
|---|---|
| CartSearchingNotification | Triggered during a search operation on the cart. Allows customization or modification of search parameters and results. |
| GiftCardSearchingNotification | Triggered during a search operation on gift cards. Allows customization or modification of search parameters and results.  |
| OrderSearchingNotification | Triggered during a search operation on orders. Allows customization or modification of search parameters and results. |

## Umbraco.Commerce.Common.Pipelines.Events

### Pipeline Events

| **Event** | **Description** |
|---|---|
| PipelineFailNotification | Triggered when a pipeline process fails. Allows developers to handle or respond to pipeline failures, enabling custom error handling, logging, or recovery actions. |
| PipelineSuccessNotification | Triggered when a pipeline process completes successfully. Allows developers to handle successful pipeline completions, enabling actions such as logging, notifications, or further processing steps. |

## Umbraco.Commerce.Core.Events.Notification

### Configuration Parsing Events

| **Event** | **Description** |
|---|---|
| AnalyticsDashboardConfigParsingNotification | Triggered during the parsing of the analytics dashboard configuration. Allows developers to modify or extend the configuration settings before they are applied. |
| CartEditorConfigParsingNotification | Triggered when the cart editor configuration is being parsed. Allows developers to customize or extend the configuration settings before they are applied. |
| CartListConfigParsingNotification | Triggered during the parsing of the cart list configuration. Allows developers to modify or extend the configuration settings before they are applied. |

### Country Events

| **Event** | **Description** |
|---|---|
| CountryCreatedNotification | Triggered after a country has been successfully created. Allows developers to perform actions in response to the creation of a new country. |
| CountryCreatingNotification | Triggered before a country is created. Allows developers to perform actions or validations before the creation of a new country.  |
| CountryDeletedNotification | Triggered after a country has been successfully deleted. Allows developers to perform actions in response to the deletion of a country. |
| CountryDeletingNotification | Triggered before a country is deleted. Allows developers to perform actions or validations before the deletion of a country. |
| CountrySavedNotification | Triggered after a country has been successfully saved. Allows developers to perform actions in response to saving changes to a country. |
| CountrySavingNotification | Triggered before a country is saved. Allows developers to perform actions or validations before saving changes to a country. |
| CountryUpdatedNotification | Triggered after a country has been successfully updated. Allows developers to perform actions in response to the update of a country. |
| CountryUpdatingNotification | Triggered before a country is updated. Allows developers to perform actions or validations before the update of a country. |

### Currency Events

| **Event** | **Description** |
|---|---|
| CurrencyCreatedNotification | Triggered after a currency has been successfully created. Allows developers to perform actions in response to the creation of a new currency. |
| CurrencyCreatingNotification | Triggered before a currency is created. Allows developers to perform actions or validations before the creation of a new currency. |
| CurrencyDeletedNotification | Triggered after a currency has been successfully deleted. Allows developers to perform actions in response to the deletion of a currency.  |
| CurrencyDeletingNotification | Triggered before a currency is deleted. Allows developers to perform actions or validations before the deletion of a currency.  |
| CurrencySavedNotification | Triggered after a currency has been successfully saved. Allows developers to perform actions in response to saving changes to a currency. |
| CurrencySavingNotification | Triggered before a currency is saved. Allows developers to perform actions or validations before saving changes to a currency. |
| CurrencyUpdatedNotification | Triggered after a currency has been successfully updated. Allows developers to perform actions in response to the update of a currency. |
| CurrencyUpdatingNotification | Triggered before a currency is updated. Allows developers to perform actions or validations before the update of a currency. |

### Discount Events

| **Event** | **Description** |
|---|---|
| DiscountCreatedNotification | Triggered after a discount has been successfully created. Allows developers to perform actions in response to the creation of a new discount. |
| DiscountCreatingNotification | Triggered before a discount is created. Allows developers to perform actions or validations before the creation of a new discount.  |
| DiscountDeletedNotification | Triggered after a discount has been successfully deleted. Allows developers to perform actions in response to the deletion of a discount. |
| DiscountDeletingNotification | Triggered before a discount is deleted. Allows developers to perform actions or validations before the deletion of a discount. |
| DiscountSavedNotification | Triggered after a discount has been successfully saved. Allows developers to perform actions in response to saving changes to a discount. |
| DiscountSavingNotification | Triggered before a discount is saved. Allows developers to perform actions or validations before saving changes to a discount. |
| DiscountUpdatedNotification | Triggered after a discount has been successfully updated. Allows developers to perform actions in response to the update of a discount. |
| DiscountUpdatingNotification | Triggered before a discount is updated. Allows developers to perform actions or validations before the update of a discount. |

### Email Events

| **Event** | **Description** |
|---|---|
| EmailFailedNotification | Triggered when an email fails to send. Allows developers to handle email failures, perform logging, or take corrective actions. |
| EmailSendingNotification | Triggered before an email is sent. Allows developers to customize the email content, perform validations, or log the sending process. |
| EmailSentNotification | Triggered after an email has been successfully sent. Allows developers to perform actions in response to the successful sending of an email, such as logging or triggering follow-up actions. |
| EmailTemplateCreatedNotification | Triggered after an email template has been successfully created. Allows developers to perform actions in response to the creation of a new email template. |
| EmailTemplateCreatingNotification | Triggered before an email template is created. Allows developers to perform actions or validations before the creation of a new email template.  |
| EmailTemplateDeletedNotification | Triggered after an email template has been successfully deleted. Allows developers to perform actions in response to the deletion of an email template. |
| EmailTemplateDeletingNotification | Triggered before an email template is deleted. Allows developers to perform actions or validations before the deletion of an email template. |
| EmailTemplateSavedNotification | Triggered after an email template has been successfully saved. Allows developers to perform actions in response to saving changes to an email template. |
| EmailTemplateSavingNotification | Triggered before an email template is saved. Allows developers to perform actions or validations before saving changes to an email template. |
| EmailTemplateUpdatedNotification | Triggered after an email template has been successfully updated. Allows developers to perform actions in response to the update of an email template. |
| EmailTemplateUpdatingNotification | Triggered before an email template is updated. Allows developers to perform actions or validations before the update of an email template. |

### Export Template Events

| **Event** | **Description** |
|---|---|
| ExportTemplateCreatedNotification | Triggered after an export template has been successfully created. Allows developers to perform actions in response to the creation of a new export template. |
| ExportTemplateCreatingNotification | Triggered before an export template is created. Allows developers to perform actions or validations before the creation of a new export template. |
| ExportTemplateDeletedNotification | Triggered after an export template has been successfully deleted. Allows developers to perform actions in response to the deletion of an export template. |
| ExportTemplateDeletingNotification | Triggered before an export template is deleted. Allows developers to perform actions or validations before the deletion of an export template. |
| ExportTemplateSavedNotification | Triggered after an export template has been successfully saved. Allows developers to perform actions in response to saving changes to an export template. |
| ExportTemplateSavingNotification | Triggered before an export template is saved. Allows developers to perform actions or validations before saving changes to an export template. |
| ExportTemplateUpdatedNotification | Triggered after an export template has been successfully updated. Allows developers to perform actions in response to the update of an export template. |
| ExportTemplateUpdatingNotification | Triggered before an export template is updated. Allows developers to perform actions or validations before the update of an export template. |

### Frozen Prices Events

| **Event** | **Description** |
|---|---|
| FrozenPricesThawedNotification | Triggered after previously frozen prices have been unfrozen and are now adjustable again. Allows developers to perform actions in response to the thawing of prices.|
| FrozenPricesThawingNotification | Triggered before previously frozen prices are about to be unfrozen and become adjustable. Allows developers to perform actions or validations before the thawing of prices. |

### Gift Card Events

| **Event** | **Description** |
|---|---|
| GiftCardCreatedNotification |  Triggered after a gift card has been successfully created. Allows developers to perform actions in response to the creation of a new gift card.|
| GiftCardCreatingNotification | Triggered before a gift card is created. Allows developers to perform actions or validations before the creation of a new gift card. |
| GiftCardDeletedNotification | Triggered after a gift card has been successfully deleted. Allows developers to perform actions in response to the deletion of a gift card. |
| GiftCardDeletingNotification | Triggered before a gift card is deleted. Allows developers to perform actions or validations before the deletion of a gift card. |
| GiftCardSavedNotification | Triggered after a gift card has been successfully saved. Allows developers to perform actions in response to saving changes to a gift card. |
| GiftCardSavingNotification | Triggered before a gift card is saved. Allows developers to perform actions or validations before saving changes to a gift card. |
| GiftCardUpdatedNotification | Triggered after a gift card has been successfully updated. Allows developers to perform actions in response to the update of a gift card. |
| GiftCardUpdatingNotification | Triggered before a gift card is updated. Allows developers to perform actions or validations before the update of a gift card. |

### Location Events

| **Event** | **Description** |
|---|---|
| LocationCreatedNotification | Triggered after a location has been successfully created. Allows developers to perform actions in response to the creation of a new location. |
| LocationCreatingNotification | Triggered before a location is created. Allows developers to perform actions or validations before the creation of a new location. |
| LocationDeletedNotification | Triggered after a location has been successfully deleted. Allows developers to perform actions in response to the deletion of a location. |
| LocationDeletingNotification | Triggered before a location is deleted. Allows developers to perform actions or validations before the deletion of a location. |
| LocationSavedNotification | Triggered after a location has been successfully saved. Allows developers to perform actions in response to saving changes to a location. |
| LocationSavingNotification | Triggered before a location is saved. Allows developers to perform actions or validations before saving changes to a location. |
| LocationUpdatedNotification | Triggered after a location has been successfully updated. Allows developers to perform actions in response to the update of a location. |
| LocationUpdatingNotification | Triggered before a location is updated. Allows developers to perform actions or validations before the update of a location.  |

### Order Events

| **Event** | **Description** |
|---|---|
| OrderAssignedToCustomerNotification | Triggered after an order has been successfully assigned to a customer. Allows developers to perform actions in response to the assignment. |
| OrderAssigningToCustomerNotification | Triggered before an order is assigned to a customer. Allows developers to perform actions or validations before the assignment. |
| OrderConfigParsingNotification | Triggered during the parsing of the order configuration. Allows developers to modify or extend the configuration settings before they are applied. |
| OrderCreatedNotification | Triggered after an order has been successfully created. Allows developers to perform actions in response to the creation of a new order.|
| OrderCreatingNotification | Triggered before an order is created. Allows developers to perform actions or validations before the creation of a new order. |
| OrderCurrencyChangedNotification | Triggered after the currency of an order has been successfully changed. Allows developers to perform actions in response to the currency change. |
| OrderCurrencyChangingNotification | Triggered before the currency of an order is changed. Allows developers to perform actions or validations before the currency change. |
| OrderDeletedNotification | Triggered after an order has been successfully deleted. Allows developers to perform actions in response to the deletion of an order. |
| OrderDeletingNotification | Triggered before an order is deleted. Allows developers to perform actions or validations before the deletion of an order. |
| OrderDiscountCodeRedeemedNotification | Triggered after a discount code has been successfully redeemed on an order. Allows developers to perform actions in response to the redemption. |
| OrderDiscountCodeRedeemingNotification | Triggered before a discount code is redeemed on an order. Allows developers to perform actions or validations before the redemption. |
| OrderDiscountCodeUnredeemedNotification | Triggered after a discount code has been successfully unredeemed (reversing the application of a previously redeemed discount code) on an order. Allows developers to perform actions in response to the unredemption. |
| OrderDiscountCodeUnredeemingNotification | Triggered before a discount code is unredeemed on an order. Allows developers to perform actions or validations before the unredemption. |
| OrderEditorConfigParsingNotification | Triggered during the parsing of the order editor configuration. Allows developers to modify or extend the configuration settings before they are applied. |
| OrderFinalizedNotification | Triggered after an order has been successfully finalized. Allows developers to perform actions in response to the finalization. |
| OrderFinalizingNotification | Triggered before an order is finalized. Allows developers to perform actions or validations before the finalization. |
| OrderGiftCardRedeemedNotification | Triggered after a gift card has been successfully redeemed on an order. Allows developers to perform actions in response to the redemption. |
| OrderGiftCardRedeemingNotification | Triggered before a gift card is redeemed on an order. Allows developers to perform actions or validations before the redemption. |
| OrderGiftCardUnredeemedNotification | Triggered after a gift card has been successfully unredeemed on an order. Allows developers to perform actions in response to the unredemption. |
| OrderGiftCardUnredeemingNotification | Triggered before a gift card is unredeemed on an order. Allows developers to perform actions or validations before the unredemption. |
| OrderLanguageChangedNotification | Triggered after the language of an order has been successfully changed. Allows developers to perform actions in response to the language change. |
| OrderLanguageChangingNotification | Triggered before the language of an order is changed. Allows developers to perform actions or validations before the language change. |
| OrderLineAddedNotification | Triggered after a line item has been successfully added to an order. Allows developers to perform actions in response to the addition. |
| OrderLineAddingNotification | Triggered before a line item is added to an order. Allows developers to perform actions or validations before the addition. |
| OrderLineChangedNotification | Triggered after a line item in an order has been successfully changed. Allows developers to perform actions in response to the change. |
| OrderLineChangingNotification | Triggered before a line item in an order is changed. Allows developers to perform actions or validations before the change. |
| OrderLineRemovedNotification | Triggered after a line item has been successfully removed from an order. Allows developers to perform actions in response to the removal. |
| OrderLineRemovingNotification | Triggered before a line item is removed from an order. Allows developers to perform actions or validations before the removal. |
| OrderListConfigParsingNotification | Triggered during the parsing of the order list configuration. Allows developers to modify or extend the configuration settings before they are applied. |
| OrderPaymentCountryRegionChangedNotification | Triggered after the payment country or region of an order has been successfully changed. Allows developers to perform actions in response to the change. |
| OrderPaymentCountryRegionChangingNotification | Triggered before the payment country or region of an order is changed. Allows developers to perform actions or validations before the change. |
| OrderPaymentMethodChangedNotification | Triggered after the payment method of an order has been successfully changed. Allows developers to perform actions in response to the change. |
| OrderPaymentMethodChangingNotification | Triggered before the payment method of an order is changed. Allows developers to perform actions or validations before the change. |
| OrderProductAddedNotification | Triggered after a product has been successfully added to an order. Allows developers to perform actions in response to the addition. |
| OrderProductAddingNotification | Triggered before a product is added to an order. Allows developers to perform actions or validations before the addition.  |
| OrderPropertiesChangedNotification | Triggered after properties of an order have been successfully changed. Allows developers to perform actions in response to the changes. |
| OrderPropertiesChangingNotification | Triggered before properties of an order are changed. Allows developers to perform actions or validations before the changes. |
| OrderSavedNotification | Triggered after an order has been successfully saved. Allows developers to perform actions in response to saving changes to an order. |
| OrderSavingNotification | Triggered before an order is saved. Allows developers to perform actions or validations before saving changes to an order. |
| OrderShippingCountryRegionChangedNotification | Triggered after the shipping country or region of an order has been successfully changed. Allows developers to perform actions in response to the change. |
| OrderShippingCountryRegionChangingNotification | Triggered before the shipping country or region of an order is changed. Allows developers to perform actions or validations before the change. |
| OrderShippingMethodChangedNotification | Triggered after the shipping method of an order has been successfully changed. Allows developers to perform actions in response to the change. |
| OrderShippingMethodChangingNotification | Triggered before the shipping method of an order is changed. Allows developers to perform actions or validations before the change. |
| OrderStatusChangedNotification | Triggered after the status of an order has been successfully changed. Allows developers to perform actions in response to the status change. |
| OrderStatusChangingNotification | Triggered before the status of an order is changed. Allows developers to perform actions or validations before the status change. |
| OrderStatusCreatedNotification | Triggered after a new order status has been successfully created. Allows developers to perform actions in response to the creation of a new status. |
| OrderStatusCreatingNotification | Triggered before a new order status is created. Allows developers to perform actions or validations before the creation of a new status. |
| OrderStatusDeletedNotification | Triggered after an order status has been successfully deleted. Allows developers to perform actions in response to the deletion of a status. |
| OrderStatusDeletingNotification | Triggered before an order status is deleted. Allows developers to perform actions or validations before the deletion of a status. |
| OrderStatusSavedNotification | Triggered after an order status has been successfully saved. Allows developers to perform actions in response to saving changes to a status.|
| OrderStatusSavingNotification | Triggered before an order status is saved. Allows developers to perform actions or validations before saving changes to a status. |
| OrderStatusUpdatedNotification | Triggered after an order status has been successfully updated. Allows developers to perform actions in response to the update of a status. |
| OrderStatusUpdatingNotification | Triggered before an order status is updated. Allows developers to perform actions or validations before the update of a status. |
| OrderTagsChangedNotification |Triggered after the tags of an order have been successfully changed. Allows developers to perform actions in response to the tag changes.  |
| OrderTagsChangingNotification | Triggered before the tags of an order are changed. Allows developers to perform actions or validations before the tag changes. |
| OrderTaxClassChangedNotification | Triggered after the tax class of an order has been successfully changed. Allows developers to perform actions in response to the tax class change. |
| OrderTaxClassChangingNotification | Triggered before the tax class of an order is changed. Allows developers to perform actions or validations before the tax class change. |
| OrderTransactionUpdatedNotification | Triggered after a transaction in an order has been successfully updated. Allows developers to perform actions in response to the transaction update. |
| OrderTransactionUpdatingNotification | Triggered before a transaction in an order is updated. Allows developers to perform actions or validations before the transaction update. |
| OrderUpdatedNotification | Triggered after an order has been successfully updated. Allows developers to perform actions in response to the update of an order. |
| OrderUpdatingNotification | Triggered before an order is updated. Allows developers to perform actions or validations before the update of an order. |

### Payment Events

| **Event** | **Description** |
|---|---|
| PaymentFormGeneratingNotification | Triggered during the generation of a payment form. Allows developers to customize or modify the payment form before it is presented to the user. |
| PaymentMethodCreatedNotification | Triggered after a payment method has been successfully created. Allows developers to perform actions in response to the creation of a new payment method. |
| PaymentMethodCreatingNotification | Triggered before a payment method is created. Allows developers to perform actions or validations before the creation of a new payment method. |
| PaymentMethodDeletedNotification | Triggered after a payment method has been successfully deleted. Allows developers to perform actions in response to the deletion of a payment method. |
| PaymentMethodDeletingNotification | Triggered before a payment method is deleted. Allows developers to perform actions or validations before the deletion of a payment method. |
| PaymentMethodSavedNotification | Triggered after a payment method has been successfully saved. Allows developers to perform actions in response to saving changes to a payment method. |
| PaymentMethodSavingNotification | Triggered before a payment method is saved. Allows developers to perform actions or validations before saving changes to a payment method. |
| PaymentMethodUpdatedNotification | Triggered after a payment method has been successfully updated. Allows developers to perform actions in response to the update of a payment method. |
| PaymentMethodUpdatingNotification | Triggered before a payment method is updated. Allows developers to perform actions or validations before the update of a payment method. |

### Print Template Events

| **Event** | **Description** |
|---|---|
| PrintTemplateCreatedNotification | Triggered after a print template has been successfully created. Allows developers to perform actions in response to the creation of a new print template. |
| PrintTemplateCreatingNotification | Triggered before a print template is created. Allows developers to perform actions or validations before the creation of a new print template. |
| PrintTemplateDeletedNotification | Triggered after a print template has been successfully deleted. Allows developers to perform actions in response to the deletion of a print template. |
| PrintTemplateDeletingNotification | Triggered before a print template is deleted. Allows developers to perform actions or validations before the deletion of a print template. |
| PrintTemplateSavedNotification | Triggered after a print template has been successfully saved. Allows developers to perform actions in response to saving changes to a print template. |
| PrintTemplateSavingNotification | Triggered before a print template is saved. Allows developers to perform actions or validations before saving changes to a print template. |
| PrintTemplateUpdatedNotification | Triggered after a print template has been successfully updated. Allows developers to perform actions in response to the update of a print template. |
| PrintTemplateUpdatingNotification | Triggered before a print template is updated. Allows developers to perform actions or validations before the update of a print template. |

### Product Attribute Events

| **Event** | **Description** |
|---|---|
| ProductAttributeCreatedNotification | Triggered after a product attribute (for example: size, color, or material) has been successfully created. Allows developers to perform actions in response to the creation of a new product attribute. |
| ProductAttributeCreatingNotification | Triggered before a product attribute is created. Allows developers to perform actions or validations before the creation of a new product attribute. |
| ProductAttributeDeletedNotification | Triggered after a product attribute has been successfully deleted. Allows developers to perform actions in response to the deletion of a product attribute. |
| ProductAttributeDeletingNotification | Triggered before a product attribute is deleted. Allows developers to perform actions or validations before the deletion of a product attribute. |
| ProductAttributePresetCreatedNotification | Triggered after a product attribute preset has been successfully created. Allows developers to perform actions in response to the creation of a new product attribute preset. |
| ProductAttributePresetCreatingNotification | Triggered before a product attribute preset is created. Allows developers to perform actions or validations before the creation of a new product attribute preset. |
| ProductAttributePresetDeletedNotification | Triggered after a product attribute preset has been successfully deleted. Allows developers to perform actions in response to the deletion of a product attribute preset. |
| ProductAttributePresetDeletingNotification | Triggered before a product attribute preset is deleted. Allows developers to perform actions or validations before the deletion of a product attribute preset. |
| ProductAttributePresetSavedNotification | Triggered after a product attribute preset has been successfully saved. Allows developers to perform actions in response to saving changes to a product attribute preset. |
| ProductAttributePresetSavingNotification | Triggered before a product attribute preset is saved. Allows developers to perform actions or validations before saving changes to a product attribute preset. |
| ProductAttributePresetUpdatedNotification | Triggered after a product attribute preset has been successfully updated. Allows developers to perform actions in response to the update of a product attribute preset. |
| ProductAttributePresetUpdatingNotification | Triggered before a product attribute preset is updated. Allows developers to perform actions or validations before the update of a product attribute preset. |
| ProductAttributeSavedNotification | Triggered after a product attribute has been successfully saved. Allows developers to perform actions in response to saving changes to a product attribute. |
| ProductAttributeSavingNotification | Triggered before a product attribute is saved. Allows developers to perform actions or validations before saving changes to a product attribute. |
| ProductAttributeUpdatedNotification | Triggered after a product attribute has been successfully updated. Allows developers to perform actions in response to the update of a product attribute. |
| ProductAttributeUpdatingNotification | Triggered before a product attribute is updated. Allows developers to perform actions or validations before the update of a product attribute. |

### Region Events

| **Event** | **Description** |
|---|---|
| RegionCreatedNotification | Triggered after a region has been successfully created. Allows developers to perform actions in response to the creation of a new region. |
| RegionCreatingNotification | Triggered before a region is created. Allows developers to perform actions or validations before the creation of a new region. |
| RegionDeletedNotification | Triggered after a region has been successfully deleted. Allows developers to perform actions in response to the deletion of a region. |
| RegionDeletingNotification | Triggered before a region is deleted. Allows developers to perform actions or validations before the deletion of a region. |
| RegionSavedNotification | Triggered after a region has been successfully saved. Allows developers to perform actions in response to saving changes to a region. |
| RegionSavingNotification | Triggered before a region is saved. Allows developers to perform actions or validations before saving changes to a region. |
| RegionUpdatedNotification | Triggered after a region has been successfully updated. Allows developers to perform actions in response to the update of a region. |
| RegionUpdatingNotification | Triggered before a region is updated. Allows developers to perform actions or validations before the update of a region. |

### Shipping Method Events

| **Event** | **Description** |
|---|---|
| ShippingMethodCreatedNotification | Triggered after a shipping method has been successfully created. Allows developers to perform actions in response to the creation of a new shipping method. |
| ShippingMethodCreatingNotification | Triggered before a shipping method is created. Allows developers to perform actions or validations before the creation of a new shipping method. |
| ShippingMethodDeletedNotification | Triggered after a shipping method has been successfully deleted. Allows developers to perform actions in response to the deletion of a shipping method. |
| ShippingMethodDeletingNotification | Triggered before a shipping method is deleted. Allows developers to perform actions or validations before the deletion of a shipping method. |
| ShippingMethodSavedNotification | Triggered after a shipping method has been successfully saved. Allows developers to perform actions in response to saving changes to a shipping method. |
| ShippingMethodSavingNotification | Triggered before a shipping method is saved. Allows developers to perform actions or validations before saving changes to a shipping method. |
| ShippingMethodUpdatedNotification | Triggered after a shipping method has been successfully updated. Allows developers to perform actions in response to the update of a shipping method. |
| ShippingMethodUpdatingNotification | Triggered before a shipping method is updated. Allows developers to perform actions or validations before the update of a shipping method. |

### Stock Events

| **Event** | **Description** |
|---|---|
| StockChangedNotification | Triggered after the stock level of a product has been successfully changed. Allows developers to perform actions in response to the change in stock level. |
| StockChangingNotification | Triggered before the stock level of a product is changed. Allows developers to perform actions or validations before the change in stock level. |

### Store Events

| **Event** | **Description** |
|---|---|
| StoreCreatedNotification | Triggered after a store has been successfully created. Allows developers to perform actions in response to the creation of a new store. |
| StoreCreatingNotification | Triggered before a store is created. Allows developers to perform actions or validations before the creation of a new store. |
| StoreDeletedNotification | Triggered after a store has been successfully deleted. Allows developers to perform actions in response to the deletion of a store. |
| StoreDeletingNotification | Triggered before a store is deleted. Allows developers to perform actions or validations before the deletion of a store. |
| StoreSavedNotification | Triggered after a store has been successfully saved. Allows developers to perform actions in response to saving changes to a store. |
| StoreSavingNotification | Triggered before a store is saved. Allows developers to perform actions or validations before saving changes to a store. |
| StoreUpdatedNotification | Triggered after a store has been successfully updated. Allows developers to perform actions in response to the update of a store. |
| StoreUpdatingNotification | Triggered before a store is updated. Allows developers to perform actions or validations before the update of a store. |

### Tax Class Events

| **Event** | **Description** |
|---|---|
| TaxClassCreatedNotification | Triggered after a tax class has been successfully created. Allows developers to perform actions in response to the creation of a new tax class. |
| TaxClassCreatingNotification | Triggered before a tax class is created. Allows developers to perform actions or validations before the creation of a new tax class. |
| TaxClassDeletedNotification | Triggered after a tax class has been successfully deleted. Allows developers to perform actions in response to the deletion of a tax class. |
| TaxClassDeletingNotification | Triggered before a tax class is deleted. Allows developers to perform actions or validations before the deletion of a tax class. |
| TaxClassSavedNotification | Triggered after a tax class has been successfully saved. Allows developers to perform actions in response to saving changes to a tax class. |
| TaxClassSavingNotification | Triggered before a tax class is saved. Allows developers to perform actions or validations before saving changes to a tax class. |
| TaxClassUpdatedNotification | Triggered after a tax class has been successfully updated. Allows developers to perform actions in response to the update of a tax class. |
| TaxClassUpdatingNotification | Triggered before a tax class is updated. Allows developers to perform actions or validations before the update of a tax class. |

### Unit of Work Events

| **Event** | **Description** |
|---|---|
| UnitOfWorkCreatedNotification | Triggered after a unit of work has been successfully created. Allows developers to perform actions in response to the creation of a new unit of work. |
