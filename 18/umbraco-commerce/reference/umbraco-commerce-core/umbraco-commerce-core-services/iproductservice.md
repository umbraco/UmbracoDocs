---
title: IProductService
description: API reference for IProductService in Umbraco Commerce
---
## IProductService

Defines the Product service

```csharp
public interface IProductService
```

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### GetProduct (1 of 2)

Get a [`IProductSnapshot`](../umbraco-commerce-core-models/iproductsnapshot.md) of a given product

```csharp
public IProductSnapshot GetProduct(Guid storeId, string productReference, string languageIsoCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product to snapshot |
| languageIsoCode | The ISO Code of the language of the snapshot to create |

**Returns**

An [`IProductSnapshot`](../umbraco-commerce-core-models/iproductsnapshot.md) of the given product

---

#### GetProduct (2 of 2)

Get a [`IProductSnapshot`](../umbraco-commerce-core-models/iproductsnapshot.md) of a given product

```csharp
public IProductSnapshot GetProduct(Guid storeId, string productReference, 
    string productVariantReference, string languageIsoCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product to snapshot |
| productVariantReference | The unique reference of the variant of the product to snapshot |
| languageIsoCode | The ISO Code of the language of the snapshot to create |

**Returns**

An [`IProductSnapshot`](../umbraco-commerce-core-models/iproductsnapshot.md) of the given product


---

#### GetProductStock (1 of 2)

Gets the stock level of a given product

```csharp
public decimal? GetProductStock(Guid storeId, string productReference)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |

**Returns**

The stock level of the product

---

#### GetProductStock (2 of 2)

Gets the stock level of a given product

```csharp
public decimal? GetProductStock(Guid storeId, string productReference, 
    string productVariantReference)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| productVariantReference | The unique reference of the variant of the product who's stock level to retrieve |

**Returns**

The stock level of the product


---

#### GetProductVariantAttributes

Gets a list of attributes in use by the product variants of the given primary product.

```csharp
public IEnumerable<Attribute> GetProductVariantAttributes(Guid storeId, string productReference, 
    string languageIsoCode)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store this product belongs to |
| productReference | The product reference of the product |
| languageIsoCode | The language ISO code of the culture |


---

#### IncreaseProductStock (1 of 2)

Increases the stock level of a given product

```csharp
public void IncreaseProductStock(Guid storeId, string productReference, decimal increaseBy)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to increase |
| increaseBy | The amount to increase the stock level by |

---

#### IncreaseProductStock (2 of 2)

Increases the stock level of a given product

```csharp
public void IncreaseProductStock(Guid storeId, string productReference, 
    string productVariantReference, decimal increaseBy)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to increase |
| productVariantReference | The unique reference of variant of the product who's stock level to increase |
| increaseBy | The amount to increase the stock level by |


---

#### ReduceProductStock (1 of 2)

Reduces the stock level of a given product

```csharp
public void ReduceProductStock(Guid storeId, string productReference, decimal reduceBy)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to reduce |
| reduceBy | The amount to reduce the stock level by |

---

#### ReduceProductStock (2 of 2)

Reduces the stock level of a given product

```csharp
public void ReduceProductStock(Guid storeId, string productReference, 
    string productVariantReference, decimal reduceBy)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to reduce |
| productVariantReference | The unique reference of the variant of the product who's stock level to reduce |
| reduceBy | The amount to reduce the stock level by |


---

#### SearchProductSummaries

Searches for product summaries matching the given search term.

```csharp
public PagedResult<IProductSummary> SearchProductSummaries(Guid storeId, string languageIsoCode, 
    string searchTerm, long currentPage = 1, long itemsPerPage = 50)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The id of the store to search in |
| languageIsoCode | The language ISO code of the culture |
| searchTerm | The term to search for |
| currentPage | The current page of items to return |
| itemsPerPage | The number of items per page to return |

**Returns**

A paged collection of product summaries


---

#### SearchProductVariantSummaries

Searches for the product variant summaries of a primary product matching the given search term / attributes.

```csharp
public PagedResult<IProductVariantSummary> SearchProductVariantSummaries(Guid storeId, 
    string productReference, string languageIsoCode, string searchTerm, 
    IDictionary<string, IEnumerable<string>> attributes, long currentPage = 1, 
    long itemsPerPage = 50)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store this product belongs to |
| productReference | The product reference of the product |
| languageIsoCode | The language ISO code of the culture |
| searchTerm | The term to search for |
| attributes | The attributes of the product variant |
| currentPage | The current page of items to return |
| itemsPerPage | The number of items per page to return |


---

#### SetProductStock (1 of 2)

Sets the stock level of a given product

```csharp
public void SetProductStock(Guid storeId, string productReference, decimal value)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to set |
| value | The value to set the stock level to |

---

#### SetProductStock (2 of 2)

Sets the stock level of a given product

```csharp
public void SetProductStock(Guid storeId, string productReference, string productVariantReference, 
    decimal value)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to set |
| productVariantReference | The unique reference of the variant of the product who's stock level to set |
| value | The value to set the stock level to |


---

#### TryGetProductStock (1 of 2)

Try to get the stock level of a given product

```csharp
public bool TryGetProductStock(Guid storeId, string productReference, out decimal? stock)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| stock | The output stock level of the product |

**Returns**

True if the stock level was retrieved, false if not

---

#### TryGetProductStock (2 of 2)

Try to get the stock level of a given product

```csharp
public bool TryGetProductStock(Guid storeId, string productReference, 
    string productVariantReference, out decimal? stock)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| productVariantReference | The unique reference of the variant of the product who's stock level to retrieve |
| stock | The output stock level of the product |

**Returns**

True if the stock level was retrieved, false if not


---

#### TryIncreaseProductStock (1 of 2)

Try to increase the stock level of a given product

```csharp
public bool TryIncreaseProductStock(Guid storeId, string productReference, decimal increaseBy)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| increaseBy | The amount to increase the stock level by |

**Returns**

True if the stock level was increased, false if not

---

#### TryIncreaseProductStock (2 of 2)

Try to increase the stock level of a given product

```csharp
public bool TryIncreaseProductStock(Guid storeId, string productReference, 
    string productVariantReference, decimal increaseBy)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| productVariantReference | The unique reference of variant of the product who's stock level to increase |
| increaseBy | The amount to increase the stock level by |

**Returns**

True if the stock level was increased, false if not


---

#### TryReduceProductStock (1 of 2)

Try to reduce the stock level of a given product

```csharp
public bool TryReduceProductStock(Guid storeId, string productReference, decimal reduceBy)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| reduceBy | The amount to reduce the stock level by |

**Returns**

True if the stock level was reduced, false if not

---

#### TryReduceProductStock (2 of 2)

Try to reduce the stock level of a given product

```csharp
public bool TryReduceProductStock(Guid storeId, string productReference, 
    string productVariantReference, decimal reduceBy)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| productVariantReference | The unique reference of the variant of the product who's stock level to reduce |
| reduceBy | The amount to reduce the stock level by |

**Returns**

True if the stock level was reduced, false if not


---

#### TrySetProductStock (1 of 2)

Try to set the stock level of a given product

```csharp
public bool TrySetProductStock(Guid storeId, string productReference, decimal value)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| value | The value to set the stock level to |

**Returns**

True if the stock level was set, false if not

---

#### TrySetProductStock (2 of 2)

Try to set the stock level of a given product

```csharp
public bool TrySetProductStock(Guid storeId, string productReference, 
    string productVariantReference, decimal value)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the store the product belongs to |
| productReference | The unique reference of the product who's stock level to retrieve |
| productVariantReference | The unique reference of the variant of the product who's stock level to set |
| value | The value to set the stock level to |

**Returns**

True if the stock level was set, false if not


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
