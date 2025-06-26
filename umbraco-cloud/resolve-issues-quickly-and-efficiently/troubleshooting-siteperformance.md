# Site Performance checklist

CPU issues can be many different things. Below I will give some advice on narrowing down the issue and trying to find out what is causing the problems. The first thing to do is try to find out when the trouble started. The friendly Umbraco Support will supply you with a graph of your CPU usage for the past 24 hours. Here you will likely notice a spot where it starts going up.

You can get in touch with the friendly support by either sending an email to contact@umbraco.com or by using the chat in either the Backoffice or from umbraco.com.

## Resources that can help you

### Google Analytics

If you have Google Analytics (GA) set up for your site, then you should check things like visitor counts, and the specific pages visited during the CPU increase. Be aware that things like poorly implemented search functionality can be really bad for performance, so if you have a lot of during that time it could point to that. If you have a lot more visitors than normal, then maybe your site is back to normal now, but then a load test would probably be a good idea!

### UmbracoTraceLogs

If you know when your site started having issues, then you should compare that time to your Umbraco log. Often you will find errors that help you narrow it down or other things that could be the cause. If for example, the CPU performance issues started when you are building your search indexes then there is a good chance that the two are related. Be aware that some errors may appear due to maxing out your resources, they may not be related to the cause!

{% hint style="info" %}
If you are unsure which log file corresponds to the time, you can get a list of the latest log files in Kudu by going to the logs folder `~/Umbraco/logs`then typing in:

`ls -t | head -5`

This will sort the files by last edit time, and only show you the top 5 results.
{% endhint %}

## [Common issues](https://docs.umbraco.com/umbraco-cms/reference/common-pitfalls)

## In addition to that, here are some things we see often

### Excessive indexing

It is not great for performance to have too many custom indexes. Each index adds to the performance requirements, and often the things that you want to achieve can be done in simpler and better performant ways by limiting the number of indexes and instead narrowing your searches.

### Accessing the database

Doing operations against your database can become a performance issue if you do it in the wrong way. If you for example get some data from the database in your views, then you may do a database operation for each visitor to that page. Can quickly become a problem. Please be aware that using any Umbraco Service will also include the database, and often the info you need can be retrieved from the cache instead!

### Scheduled jobs

Scheduled jobs can be very nice, but you have to think about how often they should run and how taxing they are on your site's performance. If for example you want to rebuild your cache every 5 minutes but it takes 6 minutes to do so you will run into a lot of trouble!

* [Reference](https://docs.umbraco.com/umbraco-cms/reference/scheduling)

### Other resources

To debug your site further it is recommended to perform load tests to try to discover if certain pages have issues with many users. Additionally, you can also use tools for profiling your page like dotTrace for example.
