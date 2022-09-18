---
versionFrom: 7.0.0
versionTo: 10.0.0
---

# Frequently asked questions

Here you will find answers to the questions we most commonly hear from people that are wondering about if Umbraco Cloud is the right fit for their project. The answers you will find here are of a more technical nature and are directed at developers.

If you are interested in more general and information about the product, you should [visit the FAQ on our website](https://umbraco.com/products/umbraco-cloud/faq/).

## General

### Can I try before I pay?

Yes, you can [take a free trial of Umbraco Cloud](https://umbraco.com/try-umbraco-cms/) and test it for 14 days with no obligation to buy.

### Is it a special version of Umbraco that’s used?

No. It's the same as the latest version of Umbraco that you can download.

### Can I run my high traffic site on Umbraco Cloud?

Currently we have benchmarked a "well built" site with approximately 50,000 unique visitors per day (~1.5 million per month) that performs very well. For business critical, high traffic sites, we recommend that you look into Umbraco Cloud Professional and Umbraco Cloud Enterprise possibly in combination with a dedicated server.

### Can my site auto-scale or use dedicated worker resources?

Your site can't currently auto-scale, but it is something we’re investigating as a future feature. We do offer dedicated worker resources. [Reach out to us if you want to know more](https://umbraco.com/contact-us/).

### Can I setup a load balanced Umbraco Cloud site?

Not currently.

### Can I move my site from Umbraco Cloud?

Yes, you can. Umbraco Cloud uses the very same Umbraco version that you can download and use on your own. So if you decide that Umbraco Cloud isn’t right for you or your sites then you can clone your site, restore your data locally, and delete your Umbraco Cloud project. We’ll be sad to see you go, but we understand there is a huge variety in requirements so we support and encourage you to choose the best solution for your specific site needs.

### Can I move my existing site to Umbraco Cloud?

Umbraco Cloud is best when used as the base for a new project. There is a specific way of working with Umbraco and Umbraco Cloud in order to take full advantage of the service. That’s not to say you can’t migrate an existing site, only that some changes may be required in order for your site to fully work with Umbraco Cloud. For more information [read our guide to moving an existing site](https://our.umbraco.com/documentation/Umbraco-Cloud/Deployment/Migrate-Existing-Site/).

---

## Technology

### On what kind of server environment does my Cloud site run?

All available Umbraco Cloud plans are utilising P1V3 Azure App Service Plans as their underlying infrastructure. A P1V3 Azure App Service Plan offers in total

- 2 CPU Cores
- 8GB of RAM
- 250 GB Disk space
- 1,920 TCP connections

### How many resources do I have available for my website?

In order to see quotas for the different plans on Umbraco Cloud see [Umbraco Cloud Plans](../Getting-Started/Umbraco-cloud-plans)

We also have a limitation for hostnames on the different plans on Umbraco Cloud. You can see how many hostnames you can have on our [pricing list.](https://umbraco.com/umbraco-cloud-pricing/)

In our experience there are only a few Cloud sites that have experienced these limitations and we're happy to work with people who have sites affected by these limitations.

:::note
If you have questions about how many resources your site is using, then please reach out to our friendly support team.
:::

### Can I use Cloudflare in front of my Umbraco Cloud site

Yes you can. Please note that Umbraco Cloud also uses Cloudflare for DNS, so you need to enroll your hostname as 'DNS Only' with a CNAME pointing to `dns.umbraco.io`. Once you can see the hostname is marked with 'Protected' under the Project / Hostname subpage you can turn on 'Proxying' for the hostname in your Cloudflare account if you need to use specific Cloudflare features like Page Rules.

Generally, we recommend that you keep your DNS entry set to 'DNS Only' in your own Cloudflare account and let Umbraco Cloud handle the automatic TLS (HTTPS) certificates for the hostnames you point to your Umbraco Cloud project. Check with our support team, via chat or using support@umbraco.com, before bringing in your own Cloudflare setup.

### What versions of .NET does Cloud support?

By default, Umbraco Cloud runs all Umbraco version 8 projects on .NET 4.8, Umbraco 9 projects on .NET 5.0 and Umbraco 10 projects on .NET 6.0.

---

## Upgrades

### When does Umbraco get upgraded in the various projects?

We upgrade when we're very confident the release is solid.

### How do Automated Upgrades work?

We automatically upgrade Cloud projects to the latest patch version of Umbraco CMS, Umbraco Forms and Umbraco Deploy / Courier. For minor version upgrades of our products, you’ll get a button in the interface to decide if you want to move to that version when it is released. When we make a new patch version, we first run it through our test suite, then test it on 10 test-sites. When all that passes, we roll out the upgrade in batches of 100 to customer accounts.

[Read more about upgrades](https://our.umbraco.com/documentation/Umbraco-Cloud/Upgrades/)

### My project didn't receive the auto-upgrade. Why?

When we roll out auto-upgrades to Umbraco Cloud projects the very first thing that happens is a check of all environments on a project. This check will verify whether the environments are responding and doesn't return an HTTP status error. If the auto-upgrader encounters HTTP status errors on any of the environments during this check, the upgrade process is aborted, and your project will not receive the upgrade.

Another reason why your project wasn't auto-upgraded could be, that it failed the test we perform after applying the auto-upgrade. This test compares the state of an environment from before the upgrade with the state of the same environment after the upgrade. If they do not match, we take the appropriate measures to rollback the environment to its previous state and abort the upgrade of any remaining environments.

Other reasons why you didn't receive the auto-upgrade:

 - If you are doing a deployment at the time we tried to run the auto-upgrader on your project
 - If your environments aren't running the same minor version - e.g. if you are in the middle of upgrading to a new minor version, and one environment is running 7.6.x while another environment on the same project is running 7.7.x.

You can find all the steps of the auto-upgrade process outlined in the [Upgrades](https://our.umbraco.com/documentation/Umbraco-Cloud/Upgrades/#the-process-of-auto-upgrading-an-umbraco-cloud-project) article.

### Does leaving pending commits (dev to live) derail the upgrade process?

Pending commits won't stop the auto-upgrade.

### Is it OK to do manual updates? For example if a project on 9.4.3 is updated locally to 9.4.4, can we commit back to dev?

Yes, that’s fine. In some cases you may want to upgrade sooner than the scheduled service upgrade or you may have a site we couldn't upgrade automatically for one reason or another.

Do note, however that you will need to step through the upgrade installer manually on each environment, including live. Our automated upgrader makes sure that visitors to your live site will not be prompted to log in to the upgrade installer.

### I have customized files that Umbraco ships with, will they be overwritten during upgrades?

You will have to assume that every time we upgrade your site, any file that comes with Umbraco by default will be overwritten. Generally we only overwrite the files that have been changed in the newest release but there is no guarantee for that. So if you (for example) have customized the login page then you can assume it will be reverted on each upgrade.

As a workaround you could have an [ApplicationEventHandler](https://our.umbraco.com/Documentation/Reference/Events/Application-Startup#use-applicationeventhandler-to-register-events) in which you check if the file is different from your customized file and overwrite it again. Note that this is NOT possible if you customize any of the Umbraco DLL files.

---

## Testing

### Are we allowed to perform penetration tests on our Umbraco Cloud site?

Yes, we're happy for people to do penetration testing on the sites they have built on Cloud. We do ask you to please tell us about these tests beforehand so our support staff knows to look out for possible strange things happening on your site.

We are also happy to receive any test results you receive, so that we can improve security in Umbraco where necessary.

Please contact us using the chat button at the bottom right corner of the [Umbraco Cloud portal](https://www.s1.umbraco.io/).

### Are we allowed to do (D)DOS testing on our Umbraco Cloud site?

It is strictly forbidden to attempt to do a denial of service attack on your Cloud sites.

### Are we allowed to do load testing on our Umbraco Cloud site?

We would like to talk to you beforehand about your test plan for a load test on your Cloud site.

Please contact us using the chat button at the bottom right corner of the [Umbraco Cloud portal](https://www.s1.umbraco.io/).

---

## Security and encryption

Haven't found an answer to your question? Many security related questions are answered in the [Security section](../Security) of the documentation.

### Does Umbraco Cloud support TLS / HTTPS?

Yes, in fact Umbraco Cloud provides automatic TLS (HTTPS) certificates for ALL hostnames added to an Umbraco Cloud Project's environment. Umbraco Cloud will automatically renew the certificates, which are issued by Cloudflare. By default the certificates are valid for 1 year and are then automatically renewed for as long as the hostname is active on Umbraco Cloud.

### Does Umbraco Cloud support custom certificates?

Yes. Pro and Enterprise Plans can add custom certificates for each of their custom hostnames in order to override the certificates that are provided by Umbraco Cloud by default.

Learn more about how to use your own certificates in the [Custom certificates](../Set-up/Manage-Hostnames/Security-certificates) article.

### Does Umbraco Cloud support HTTP/2?

By default, Umbraco Cloud supports HTTP/2.

### There's a ARRAffinity cookie on my site which is not sent over HTTPS, is this a security risk?

No this is not a security risk. This cookie is set by the load balancer (LB) and only used by the LB to track which server your site is on. ARRAffinity cookie is a built-in feature of Azure App Service and only useful when your website is being scaled to multiple servers. In Umbraco Cloud we cannot scale your site to multiple servers so the cookie is effectively unused.

You can learn much more about this in our [Security section](../Security/#cookies-and-security).

### Can I use wildcard certificates on Umbraco Cloud? How about an EV, DV or OV certificate?

Yes. You can use any valid certificate on Umbraco Cloud.

### I get a warning that "your connection is not private" and the certificate is served for *.umbraco.io

It seems that you didn't set up the bindings for the specific domain where this warning is showing. Check the bindings by going to the site in [the portal](https://www.s1.umbraco.io) by going to the "Manage hostnames" section for your site.

### How can I control who accesses my backoffice using IP filtering?

Yes. On Cloud you can add an IP filter of your choosing. There are a few things you need to pay attention to though. Umbraco Deploy will still need to be able to talk to the different environments in your Cloud website and you should still be able to use the site locally.

Learn more about this and how to set it up in our [Security section](../Security/#restrict-backoffice-access-using-ip-filtering).

### Does Umbraco Cloud use Transparent Data Encryption (TDE) for databases?

Yes, every site created after May 2nd 2017 will have TDE enabled by default. For older sites we can enable this by request.

---

## Building and deploying

### Umbraco Cloud creates a SQL CE / LocalDb database for me, can I use a shared SQL Server for my development team instead?

No, you should not use a shared database for your team. Umbraco Cloud is made so that each team member can safely make any changes they need and then send them to your development environment on Cloud. Another developer can do the same and also send their changes to dev to test. Once you're happy with all of the changes, each developer can pull down the changes from development and continue working on the next change.

Not only does this promote working in small increments it also prevents two problems:

 1. If you share a database between multiple developers, [Umbraco's flexible load balancing](https://our.umbraco.com/Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/flexible) automatically kicks in. Without a proper load balancing setup this means that often you will not see changes another team member has made, potentially overwriting their changes with your own changes.
 2. Our deployment engine (Umbraco Deploy) is not made for this and your local site will quickly get out of sync with changes both developers are making. Once you push your changes up to your Cloud instance you can expect to see errors and mismatches because changes have not been saved correctly.

### Can I use custom .NET code?

Yes, you can make your Umbraco implementations as you're used to, including custom .NET assemblies.

Umbraco Cloud sites run on IIS 8.5 so most things you can normally do on IIS, you can do on Umbraco Cloud. We don't, however, offer support for custom components that have to be installed on the server itself. If you can ship it in the bin folder, it should generally work on Cloud.

If you have any experience with Azure Web Apps, Cloud works in the same way. So if you can make it run on Azure Web Apps, you can make it run on Umbraco Cloud.

### Is it possible to add my own custom DLLs for extending the Umbraco Backoffice?

Yes, an Umbraco Cloud project is similar to a normal Umbraco website where we give you multiple environments and deployment of code and content between these environments. You can run your site locally (via Git) which is the best way to add your own code (templates, cs files, packages, DLLs and so forth).

### Is it possible to add custom tables in addition to the Umbraco Cloud database?

Yes, you can create custom tables in the database. Find the connection strings to the databases on the different environments on the "Connection details" page found in the "Settings" menu.

Note that custom database tables and data do not replicate automatically across Cloud environments. You might want to use Umbraco Migrations and our PetaPoco datalayer to make deployment of your custom data more automated.

### I would love to use Websockets on my site, is this possible?

Yes it is! Websockets are enabled on all sites.

### My deletions are not picked up when deployed to the next environment

When you've deleted something (e.g. content, media or schema) on one environment, the deletions will not be picked up on the next environment when you deploy.

This is intended behaviour.

We will **only delete the files** and not the database entries, as this could potentially cause you to lose data on your Live / production environment.

You can read much more about these deletions in the [Deploying Deletions](../Deployment/Deploying-Deletions) article.

---

## Package support

### Do you support package "x" on Umbraco Cloud?

We have an indicator on each package in [the projects section of Our Umbraco](https://our.umbraco.com/projects/) which either says "Works on Umbraco Cloud" or "Untested or doesn't work on Umbraco Cloud".

If the indicator says "Works on Umbraco Cloud" it means that Umbraco HQ has tested this package on Cloud and it works and changes made using this package are also deployable to the next environment.

If the indicator says "Untested or doesn't work on Umbraco Cloud" then we have not tested it and cannot vouch for it on Cloud. It might work, and we're happy for you to test it on Cloud.

We're happy to hear from and work with package developers to make their packages Cloud compatible where possible. Make sure to reach out to us using the chat button at the bottom right corner of the [Umbraco Cloud portal](https://www.s1.umbraco.io/).

### How do I make my package support Umbraco Cloud?

The biggest problem concerning Cloud support is when a package stores references to nodes, media items, or members in Umbraco.

There are two challenges here:

 1. Your package is referring to an integer identifier, for example a content item with id `1023`. On the next environment that same content item exists but since the content is a bit different there, the id is `1039` instead. Umbraco Deploy needs to know how to connect the correct identifier.
 2. Even if the identifier is correct on both environments your package might rely on the other item (the one you're referring to) to exist in the next environment. So if the content item you're referring to (`1023`) does not exist on the environment where you're pushing the content to you might see errors in your package.

These problems can be solved with so-called Umbraco Deploy connectors. We've set up a project called [Umbraco Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib/) to collect these connectors together. Umbraco Deploy Contrib is included in all Cloud sites and we keep it upgraded to the latest version for every site.

The code in the contrib project has plenty of code comments to help you understand what is going on and how you can build something like that for your own package.

If you need help with this, don't hesitate to reach out to us and we'll be happy to give you some tips.

---

## Regions


### Can I choose which region my projects run in?

Yes, you can choose between the West Europe region and US East region.

### Can I move my existing project created on Cloud in the EU region to the US region?

Yes, you can move a project that was created on Umbraco Cloud in the EU region to the US region by following the [migrate between regions guide](https://our.umbraco.com/documentation/Umbraco-Cloud/Getting-Started/Migrate-between-regions/).

### How do I select a region when creating projects on Cloud?

You can choose a region when creating a project.

### Can I have a Baseline master project in the EU and a Baseline child project in the US?

No. Baseline-projects are bound to a region for now. 


### Will my sites receive automatic patch-upgrades of CMS, Deploy, and Forms when new releases are available?

Yes. The US region is no different than normal Cloud other than its regional location. That means that the patch-upgrade functionality will work in whichever region you choose.


### Can you create Umbraco Heartcore projects in the US Region? 

Not at the moment. 

### Are all the features we have in Umbraco Cloud available in the US region?

Baseline functionality is not supported in the US-region at the moment. Other than that, all features are fully supported.


### Are you planning to add other regions in the future? 

Yes. Once we have specific plans, we will announce them publicly.

### Where can I see what region my project was created in?

 EU region has “euwest” in the URL, while US has “useast” in the URL.
---

## Backups and data retention

### What backup and restore options are available on Umbraco Cloud?

#### Database

Database backups are not available as downloads by default, but a copy can be downloaded using a Powershell script. By default 35 days point in time restore is available. Restore is dependent on your needs, requirements and database size and will be handled on a case by case basis. Contact Umbraco Cloud support through the portal to discuss your requirements.

You can read more about database backups and how to perform these on Umbraco Cloud in the [Databases/Backups section](../Databases/Backups)

#### Filesystem

Umbraco Cloud keeps 30 days of snapshots of filesystem for disaster recovery purposes.

#### Blob Storage containers

Umbraco Cloud keeps 35 days of snapshots of the Blob Storage container for disaster recovery purposes.
