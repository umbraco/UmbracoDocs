---
meta.Title: "Creating a Custom Dashboard"
meta.Description: "A guide to creating a custom dashboard in Umbraco"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Tutorial - Creating a Custom Dashboard

## Overview

This guide takes you through the steps to setup a Custom Dashboard in Umbraco.

### What is a Dashboard?

A Dashboard is a tab on the right-hand side of a section eg. the Redirect Url Management dashboard in the Content section:

![Redirect Url Management Dashboard](images/whatisadashboard.jpg)

### Why provide a Custom Dashboard for your editors?

It is generally considered good practice when you build an Umbraco site to provide a custom dashboard to welcome your editors and provide information about the site and/or provide a helpful gateway to common functionality the editors will use.
This guide will show the basics of creating a custom 'Welcome Message' dashboard and then show how you can go a little further to provide interaction using AngularJS.

The finished dashboard will give the editors an overview of which pages and media files they've worked on most recently.

Here's an overview of the steps that will be covered:

- Setting up the dashboard plugin
- Writing a basic Welcome Message view
- Configure the Custom Welcome Dashboard to be displayed
- Adding styles
- Adding an AngularJS controller
- Display the current user's name in our welcome message
- Display the current user's recent updates
- Create a shortcut button to add a new blog post
- You can do anything...

### Prerequisites

This tutorial uses AngularJS with Umbraco, so it does not cover AngularJS itself, there are tons of resources on that already here:

- [Egghead.io](https://egghead.io/courses/angularjs-fundamentals)
- [Angularjs.org/tutorial](https://docs.angularjs.org/tutorial)
- [Pluralsight](https://www.pluralsight.com/paths/angular-js)

There are a lot of parallels with Creating a Property Editor, the tutorial '[Creating a Property Editor Tutorial](../Creating-a-Property-Editor/index.md)' is very much worth a read through too.

### The end result

At the end of this guide, we should have a friendly welcoming dashboard displaying a list of the editor's recent site updates.

## Setting up a plugin

The first thing we must do is create a new folder inside our site's '/App_Plugins' folder. We will call it
'CustomWelcomeDashboard'

## Creating the dashboard view

Next we will create a HTML file inside this folder called 'WelcomeDashboard.html' the html file will contain a fragment of a html document and so does not need &lt;html&gt;&lt;head&gt;&lt;body&gt; entities.

Add the following html to the WelcomeDashboard.html

```html
<div class="welcome-dashboard">
    <h1>Welcome to Umbraco</h1>
    <p>We hope you find the experience of editing your content with Umbraco enjoyable and delightful. If you discover any problems with the site please report them to the support team at <a href="mailto:">support@popularumbracopartner.com</a></p>
    <p>You can put anything here...</p>
</div>
```

## Configuring the dashboard to appear

Similar to a property editor you will now register the dashboard in a package.manifest file, so add a new file inside the ~/App_Plugins/CustomWelcomeDashboard folder called package.manifest:

```json
{
    "dashboards":  [
        {
            "alias": "welcomeDashboard",
            "view":  "/App_Plugins/CustomWelcomeDashboard/WelcomeDashboard.html",
            "sections":  [ "content" ],
            "weight": -10,
            "access": [
                { "deny": "translator" },
                { "grant": "admin" }
            ]
        }
    ]
}
```

The above configuration is effectively saying:

> "Add a tab called 'WelcomeDashboard' to the 'Content' section of the Umbraco site, use the WelcomeDashboard.html as the content (view) of the dashboard and don't allow 'translators', but do allow 'admins' to see it!"

:::note
The order in which the tab will appear in the Umbraco Backoffice depends on its weight. To make our Custom Welcome message the first Tab the editors see in the content section, make sure the weight is less than the default dashboards, [read more about the default weights](../../Extending/Dashboards).

You can specify multiple controls to appear on a particular tab, and multiple tabs in a particular section.
:::

### Add Language Keys

After registering your dashboard, it will appear in the backoffice - however it will have it's dashboard alias [WelcomeDashboard] wrapped in square brackets. This is because it is missing a language key. The language key allows people to provide a translation of the dashboard name in multilingual environments. To remove the square brackets - add a language key:

You will need to create a *Lang* folder in your custom dashboard folder and create a package specific language file:  `~/App_Plugins/CustomWelcomeDashboard/Lang/en-US.xml`

:::note
The `App_Plugins` version of the `Lang` directory is case sensitive on Linux systems, so make sure that it start with a capital `L`.
:::

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language>
  <area alias="dashboardTabs">
    <key alias="welcomeDashboard">Welcome</key>
  </area>
</language>
```

[Read more about language files](../../Extending/Language-Files/index.md)

### The Result

![Custom Dashboard Welcome Message](images/welcomemessage-v8.png)

:::note
If you don't see the brackets disappearing - you may need to recycle your app pool. Try adding a space at the end of a line in your web.config file and then reload.
:::

## Adding a bit of style

Congratulations! Job well done - no unfortunately not, this is only the starting point. The dashboard can be styled as you want it to be with CSS, but there are a couple of further steps to undertake be able to apply a custom stylesheet to the dashboard:

Inside this package manifest we add a bit of JSON to describe the dashboard's required JavaScript and stylesheet resources:

```json
{
    "dashboards":  [
        {
            "alias": "welcomeDashboard",
            "view":  "/App_Plugins/CustomWelcomeDashboard/WelcomeDashboard.html",
            "sections":  [ "content" ],
            "weight": -10,
            "access": [
                { "deny": "translator" },
                { "grant": "admin" }
            ]
        }
    ],
	"javascript": [
        /*javascript files listed here*/
    ],
    "css": [
        "~/App_Plugins/CustomWelcomeDashboard/customwelcomedashboard.css"
    ]
}
```

Now create a stylesheet in our CustomWelcomeDashboard folder called 'customwelcomedashboard.css', and add some styles, I don't know perhaps a bit of purple:

```css
.welcome-dashboard h1 {
    font-size:4em;
    color:purple;
}
```

This stylesheet will now be loaded and applied to your dashboard. Add images and html markup as required.

![Custom Dashboard Welcome Message With styles...](images/welcomemessagewithstyles-v8.png)

:::note
One caveat is that the package.manifest file is loaded into memory when Umbraco starts up. If you are adding a new stylesheet or JavaScript file you will need to start and stop your application for it to be loaded.
:::

If the title doesn't change colour, you may be running the site without debugging and therefore [ClientDependency Framework](https://github.com/Shazwazza/ClientDependency) (CDF) will be caching the CSS and JavaScript. To clear the CDF cache and get it to load in the new JavaScript and CSS, you need to increment the version number in the [ClientDependency.config file](https://github.com/Shazwazza/ClientDependency/wiki/Configuration#complete-config) and press save. Now you can reload the page and see the colourful title.

Hopefully, now you can see the potential of what you could provide to an editor as a basic welcome dashboard when they log in to Umbraco.

## Adding functionality

We can add functionality to the dashboard by associating an AngularJS controller with the HTML view.

Let's add a new file to the CustomWelcomeDashboard folder called 'customwelcomedashboard.controller.js' where our controller code will live.

We register this AngularJS controller to the Umbraco Angular module:

```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope) {
    var vm = this;
    alert("hello world");
});
```

In our html view, we update the outer div to wire up the controller to the view:

```html
<div class="welcome-dashboard" ng-controller="CustomWelcomeDashboardController as vm">
```

:::note
The use of vm (short for view model) is to enable communication between the view and the controller.
:::

Finally, we need to update the package.manifest file to load the additional controller JavaScript file when the dashboard is displayed:

```json
{
    "dashboards":  [
        {
            "alias": "welcomeDashboard",
            "view":  "/App_Plugins/CustomWelcomeDashboard/WelcomeDashboard.html",
            "sections":  [ "content" ],
            "weight": -10,
            "access": [
                { "deny": "translator" },
                { "grant": "admin" }
            ]
        }
    ],
	"javascript": [
        "~/App_Plugins/CustomWelcomeDashboard/customwelcomedashboard.controller.js"
    ],
    "css": [
        "~/App_Plugins/CustomWelcomeDashboard/customwelcomedashboard.css"
    ]
}
```

If all is setup fine we should now receive the 'Hello world' alert every time the dashboard is reloaded in the content section of Umbraco, not very helpful, yet.

### Going further - Umbraco Angular Services and Directives

Umbraco has a fine selection of angular directives, resources and services that you can use in your custom property editors and dashboards, the details are here: https://our.umbraco.com/apidocs/v8/ui/#/api

For this example it would be nice to welcome the editor by name, to achieve this we can use the **userService** here to customise our dashboard welcome message and increase friendliness:

We inject the **userService** into our AngularJS controller like so:

```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope,userService) {
```

and then we can use the userService's promise based **getCurrentUser()** method to get the details of the current logged in user:

```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope, userService) {
    var vm = this;
    vm.UserName = "guest";

    var user = userService.getCurrentUser().then(function(user) {
        console.log(user);
        vm.UserName = user.name;
    });
});
```

:::tip
Notice you can use console.log to write out to the browser console window what is being returned by the promise, it helps to debug, but also understand what properties are available to use.
:::

Finally we can now update our view to incorporate the current user's name in our Welcome Message:

```html
<h1>Welcome {{vm.UserName}} to Umbraco</h1>
```

![Custom Dashboard Welcome Message With Current User's Name](images/welcomemessagepersonalised-v8.png)

## I know what you did last Tuesday

A returning editor may find it useful to see a list of the last few articles they have been editing, with a handy link to load and continue editing. This could be instead of having to remember, and find the item again in the Umbraco Content Tree.

We can make use of Umbraco's Angular resource for retrieving audit log information, the **logResource** using the **getPagedUserLog** method to return a list of activities the current user has performed recently.

We inject the logResource into our controller:

```js
angular.Module("umbraco").controller("CustomWelcomeDashboardController", function ($scope, userService, logResource) {
```

Add a property on our ViewModel to store the log information:

```js
vm.UserLogHistory = [];
```

Add to our WelcomeDashboard.html view some markup using angular's *ng-repeat* to display a list of these log entries:

```html
<h2>We know what you edited last week...</h2>
<ul>
    <li ng-repeat="logEntry in vm.UserLogHistory.items">{{logEntry.nodeId}} - {{logEntry.logType}} - {{logEntry.timestamp  | date:'medium'}}</li>
</ul>
```

Back in our controller we'll populate the array of entries using the **logResource**, the getPagedUserLog method expects to receive a JSON object containing information to filter the log by:

```js
var userLogOptions = {
    pageSize: 10,
    pageNumber: 1,
    orderDirection: "Descending",
    sinceDate: new Date(2018, 0, 1)
};
```

These options should retrieve the last ten activities for the current user in descending order since the start of 2018, we pass the options into the **getPagedUserLog** like so:

```js
logResource.getPagedUserLog(userLogOptions)
    .then(function (response) {
        console.log(response);
        vm.UserLogHistory = response;
    });
```

Take a look at the output of console.log of the response in your browser to see the kind of information retrieved  from the log:

```js
{pageNumber: 1, pageSize: 10, totalPages: 1, totalItems: 1, items: Array(1)}
    items: Array(1)
        0:
            $$hashKey: "object:1289"
            comment: "Published languages: English (United States)"
            entityType: "Document"
            logType: "PublishVariant"
            nodeId: 1055
            parameters: "English (United States)"
            timestamp: "2019-10-10T14:49:55.223Z"
            userAvatars: []
            userId: 1
            userName: "Jesper Christensen Mayntzhusen"
    pageNumber: 1
    pageSize: 10
    totalItems: 1
    totalPages: 1
```

It's nearly all we need but missing information about the item that was saved and published!

We can use the **entityResource**, another Umbraco Angular resource to enables us to retrieve more information about an entity given its id.

Inject this into our angular controller:

```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope, userService, logResource, entityResource) {
```

We need to loop through the log items from the **logResource**. Since this includes everything, we need to filter out activities we're not interested in eg, Macro Saves, or DocType Saves. Generally we need the entry in the log to have a `nodeId`, a 'logType' of 'save' and an entity type of Media or Content.

The **entityResource** then has a **getById** method that accepts the Id of the item and the entity 'type' to retrieve useful information about the entity, ie its name and icon.

The `getById` method is supported on the following entity types: Document (content), Media, Member Type, Member Group, Media Type, Document Type, Member and Data Type. This needs to be defined before we loop through the entries.

Putting this together:

```js
logResource.getPagedUserLog(userLogOptions)
    .then(function (response) {
        console.log(response);
        vm.UserLogHistory = response;
        var filteredLogEntries = [];
        // Define supported entity types
        var supportedEntityTypes = ["Document", "Media", "MemberType", "MemberGroup", "MediaType", "DocumentType", "Member", "DataType"];
        // Loop through the response, and flter out save log entries we are not interested in
        angular.forEach(response.items, function (item) {
            // if the query finds a log entry for an entity type that isn't supported, nothing should done with that
            if (!supportedEntityTypes.includes(item.entityType)) 
                {
                    return;
                }
            // if no entity exists -1 is returned for the nodeId (eg saving a macro would create a log entry without a nodeid)
            if (item.nodeId > 0) {
                // check if we already grabbed this from the entityservice
                var nodesWeKnowAbout = [];
                if (nodesWeKnowAbout.indexOf(item.nodeId) !== -1)
                    return;
                // find things the user saved and/or published
                if (item.logType === "Save" || item.logType === "SaveVariant" || item.logType === "Publish") {
                    // check if it is media or content
                    if (item.entityType === "Document") {
                        item.editUrl = "content/content/edit/" + item.nodeId;
                    }
                    if (item.entityType === "Media") {
                        item.editUrl = "media/media/edit/" + item.nodeId;
                    }

                    if (typeof item.entityType !== 'undefined') {
                        // use entityResource to retrieve details of the content/media item
                        var ent = entityResource.getById(item.nodeId, item.entityType).then(function (ent) {
                            console.log(ent);
                            item.Content = ent;
                        });

                        nodesWeKnowAbout.push(ent.id);
                        filteredLogEntries.push(item);
                    }
                }
            }
        });
        vm.UserLogHistory.items = filteredLogEntries;
    });
});
```

Finally update our view to use the additional retrieved entity information:

```js
<h2>We know what you edited last week...</h2>
<ul class="unstyled">
    <li ng-repeat="logEntry in vm.UserLogHistory.items">
        <i class="{{logEntry.Content.icon}}"></i> <a href="/Umbraco/#/{{logEntry.editUrl}}">{{logEntry.Content.name}} <span ng-if="logEntry.comment">- {{logEntry.comment}}</span></a> - <span class="text-muted">(Edited on: {{logEntry.timestamp  | date:'medium'}})</span>
    </li>
</ul>
```

and we should have a list of recently saved content and media:

![We know what you edited last week...](images/WeKnowWhatYouEditedLastWeek-v8.png)

:::note
The url /umbraco/#/content/content/edit/1234 is the path to open up a particular entity (with id 1234) ready for editing.

The `logResource` has a few bugs prior to version 8.1.4, so if you are on a lower version this may not give the expected result.
:::

## I know what you want to do today

One of the key user journeys an editor will make in the backoffice is to create a new thing of some sort. If it is a person's job to create new blog entries in the same section two or three times a day, why not create them some handy shortcuts to achieve these common tasks:

We can use the knowledge that by convention a link to 'edit a page' can be made to present the user with a brand new content item of the alias type to create within the section. The additional querystring parameters doctype=alias and create=true also needs to be passed.

Add the following to our view:

```html
<div>
    <a class="btn btn-primary btn-large" href="/umbraco/#/content/content/edit/1075?doctype=BlogPost&create=true">
        <i class="icon-edit"></i>
        Create New Blog Post
    </a>
</div>
```

Where 1075, is the id of our blog section, and BlogPost is the alias of the type of document we want to create.

![Handy shortcut buttons](images/CreateNewBlogPost-v8.png)

At this point we are done with the tutorial, your files should contain this:

CustomWelcomeDashboardController:

```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope, userService, logResource, entityResource) {
    var vm = this;
    vm.UserName = "guest";
    vm.UserLogHistory = [];

    var user = userService.getCurrentUser().then(function (user) {
        console.log(user);
        vm.UserName = user.name;
    });

    var userLogOptions = {
        pageSize: 10,
        pageNumber: 1,
        orderDirection: "Descending",
        sinceDate: new Date(2018, 0, 1)
    };

    logResource.getPagedUserLog(userLogOptions)
        .then(function (response) {
            console.log(response);
            vm.UserLogHistory = response;
            var filteredLogEntries = [];
            // Define supported entity types
            var supportedEntityTypes = ["Document", "Media", "MemberType", "MemberGroup", "MediaType", "DocumentType", "Member", "DataType"];
            // Loop through the response, and flter out save log entries we are not interested in
            angular.forEach(response.items, function (item) {
                // if the query finds a log entry for an entity type that isn't supported, nothing should done with that
                if (!supportedEntityTypes.includes(item.entityType)) 
                {
                    return;
                }
                // if no entity exists -1 is returned for the nodeId (eg saving a macro would create a log entry without a nodeid)
                if (item.nodeId > 0) {
                    // check if we already grabbed this from the entityservice
                    var nodesWeKnowAbout = [];
                    if (nodesWeKnowAbout.indexOf(item.nodeId) !== -1)
                        return;
                    // find things the user saved
                    if (item.logType === "Save" || item.logType === "SaveVariant" || item.logType === "Publish") {
                        // check if it is media or content
                        if (item.entityType === "Document") {
                            item.editUrl = "content/content/edit/" + item.nodeId;
                        }
                        if (item.entityType === "Media") {
                            item.editUrl = "media/media/edit/" + item.nodeId;
                        }

                        if (typeof item.entityType !== 'undefined') {
                            // use entityResource to retrieve details of the content/media item
                            var ent = entityResource.getById(item.nodeId, item.entityType).then(function (ent) {
                                console.log(ent);
                                item.Content = ent;
                            });

                            nodesWeKnowAbout.push(ent.id);
                            filteredLogEntries.push(item);
                        }
                    }
                }
            });
            vm.UserLogHistory.items = filteredLogEntries;
        });
});
```

WelcomeDashboard.html:

```html
<div class="welcome-dashboard" ng-controller="CustomWelcomeDashboardController as vm">
    <h1>Welcome {{vm.UserName}} to Umbraco</h1>
    <p>We hope you find the experience of editing your content with Umbraco enjoyable and delightful. If you discover any problems with the site please report them to the support team at <a href="mailto:">support@popularumbracopartner.com</a></p>

<h2>We know what you edited last week...</h2>
<ul class="unstyled">
    <li ng-repeat="logEntry in vm.UserLogHistory.items">
        <i class="{{logEntry.Content.icon}}"></i> <a href="/Umbraco/#/{{logEntry.editUrl}}">{{logEntry.Content.name}} <span ng-if="logEntry.comment">- {{logEntry.comment}}</span></a> - <span class="text-muted">(Edited on: {{logEntry.timestamp  | date:'medium'}})</span>
    </li>
</ul>

    <div>
        <a class="btn btn-primary btn-large" href="/umbraco/#/content/content/edit/1075?doctype=BlogPost&create=true">
            <i class="icon-edit"></i>
            Create New Blog Post
        </a>
    </div>
</div>
```

## Custom External Data - creating your own angular resource

You can create your own custom angular services/resources, to interact with your own serverside data (using UmbracoAuthorizedJsonController), The property editor tutorial has a step explaining how to do this [part 4 - Adding server-side data to a property editor](../Creating-a-Property-Editor/part-4.md).

## The end

With all of the steps completed, you should have a functional dashboard that will let the logged-in user see the changes they made!

Hopefully this tutorial has given you some ideas on what is possible to do when creating a dashboard. Remember to check out the [Angular API docs](https://our.umbraco.com/apidocs/v8/ui/#/api) for more info on all of the resources and services you can find for the backoffice!
