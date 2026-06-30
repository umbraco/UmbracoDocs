# July 2026

## Key Takeaways

* **Load Balancing** - Distribute incoming traffic across multiple dedicated instances to handle higher load and keep your site running smoothly under pressure.
* **Dedicated Redis** - A dedicated Redis cache that stores hot data for the CMS. Required for Load Balancing as session storage, and available on its own as a second-level cache.
* **New Dedicated Resource tiers** - Updated Dedicated Resource tiers as a first step toward better options and more flexibility. Available sizes: Extra Small, Small, Medium, and Large.

## Load Balancing

Load Balancing distributes incoming traffic to your website across multiple dedicated servers. This lets you handle more incoming traffic and ensures your website keeps running smoothly under increased load.

When you enable Load Balancing, Cloud automatically provisions and configures an additional Redis cache resource. This is used to store and share hot data across the dedicated instances, keeping them in sync.

<figure><img src="../../.gitbook/assets/cloud-load-balancing-config.png" alt="The Load Balancing configuration page showing the readiness check and the enable toggle"><figcaption><p>Enable Load Balancing on the Live environment once all readiness requirements pass.</p></figcaption></figure>

For more information, see the [Load Balancing documentation](https://docs.umbraco.com/umbraco-cloud/optimize-and-maintain-your-site/optimize-performance/load-balancing) and the [Cache Configuration documentation](https://docs.umbraco.com/umbraco-cloud/optimize-and-maintain-your-site/optimize-performance/cache-configuration).

## Dedicated Redis

Dedicated Redis can significantly improve the performance of your website by storing vital hot data used by the CMS, offloading the cache burden from the CMS instance itself.

Dedicated Redis is required for Load Balancing, where it handles session storage across your instances. It is also available on its own, making it a perfect second-level cache for the CMS even when you are not load balancing.

Depending on your project's needs, you can now choose from the following Redis plans:

| Name | Size | High Availability | SLA |
| :-- | :-- | :-- | :-- |
| Extra Small | 0.5 GB | No | No |
| Extra Small + | 0.5 GB | Yes | Yes |
| Small + | 1 GB | Yes | Yes |
| Medium + | 3 GB | Yes | Yes |
| Large + | 6 GB | Yes | Yes |
| Extra Large + | 12 GB | Yes | Yes |

<figure><img src="../../.gitbook/assets/cloud-cache-configuration-redis.png" alt="The Cache Configuration page with the Redis cache toggle and the SKU selector for choosing cache size and SLA tier"><figcaption><p>Enable Dedicated Redis and choose a plan from the Cache Configuration page.</p></figcaption></figure>

For more information, see the [Cache Configuration documentation](https://docs.umbraco.com/umbraco-cloud/optimize-and-maintain-your-site/optimize-performance/cache-configuration). If you need additional performance, take a look at Load Balancing.

## Dedicated Resources

We have updated our Dedicated Resource tiers. This is the first step toward providing better options and more flexibility. The available sizes are Extra Small, Small, Medium, and Large.

| Size | Available on | CPU | RAM |
| :-- | :-- | :-- | :-- |
| Extra Small | Starter, Standard | 1 | 4 GB |
| Small | Standard, Professional | 2 | 8 GB |
| Medium | Professional | 4 | 16 GB |
| Large | Professional | 8 | 32 GB |

Size and pricing are now consistent across plans. Where two plans offer the same size, it is exactly the same resource, so there is no longer a difference between plans for an identical dedicated resource.

For more information, see the [Dedicated Resources product page](https://umbraco.com/products/umbraco-cloud/dedicated-resources/).
