# Site Performance checklist

CPU issues can be many different things. Below I will give some advice on narrowing down the issue and trying to find out what is causing the problems. The first thing to do is try to find out when the trouble started. The friendly Umbraco Support will supply you with a graph of your CPU usage for the past 24 hours. Here you will likely notice a spot where it starts going up.

You can contact Support by sending an email to `contact@umbraco.com` or using the chat option in the Backoffice or on [umbraco.com](https://umbraco.com/).

## Resources that can help you

### Google Analytics

If you have Google Analytics (GA) set up for your site, then you should check things like visitor counts, and the specific pages visited during the CPU increase. Be aware that things like poorly implemented search functionality can be really bad for performance, so if you have a lot of during that time it could point to that. If you have a lot more visitors than normal, then maybe your site is back to normal now, but then a load test would probably be a good idea!

### UmbracoTraceLogs

If you know when your site started having issues, then you should compare that time to your Umbraco log. Often you will find errors that help you narrow it down or other things that could be the cause. If for example, the CPU performance issues started when you are building your search indexes then there is a good chance that the two are related. Be aware that some errors may appear due to maxing out your resources, they may not be related to the cause!

{% hint style="info" %}
To find the latest log files in Kudu, go to the logs folder `~/Umbraco/logs` and type:

`ls -t | head -5`

This will sort the files by last edited time and display only the top 5 results.
{% endhint %}

## [Common issues](https://docs.umbraco.com/umbraco-cms/reference/common-pitfalls)

## In addition to that, here are some things we see often

### Excessive indexing

It is not great for performance to have too many custom indexes. Each index increases performance requirements. Achieving your goals can often be simpler and more efficient by reducing the number of indexes and narrowing your searches instead.

### Accessing the database

Performing operations on your database can lead to performance issues if not done correctly. For instance, if you retrieve data from the database in your views, this could result in a database operation for each visitor to that page. This can quickly become problematic. Using any Umbraco service also involves the database, and often, the information you need can be retrieved from the cache instead.

### Scheduled jobs

Scheduled jobs are nice, but you have to think about how often they should run and how taxing they are on your site's performance. For example, rebuilding your cache every 5 minutes when it takes 6 minutes can cause significant issues.

* [Reference](https://docs.umbraco.com/umbraco-cms/reference/scheduling)

### Other resources

To debug your site further it is recommended to perform load tests to try to discover if certain pages have issues with many users. Additionally, you can also use tools for profiling your page like dotTrace for example.
