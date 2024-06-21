---
description: Hooking into notification events within Umbraco Commerce.
---

# List of Notification Events

{% hint style="warning" %}
This article is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

## Umbraco.Commerce.Cms.Web.Events.Notification

| **Event** | **Description** |
|---|---|
| ActivityLogEntriesRenderingNotification | Triggered when activity log entries are being rendered. Allows customization or modification of the log entries before display. |
| AnalyticsDashboardConfigParsingNotification | **OBSOLETE:** Use the `AnalyticsDashboardConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the analytics dashboard configuration, allowing developers to modify or extend the configuration settings before they were applied. |
| CartEditorConfigParsingNotification | **OBSOLETE:** Use the `CartEditorConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the cart editor configuration, allowing developers to customize or extend the configuration settings before they were applied. |
| CartListConfigParsingNotification | **OBSOLETE:** Use the `CartListConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the cart list configuration, allowing developers to modify or extend the configuration settings before they were applied. |
| CartSearchingNotification | Triggered during a search operation on the cart. Allows customization or modification of search parameters and results. |
| GiftCardSearchingNotification | Triggered during a search operation on gift cards. Allows customization or modification of search parameters and results.  |
| OrderEditorConfigParsingNotification | **OBSOLETE:** Use the `OrderEditorConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the order editor configuration, allowing developers to customize or extend the configuration settings before they were applied. |
| OrderListConfigParsingNotification | **OBSOLETE:** Use the `OrderListConfigParsingNotification` in the `Umbraco.Commerce.Core.Events.Notification` namespace instead. This event was originally used for parsing the order list configuration, allowing developers to modify or extend the configuration settings before they were applied. |
| OrderSearchingNotification | Triggered during a search operation on orders. Allows customization or modification of search parameters and results. |
| StoreActionsRenderingNotification | Triggered when store actions are being rendered. Allows customization or modification of the actions before display. |

## Umbraco.Commerce.Common.Pipelines.Events

| **Event** | **Description** |
|---|---|
| PipelineFailNotification | Triggered when a pipeline process fails. Allows developers to handle or respond to pipeline failures, enabling custom error handling, logging, or recovery actions. |
| PipelineSuccessNotification | Triggered when a pipeline process completes successfully. Allows developers to handle successful pipeline completions, enabling actions such as logging, notifications, or further processing steps. |

## Umbraco.Commerce.Core.Events.Notification

| **Event** | **Description** |
|---|---|
| AnalyticsDashboardConfigParsingNotification | Triggered during the parsing of the analytics dashboard configuration. Allows developers to modify or extend the configuration settings before they are applied. |
| CartEditorConfigParsingNotification | Triggered when the cart editor configuration is being parsed. Allows developers to customize or extend the configuration settings before they are applied. |
| CartListConfigParsingNotification | Triggered during the parsing of the cart list configuration. Allows developers to modify or extend the configuration settings before they are applied. |
| CountryCreatedNotification | Triggered after a country has been successfully created. Allows developers to perform actions in response to the creation of a new country. |
| CountryCreatingNotification | Triggered before a country is created. Allows developers to perform actions or validations before the creation of a new country.  |
| CountryDeletedNotification | Triggered after a country has been successfully deleted. Allows developers to perform actions in response to the deletion of a country. |
| CountryDeletingNotification | Triggered before a country is deleted. Allows developers to perform actions or validations before the deletion of a country. |
| CountrySavedNotification | Triggered after a country has been successfully saved. Allows developers to perform actions in response to saving changes to a country. |
| CountrySavingNotification | Triggered before a country is saved. Allows developers to perform actions or validations before saving changes to a country. |
| CountryUpdatedNotification | Triggered after a country has been successfully updated. Allows developers to perform actions in response to the update of a country. |
| CountryUpdatingNotification | Triggered before a country is updated. Allows developers to perform actions or validations before the update of a country. |
| CurrencyCreatedNotification | Triggered after a currency has been successfully created. Allows developers to perform actions in response to the creation of a new currency. |
| CurrencyCreatingNotification | Triggered before a currency is created. Allows developers to perform actions or validations before the creation of a new currency. |
| CurrencyDeletedNotification | Triggered after a currency has been successfully deleted. Allows developers to perform actions in response to the deletion of a currency.  |
| CurrencyDeletingNotification | Triggered before a currency is deleted. Allows developers to perform actions or validations before the deletion of a currency.  |
| CurrencySavedNotification | Triggered after a currency has been successfully saved. Allows developers to perform actions in response to saving changes to a currency. |
| CurrencySavingNotification | Triggered before a currency is saved. Allows developers to perform actions or validations before saving changes to a currency. |
| CurrencyUpdatedNotification | Triggered after a currency has been successfully updated. Allows developers to perform actions in response to the update of a currency. |
| CurrencyUpdatingNotification | Triggered before a currency is updated. Allows developers to perform actions or validations before the update of a currency. |
| DiscountCreatedNotification | Triggered after a discount has been successfully created. Allows developers to perform actions in response to the creation of a new discount. |
| DiscountCreatingNotification | Triggered before a discount is created. Allows developers to perform actions or validations before the creation of a new discount.  |
| DiscountDeletedNotification | Triggered after a discount has been successfully deleted. Allows developers to perform actions in response to the deletion of a discount. |
| DiscountDeletingNotification | Triggered before a discount is deleted. Allows developers to perform actions or validations before the deletion of a discount. |
| DiscountSavedNotification | Triggered after a discount has been successfully saved. Allows developers to perform actions in response to saving changes to a discount. |
| DiscountSavingNotification | Triggered before a discount is saved. Allows developers to perform actions or validations before saving changes to a discount. |
| DiscountUpdatedNotification | Triggered after a discount has been successfully updated. Allows developers to perform actions in response to the update of a discount. |
| DiscountUpdatingNotification | Triggered before a discount is updated. Allows developers to perform actions or validations before the update of a discount. |
| EmailFailedNotification |  |
| EmailSendingNotification |  |
| EmailSentNotification |  |
| EmailTemplateCreatedNotification |  |
| EmailTemplateCreatingNotification |  |
| EmailTemplateDeletedNotification |  |
| EmailTemplateDeletingNotification |  |
| EmailTemplateSavedNotification |  |
| EmailTemplateSavingNotification |  |
| EmailTemplateUpdatedNotification |  |
| EmailTemplateUpdatingNotification |  |
| ExportTemplateCreatedNotification |  |
| ExportTemplateCreatingNotification |  |
| ExportTemplateDeletedNotification |  |
| ExportTemplateDeletingNotification |  |
| ExportTemplateSavedNotification |  |
| ExportTemplateSavingNotification |  |
| ExportTemplateUpdatedNotification |  |
| ExportTemplateUpdatingNotification |  |
| FrozenPricesThawedNotification |  |
| FrozenPricesThawingNotification |  |
| GiftCardCreatedNotification |  |
| GiftCardCreatingNotification |  |
| GiftCardDeletedNotification |  |
| GiftCardDeletingNotification |  |
| GiftCardSavedNotification |  |
| GiftCardSavingNotification |  |
| GiftCardUpdatedNotification |  |
| GiftCardUpdatingNotification |  |
| LocationCreatedNotification |  |
| LocationCreatingNotification |  |
| LocationDeletedNotification |  |
| LocationDeletingNotification |  |
| LocationSavedNotification |  |
| LocationSavingNotification |  |
| LocationUpdatedNotification |  |
| LocationUpdatingNotification |  |
| OrderAssignedToCustomerNotification |  |
| OrderAssigningToCustomerNotification |  |
| OrderConfigParsingNotification |  |
| OrderCreatedNotification |  |
| OrderCreatingNotification |  |
| OrderCurrencyChangedNotification |  |
| OrderCurrencyChangingNotification |  |
| OrderDeletedNotification |  |
| OrderDeletingNotification |  |
| OrderDiscountCodeRedeemedNotification |  |
| OrderDiscountCodeRedeemingNotification |  |
| OrderDiscountCodeUnredeemedNotification |  |
| OrderDiscountCodeUnredeemingNotification |  |
| OrderEditorConfigParsingNotification |  |
| OrderFinalizedNotification |  |
| OrderFinalizingNotification |  |
| OrderGiftCardRedeemedNotification |  |
| OrderGiftCardRedeemingNotification |  |
| OrderGiftCardUnredeemedNotification |  |
| OrderGiftCardUnredeemingNotification |  |
| OrderLanguageChangedNotification |  |
| OrderLanguageChangingNotification |  |
| OrderLineAddedNotification |  |
| OrderLineAddingNotification |  |
| OrderLineChangedNotification |  |
| OrderLineChangingNotification |  |
| OrderLineRemovedNotification |  |
| OrderLineRemovingNotification |  |
| OrderListConfigParsingNotification |  |
| OrderPaymentCountryRegionChangedNotification |  |
| OrderPaymentCountryRegionChangingNotification |  |
| OrderPaymentMethodChangedNotification |  |
| OrderPaymentMethodChangingNotification |  |
| OrderProductAddedNotification |  |
| OrderProductAddingNotification |  |
| OrderPropertiesChangedNotification |  |
| OrderPropertiesChangingNotification |  |
| OrderSavedNotification |  |
| OrderSavingNotification |  |
| OrderShippingCountryRegionChangedNotification |  |
| OrderShippingCountryRegionChangingNotification |  |
| OrderShippingMethodChangedNotification |  |
| OrderShippingMethodChangingNotification |  |
| OrderStatusChangedNotification |  |
| OrderStatusChangingNotification |  |
| OrderStatusCreatedNotification |  |
| OrderStatusCreatingNotification |  |
| OrderStatusDeletedNotification |  |
| OrderStatusDeletingNotification |  |
| OrderStatusSavedNotification |  |
| OrderStatusSavingNotification |  |
| OrderStatusUpdatedNotification |  |
| OrderStatusUpdatingNotification |  |
| OrderTagsChangedNotification |  |
| OrderTagsChangingNotification |  |
| OrderTaxClassChangedNotification |  |
| OrderTaxClassChangingNotification |  |
| OrderTransactionUpdatedNotification |  |
| OrderTransactionUpdatingNotification |  |
| OrderUpdatedNotification |  |
| OrderUpdatingNotification |  |
| PaymentFormGeneratingNotification |  |
| PaymentMethodCreatedNotification |  |
| PaymentMethodCreatingNotification |  |
| PaymentMethodDeletedNotification |  |
| PaymentMethodDeletingNotification |  |
| PaymentMethodSavedNotification |  |
| PaymentMethodSavingNotification |  |
| PaymentMethodUpdatedNotification |  |
| PaymentMethodUpdatingNotification |  |
| PrintTemplateCreatedNotification |  |
| PrintTemplateCreatingNotification |  |
| PrintTemplateDeletedNotification |  |
| PrintTemplateDeletingNotification |  |
| PrintTemplateSavedNotification |  |
| PrintTemplateSavingNotification |  |
| PrintTemplateUpdatedNotification |  |
| PrintTemplateUpdatingNotification |  |
| ProductAttributeCreatedNotification |  |
| ProductAttributeCreatingNotification |  |
| ProductAttributeDeletedNotification |  |
| ProductAttributeDeletingNotification |  |
| ProductAttributePresetCreatedNotification |  |
| ProductAttributePresetCreatingNotification |  |
| ProductAttributePresetDeletedNotification |  |
| ProductAttributePresetDeletingNotification |  |
| ProductAttributePresetSavedNotification |  |
| ProductAttributePresetSavingNotification |  |
| ProductAttributePresetUpdatedNotification |  |
| ProductAttributePresetUpdatingNotification |  |
| ProductAttributeSavedNotification |  |
| ProductAttributeSavingNotification |  |
| ProductAttributeUpdatedNotification |  |
| ProductAttributeUpdatingNotification |  |
| RegionCreatedNotification |  |
| RegionCreatingNotification |  |
| RegionDeletedNotification |  |
| RegionDeletingNotification |  |
| RegionSavedNotification |  |
| RegionSavingNotification |  |
| RegionUpdatedNotification |  |
| RegionUpdatingNotification |  |
| ShippingMethodCreatedNotification |  |
| ShippingMethodCreatingNotification |  |
| ShippingMethodDeletedNotification |  |
| ShippingMethodDeletingNotification |  |
| ShippingMethodSavedNotification |  |
| ShippingMethodSavingNotification |  |
| ShippingMethodUpdatedNotification |  |
| ShippingMethodUpdatingNotification |  |
| StockChangedNotification |  |
| StockChangingNotification |  |
| StoreCreatedNotification |  |
| StoreCreatingNotification |  |
| StoreDeletedNotification |  |
| StoreDeletingNotification |  |
| StoreSavedNotification |  |
| StoreSavingNotification |  |
| StoreUpdatedNotification |  |
| StoreUpdatingNotification |  |
| TaxClassCreatedNotification |  |
| TaxClassCreatingNotification |  |
| TaxClassDeletedNotification |  |
| TaxClassDeletingNotification |  |
| TaxClassSavedNotification |  |
| TaxClassSavingNotification |  |
| TaxClassUpdatedNotification |  |
| TaxClassUpdatingNotification |  |
| UnitOfWorkCreatedNotification |  |
