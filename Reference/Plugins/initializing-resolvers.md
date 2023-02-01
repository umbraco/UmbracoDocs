---
versionFrom: 7.0.0
meta.RedirectLink: "/umbraco-cms/reference/plugins/creating-resolvers"
---

# Initializing Resolvers

**Applies to: Umbraco 4.10.0+**

_All resolvers need to be initialized, this occurs in an IBootManager_

## Initializing the singleton

An `IBootManager` is a bootstrapper that initializing all required objects during application startup, this includes initializing all resolvers.

For example to initialize the custom resolvers we've made in the previous steps we would do the following:

```csharp
// initialize the singleton with a DefaultErrorLogger
ErrorLoggerResolver.Current = new ErrorLoggerResolver(new DefaultErrorLogger());

// initialize the language converters singleton with
// our default language converter types
LanguageConvertersResolver.Current = new LanguageConvertersResolver(
    new Type[] {
        typeof(EnglishLanguageConverter),
        typeof(SpanishLanguageConverter)
    });
```

## Initialization with type finding

Instead of initializing multiple object resolvers with an array of known types, we can initialize them with types found in the current application pool if this is the desired behavior. This is possible to do once we've created an extension method for the PluginManager to find the specified type. This example initializes the ActionsResolver:

```csharp
ActionsResolver.Current = new ActionsResolver(
    PluginManager.Current.ResolveActions());
```
