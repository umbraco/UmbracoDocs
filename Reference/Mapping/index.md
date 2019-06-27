---
versionFrom: 8.1.0
---

# UmbracoMapper

:::tip
UmbracoMapper replaced AutoMapper which was an external dependency. AutoMapper builds the mapping code dynamically, based upon mapping profiles, which are defined as C# expressions. UmbracoMapper relies on static code, i.e. mappings need to be hand-written.

This is not to be confused with the [package by Andy Butland](https://our.umbraco.com/packages/developer-tools/umbraco-mapper)
:::

## Accessing the UmbracoMapper

The UmbracoMapper is registered with Dependency Imjection (DI). It can therefore be injected in constructors, wherever DI is used. Alternatively, it is also exposed via `Current.Mapper`.

## Mapping

Mapping with the UmbracoMapper works in ways very similar to AutoMapper:

```cs
// assuming source is ISource, create a new target instance
var target = umbracoMapper.Map<ITarget>(source);

// assuming both source and target already exists
target = umbracoMapper.Map<source, target);
```

The UmbracoMapper class also defines explicit methods to map enumerables:

```cs
// assuming sources is IEnumerable<ISource>, map to IEnumerable<ITarget>
var targets = umbracoMapper.MapEnumerable<ISource, ITarget>(sources);
```

Explicit mapping of enumerables enumerates the source items, and map each item individually.

It can also implicitly map enumerables. The following code is also valid:

```cs
// assuming sources is IEnumerable<ISource>, map to IEnumerable<ITarget>
var targets = umbracoMapper.Map<IEnumerable<ITarget>>(sources);
```

If a mapping has been defined from `IEnumerable<ISource>` to `IEnumerable<ITarget>`, then it will be used. Otherwise, the UmbracoMapper will look for a mapping from the source type to the target type, pretty much like the explicit method.

## Defining mappings

Mappings are defined in `IMapDefinition` instances. This interface defines one method:

```cs
void DefineMaps(UmbracoMapper mapper);
```

Mappings are registered (and must be registered) via a [collection builder](../../Implementation/Composing/index.md#Collections):

```cs
composition.WithCollectionBuilder<MapDefinitionCollectionBuilder>()
    .Add<MyMapDefinition>();
```

A definition provides a constructor, and a map:

```cs
public void DefineMaps(UmbracoMapper mapper)
{
    mapper.Define<ISource, ITarget>(
        (source, context) => { ... },           // constructor
        (source, target, context) => { .... }   // map
    );
}
```

The constructor function is used to create an instance of the target class. The most basic implementation would be:

```cs
(source, context) => new TargetClass(),
```

The mapping action is used to map an instance of the source class, to an instance of the target class. The most basic implementation would be:

```cs
(source, target, context) =>    
{
    target.MyProperty1 = source.MyProperty1;
    target.MyProperty2 = source.MyProperty2;
    ...
}
```

The constructor function is used whenever the mapper is asked to create a target instance. Then, the mapping action is used.

In other words, `umbracoMapper.Map<ITarget>(source)` will first run the construction function, and then the mapping action.
On the other hand, `umbracoMapper.Map(source, target)` where target already exists, would only run the mapping action.

The UmbracoMapper class provides various overloads of the Define method:

- An overload accepting a constructor function and a mapping action, as presented above.
- An overload accepting a mapping action only, which tells the mapper how to map to an existing target (but the mapper will not be able to create new target instances).
- An overload accepting a construction function, which tells the mapper how to create new target instances (but the mapper will not perform any additional mapping).
- A parameter-less overload, which defines a "no-operation" mapping (the mapper cannot create new target instance, and mapping does nothing).

## Context

Both constructor functions and map actions presented above expose a context parameter which is an instance of MapperContext and provides two types of services:

- An `Items` dictionary which can store any type of object, using string keys, and can be used to carry some context along mappings;
- Some Map and MapEnumerable functions that can be used in mapping functions, to recursively map nested elements, while propagating the context.

:::note
The context provides a `HasItem` property. To check whether the context has items, without allocating an extra empty dictionary, use this property.
:::

The context is used, for instance, to carry the culture when mapping content items with variants. See the `MapperContextExtensions` class, which contains methods such as:

```cs
public static void SetCulture(this MapperContext context, string culture)
{
    context.Items[CultureKey] = culture;
}
```

And

```cs
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

```cs
var target = umbracoMapper.Map<ITarget>(source, context =>
    {
        context.SetCulture(cultureName);
    });
```

## Umbraco.Code

Umbraco.Code is an assembly which should contain various coding utilities for Umbraco. At the moment, it contains only one Roslyn analyzer, the `MapAllAnalyzer`, which is used to help writing mapping methods.

The code lives in the [Umbraco.Code repository](https://github.com/umbraco/Umbraco-Code) and the tool is available via [Nuget](https://www.nuget.org/packages/Umbraco.Code/). It is included as a development dependency in Umbraco.

The analyzer examines every method mapping from a source to a target, and being marked with the `// Umbraco.Code.MapAll` comment block:

```cs
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

Since, contrary to AutoMapper, mapping is not implicit nor automatic, this ensures that, should a new property be added to ISource, an error would be raised until the corresponding mappings are updated.

It is possible to exclude some properties from the check:

```cs
// Umbraco.Code.MapAll -Property2
```

And the comment can be repeated if the list of excluded properties is long:

```cs
// Umbraco.Code.MapAll -Property2 -Property3 -Property4
// Umbraco.Code.MapAll -Property5 -Property6 -Property7
```

The analyzer follows the standard analyzer development patterns, and simply building the code in Release mode produces the appropriate NuGet package.
