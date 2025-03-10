# UmbracoMapper

Often in code there is a need to 'map' one object's properties to another type of object. The 'type of objects' are not related by inheritance or interface. (Think database layer object, passing information to a presentation layer ViewModel etc). In these circumstances, it can save time and provide consistency to consolidate the logic to map between the options into one set of 'Mapping' rules.

{% hint style="info" %}
UmbracoMapper replaced AutoMapper which was an external dependency. AutoMapper builds the mapping code dynamically, based upon mapping profiles, which are defined as C# expressions. UmbracoMapper relies on static code, that is, mappings need to be hand-written.

If you need to map `IPublishedContent`, you might need a **custom implementation** or a **third-party solution like** [**Andy Butland’s Umbraco Mapper**](https://our.umbraco.com/packages/developer-tools/umbraco-mapper) **(**&#x77;hich has been renamed to [Anaximapper](https://www.andybutland.dev/2022/08/a-quick-post-on-view-model-mapping.html)) rather than relying on Umbraco's `IUmbracoMapper.`
{% endhint %}

## Accessing the IUmbracoMapper

The IUmbracoMapper is registered with Dependency Injection (DI). It can therefore be injected into constructors of controllers, custom classes etc, wherever DI is used.

## Mapping

Mapping with the UmbracoMapper works in ways similar to AutoMapper:

```csharp
// assuming source is ISource, create a new target instance
var target = umbracoMapper.Map<ITarget>(source);

// assuming both source and target already exists
target = umbracoMapper.Map(source, target);
```

The UmbracoMapper class also defines explicit methods to map enumerables:

```csharp
// assuming sources is IEnumerable<ISource>, map to IEnumerable<ITarget>
var targets = umbracoMapper.MapEnumerable<ISource, ITarget>(sources);
```

Explicit mapping of enumerables enumerates the source items, and map each item individually.

It can also implicitly map enumerables. The following code is also valid:

```csharp
// assuming sources is IEnumerable<ISource>, map to IEnumerable<ITarget>
var targets = umbracoMapper.Map<IEnumerable<ITarget>>(sources);
```

If a mapping has been defined from `IEnumerable<ISource>` to `IEnumerable<ITarget>`, then it will be used. Otherwise, the UmbracoMapper will look for a mapping from the source type to the target type, pretty much like the explicit method.

## Defining mappings

Mappings are defined in `IMapDefinition` instances. This interface defines one method:

```csharp
void DefineMaps(IUmbracoMapper mapper);
```

Mappings are registered (and must be registered) via a [collection builder](../implementation/composing.md#collections):

```csharp
builder.WithCollectionBuilder<MapDefinitionCollectionBuilder>()
    .Add<MyMapDefinition>();
```

A definition provides a constructor, and a map:

```csharp
public void DefineMaps(IUmbracoMapper mapper)
{
    mapper.Define<ISource, ITarget>(
        (source, context) => { ... },           // constructor
        (source, target, context) => { .... }   // map
    );
}
```

The constructor function is used to create an instance of the target class. The most basic implementation would be:

```csharp
(source, context) => new TargetClass(),
```

The mapping action is used to map an instance of the source class, to an instance of the target class. The most basic implementation would be:

```csharp
(source, target, context) =>
{
    target.MyProperty1 = source.MyProperty1;
    target.MyProperty2 = source.MyProperty2;
    ...
}
```

The constructor function is used whenever the mapper is asked to create a target instance. Then, the mapping action is used.

In other words, `umbracoMapper.Map<ITarget>(source)` will first run the construction function, and then the mapping action. On the other hand, `umbracoMapper.Map(source, target)` where target already exists, would only run the mapping action.

The UmbracoMapper class provides multiple overloads of the Define method:

* An overload accepting a constructor function and a mapping action, as presented above.
* An overload accepting a mapping action only, which tells the mapper how to map to an existing target (but the mapper will not be able to create new target instances).
* An overload accepting a construction function, which tells the mapper how to create new target instances (but the mapper will not perform any additional mapping).
* A parameter-less overload, which defines a "no-operation" mapping (the mapper cannot create new target instance, and mapping does nothing).

## Context

Both constructor functions and map actions presented above expose a context parameter which is an instance of MapperContext and provides two types of services:

* An `Items` dictionary which can store any type of object, using string keys, and can be used to carry some context along mappings;
* Some Map and MapEnumerable functions that can be used in mapping functions, to recursively map nested elements, while propagating the context.

{% hint style="info" %}
The context provides a `HasItem` property. To check whether the context has items, without allocating an extra empty dictionary, use this property.
{% endhint %}

The context is used, for instance, to carry the culture when mapping content items with variants. See the `MapperContextExtensions` class, which contains methods such as:

```csharp
public static void SetCulture(this MapperContext context, string culture)
{
    context.Items[CultureKey] = culture;
}
```

And

```csharp
public static string GetCulture(this MapperContext context)
{
    return context.HasItems &&
            context.Items.TryGetValue(CultureKey, out var obj) &&
            obj is string s
        ? s
        : null;
}
```

Every `Map` and `MapEnumerable` method exposed by the UmbracoMapper have overloads that can manipulate the context before executing the mapping. For instance,

```csharp
var target = umbracoMapper.Map<ITarget>(source, context =>
    {
        context.SetCulture(cultureName);
    });
```

## Umbraco.Code

Umbraco.Code is an assembly which should contain coding utilities for Umbraco. At the moment, it contains only one Roslyn analyzer, the `MapAllAnalyzer`, which is used to help writing mapping methods.

The code lives in the [Umbraco.Code repository](https://github.com/umbraco/Umbraco-Code) and the tool is available via [Nuget](https://www.nuget.org/packages/Umbraco.Code/). It is included as a development dependency in Umbraco.

The analyzer examines every method mapping from a source to a target, and being marked with the `// Umbraco.Code.MapAll` comment block:

```csharp
mapper.Define<ISource, ITarget>(
        (source, context) => new Target(),  // constructor
        Map                                 // map
    );

// Umbraco.Code.MapAll
private static void Map(ISource source,
                        ITarget target,
                        MapperContext context)
{
    target.Property1 = source.Property1;
    target.Property2 = source.Property2;
}
```

The analyzer verifies that every publicly settable property of target is assigned a value. If a property is not assigned a value, the tool raises a build error (ie. the code will not compile).

Since, contrary to AutoMapper, mapping is not implicit nor automatic, this ensures that an error would be raised. Should a new property be added to ISource, the corresponding mappings must be updated.

It is possible to exclude some properties from the check:

```csharp
// Umbraco.Code.MapAll -Property2
```

And the comment can be repeated if the list of excluded properties is long:

```csharp
// Umbraco.Code.MapAll -Property2 -Property3 -Property4
// Umbraco.Code.MapAll -Property5 -Property6 -Property7
```

The analyzer follows the standard analyzer development patterns, and building the code in Release mode produces the appropriate NuGet package.

## Full example

Below you will find a full example showing you how to map a collection of type Product to a collection of type ProductDto.

```csharp
#region Models

public class Product
{
    public string Name { get; set; }
    public string SuperSecretThingNotForPublicDisplay { get; set; }
}

[DataContract(Name = "product")]
public class ProductDto
{
    [DataMember(Name = "name")]
    public string Name { get; set; }
}

#endregion

#region Mapping

public class ProductMappingDefinition : IMapDefinition
{
    public void DefineMaps(IUmbracoMapper mapper)
    {
        mapper.Define<Product, ProductDto>((source, context) => new ProductDto(), Map);
    }

    private void Map(Product source, ProductDto target, MapperContext context)
    {
        target.Name = source.Name;
    }
}

#endregion

#region Composing

public class ProductComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.WithCollectionBuilder<MapDefinitionCollectionBuilder>()
            .Add<ProductMappingDefinition>();
    }
}

#endregion

[ApiController]
[Route("/umbraco/api/products")]
public class ProductsController : Controller
{
    private readonly IUmbracoMapper _mapper;

    public ProductsController(IUmbracoMapper mapper) => _mapper = mapper;

    [HttpGet("getall")]
    public IActionResult GetAll()
    {
        var products = FakeServiceCall();
        var mapped = _mapper.MapEnumerable<Product, ProductDto>(products);

        return Ok(mapped);
    }

    [HttpGet("getfirstproduct")]
    public IActionResult GetFirstProduct()
    {
        var product = FakeServiceCall().First();
        var mapped = _mapper.Map<ProductDto>(product);

        return Ok(mapped);
    }

    private IEnumerable<Product> FakeServiceCall()
    {
        return new List<Product>()
        {
            new Product()
            {
                Name = "Umbraco Cloud",
                SuperSecretThingNotForPublicDisplay = "Secret"
            },
            new Product()
            {
                Name = "Umbraco Forms",
                SuperSecretThingNotForPublicDisplay = "Also secret"
            }
        };
    }
}
```

Result from `/umbraco/api/products/getall`:

```json
[
    {
        "name": "Umbraco Cloud"
    },
    {
        "name": "Umbraco Forms"
    }
]
```

Result from `/umbraco/api/products/getfirstproduct`:

```json
{
    "name": "Umbraco Cloud"
}
```
