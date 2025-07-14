# Partial view cache refresher for members

This section describes the `IMemberPartialViewCacheInvalidator` interface, what it's default implementation does and how to customize it.

## What is an IMemberPartialViewCacheInvalidator?

This interface is used to isolate the logic that invalidates parts of the partial view cache when a member is updated.

## Why do we need to partially invalidate the partial view cache?

Razor templates showing data retrieved from a member object can be cached as partial views via:


## Where is it used?

This interface is called from the member cache refresher (`MemberCacheRefresher`) which is invoked every time a member is updated.

## Details of the default implementation

Razor template partials are cached through a call to `Html.CachedPartialAsync` with `cacheByMember` set to `true`. This will append the id of the currently logged in member with a marker to the partial view cache key.  For example, `-m1015-`. 

When the `ClearPartialViewCacheItems` method is called it will clear all cache items that match the marker for the updated members.

Since it is possible to call the `Html.CachedPartialAsync` with `cacheByMember` set to `true` while there is no member logged in, it will also clear all cache items with an empty member marker (i.e. `-m-`)

## Customizing the implementation

You can replace the default implementation by removing it and registering your own in a composer.

```csharp
public class ReplaceMemberCacheInvalidatorComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IMemberPartialViewCacheInvalidator, MyCustomMemberPartialViewCacheInvalidator>();
    }
}
```
