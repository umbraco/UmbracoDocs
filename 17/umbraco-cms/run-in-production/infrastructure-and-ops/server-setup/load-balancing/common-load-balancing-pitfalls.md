---
description: >-
  Common load-balancing pitfalls and anti-patterns to avoid in your code, so
  your Umbraco site behaves correctly when it runs across multiple servers.
---

# Common Load-Balancing Pitfalls & Anti-Patterns

Most of the code you write for an Umbraco site behaves the same whether the site runs on one server or many. A handful of patterns work on a single server but fall apart when the site is load balanced. Once you know what to look for, you can avoid the patterns. This article shows you how.

This article focuses on what *your code* needs to do. For how to set up and configure a load-balanced environment, start with [Umbraco in Load Balanced Environments](README.md).

{% hint style="info" %}
On **Umbraco Cloud**, the surrounding setup is wired up for you when you enable Load Balancing. The setup covers distributed cache, session storage, forwarded headers, and server roles. The application patterns below still apply to your own code. You can focus on writing the code well rather than configuring the plumbing.
{% endhint %}

## Write for round robin, not for sticky sessions

Nearly every load-balancing surprise comes down to a single habit. You write code that assumes there's only ever one server. You also assume that whatever you put in memory or on disk stays there until next time you look. Once your code runs across multiple servers, neither assumption holds.

To stay on the right side of the habit, **write your code as if every request could land on a different server**. In other words, assume a plain round-robin setup with no session affinity. The assumption is the safest one you can make. Code that works under round robin also works with sticky sessions. Code that depends on sticky sessions breaks the moment a request lands somewhere else. And requests will land elsewhere: servers recycle, deployments happen, and the load balancer moves traffic between servers. Treat sticky sessions as a performance optimization you switch on later. Never treat sticky sessions as something your code leans on to be correct.

The rest of the article applies the principle to the places where the problem bites most often.

## Don't rely on the local filesystem

Every server has its own disk. `App_Data`, `wwwroot`, and any custom folders you create live on one server only. If you write a file on one request, the next request might land on a different server. The file you wrote will not be there.

```csharp
// Don't: writes to one server's disk, invisible to the others
System.IO.File.WriteAllText("App_Data/export.csv", data);

// Do: route through IFileSystem so it lands in shared storage
mediaFileManager.FileSystem.AddFile("export.csv", stream);
```

What to do instead:

* Save and read media through `IFileSystem` or `MediaFileManager` rather than `System.IO.File`. The approach routes your files to shared storage that every server can reach. On Umbraco Cloud, and in any Azure Blob setup, the storage is `Umbraco.StorageProviders.AzureBlob`.
* Write your own exports, generated PDFs, or "download this once" files to shared storage. Then hand out a signed URL rather than a path to local disk.

For temporary backoffice uploads and how Umbraco's own temp folder is handled across servers, see [Load Balancing the Backoffice](load-balancing-backoffice.md) and [Standalone File System](file-system-replication.md).

## Keep shared state out of in-process memory

Anything you keep in a `static` field, a singleton service, `IMemoryCache`, a `ConcurrentDictionary`, or an in-memory queue lives on one server. The other servers cannot see the value, and the value disappears when the server recycles. The behavior is fine for some things and a real problem for others. Be deliberate about which is which.

```csharp
// Don't: each server gets its own counter, none of them agree
private static int _submissions;

// Do: keep shared, mutable state somewhere all servers can see it
await distributedCache.SetAsync(key, value, token);
```

What to do instead:

* `IMemoryCache` works well for values you compute once per server. The values don't need to match exactly across servers, such as read-only lookups.
* For anything that *should* be the same everywhere, reach for `HybridCache`. When you register an `IDistributedCache`, `HybridCache` uses the distributed cache as a second-level cache. The same code then works whether you run one server or ten. Choose `HybridCache` for new code.
* Some state needs every server to agree on the value. Examples include feature flags, counters, rate-limit buckets, and "has this user done X recently". Keep that state in the database or a distributed cache, not in memory.
* `static` is fine for pure functions and config you load once at startup. Watch out for `static` that holds *mutable* state. The state sticks around between requests on one server. The state also drifts out of sync with the other servers.
* In-process queues (`Channel<T>`, `ConcurrentQueue<T>`, `BlockingCollection<T>`) aren't durable. If the work matters, hand the work to a real queue or a persistent job framework.

## Build URLs from the forwarded headers, not the raw request

Sometimes you generate an absolute URL - in an email, a sitemap, an OAuth callback, a canonical tag, or a webhook. The URL should reflect the address your visitor used, not the internal address the request arrived on. Behind a load balancer, TLS is terminated up front. The raw request reaching your code looks like plain HTTP from an internal hostname.

Once forwarded headers are honored, `Request.Scheme` and `Request.Host` report the real public values. Your URL-building code then needs no special cases. Trust the reported values rather than reconstructing the URL yourself. When you need a stable base URL in code, read `Umbraco:CMS:WebRouting:UmbracoApplicationUrl`. Avoid inferring the URL from the current request. The first request after a cold start might be an internal health check.

{% hint style="info" %}
On Umbraco Cloud, the forwarded headers and `UmbracoApplicationUrl` are already taken care of. So `Request.Scheme` and friends give you the right answer out of the box.
{% endhint %}

## Don't let scheduled work run on every server

Anything you run on a timer runs on *every* server unless you tell the job not to. Examples include sending a newsletter, cleaning up nightly, or calling a third-party API. The trap is `IRecurringBackgroundJob`, which runs on all servers by design. Pick `IRecurringBackgroundJob` by accident for work that should happen once, and you send the newsletter N times.

For recurring work that must run exactly once, implement `IDistributedBackgroundJob` instead. Umbraco tracks the job in the database, so only a single server picks the job up. The full setup is covered in [Scheduling](../../../../extend-your-project/server-side-extensions/scheduling.md) and [Load Balancing the Backoffice](load-balancing-backoffice.md). The setup also covers server roles and repository-cache configuration for the backoffice.

## Invalidate your own caches across servers

Umbraco keeps its own caches in sync across servers for you. Watch for a *custom* cache of your own that expires on a timer and never listens for changes. On a single server, you never notice the problem. Across servers, one server holds the fresh value. Another server serves a stale value until the timer runs out.

When you cache something that mirrors Umbraco content, don't lean on a time-to-live alone. Subscribe to the relevant notification, such as `ContentPublishedNotification` or a cache-refresher notification. Clear your cache when the notification fires. If you write your own `ICacheRefresher`, send something the *other* servers can act on. Send an ID they can re-read, not a reference to an object that only exists in the current server's memory. See [Cache & Distributed Cache](../../../../extend-your-project/server-side-extensions/cache/README.md) for the full picture.

## Don't assume request 2 lands where request 1 did

Sometimes one request depends on what happened in a previous one, such as a session, a multi-step form or wizard, or OAuth state. By default, the state lives in the memory of whichever server handled the first request. The next request might go somewhere else. Store session through `IDistributedCache` so every server can reach the state. Then apply the round-robin principle from the top of the article. Get the flow working without affinity first, then switch sticky sessions on if you want them for performance.

The backoffice has its own considerations, such as SignalR for real-time updates. [Load Balancing the Backoffice](load-balancing-backoffice.md) covers them.

{% hint style="info" %}
Backoffice load balancing is available from **Umbraco 17**. The same applies to multiple APIs mentioned above, such as `IDistributedBackgroundJob` and `LoadBalanceIsolatedCaches()`. On earlier versions, load balancing assumes a single backoffice server and multiple front-end servers.
{% endhint %}

## Related documentation

* [Umbraco in Load Balanced Environments](README.md)
* [Load Balancing the Backoffice](load-balancing-backoffice.md)
* [Cache & Distributed Cache](../../../../extend-your-project/server-side-extensions/cache/README.md)
* [Scheduling](../../../../extend-your-project/server-side-extensions/scheduling.md)
* [Common Pitfalls & Anti-Patterns](../../../../develop-with-umbraco/application-code/common-pitfalls.md)
