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
* [Umbraco.Commerce.Core](README.md)

### Fields

#### DefaultMonetaryPrecision

The default precision of monetary values

```csharp
public static int DefaultMonetaryPrecision;
```


---

#### InstanceId

Defines a unique instance ID for this instance of Umbraco Commerce.

```csharp
public static string InstanceId;
```


### Classes

#### Constants.Entities

Entity related constants

```csharp
public static class Entities
```

##### Classes

#### Constants.Entities.EntityTypes

Entity type constants

```csharp
public static class EntityTypes
```

##### Fields

#### Cart

Cart entity type

```csharp
public const string Cart;
```


---

#### Country

Country entity type

```csharp
public const string Country;
```


---

#### Currency

Currency entity type

```csharp
public const string Currency;
```


---

#### Discount

Discount entity type

```csharp
public const string Discount;
```


---

#### EmailTemplate

Email Template entity type

```csharp
public const string EmailTemplate;
```


---

#### ExportTemplate

Export Template entity type

```csharp
public const string ExportTemplate;
```


---

#### GiftCard

Gift Card entity type

```csharp
public const string GiftCard;
```


---

#### Order

Order entity type

```csharp
public const string Order;
```


---

#### OrderStatus

Order Status entity type

```csharp
public const string OrderStatus;
```


---

#### PaymentMethod

Payment Method entity type

```csharp
public const string PaymentMethod;
```


---

#### PrintTemplate

Print Template entity type

```csharp
public const string PrintTemplate;
```


---

#### ProductAttribute

Product Attribute entity type

```csharp
public const string ProductAttribute;
```


---

#### ProductAttributePreset

Product Attribute Preset entity type

```csharp
public const string ProductAttributePreset;
```


---

#### ProductAttributeValue

Product Attribute Value entity type

```csharp
public const string ProductAttributeValue;
```


---

#### Region

Region entity type

```csharp
public const string Region;
```


---

#### ShippingMethod

Shipping Method entity type

```csharp
public const string ShippingMethod;
```


---

#### Store

Store entity type

```csharp
public const string Store;
```


---

#### TaxClass

Tax Class entity type

```csharp
public const string TaxClass;
```




---

#### Constants.PaymentProviders

Payment provider related constants

```csharp
public static class PaymentProviders
```

##### Classes

#### Constants.PaymentProviders.Aliases

Payment provider aliases

```csharp
public static class Aliases
```

##### Fields

#### Invoicing

The invoicing payment provider alias

```csharp
public const string Invoicing;
```


---

#### ZeroValue

The zero value payment provider alias

```csharp
public const string ZeroValue;
```




---

#### Constants.Properties

Property constants

```csharp
public static class Properties
```

##### Classes

#### Constants.Properties.Customer

Customer property constants

```csharp
public static class Customer
```

##### Fields

#### EmailPropertyAlias

The property alias of the customer Email property

```csharp
public const string EmailPropertyAlias;
```


---

#### FirstNamePropertyAlias

The property alias of the customer First Name property

```csharp
public const string FirstNamePropertyAlias;
```


---

#### LastNamePropertyAlias

The property alias of the customer Last Name property

```csharp
public const string LastNamePropertyAlias;
```



---

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

#### Constants.System

System constants

```csharp
public static class System
```

##### Fields

#### ConnectionStringName

The connection string name for the Umbraco Commerce database

```csharp
public const string ConnectionStringName;
```


---

#### MigrationPlanName

The Umbraco Commerce migration plan name

```csharp
public const string MigrationPlanName;
```


---

#### ProductAlias

The UmbracoCommerce product alias

```csharp
public const string ProductAlias;
```


---

#### ProductId

The Umbraco Commerce product ID

```csharp
public const string ProductId;
```


---

#### ProductName

The Umbraco Commerce product name

```csharp
public const string ProductName;
```


##### Classes

#### Constants.System.Messages

System message constants

```csharp
public static class Messages
```

##### Fields

#### ScaffoldToWritableExceptionMessage

Exception message to display if a scaffold entity is attempted to be made writable

```csharp
public const string ScaffoldToWritableExceptionMessage;
```




<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
