# Partial view cache refresher for members

This section describes the `IMemberPartialViewCacheInvalidator` interface, what it's default implementation does and how to customize it.

## What is an IMemberPartialViewCacheInvalidator?

This interface is used to isolate the logic that invalidates parts of the partial view cache when a member is updated.

## Why do we need to partially invalidate the partial view cache?

Razor templates may show data that is retrieved from a member object. Those templates might be cached by using the partial caching mechanism (for example, `@await Html.CachedPartialAsync("member",Model,TimeSpan.FromDays(1), cacheByMember:true)`). When a member is updated, these cached partials must be invalidated to ensure updated data is shown.

## Where is it used?

This interface is called from the member cache refresher (`MemberCacheRefresher`), which is invoked every time a member is updated.

## Details of the default implementation

Razor template partials are cached through a call to `Html.CachedPartialAsync` with `cacheByMember` set to `true`. This will append the ID of the currently logged-in member with a marker to the partial view cache key.  For example, `-m1015-`.

When the `ClearPartialViewCacheItems` method is called it will clear all cache items that match the marker for the updated members.

If no member is logged in during caching, items with an empty member marker (for example, `-m-`) are also cleared.

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
