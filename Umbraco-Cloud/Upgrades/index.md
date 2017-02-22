#Umbraco Cloud Product Upgrades

_This document describes when & what product updates are rolled out on Umbraco Cloud_

##What products are auto upgraded?

* Umbraco CMS patch updates
* Forms 
* Courier
* Internal Umbraco Cloud services (generally these updates will not affect running websites but in some cases if they do we will notify Umbraco Cloud users via the status page)

##When do upgrades happen?

* The status page will include all important roll out information: __[http://status.umbraco.io/](http://status.umbraco.io/)__
* We will release product updates only on __Tuesday__
* The decision to roll out an upgrade will be made no later than the __Thursday__ prior and that status page will be updated accordingly
* A product upgrade will be rolled out if:
* A fix needs to be shipped due to a critical issue in any product
* A patch version of Umbraco Core is ready for release
* A new version of Courier is ready for release
* A new version of Forms is ready for release
* Umbraco Cloud reserves the right to rollout an emergency product fix to fix a critical issue at any time

##The auto upgrade roll out process

Before a live upgrade is rolled out on Umbraco Cloud:

* Write release notes and include special upgrade instructions and/or blog post if necessary
* Create a new version on the issue tracker
* Take the build from AppVeyor and push to Nuget
* Update Our.umbraco.org release page
* Update Umbraco Cloud’s site creation engine with the new version so that all new sites are built with the latest version  
* Run the auto-upgrader on Umbraco Cloud on a subset of test sites to verify there are no issues
* Run the auto-upgrader on all Umbraco Cloud sites

##The process of auto-upgrading an Umbraco Cloud project

This describes how an Umbraco Cloud project is auto-upgraded:

* The upgrade payload will have been created for the specific product(s) being upgraded
* The payload is a set of files (such as DLLs, and other ASP.NET website files)
* The upgrader will verify that the home page of all the environments (dev/staging/live) are healthy, meaning they don’t return an http status error. If all environments are ok, it will proceed.
* The upgrader will take a snapshot of the Dev site’s home page including it’s http status code result and its html contents. 
* The payload is deployed to the Dev site’s Git repository and committed with a tag for the product version being updated. This new Git repository commit will replace the Umbraco product assembly (DLL) files along with other product files such as files located in /umbraco, /umbraco_client folders
* The normal Umbraco Cloud deployment process is invoked and the repository files are deployed to the website
* The upgrader will automatically ensure the web.config version and the database version are updated so that the Installer/upgrade page is not shown
* The upgrader will verify that the new http status code returned from the Dev site’s home page is OK and will verify that the html contents of the home page match that of the snapshot originally taken. 
* If either of these tests fail we will be notified and Umbraco will take appropriate measures to rollback the site to it’s previous state
* The failed upgrade is then tracked for reporting and the customer will be notified if necessary
* When the Dev site is upgraded successfully, the upgrader will continue this same process for the next environment in the chain (i.e. Dev -> Staging -> Live) depending on the number of environments that exist for the project.

##Minor version upgrades

When Umbraco CMS minor version upgrades are available your site will not be auto upgraded to this version. You will need to press the Upgrade button in the Umbraco Cloud portal to perform the upgrade. This will upgrade your Development site so you can test it before pushing the upgrade to your live site. For single environment sites, you will need to add a Development environment first before you can perform the upgrade.

##How do baseline updates work?

If a project is a project that has had child projects created off it, the upgrade process for patch versions is the same as described above. The difference is that we always upgrade the baseline as the first project, and afterwards we upgrade the child projects. This ensures that if for some reason an update is done from the baseline to the children in the meantime, the patch upgrade will also be sent to the children.

##What is a breaking change?
It is important that developers understand what is considered a breaking change in Umbraco products. In most cases an auto-upgrade will not have any breaking changes and we strive to ensure this is the case. However, in some rare cases developers may be using Umbraco’s internal code or Umbraco’s code that is not intended for public consumption and in some releases that code may change. It is important for developers to understand the risks of using Umbraco code that is not considered a breaking change when it is updated since this may directly affect a site that is auto-upgraded. 

What is a breaking change is documented here: [https://our.umbraco.org/documentation/development-guidelines/breaking-changes](https://our.umbraco.org/documentation/development-guidelines/breaking-changes)

##Can I opt out of product auto upgrades?

In order for us to be able to support a site on Umbraco Cloud we must ensure that all sites are running the latest versions of our products so that we know the site is running in it’s most stable state. In rare cases you may contact us to opt-out your site from auto upgrades if you are on a Pro plan. However, if you choose to do this then that site will no longer be supported. If a project is opted out from being auto upgraded, Umbraco reserves the right to either shut down the project or force an upgrade on the project if a security related issue is discovered with the project.
