---
meta.Title: "Umbraco in Load Balanced Environments"
meta.Description: "Information on how to deploy Umbraco in a Load Balanced scenario and other details to consider when setting up Umbraco for load balancing"
versionFrom: 8.6.4
---

# Umbraco in Load Balanced Environments

Below we will dive further into how load balancing in Umbraco works, slave

If you are instead looking for how to configure your load balanced site, and already know the basics then you may instead be looking for one of these:

## [Configuration for load balanced sites]()

Learn about how you can configure a load balanced site. Includes the nessecary app settings, logging, deploymentm setting a server registrar and more.

## [Load balancing on Azure]()

If you are load balancing on Azure, then after you have read about [Configuration for load balanced sites]() above, you should check out the Azure specific settings and features in this article.

## [File system replication]()

Read all about the different options for replicating files across your load balanced server environments.

## Overview

Configuring and setting up a load balanced server environment requires planning, design and testing. This document should assist you in setting up your servers, load balanced environment and Umbraco configuration.

:::note
It is highly recommended that you setup your staging environment to also be load balanced so that you can run all of your testing on a similar environment to your live environment.
:::

## Design

These instructions make the following assumptions:

* All web servers can communicate with the database where Umbraco data is stored
* You are running Umbraco 8.6.4 or above
* _**You will designate a single server to be the backoffice server for which your editors will log into for editing content.**_ Umbraco will not work correctly if the backoffice is behind the load balancer.

There are three design alternatives you can use to effectively load balance servers:

1. You use cloud based auto-scaling appliances like Azure Web Apps
2. Each server hosts copies of the load balanced website files and a file replication service is running to ensure that all files on all servers are up to date
3. The load balanced website files are located on a centralized file share (SAN/NAS/Clustered File Server/Network Share)

You will need a load balancer to do your load balancing.

## How Umbraco load balancing works

In order to understand how to host your site it is best to understand how Umbraco's flexible load balancing works.

The following diagram shows the data flow/communication between each item in the environment:

 ![Umbraco flexible load balancing diagram](images/flexible-load-balancing.png)

The process is as follows:

* Administrators and editors create, update, delete data/content on the master server
* These events are converted into data structures called "instructions" and are stored in the database in a queue (in the `umbracoCacheInstruction` table)
* Each front-end server checks to see if there are any outstanding instructions it hasn't processed yet (read more on how this is done under [DatabaseServerMessengerOptions]())
* When a front-end server detects that there are pending instructions, it downloads them and processes them and in turn updates it's cache, cache files and indexes on its own file system
* There can be a delay between content updates and a front-end server's refreshing, this is expected and normal behaviour.

## Scheduling and master election

Although there is a Master server designated for administration, by default this is not explicitly set as the "Scheduling server".
In Umbraco there can only be a single scheduling server which performs the following 3 things:

* Keep alive service - to ensure scheduled publishing occurs
* Scheduled tasks - to initiate any configured scheduled tasks
* Scheduled publishing - to initiate any scheduled publishing for documents

Umbraco will automatically elect a "Scheduling server" to perform the above services. This means
that all of the servers will need to be able to resolve the URL of either: itself, the Master server, the internal load balancer or the public address.

For example, In the following diagram the replica node **f02.mysite.local** is the elected "Scheduling server". In order for scheduling to work it needs to be able to send
requests to itself, the Master server, the internal load balancer or the public address. The address used by the "Scheduling server" is called the "umbracoApplicationUrl".

![Umbraco flexible load balancing diagram](images/flexible-load-balancing-scheduler.png)

By default, Umbraco will set the "umbracoApplicationUrl" to the address made by the first accepted request when the AppDomain starts.
It is assumed that this address will be a DNS address that the server can resolve.

For example, if a public request reached the load balancer on `www.mysite.com`, the load balancer may send the request on to the servers with the original address: `www.mysite.com`. By default the "umbracoApplicationUrl" will be `www.mysite.com`. However, load balancers may route the request internally under a different DNS name such as "f02.mysite.local" which
by default would mean the "umbracoApplicationUrl" is "f02.mysite.local". In any case the elected "Scheduling server" must be able to resolve this address.

In many scenarios this is fine, but in case this is not adequate there's a few of options you can use:

* __Recommended__: [set your front-end(s) (non-admin server) to be explicit replica servers](flexible-advanced.md#explicit-master-scheduling-server) by creating a custom `IServerRegistrar`, this means the front end servers will never be used as the master scheduler
* Set the `umbracoApplicationUrl` property in the [Web.Routing section of /Config/umbracoSettings.config](../../../../Reference/Config/umbracoSettings/index.md)

Now that you understand the way load balancing works with Umbraco, you can read more in these articles:

- [Configuration for load balanced sites]()
- [Load balancing on Azure]()
- [File system replication]()

## FAQs

_Here's some common questions that are asked regarding Load Balancing with Umbraco:_

__Question>__ _Why do I need to have a single web instance for Umbraco admin?_

_TL:DR_ You must not load balance the Umbraco backoffice, you will end up with data integrity or corruption issues.

The reason you need a single server is because there is no way to guarantee transactional safety between servers. This is because we don't currently use database level locking, we only use application (c#) level locks to guarantee transactional data integrity which is only possible to work on one server. If you have multiple admins saving and publishing at once between servers then the order in which this data is read and written to the database absolutely must be consistent otherwise you will end up with data corruption.

Additionally the order in which cache instructions are written to the cache instructions table is very important for LB, this order is guaranteed by having a single admin server.

__Question>__ _Can my Master admin server also serve front-end requests?_

Yes. There are no problems with having your master admin server also serve front-end request.

However, if you wish to have different security policies for your front-end servers and your back
office servers, you may choose to not do this.
