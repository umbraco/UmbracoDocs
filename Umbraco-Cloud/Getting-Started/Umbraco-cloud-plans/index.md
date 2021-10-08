---
versionFrom: 9.0.0
---

# Umbraco Cloud Plans

Umbraco Cloud plans Starter, Standard & Professional are running on shared infrastructure, referred to as pools. In order to ensure performance and prevent exhaustion of a given pool, each website is assigned a resource quota, depending on the plan, and resource usage is continuously monitored. This applies to websites running on the new infrastructure. If you're interested in earlier generation of Umbraco Cloud hosting, you can [head to the FAQ](../../Frequently-Asked-Questions) to learn more.

The shared resources used by the Umbraco Cloud websites are:

- CPU
- RAM / Memory
- Disk space
- TCP connections

Currently all available Umbraco Cloud plans are utilising P1V3 Azure App Service Plans as their underlying infrastructure. A P1V3 Azure App Service Plan offers in total

- 2 CPU Cores
- 8GB of RAM
- 250 GB Disk space
- 1,920 TCP connections

In order to ensure stable performance of all websites hosted on Umbraco Cloud shared plans, soft and hard quotas were put in place. Quotas per site and the number of sites in the  pool varies per Umbraco Cloud Plan.

# Hard quotas for shared Umbraco Cloud Plans

Whenever a CPU or RAM quota is met, the website will be restarted within a minute in order to ensure stable performance for all websites in the pool. Meeting a disk quota will result in errors whenever performing write operations to disk. No hard limits exist for TCP connections per site, besides the total amount TCP connections available to all sites in the pool set at 1,920, attempting to open new TCP connections afterwards will result in errors.

These are hard quotas, as they can't be broken for more than a minute and will immediately restrict functionality of the site.

Umbraco Cloud Starter plan

- CPU - 20%
- RAM - 1500 mb
- Disk - 7800 mb

Umbraco Cloud Standard plan

- CPU - 40%
- RAM - 1800 mb
- Disk - 9600 mb

Umbraco Cloud Professional plan

- CPU - 50%
- RAM - 2000 mb
- Disk - 10400 mb

# Soft quotas for shared Umbraco Cloud Plans

Sites are monitored for hitting soft quotas every minute. (Evaluation freqency). A quota is evaluated for a window of 5 minutes. In case a site reaches the soft quota it will be restarted. After multiple restarts, due to exceeding the soft quota, the site will be isolated in order to protect the rest of the sites in the pool. The number of restarts depends on the Cloud plan, details for each plan can be found below.

These are soft quotas because peaks are allowed and the evaluation period is 5 minutes.

Umbraco Cloud Starter plan

- CPU - 120 CPU seconds total in the past 5 minutes - equivalent to 20 % average CPU
- RAM - 524 mb average in the past 5 minutes
- Restarted 5 times before isolated

Umbraco Cloud Standard plan

- CPU - 210 seconds total - equivalent to 35 % CPU
- RAM - 786 mb
- Restarted 3 times before isolated

Umbraco Cloud Professional plan

- CPU - 300 seconds total - equivalent to 50 % CPU
- RAM - 1048 mb
- Restarted 2 times before isolated

# Quotas for the shared pool

Whenever a pool hits above 95% usage of any resource disk, the busiest staging or development environment, that hasn't been moved previously will be moved to a different pool.
