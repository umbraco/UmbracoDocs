---


---

# Circular Dependencies

In some cases you might experience that a circular dependency is preventing your Umbraco installing from starting up.

An example of this could be a circular dependency on `IUmbracoContextFactory`. This would happen if your service interacts with third-party code that also depends on an `IUmbracoContextFactory` instance.

In this situation, you can request a lazy version of the dependency so it won't evaluate during boot, only when accessed:

```csharp
public class SiteService : ISiteService
{
    private readonly Lazy<IUmbracoContextFactory> _umbracoContextFactory;
    public SiteService(Lazy<IUmbracoContextFactory> umbracoContextFactory)
    {
        _umbracoContextFactory = umbracoContextFactory;
    }
     public IPublishedContent GetNewsSection()
    {
         using (UmbracoContextReference umbracoContextReference = _umbracoContextFactory.Value.EnsureUmbracoContext())
         {
             // Do your thing
         }
    }
}
```
