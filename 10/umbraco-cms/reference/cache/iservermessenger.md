---
needsV8Update: 'true'
---

# IServerMessenger

Broadcasts distributed cache notifications to all servers of a load balanced environment. Also ensures that the notification is processed on the local environment.

For a specified [ICacheRefresher](icacherefresher.md), the implemented methods will:

* Notify the distributed cache
* Invalidate specified items
* Notify all servers of specified items removal
* Notify all servers of invalidation of a object
* Notify all servers of a global invalidation (clear the complete cache)
