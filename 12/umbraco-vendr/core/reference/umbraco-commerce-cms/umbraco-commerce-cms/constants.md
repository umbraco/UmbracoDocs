---
title: Constants
description: API reference for Constants in Umbraco Commerce
---
## Constants

Umbraco Commerce constant variables

```csharp
public static class Constants
```

**Namespace**
* [Umbraco.Commerce.Cms](README.md)

### Classes

#### Constants.DistributedCache

Defines the alias identifiers for Umbraco Commerce's distributed cache control.

```csharp
public static class DistributedCache
```

##### Fields

#### CampaignCacheRefresherGuid

```csharp
public static readonly Guid CampaignCacheRefresherGuid;
```


---

#### CampaignCacheRefresherId

```csharp
public const string CampaignCacheRefresherId;
```


---

#### CountryCacheRefresherGuid

```csharp
public static readonly Guid CountryCacheRefresherGuid;
```


---

#### CountryCacheRefresherId

```csharp
public const string CountryCacheRefresherId;
```


---

#### CurrencyCacheRefresherGuid

```csharp
public static readonly Guid CurrencyCacheRefresherGuid;
```


---

#### CurrencyCacheRefresherId

```csharp
public const string CurrencyCacheRefresherId;
```


---

#### DiscountCacheRefresherGuid

```csharp
public static readonly Guid DiscountCacheRefresherGuid;
```


---

#### DiscountCacheRefresherId

```csharp
public const string DiscountCacheRefresherId;
```


---

#### EmailTemplateCacheRefresherGuid

```csharp
public static readonly Guid EmailTemplateCacheRefresherGuid;
```


---

#### EmailTemplateCacheRefresherId

```csharp
public const string EmailTemplateCacheRefresherId;
```


---

#### ExportTemplateCacheRefresherGuid

```csharp
public static readonly Guid ExportTemplateCacheRefresherGuid;
```


---

#### ExportTemplateCacheRefresherId

```csharp
public const string ExportTemplateCacheRefresherId;
```


---

#### GiftCardCacheRefresherGuid

```csharp
public static readonly Guid GiftCardCacheRefresherGuid;
```


---

#### GiftCardCacheRefresherId

```csharp
public const string GiftCardCacheRefresherId;
```


---

#### OrderCacheRefresherGuid

```csharp
public static readonly Guid OrderCacheRefresherGuid;
```


---

#### OrderCacheRefresherId

```csharp
public const string OrderCacheRefresherId;
```


---

#### OrderStatusCacheRefresherGuid

```csharp
public static readonly Guid OrderStatusCacheRefresherGuid;
```


---

#### OrderStatusCacheRefresherId

```csharp
public const string OrderStatusCacheRefresherId;
```


---

#### PaymentMethodCacheRefresherGuid

```csharp
public static readonly Guid PaymentMethodCacheRefresherGuid;
```


---

#### PaymentMethodCacheRefresherId

```csharp
public const string PaymentMethodCacheRefresherId;
```


---

#### PrintTemplateCacheRefresherGuid

```csharp
public static readonly Guid PrintTemplateCacheRefresherGuid;
```


---

#### PrintTemplateCacheRefresherId

```csharp
public const string PrintTemplateCacheRefresherId;
```


---

#### ProductAttributeCacheRefresherGuid

```csharp
public static readonly Guid ProductAttributeCacheRefresherGuid;
```


---

#### ProductAttributeCacheRefresherId

```csharp
public const string ProductAttributeCacheRefresherId;
```


---

#### ProductAttributePresetCacheRefresherGuid

```csharp
public static readonly Guid ProductAttributePresetCacheRefresherGuid;
```


---

#### ProductAttributePresetCacheRefresherId

```csharp
public const string ProductAttributePresetCacheRefresherId;
```


---

#### RegionCacheRefresherGuid

```csharp
public static readonly Guid RegionCacheRefresherGuid;
```


---

#### RegionCacheRefresherId

```csharp
public const string RegionCacheRefresherId;
```


---

#### ShippingMethodCacheRefresherGuid

```csharp
public static readonly Guid ShippingMethodCacheRefresherGuid;
```


---

#### ShippingMethodCacheRefresherId

```csharp
public const string ShippingMethodCacheRefresherId;
```


---

#### StockCacheRefresherGuid

```csharp
public static readonly Guid StockCacheRefresherGuid;
```


---

#### StockCacheRefresherId

```csharp
public const string StockCacheRefresherId;
```


---

#### StoreCacheRefresherGuid

```csharp
public static readonly Guid StoreCacheRefresherGuid;
```


---

#### StoreCacheRefresherId

```csharp
public const string StoreCacheRefresherId;
```


---

#### TaxClassCacheRefresherGuid

```csharp
public static readonly Guid TaxClassCacheRefresherGuid;
```


---

#### TaxClassCacheRefresherId

```csharp
public const string TaxClassCacheRefresherId;
```



---

#### Constants.Properties

Property constants

```csharp
public static class Properties
```

##### Fields

#### StorePropertyAlias

The property alias of the Store property

```csharp
public const string StorePropertyAlias;
```


##### Classes

#### Constants.Properties.Product

Product property constants

```csharp
public static class Product
```

##### Fields

#### IsGiftCardPropertyAlias

The property alias of the product Is Gift Card property

```csharp
public const string IsGiftCardPropertyAlias;
```


---

#### IsRecurringPropertyAlias

The property alias of the product Is Recurring property

```csharp
public const string IsRecurringPropertyAlias;
```


---

#### NamePropertyAlias

The property alias of the product Product Name property

```csharp
public const string NamePropertyAlias;
```

**Remarks**

If a productName property isn't present, the nodes Name will be used


---

#### PricePropertyAlias

The property alias of the product Price property

```csharp
public const string PricePropertyAlias;
```


---

#### ProductSourcePropertyAlias

The property alias of the linked product source node property

```csharp
public const string ProductSourcePropertyAlias;
```


---

#### SkuPropertyAlias

The property alias of the product SKU property

```csharp
public const string SkuPropertyAlias;
```


---

#### StockPropertyAlias

The property alias of the product Stock property

```csharp
public const string StockPropertyAlias;
```


---

#### TaxClassPropertyAlias

The property alias of the product Tax Class property

```csharp
public const string TaxClassPropertyAlias;
```


---

#### VariantsPropertyAlias

The property alias of the product Variants property

```csharp
public const string VariantsPropertyAlias;
```



---

#### Constants.Properties.ProductVariant

Product Variant property constants

```csharp
public static class ProductVariant
```

##### Fields

#### PriceAdjustmentPropertyAlias

The property alias of the product variant Price Adjustment property

```csharp
public const string PriceAdjustmentPropertyAlias;
```




---

#### Constants.PropertyEditors

Property Editor constants

```csharp
public static class PropertyEditors
```

##### Classes

#### Constants.PropertyEditors.Aliases

Defines Umbraco Commerce built-in property editor aliases.

```csharp
public static class Aliases
```

##### Fields

#### Price

Price.

```csharp
public const string Price;
```


---

#### Stock

Stock.

```csharp
public const string Stock;
```


---

#### StoreEntityPicker

Store Entity Picker.

```csharp
public const string StoreEntityPicker;
```


---

#### StorePicker

Store Picker.

```csharp
public const string StorePicker;
```


---

#### VariantsEditor

Variants Editor.

```csharp
public const string VariantsEditor;
```




---

#### Constants.Sections

Defines the alias identifiers for Umbraco Commerce's core sections.

```csharp
public static class Sections
```

##### Fields

#### Commerce

Application alias for the commerce section.

```csharp
public const string Commerce;
```



---

#### Constants.Trees

Defines the alias identifiers for Umbraco Commerce's core trees.

```csharp
public static class Trees
```

##### Classes

#### Constants.Trees.Settings

Defines the alias identifiers for Umbraco Commerce's core settings trees.

```csharp
public static class Settings
```

##### Fields

#### Alias

Tree alias for the store settings tree.

```csharp
public const string Alias;
```


---

#### Icons

Defines the maps of icons for Umbraco Commerce's core settings tree node types.

```csharp
public static readonly IReadOnlyDictionary<NodeType, string> Icons;
```


---

#### Ids

Defines the maps of fixed IDs for Umbraco Commerce's core settings tree node types.

```csharp
public static readonly IReadOnlyDictionary<NodeType, int> Ids;
```


##### Enumerations

#### Constants.Trees.Settings.NodeType

Defines the aliases for Umbraco Commerce's core settings tree node types.

```csharp
public enum NodeType
```

**Values**

| Name | Value | Description |
| --- | --- | --- |
| Settings | `0` | Alias for the settings node. |
| Stores | `1` | Alias for the stores node. |
| Store | `2` | Alias for a single store node. |
| OrderStatuses | `3` | Alias for the order statuses node. |
| OrderStatus | `4` | Alias for a single order status node. |
| ShippingMethods | `5` | Alias for the shipping methods node. |
| ShippingMethod | `6` | Alias for a single shipping method node. |
| PaymentMethods | `7` | Alias for the payment methods node. |
| PaymentMethod | `8` | Alias for a single payment method node. |
| Countries | `9` | Alias for the countries node. |
| Country | `10` | Alias for a single country node. |
| Region | `11` | Alias for a single region node. |
| Currencies | `12` | Alias for the currencies node. |
| Currency | `13` | Alias for a single currency node. |
| TaxClasses | `14` | Alias for the tax classes node. |
| TaxClass | `15` | Alias for a single tax class node. |
| Templating | `16` | Alias for the templating node. |
| EmailTemplates | `17` | Alias for the email templates node. |
| EmailTemplate | `18` | Alias for a single email template node. |
| PrintTemplates | `19` | Alias for the print templates node. |
| PrintTemplate | `20` | Alias for a single print template node. |
| ExportTemplates | `21` | Alias for the export templates node. |
| ExportTemplate | `22` | Alias for a single export template node. |


##### Classes

#### Constants.Trees.Settings.Groups

Defines the tree group alias identifiers for Umbraco Commerce's core settings trees.

```csharp
public static class Groups
```

##### Fields

#### Commerce

Alias for the commerce tree settings group.

```csharp
public const string Commerce;
```




---

#### Constants.Trees.Stores

Defines the alias identifiers for Umbraco Commerce's stores trees.

```csharp
public static class Stores
```

##### Fields

#### Alias

Tree alias for the commerce section.

```csharp
public const string Alias;
```


---

#### Icons

Defines the maps of icons for Umbraco Commerce's core tree node types.

```csharp
public static readonly IReadOnlyDictionary<NodeType, string> Icons;
```


---

#### Ids

Defines the maps of fixed IDs for Umbraco Commerce's core settings tree node types.

```csharp
public static readonly IReadOnlyDictionary<NodeType, int> Ids;
```


##### Enumerations

#### Constants.Trees.Stores.NodeType

Defines the aliases for Umbraco Commerce's core tree node types.

```csharp
public enum NodeType
```

**Values**

| Name | Value | Description |
| --- | --- | --- |
| Stores | `0` | Alias for the stores node. |
| Store | `1` | Alias for a single store node. |
| Orders | `2` | Alias for the orders node. |
| Order | `3` | Alias for a single order node. |
| Carts | `4` | Alias for the carts node. |
| Cart | `5` | Alias for a single cart node. |
| Discounts | `6` | Alias for the discounts node. |
| Discount | `7` | Alias for a single discount node. |
| GiftCards | `8` | Alias for the gift cards node. |
| GiftCard | `9` | Alias for a single gift card node. |
| Analytics | `10` | Alias for a analytics node. |
| Options | `11` | Alias for a options node. |
| ProductAttributes | `12` | Alias for a product attributes node. |
| ProductAttribute | `13` | Alias for a product attribute node. |
| ProductAttributePresets | `14` | Alias for a product attribute presets node. |
| ProductAttributePreset | `15` | Alias for a product attribute preset node. |




<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Cms.dll -->
