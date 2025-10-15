---
description: Converting product sources into understandable products for Umbraco Commerce.
---

# Product Adapters

The role of a Product Adapter in Umbraco Commerce is to provide an interface between a product information source and convert it into a standardized format. This is done to prevent the need for Umbraco Commerce to be tied to that source.

What this means for developers is that Product Adapters allow you to hook in alternative product information sources that may not be Umbraco node based. You may hold your product information in a third-party database table. A custom Product Adapter would then allow Umbraco Commerce to interface with that custom data in the same way it would the default Umbraco node data.

## Example Product Adapter

An example of a Product Adapter would look something like this:

```csharp
public class MyCustomProductAdapter : IProductAdapter
{
    public IProductSnapshot GetProductSnapshot(string productReference, string languageIsoCode)
    {
        // Lookup a product by productReference and convert to IProductSnapshot
    }

    public IProductSnapshot GetProductSnapshot(string productReference, string productVariantReference, string languageIsoCode)
    {
        // Lookup a product by productVariantReference and convert to IProductSnapshot
    }

    public bool TryGetProductReference(Guid storeId, string sku, out string productReference, out string productVariantReference)
    {
        // Try lookup a product / variant reference by store + sku
    }
}

```

All Product Adapters implement the `IProductAdapter` interface which requires three method implementations:

* Two `GetProductSnapshot` methods that retrieve a Product Snapshot for either a product or product variant by reference parameters.
* A `TryGetProductReference` method which retrieves a product/variant reference for a product that belongs to a given `storeId` and has the given `sku`.

A Product Snapshot consists of the following properties in order to present a Product to Umbraco Commerce in a standard way.

```csharp
public interface IProductSnapshot
{
    // The unique reference for the product
    string ProductReference { get; }

    // The unique reference for the variant (if this is a variant snapshot)
    string ProductVariantReference { get; }

    // The unique SKU for this product/variant
    string Sku { get; }

    // The name of this product/variant
    string Name { get; }

    // The ID of the store this product/variant belongs to
    Guid StoreId { get; }

    // An optional Tax Class ID for this product/variant
    Guid? TaxClassId { get; }

    // Any properties exposed by this product/variant that should be copied to the orderline
    IDictionary<string, string> Properties { get; }

    // Any variant attributes for this product (if this is a variant snapshot)
    IEnumerable<AttributeCombination> Attributes { get; }

    // The available prices for this product/variant
    IEnumerable<ProductPrice> Prices { get; }

    // Flag indicating whether this product is a gift card product
    bool IsGiftCard { get; }
}

```

## Support editable carts

To allow Umbraco Commerce to search for products/variants to add to a cart via the backoffice, Product Adapters can implement 3 additional methods. This can also be done to support editable carts.

```csharp
public class MyCustomProductAdapter : ProductAdapterBase
{
    ... 

    public override PagedResult<IProductSummary> SearchProductSummaries(Guid storeId, string languageIsoCode, string searchTerm, long currentPage = 1, long itemsPerPage = 50)
    {
        // Search for products matching the given search term and convert to a IProductSummary
    }

    public override IEnumerable<Attribute> GetProductVariantAttributes(Guid storeId, string productReference, string languageIsoCode)
    {
        // Lookup the in-use product attributes of a primary product
    }

    public override PagedResult<IProductVariantSummary> SearchProductVariantSummaries(Guid storeId, string productReference, string languageIsoCode, string searchTerm, IDictionary<string, IEnumerable<string>> attributes, long currentPage = 1, long itemsPerPage = 50)
    {
        // Search for product variants matching the given search term and/or the given attributes and convert to a IProductVariantSummary
    }
}

```

The `IProductSummary`, `Attribute` and `IProductVariantSummary` consists of the following properties in order to present a Product to Umbraco Commerce in a standard way.

```csharp
public interface IProductSnapshot
{
    // The unique reference for the product
    string Reference { get; }

    // The unique SKU for this product 
    string Sku { get; }

    // The name of this product 
    string Name { get; }

    // The available prices for this product 
    IEnumerable<ProductPrice> Prices { get; }

    // Flag indicating whether this product has variants
    bool HasVariants { get; }
}

public class Attribute 
{
    // The alias of the attribute
    public string Alias { get; }

    // The name of the attribute
    public string Name { get; }

    // The attribute values
    IEnumerable<AttributeValue> Values { get; }
}

public class AttributeValue
{
    // The alias of the attribute value
    public string Alias { get; }

    // The name of the attribute value
    public string Name { get; }

}

public interface IProductVariantSnapshot
{
    // The unique reference for the product variant
    string Reference { get; }

    // The unique SKU for this product variant
    string Sku { get; }

    // The name of this product variant
    string Name { get; }

    // The available prices for this product variant
    IEnumerable<ProductPrice> Prices { get; }

    // The collection of attribute alias pairs of this product variant
    IReadOnlyDictionary<string, string> Attributes { get; }
}

```

## Registering a Product Adapter

typeProduct Adapters are [registered via the IUmbracoCommerceBuilder](umbraco-commerce-builder.md) interface using the `AddUnique<IProductAdapter, TReplacementAdapter>()` method on the `Services` property. The `TReplacementAdapter` parameter is the type of our custom Product Adapter implementation.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyServices(IUmbracoCommerceBuilder builder)
    {
        // Replacing the default Product Adapter implementation
        builder.Services.AddUnique<IProductAdapter, MyCustomProductAdapter>();

        // Return the builder to continue the chain
        return builder;
    }
}
```
