# ICacheRefresher

This section describes what IMemberPartialViewCacheInvalidator is, what it's default implementation does and how to customize it.

## What is an IMemberPartialViewCacheInvalidator

This interface is used to isolate the logic that needs to run to invalidate parts of the PartialView cache when a member is updated

## Why do we need to partialy invalidate the partialView cache

Razor templates may show data that is retrieved from a member object. Those templates might be cached by using the partial caching mechanism (for example, `@await Html.CachedPartialAsync("member",Model,TimeSpan.FromDays(1), cacheByMember:true)`). When a member is updated, these cached partials must be invalidated to ensure updated data is shown.

## Where is it used

This interface is called from the MemberCacheRefresher which is called every time a member is updated.

## Details of the implementation

When a razor template partial is cached trough `Html.CachedPartialAsync` and `cacheByMember` is set to `true`, the extension method will append the memberId of the currently logged in member and a marker (i.e. `-m1015-`) to the partialView chachekey.
When the `ClearPartialViewCacheItems` method is called it will clear all PartialView cacheItems that have the memberId marker for all passed in members.
Since it is possible to call the `Html.CachedPartialAsync` with `cacheByMember` set to `true` while there is no member logged in, it will also clear all cache items with an empty member marker (i.e. `-m-`)

## Customizing the implementation

You can replace the default implementation like usual by removing the default and registering your own in a composer.

```csharp
public class ReplaceMemberCacheInvalidatorComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IMemberPartialViewCacheInvalidator, MyCustomMemberPartialViewCacheInvalidator>();
    }
}
```
