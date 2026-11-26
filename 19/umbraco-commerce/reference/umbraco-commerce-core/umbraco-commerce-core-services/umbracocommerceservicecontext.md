---
title: UmbracoCommerceServiceContext
description: API reference for UmbracoCommerceServiceContext in Umbraco Commerce
---
## UmbracoCommerceServiceContext

A central service context for easy access to all of Umbraco Commerce's services

```csharp
public class UmbracoCommerceServiceContext
```

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Constructors

#### UmbracoCommerceServiceContext

Instantiates a new UmbracoCommerceServiceContext instance

```csharp
public UmbracoCommerceServiceContext(Lazy<ICountryService> countryService, 
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
| registeredCustomerInfoService |  |
| tagService |  |


### Properties

#### ActivityLogService

Gets the [`IActivityLogService`](iactivitylogservice.md)

```csharp
public IActivityLogService ActivityLogService { get; }
```


---

#### AnalyticsService

Gets the [`IAnalyticsService`](ianalyticsservice.md)

```csharp
public IAnalyticsService AnalyticsService { get; }
```


---

#### CountryService

Gets the [`ICountryService`](icountryservice.md)

```csharp
public ICountryService CountryService { get; }
```


---

#### CurrencyService

Gets the [`ICurrencyService`](icurrencyservice.md)

```csharp
public ICurrencyService CurrencyService { get; }
```


---

#### DiscountService

Gets the [`IDiscountService`](idiscountservice.md)

```csharp
public IDiscountService DiscountService { get; }
```


---

#### EmailTemplateService

Gets the [`IEmailTemplateService`](iemailtemplateservice.md)

```csharp
public IEmailTemplateService EmailTemplateService { get; }
```


---

#### EntityService

Gets the [`IEntityService`](ientityservice.md)

```csharp
public IEntityService EntityService { get; }
```


---

#### ExportTemplateService

Gets the [`IExportTemplateService`](iexporttemplateservice.md)

```csharp
public IExportTemplateService ExportTemplateService { get; }
```


---

#### GiftCardService

Gets the [`IGiftCardService`](igiftcardservice.md)

```csharp
public IGiftCardService GiftCardService { get; }
```


---

#### OrderService

Gets the [`IOrderService`](iorderservice.md)

```csharp
public IOrderService OrderService { get; }
```


---

#### OrderStatusService

Gets the [`IOrderStatusService`](iorderstatusservice.md)

```csharp
public IOrderStatusService OrderStatusService { get; }
```


---

#### PaymentMethodService

Gets the [`IPaymentMethodService`](ipaymentmethodservice.md)

```csharp
public IPaymentMethodService PaymentMethodService { get; }
```


---

#### PaymentProviderService

Gets the [`IPaymentProviderService`](ipaymentproviderservice.md)

```csharp
public IPaymentProviderService PaymentProviderService { get; }
```


---

#### PaymentService

Gets the [`IPaymentService`](ipaymentservice.md)

```csharp
public IPaymentService PaymentService { get; }
```


---

#### PrintTemplateService

Gets the [`IPrintTemplateService`](iprinttemplateservice.md)

```csharp
public IPrintTemplateService PrintTemplateService { get; }
```


---

#### ProductAttributeService

Gets the [`IProductAttributeService`](iproductattributeservice.md)

```csharp
public IProductAttributeService ProductAttributeService { get; }
```


---

#### ProductService

Gets the [`IProductService`](iproductservice.md)

```csharp
public IProductService ProductService { get; }
```


---

#### RegisteredCustomerInfoService

Gets the [`IRegisteredCustomerInfoService`](iregisteredcustomerinfoservice.md)

```csharp
public IRegisteredCustomerInfoService RegisteredCustomerInfoService { get; }
```


---

#### ShippingMethodService

Gets the [`IShippingMethodService`](ishippingmethodservice.md)

```csharp
public IShippingMethodService ShippingMethodService { get; }
```


---

#### StoreService

Gets the [`IStoreService`](istoreservice.md)

```csharp
public IStoreService StoreService { get; }
```


---

#### TagService

Gets the [`ITagService`](itagservice.md)

```csharp
public ITagService TagService { get; }
```


---

#### TaxService

Gets the [`ITaxService`](itaxservice.md)

```csharp
public ITaxService TaxService { get; }
```


---

#### TranslationService

Gets the [`ITranslationService`](itranslationservice.md)

```csharp
public ITranslationService TranslationService { get; }
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
