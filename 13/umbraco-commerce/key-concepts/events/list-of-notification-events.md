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
| ExportTemplateCreatedNotification | Triggered after an export template has been successfully created. Allows developers to perform actions in response to the creation of a new export template. |
| ExportTemplateCreatingNotification | Triggered before an export template is created. Allows developers to perform actions or validations before the creation of a new export template. |
| ExportTemplateDeletedNotification | Triggered after an export template has been successfully deleted. Allows developers to perform actions in response to the deletion of an export template. |
| ExportTemplateDeletingNotification | Triggered before an export template is deleted. Allows developers to perform actions or validations before the deletion of an export template. |
| ExportTemplateSavedNotification | Triggered after an export template has been successfully saved. Allows developers to perform actions in response to saving changes to an export template. |
| ExportTemplateSavingNotification | Triggered before an export template is saved. Allows developers to perform actions or validations before saving changes to an export template. |
| ExportTemplateUpdatedNotification | Triggered after an export template has been successfully updated. Allows developers to perform actions in response to the update of an export template. |
| ExportTemplateUpdatingNotification | Triggered before an export template is updated. Allows developers to perform actions or validations before the update of an export template. |
| FrozenPricesThawedNotification | Triggered after previously frozen prices have been unfrozen and are now adjustable again. Allows developers to perform actions in response to the thawing of prices.|
| FrozenPricesThawingNotification | Triggered before previously frozen prices are about to be unfrozen and become adjustable. Allows developers to perform actions or validations before the thawing of prices. |
| GiftCardCreatedNotification |  Triggered after a gift card has been successfully created. Allows developers to perform actions in response to the creation of a new gift card.|
| GiftCardCreatingNotification | Triggered before a gift card is created. Allows developers to perform actions or validations before the creation of a new gift card. |
| GiftCardDeletedNotification | Triggered after a gift card has been successfully deleted. Allows developers to perform actions in response to the deletion of a gift card. |
| GiftCardDeletingNotification | Triggered before a gift card is deleted. Allows developers to perform actions or validations before the deletion of a gift card. |
| GiftCardSavedNotification | Triggered after a gift card has been successfully saved. Allows developers to perform actions in response to saving changes to a gift card. |
| GiftCardSavingNotification | Triggered before a gift card is saved. Allows developers to perform actions or validations before saving changes to a gift card. |
| GiftCardUpdatedNotification | Triggered after a gift card has been successfully updated. Allows developers to perform actions in response to the update of a gift card. |
| GiftCardUpdatingNotification | Triggered before a gift card is updated. Allows developers to perform actions or validations before the update of a gift card. |
| LocationCreatedNotification | Triggered after a location has been successfully created. Allows developers to perform actions in response to the creation of a new location. |
| LocationCreatingNotification | Triggered before a location is created. Allows developers to perform actions or validations before the creation of a new location. |
| LocationDeletedNotification | Triggered after a location has been successfully deleted. Allows developers to perform actions in response to the deletion of a location. |
| LocationDeletingNotification | Triggered before a location is deleted. Allows developers to perform actions or validations before the deletion of a location. |
| LocationSavedNotification | Triggered after a location has been successfully saved. Allows developers to perform actions in response to saving changes to a location. |
| LocationSavingNotification | Triggered before a location is saved. Allows developers to perform actions or validations before saving changes to a location. |
| LocationUpdatedNotification | Triggered after a location has been successfully updated. Allows developers to perform actions in response to the update of a location. |
| LocationUpdatingNotification | Triggered before a location is updated. Allows developers to perform actions or validations before the update of a location.  |
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
