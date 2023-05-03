---
title: VendrServiceContext
description: API reference for VendrServiceContext in Vendr, the eCommerce solution for Umbraco
---
## VendrServiceContext

A central service context for easy access to all of Vendr's services

```csharp
public class VendrServiceContext
```

**Namespace**
* [Vendr.Core.Services](../)

### Constructors

#### VendrServiceContext

Instantiates a new VendrServiceContext instance

```csharp
public VendrServiceContext(Lazy<ICountryService> countryService, 
    Lazy<ICurrencyService> currencyService, Lazy<IEmailTemplateService> emailTemplateService, 
    Lazy<IPrintTemplateService> printTemplateService, 
    Lazy<IExportTemplateService> exportTemplateService, Lazy<IOrderService> orderService, 
    Lazy<IOrderStatusService> orderStatusService, Lazy<IPaymentMethodService> paymentMethodService, 
    Lazy<IPaymentService> paymentService, Lazy<IPaymentProviderService> paymentProviderService, 
    Lazy<IShippingMethodService> shippingMethodService, Lazy<IStoreService> storeService, 
    Lazy<ITaxService> taxService, Lazy<IProductService> productService, 
    Lazy<IDiscountService> discountService, Lazy<IGiftCardService> giftCardService, 
    Lazy<ITranslationService> translationService, 
    Lazy<IProductAttributeService> productAttributeService, Lazy<IEntityService> entityService, 
    Lazy<IActivityLogService> activityLogService, Lazy<IAnalyticsService> analyticsService, 
    Lazy<LicensingService> licensingService, 
    Lazy<IRegisteredCustomerInfoService> registeredCustomerInfoService, 
    Lazy<ITagService> tagService)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| countryService |  |
| currencyService |  |
| emailTemplateService |  |
| printTemplateService |  |
| exportTemplateService |  |
| orderService |  |
| orderStatusService |  |
| paymentMethodService |  |
| paymentService |  |
| paymentProviderService |  |
| shippingMethodService |  |
| storeService |  |
| taxService |  |
| productService |  |
| discountService |  |
| giftCardService |  |
| translationService |  |
| productAttributeService |  |
| entityService |  |
| activityLogService |  |
| analyticsService |  |
| licensingService |  |
| registeredCustomerInfoService |  |
| tagService |  |


### Properties

#### ActivityLogService

Gets the [`IActivityLogService`](../iactivitylogservice/)

```csharp
public IActivityLogService ActivityLogService { get; }
```


---

#### AnalyticsService

Gets the [`IAnalyticsService`](../ianalyticsservice/)

```csharp
public IAnalyticsService AnalyticsService { get; }
```


---

#### CountryService

Gets the [`ICountryService`](../icountryservice/)

```csharp
public ICountryService CountryService { get; }
```


---

#### CurrencyService

Gets the [`ICurrencyService`](../icurrencyservice/)

```csharp
public ICurrencyService CurrencyService { get; }
```


---

#### DiscountService

Gets the [`IDiscountService`](../idiscountservice/)

```csharp
public IDiscountService DiscountService { get; }
```


---

#### EmailTemplateService

Gets the [`IEmailTemplateService`](../iemailtemplateservice/)

```csharp
public IEmailTemplateService EmailTemplateService { get; }
```


---

#### EntityService

Gets the [`IEntityService`](../ientityservice/)

```csharp
public IEntityService EntityService { get; }
```


---

#### ExportTemplateService

Gets the [`IExportTemplateService`](../iexporttemplateservice/)

```csharp
public IExportTemplateService ExportTemplateService { get; }
```


---

#### GiftCardService

Gets the [`IGiftCardService`](../igiftcardservice/)

```csharp
public IGiftCardService GiftCardService { get; }
```


---

#### LicensingService

Gets the `LicensingService`

```csharp
public LicensingService LicensingService { get; }
```


---

#### OrderService

Gets the [`IOrderService`](../iorderservice/)

```csharp
public IOrderService OrderService { get; }
```


---

#### OrderStatusService

Gets the [`IOrderStatusService`](../iorderstatusservice/)

```csharp
public IOrderStatusService OrderStatusService { get; }
```


---

#### PaymentMethodService

Gets the [`IPaymentMethodService`](../ipaymentmethodservice/)

```csharp
public IPaymentMethodService PaymentMethodService { get; }
```


---

#### PaymentProviderService

Gets the [`IPaymentProviderService`](../ipaymentproviderservice/)

```csharp
public IPaymentProviderService PaymentProviderService { get; }
```


---

#### PaymentService

Gets the [`IPaymentService`](../ipaymentservice/)

```csharp
public IPaymentService PaymentService { get; }
```


---

#### PrintTemplateService

Gets the [`IPrintTemplateService`](../iprinttemplateservice/)

```csharp
public IPrintTemplateService PrintTemplateService { get; }
```


---

#### ProductAttributeService

Gets the [`IProductAttributeService`](../iproductattributeservice/)

```csharp
public IProductAttributeService ProductAttributeService { get; }
```


---

#### ProductService

Gets the [`IProductService`](../iproductservice/)

```csharp
public IProductService ProductService { get; }
```


---

#### RegisteredCustomerInfoService

Gets the [`IRegisteredCustomerInfoService`](../iregisteredcustomerinfoservice/)

```csharp
public IRegisteredCustomerInfoService RegisteredCustomerInfoService { get; }
```


---

#### ShippingMethodService

Gets the [`IShippingMethodService`](../ishippingmethodservice/)

```csharp
public IShippingMethodService ShippingMethodService { get; }
```


---

#### StoreService

Gets the [`IStoreService`](../istoreservice/)

```csharp
public IStoreService StoreService { get; }
```


---

#### TagService

Gets the [`ITagService`](../itagservice/)

```csharp
public ITagService TagService { get; }
```


---

#### TaxService

Gets the [`ITaxService`](../itaxservice/)

```csharp
public ITaxService TaxService { get; }
```


---

#### TranslationService

Gets the [`ITranslationService`](../itranslationservice/)

```csharp
public ITranslationService TranslationService { get; }
```


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
