---
title: EventHub
description: API reference for EventHub in Umbraco Commerce
---
## EventHub

```csharp
public class EventHub
```

**Namespace**
* [Umbraco.Commerce.Core.Events](README.md)

### Constructors

#### EventHub

The default constructor.

```csharp
public EventHub()
```


### Classes

#### EventHub.NotificationEvents

```csharp
public class NotificationEvents
```

##### Constructors

#### EventHub.NotificationEvents

The default constructor.

```csharp
public NotificationEvents()
```


##### Methods

#### OnCountryCreated

```csharp
public static void OnCountryCreated(Action<CountryCreatedNotification> callback)
```


---

#### OnCountryCreating

```csharp
public static void OnCountryCreating(Action<CountryCreatingNotification> callback)
```


---

#### OnCountryDeleted

```csharp
public static void OnCountryDeleted(Action<CountryDeletedNotification> callback)
```


---

#### OnCountryDeleting

```csharp
public static void OnCountryDeleting(Action<CountryDeletingNotification> callback)
```


---

#### OnCountrySaved

```csharp
public static void OnCountrySaved(Action<CountrySavedNotification> callback)
```


---

#### OnCountrySaving

```csharp
public static void OnCountrySaving(Action<CountrySavingNotification> callback)
```


---

#### OnCountryUpdated

```csharp
public static void OnCountryUpdated(Action<CountryUpdatedNotification> callback)
```


---

#### OnCountryUpdating

```csharp
public static void OnCountryUpdating(Action<CountryUpdatingNotification> callback)
```


---

#### OnCurrencyCreated

```csharp
public static void OnCurrencyCreated(Action<CurrencyCreatedNotification> callback)
```


---

#### OnCurrencyCreating

```csharp
public static void OnCurrencyCreating(Action<CurrencyCreatingNotification> callback)
```


---

#### OnCurrencyDeleted

```csharp
public static void OnCurrencyDeleted(Action<CurrencyDeletedNotification> callback)
```


---

#### OnCurrencyDeleting

```csharp
public static void OnCurrencyDeleting(Action<CurrencyDeletingNotification> callback)
```


---

#### OnCurrencySaved

```csharp
public static void OnCurrencySaved(Action<CurrencySavedNotification> callback)
```


---

#### OnCurrencySaving

```csharp
public static void OnCurrencySaving(Action<CurrencySavingNotification> callback)
```


---

#### OnCurrencyUpdated

```csharp
public static void OnCurrencyUpdated(Action<CurrencyUpdatedNotification> callback)
```


---

#### OnCurrencyUpdating

```csharp
public static void OnCurrencyUpdating(Action<CurrencyUpdatingNotification> callback)
```


---

#### OnDiscountCreated

```csharp
public static void OnDiscountCreated(Action<DiscountCreatedNotification> callback)
```


---

#### OnDiscountCreating

```csharp
public static void OnDiscountCreating(Action<DiscountCreatingNotification> callback)
```


---

#### OnDiscountDeleted

```csharp
public static void OnDiscountDeleted(Action<DiscountDeletedNotification> callback)
```


---

#### OnDiscountDeleting

```csharp
public static void OnDiscountDeleting(Action<DiscountDeletingNotification> callback)
```


---

#### OnDiscountSaved

```csharp
public static void OnDiscountSaved(Action<DiscountSavedNotification> callback)
```


---

#### OnDiscountSaving

```csharp
public static void OnDiscountSaving(Action<DiscountSavingNotification> callback)
```


---

#### OnDiscountUpdated

```csharp
public static void OnDiscountUpdated(Action<DiscountUpdatedNotification> callback)
```


---

#### OnDiscountUpdating

```csharp
public static void OnDiscountUpdating(Action<DiscountUpdatingNotification> callback)
```


---

#### OnEmailFailed

```csharp
public static void OnEmailFailed(Action<EmailFailedNotification> callback)
```


---

#### OnEmailSending

```csharp
public static void OnEmailSending(Action<EmailSendingNotification> callback)
```


---

#### OnEmailSent

```csharp
public static void OnEmailSent(Action<EmailSentNotification> callback)
```


---

#### OnEmailTemplateCreated

```csharp
public static void OnEmailTemplateCreated(Action<EmailTemplateCreatedNotification> callback)
```


---

#### OnEmailTemplateCreating

```csharp
public static void OnEmailTemplateCreating(Action<EmailTemplateCreatingNotification> callback)
```


---

#### OnEmailTemplateDeleted

```csharp
public static void OnEmailTemplateDeleted(Action<EmailTemplateDeletedNotification> callback)
```


---

#### OnEmailTemplateDeleting

```csharp
public static void OnEmailTemplateDeleting(Action<EmailTemplateDeletingNotification> callback)
```


---

#### OnEmailTemplateSaved

```csharp
public static void OnEmailTemplateSaved(Action<EmailTemplateSavedNotification> callback)
```


---

#### OnEmailTemplateSaving

```csharp
public static void OnEmailTemplateSaving(Action<EmailTemplateSavingNotification> callback)
```


---

#### OnEmailTemplateUpdated

```csharp
public static void OnEmailTemplateUpdated(Action<EmailTemplateUpdatedNotification> callback)
```


---

#### OnEmailTemplateUpdating

```csharp
public static void OnEmailTemplateUpdating(Action<EmailTemplateUpdatingNotification> callback)
```


---

#### OnExportTemplateCreated

```csharp
public static void OnExportTemplateCreated(Action<ExportTemplateCreatedNotification> callback)
```


---

#### OnExportTemplateCreating

```csharp
public static void OnExportTemplateCreating(Action<ExportTemplateCreatingNotification> callback)
```


---

#### OnExportTemplateDeleted

```csharp
public static void OnExportTemplateDeleted(Action<ExportTemplateDeletedNotification> callback)
```


---

#### OnExportTemplateDeleting

```csharp
public static void OnExportTemplateDeleting(Action<ExportTemplateDeletingNotification> callback)
```


---

#### OnExportTemplateSaved

```csharp
public static void OnExportTemplateSaved(Action<ExportTemplateSavedNotification> callback)
```


---

#### OnExportTemplateSaving

```csharp
public static void OnExportTemplateSaving(Action<ExportTemplateSavingNotification> callback)
```


---

#### OnExportTemplateUpdated

```csharp
public static void OnExportTemplateUpdated(Action<ExportTemplateUpdatedNotification> callback)
```


---

#### OnExportTemplateUpdating

```csharp
public static void OnExportTemplateUpdating(Action<ExportTemplateUpdatingNotification> callback)
```


---

#### OnFrozenPricesThawed

```csharp
public static void OnFrozenPricesThawed(Action<FrozenPricesThawedNotification> callback)
```


---

#### OnFrozenPricesThawing

```csharp
public static void OnFrozenPricesThawing(Action<FrozenPricesThawingNotification> callback)
```


---

#### OnGiftCardCreated

```csharp
public static void OnGiftCardCreated(Action<GiftCardCreatedNotification> callback)
```


---

#### OnGiftCardCreating

```csharp
public static void OnGiftCardCreating(Action<GiftCardCreatingNotification> callback)
```


---

#### OnGiftCardDeleted

```csharp
public static void OnGiftCardDeleted(Action<GiftCardDeletedNotification> callback)
```


---

#### OnGiftCardDeleting

```csharp
public static void OnGiftCardDeleting(Action<GiftCardDeletingNotification> callback)
```


---

#### OnGiftCardSaved

```csharp
public static void OnGiftCardSaved(Action<GiftCardSavedNotification> callback)
```


---

#### OnGiftCardSaving

```csharp
public static void OnGiftCardSaving(Action<GiftCardSavingNotification> callback)
```


---

#### OnGiftCardUpdated

```csharp
public static void OnGiftCardUpdated(Action<GiftCardUpdatedNotification> callback)
```


---

#### OnGiftCardUpdating

```csharp
public static void OnGiftCardUpdating(Action<GiftCardUpdatingNotification> callback)
```


---

#### OnOrderCreated

```csharp
public static void OnOrderCreated(Action<OrderCreatedNotification> callback)
```


---

#### OnOrderCreating

```csharp
public static void OnOrderCreating(Action<OrderCreatingNotification> callback)
```


---

#### OnOrderDeleted

```csharp
public static void OnOrderDeleted(Action<OrderDeletedNotification> callback)
```


---

#### OnOrderDeleting

```csharp
public static void OnOrderDeleting(Action<OrderDeletingNotification> callback)
```


---

#### OnOrderFinalized

```csharp
public static void OnOrderFinalized(Action<OrderFinalizedNotification> callback)
```


---

#### OnOrderFinalizing

```csharp
public static void OnOrderFinalizing(Action<OrderFinalizingNotification> callback)
```


---

#### OnOrderSaved

```csharp
public static void OnOrderSaved(Action<OrderSavedNotification> callback)
```


---

#### OnOrderSaving

```csharp
public static void OnOrderSaving(Action<OrderSavingNotification> callback)
```


---

#### OnOrderStatusChanged

```csharp
public static void OnOrderStatusChanged(Action<OrderStatusChangedNotification> callback)
```


---

#### OnOrderStatusChanging

```csharp
public static void OnOrderStatusChanging(Action<OrderStatusChangingNotification> callback)
```


---

#### OnOrderStatusCreated

```csharp
public static void OnOrderStatusCreated(Action<OrderStatusCreatedNotification> callback)
```


---

#### OnOrderStatusCreating

```csharp
public static void OnOrderStatusCreating(Action<OrderStatusCreatingNotification> callback)
```


---

#### OnOrderStatusDeleted

```csharp
public static void OnOrderStatusDeleted(Action<OrderStatusDeletedNotification> callback)
```


---

#### OnOrderStatusDeleting

```csharp
public static void OnOrderStatusDeleting(Action<OrderStatusDeletingNotification> callback)
```


---

#### OnOrderStatusSaved

```csharp
public static void OnOrderStatusSaved(Action<OrderStatusSavedNotification> callback)
```


---

#### OnOrderStatusSaving

```csharp
public static void OnOrderStatusSaving(Action<OrderStatusSavingNotification> callback)
```


---

#### OnOrderStatusUpdated

```csharp
public static void OnOrderStatusUpdated(Action<OrderStatusUpdatedNotification> callback)
```


---

#### OnOrderStatusUpdating

```csharp
public static void OnOrderStatusUpdating(Action<OrderStatusUpdatingNotification> callback)
```


---

#### OnOrderTransactionChanged

```csharp
public static void OnOrderTransactionChanged(Action<OrderTransactionUpdatedNotification> callback)
```


---

#### OnOrderTransactionChanging

```csharp
public static void OnOrderTransactionChanging(Action<OrderTransactionUpdatingNotification> callback)
```


---

#### OnOrderUpdated

```csharp
public static void OnOrderUpdated(Action<OrderUpdatedNotification> callback)
```


---

#### OnOrderUpdating

```csharp
public static void OnOrderUpdating(Action<OrderUpdatingNotification> callback)
```


---

#### OnPaymentFormGenerting

```csharp
public static void OnPaymentFormGenerting(Action<PaymentFormGeneratingNotification> callback)
```


---

#### OnPaymentMethodCreated

```csharp
public static void OnPaymentMethodCreated(Action<PaymentMethodCreatedNotification> callback)
```


---

#### OnPaymentMethodCreating

```csharp
public static void OnPaymentMethodCreating(Action<PaymentMethodCreatingNotification> callback)
```


---

#### OnPaymentMethodDeleted

```csharp
public static void OnPaymentMethodDeleted(Action<PaymentMethodDeletedNotification> callback)
```


---

#### OnPaymentMethodDeleting

```csharp
public static void OnPaymentMethodDeleting(Action<PaymentMethodDeletingNotification> callback)
```


---

#### OnPaymentMethodSaved

```csharp
public static void OnPaymentMethodSaved(Action<PaymentMethodSavedNotification> callback)
```


---

#### OnPaymentMethodSaving

```csharp
public static void OnPaymentMethodSaving(Action<PaymentMethodSavingNotification> callback)
```


---

#### OnPaymentMethodUpdated

```csharp
public static void OnPaymentMethodUpdated(Action<PaymentMethodUpdatedNotification> callback)
```


---

#### OnPaymentMethodUpdating

```csharp
public static void OnPaymentMethodUpdating(Action<PaymentMethodUpdatingNotification> callback)
```


---

#### OnPipelineFail

```csharp
public static void OnPipelineFail(Action<PipelineFailNotification> callback)
```


---

#### OnPipelineSuccess

```csharp
public static void OnPipelineSuccess(Action<PipelineSuccessNotification> callback)
```


---

#### OnPrintTemplateCreated

```csharp
public static void OnPrintTemplateCreated(Action<PrintTemplateCreatedNotification> callback)
```


---

#### OnPrintTemplateCreating

```csharp
public static void OnPrintTemplateCreating(Action<PrintTemplateCreatingNotification> callback)
```


---

#### OnPrintTemplateDeleted

```csharp
public static void OnPrintTemplateDeleted(Action<PrintTemplateDeletedNotification> callback)
```


---

#### OnPrintTemplateDeleting

```csharp
public static void OnPrintTemplateDeleting(Action<PrintTemplateDeletingNotification> callback)
```


---

#### OnPrintTemplateSaved

```csharp
public static void OnPrintTemplateSaved(Action<PrintTemplateSavedNotification> callback)
```


---

#### OnPrintTemplateSaving

```csharp
public static void OnPrintTemplateSaving(Action<PrintTemplateSavingNotification> callback)
```


---

#### OnPrintTemplateUpdated

```csharp
public static void OnPrintTemplateUpdated(Action<PrintTemplateUpdatedNotification> callback)
```


---

#### OnPrintTemplateUpdating

```csharp
public static void OnPrintTemplateUpdating(Action<PrintTemplateUpdatingNotification> callback)
```


---

#### OnProductAttributeCreated

```csharp
public static void OnProductAttributeCreated(Action<ProductAttributeCreatedNotification> callback)
```


---

#### OnProductAttributeCreating

```csharp
public static void OnProductAttributeCreating(Action<ProductAttributeCreatingNotification> callback)
```


---

#### OnProductAttributeDeleted

```csharp
public static void OnProductAttributeDeleted(Action<ProductAttributeDeletedNotification> callback)
```


---

#### OnProductAttributeDeleting

```csharp
public static void OnProductAttributeDeleting(Action<ProductAttributeDeletingNotification> callback)
```


---

#### OnProductAttributePresetCreated

```csharp
public static void OnProductAttributePresetCreated(
    Action<ProductAttributePresetCreatedNotification> callback)
```


---

#### OnProductAttributePresetCreating

```csharp
public static void OnProductAttributePresetCreating(
    Action<ProductAttributePresetCreatingNotification> callback)
```


---

#### OnProductAttributePresetDeleted

```csharp
public static void OnProductAttributePresetDeleted(
    Action<ProductAttributePresetDeletedNotification> callback)
```


---

#### OnProductAttributePresetDeleting

```csharp
public static void OnProductAttributePresetDeleting(
    Action<ProductAttributePresetDeletingNotification> callback)
```


---

#### OnProductAttributePresetSaved

```csharp
public static void OnProductAttributePresetSaved(
    Action<ProductAttributePresetSavedNotification> callback)
```


---

#### OnProductAttributePresetSaving

```csharp
public static void OnProductAttributePresetSaving(
    Action<ProductAttributePresetSavingNotification> callback)
```


---

#### OnProductAttributePresetUpdated

```csharp
public static void OnProductAttributePresetUpdated(
    Action<ProductAttributePresetUpdatedNotification> callback)
```


---

#### OnProductAttributePresetUpdating

```csharp
public static void OnProductAttributePresetUpdating(
    Action<ProductAttributePresetUpdatingNotification> callback)
```


---

#### OnProductAttributeSaved

```csharp
public static void OnProductAttributeSaved(Action<ProductAttributeSavedNotification> callback)
```


---

#### OnProductAttributeSaving

```csharp
public static void OnProductAttributeSaving(Action<ProductAttributeSavingNotification> callback)
```


---

#### OnProductAttributeUpdated

```csharp
public static void OnProductAttributeUpdated(Action<ProductAttributeUpdatedNotification> callback)
```


---

#### OnProductAttributeUpdating

```csharp
public static void OnProductAttributeUpdating(Action<ProductAttributeUpdatingNotification> callback)
```


---

#### OnRegionCreated

```csharp
public static void OnRegionCreated(Action<RegionCreatedNotification> callback)
```


---

#### OnRegionCreating

```csharp
public static void OnRegionCreating(Action<RegionCreatingNotification> callback)
```


---

#### OnRegionDeleted

```csharp
public static void OnRegionDeleted(Action<RegionDeletedNotification> callback)
```


---

#### OnRegionDeleting

```csharp
public static void OnRegionDeleting(Action<RegionDeletingNotification> callback)
```


---

#### OnRegionSaved

```csharp
public static void OnRegionSaved(Action<RegionSavedNotification> callback)
```


---

#### OnRegionSaving

```csharp
public static void OnRegionSaving(Action<RegionSavingNotification> callback)
```


---

#### OnRegionUpdated

```csharp
public static void OnRegionUpdated(Action<RegionUpdatedNotification> callback)
```


---

#### OnRegionUpdating

```csharp
public static void OnRegionUpdating(Action<RegionUpdatingNotification> callback)
```


---

#### OnShippingMethodCreated

```csharp
public static void OnShippingMethodCreated(Action<ShippingMethodCreatedNotification> callback)
```


---

#### OnShippingMethodCreating

```csharp
public static void OnShippingMethodCreating(Action<ShippingMethodCreatingNotification> callback)
```


---

#### OnShippingMethodDeleted

```csharp
public static void OnShippingMethodDeleted(Action<ShippingMethodDeletedNotification> callback)
```


---

#### OnShippingMethodDeleting

```csharp
public static void OnShippingMethodDeleting(Action<ShippingMethodDeletingNotification> callback)
```


---

#### OnShippingMethodSaved

```csharp
public static void OnShippingMethodSaved(Action<ShippingMethodSavedNotification> callback)
```


---

#### OnShippingMethodSaving

```csharp
public static void OnShippingMethodSaving(Action<ShippingMethodSavingNotification> callback)
```


---

#### OnShippingMethodUpdated

```csharp
public static void OnShippingMethodUpdated(Action<ShippingMethodUpdatedNotification> callback)
```


---

#### OnShippingMethodUpdating

```csharp
public static void OnShippingMethodUpdating(Action<ShippingMethodUpdatingNotification> callback)
```


---

#### OnStockChanged

```csharp
public static void OnStockChanged(Action<StockChangedNotification> callback)
```


---

#### OnStockChanging

```csharp
public static void OnStockChanging(Action<StockChangingNotification> callback)
```


---

#### OnStoreCreated

```csharp
public static void OnStoreCreated(Action<StoreCreatedNotification> callback)
```


---

#### OnStoreCreating

```csharp
public static void OnStoreCreating(Action<StoreCreatingNotification> callback)
```


---

#### OnStoreDeleted

```csharp
public static void OnStoreDeleted(Action<StoreDeletedNotification> callback)
```


---

#### OnStoreDeleting

```csharp
public static void OnStoreDeleting(Action<StoreDeletingNotification> callback)
```


---

#### OnStoreSaved

```csharp
public static void OnStoreSaved(Action<StoreSavedNotification> callback)
```


---

#### OnStoreSaving

```csharp
public static void OnStoreSaving(Action<StoreSavingNotification> callback)
```


---

#### OnStoreUpdated

```csharp
public static void OnStoreUpdated(Action<StoreUpdatedNotification> callback)
```


---

#### OnStoreUpdating

```csharp
public static void OnStoreUpdating(Action<StoreUpdatingNotification> callback)
```


---

#### OnTaxClassCreated

```csharp
public static void OnTaxClassCreated(Action<TaxClassCreatedNotification> callback)
```


---

#### OnTaxClassCreating

```csharp
public static void OnTaxClassCreating(Action<TaxClassCreatingNotification> callback)
```


---

#### OnTaxClassDeleted

```csharp
public static void OnTaxClassDeleted(Action<TaxClassDeletedNotification> callback)
```


---

#### OnTaxClassDeleting

```csharp
public static void OnTaxClassDeleting(Action<TaxClassDeletingNotification> callback)
```


---

#### OnTaxClassSaved

```csharp
public static void OnTaxClassSaved(Action<TaxClassSavedNotification> callback)
```


---

#### OnTaxClassSaving

```csharp
public static void OnTaxClassSaving(Action<TaxClassSavingNotification> callback)
```


---

#### OnTaxClassUpdated

```csharp
public static void OnTaxClassUpdated(Action<TaxClassUpdatedNotification> callback)
```


---

#### OnTaxClassUpdating

```csharp
public static void OnTaxClassUpdating(Action<TaxClassUpdatingNotification> callback)
```


---

#### OnUnitOfWorkCreated

```csharp
public static void OnUnitOfWorkCreated(Action<UnitOfWorkCreatedNotification> callback)
```



<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
