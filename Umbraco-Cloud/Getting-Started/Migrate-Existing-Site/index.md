# Migrating an Existing Site to Umbraco Cloud
Sometimes you may already have an Umbraco site built that did not start with a clone of an Umbraco Cloud site. Or perhaps you have decided to move a site that's already live to Umbraco Cloud. In any case, migrating an existing site is not difficult, but it does require some specific steps, and an understanding of how Umbraco Cloud deployments work can be very helpful.

## Requirements
Before you start migrating your Umbraco 7 site to Umbraco Cloud there are a few things you need to consider. In order to migrate your site smoothly, we have made a list of requirements your project(s) needs to meet.

Your Umbraco site has to fulfill these requirements:

* Has no more content items than your plan covers (Starter plan: 1000 - Pro Plan: 25000)
* Contains no member data (these you will need to import manually!)
* No obsolete/old packages
* Isn’t a site that has been upgraded from versions below Umbraco 7 (as legacy code from older versions can potentially cause issues)

If you have a site that does not meet the above requirements, feel free to contact us and we will help you find the best solution for your site.

## Understanding what you have
Prior to undertaking a migration you'll want to make sure you know the packages, add-ons, and custom code your site is using.  This is especially important if you are using custom property editors that will require connectors in order to work properly with the Umbraco Cloud deployment engine. Connectors are used by Umbraco Deploy to aid with the deployment and transferring of content/property-data between environments on Umbraco Cloud.

There are some common property editors that will require a connector, like [Mortar](https://github.com/leekelleher/umbraco-mortar/tree/develop/src/Our.Umbraco.Mortar.Courier) and [Archetype](https://github.com/leekelleher/Archetype.Courier), which do not currently contain a connector and will not deploy properly. There are certainly other property editors that will require a custom connector but, for the most part, property editors that store data as Umbraco data will deploy without requiring any special attention.

To help smooth this process for you, we've build a project called [Umbraco.Deploy.Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) which contains connectors for the most common Umbraco packages:

* Archetype
* Content List
* DocType Grid Editor
* LeBlender
* Multi Url Picker
* nuPickers
* Property List
* Stacked Content
* Tuple
* UrlPicker

With that in mind, let's get started: [Prepare your site for migration](part-1.md)
