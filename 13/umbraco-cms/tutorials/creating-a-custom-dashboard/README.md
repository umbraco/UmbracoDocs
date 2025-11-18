---
description: A guide that shows you how you can create a custom dashboard in Umbraco CMS.
---

# Creating a Custom Dashboard

## What is a Dashboard?

A Dashboard is a tab on the right-hand side of a section eg. the Getting Started dashboard in the Content section:

![Welcome dashboard](../images/whatisadashboard-v10.jpg)

### Why provide a Custom Dashboard for editors?

It is generally considered good practice to provide a custom dashboard to welcome your editors to the backoffice of your site. You can provide information about the site and/or provide a helpful gateway to common functionality the editors will use. This guide will show the basics of creating a custom 'Welcome Message' dashboard. The guide will also show how you can go a little further to provide interaction using AngularJS.

The finished dashboard will give the editors an overview of which pages and media files they've worked on most recently.

### Prerequisites

This tutorial uses AngularJS with Umbraco, so it does not cover AngularJS itself, there are tons of resources on that already here:

* [Egghead.io](https://egghead.io/courses/angularjs-fundamentals)
* [AngularJS.org/tutorial](https://docs.angularjs.org/tutorial)

There are a lot of parallels with Creating a Property Editor. The tutorial [Creating a Property Editor Tutorial](../creating-a-property-editor/) is worth a read too.

At the end of this guide, we should have a friendly welcoming dashboard displaying a list of the editor's recent site updates.

## Step 1: Creating and configuring the Dashboard

1. Create a new folder inside our site's `/App_Plugins` folder. call it `CustomWelcomeDashboard`
2. Create an HTML file inside this folder called `WelcomeDashboard.html`. The HTML file will contain a fragment of an HTML document and does not need \<html>\<head>\<body> entities.
3. Add the following HTML to the `WelcomeDashboard.html`:

{% code title="WelcomeDashboard.html" lineNumbers="true" %}
```html
<div class="welcome-dashboard">
    <h1>Welcome to Umbraco</h1>
    <p>We hope you find the experience of editing your content with Umbraco enjoyable and delightful. If you discover any problems with the site, report them to the support team at <a href="mailto:">support@popularumbracopartner.com</a></p>
    <p>You can put anything here...</p>
</div>
```
{% endcode %}

Similar to a property editor you will now register the dashboard in a `package.manifest` file.

4\. Add a new file inside the `~/App_Plugins/CustomWelcomeDashboard` folder called `package.manifest`:

{% code title="package.manifest" lineNumbers="true" %}
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
{% endcode %}

The above configuration is effectively saying:

> Add a tab called 'WelcomeDashboard' to the 'Content' section of the Umbraco site, use the WelcomeDashboard.html as the content (view) of the dashboard and don't allow 'translators', but do allow 'admins' to see it.

{% hint style="info" %}
The order in which the tab will appear in the Umbraco Backoffice depends on its weight. To make our Custom Welcome message the first Tab the editors see, make sure the weight is less than the default dashboards. [Read more about the default weights](../../extending/dashboards.md).

You can specify multiple controls to appear on a particular tab and multiple tabs in a particular section.
{% endhint %}

## Step 2: Add Language Keys

After registering your dashboard, it will appear in the backoffice - however, it will have its dashboard alias \[WelcomeDashboard] wrapped in square brackets. This is because it is missing a language key. The language key allows people to provide a translation of the dashboard name in multilingual environments. To remove the square brackets - add a language key:

1. Create a _Lang_ folder in your custom dashboard folder
2. Create a package-specific language file: `~/App_Plugins/CustomWelcomeDashboard/Lang/en-US.xml`

{% hint style="info" %}
The `App_Plugins` version of the `Lang` directory is case-sensitive on Linux systems, so make sure that it starts with a capital `L`.
{% endhint %}

{% code title="en-US.xml" lineNumbers="true" %}
```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language>
  <area alias="dashboardTabs">
    <key alias="welcomeDashboard">Welcome</key>
  </area>
</language>
```
{% endcode %}

[Read more about language files](../../extending/language-files.md)

This is how our dashboard looks so far:

<figure><img src="../images/welcomemessage-v8.PNG" alt=""><figcaption></figcaption></figure>

We can apply the same workflow to elements inside the dashboard, not only the name/alias.

3\. Extend the translation file `xml` with the following code:

{% code title="en-US.xml" lineNumbers="true" %}
```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language>
    <area alias="dashboardTabs">
        <key alias="welcomeDashboard">Welcome</key>
    </area>
    <area alias="welcomeDashboard">
        <key alias="heading">Welcome!</key>
        <key alias="bodytext">This is the Backoffice. From here, you can modify the content, media, and settings of your website.</key>
        <key alias="copyright">© Sample Company 20XX</key>
    </area>
</language>
```
{% endcode %}

We are adding another area tag with a few keys. we then need to add some HTML to the `WelcomeDashboard`.

4. Adjust the dashboard HTML with the following code:

{% code title="WelcomeDashboard.html" lineNumbers="true" %}
```html
<div class="welcome-dashboard">
    <h1><localize key="welcomeDashboard_heading">Default heading</localize></h1>
    <p><localize key="welcomeDashboard_bodytext">Default bodytext</localize></p>
    <p><localize key="welcomeDashboard_copyright">Default copyright</localize></p>
</div>
```
{% endcode %}

The `localize` tag will be replaced with the translated keywords. We have some default text inside the tags above, which can be removed. It would usually not be visible after the translation is applied.

As for the `localize` tag syntax in HTML, the area alias is combined with the key alias - so if you want to translate:

{% code title="en-US.xml" %}
```html
<localize key="welcomeDashboard_heading">Default heading</localize>
```
{% endcode %}

The XML for that specific key will look like this:

{% code title="en-US.xml" %}
```xml
    <area alias="welcomeDashboard">
        <key alias="heading">Welcome!</key>
    </area>
```
{% endcode %}

The area and key aliases are combined and an underscore is added in between.

![Dashboard with translation keys](../images/dashboard-untranslated-v10.png)

{% hint style="info" %}
If you don't see the brackets disappearing - you may need to restart the website.
{% endhint %}

### Different languages

With the above steps completed, our dashboard is all set up to be translated across different backoffice languages.

To test it out, you can add another language XML file, like `da.xml` for the Danish language.

{% code title="da.xml" %}
```xml
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<language>
    <area alias="dashboardTabs">
        <key alias="welcomeDashboard">Velkommen</key>
    </area>
    <area alias="welcomeDashboard">
        <key alias="heading">Velkommen!</key>
        <key alias="bodytext">Dette er Backoffice. Herfra kan du ændre indholdet, medierne og indstillingerne på din hjemmeside.</key>
        <key alias="copyright">© Sample Selskab 20XX</key>
    </area>
</language>
```
{% endcode %}

The backoffice language can be changed in the Users section if you wish to test out the translations.

![Changing backoffice language](../images/changing-languages-v10.png)

![Dashboard in danish](../images/dashboard-translated-v10.png)

## Step 3: Adding style

Dashboards can be styled with CSS, however, there are a couple more steps to do to be able to apply a custom stylesheet.

Inside the package.manifest we add a bit of JSON to describe the dashboard's required JavaScript and stylesheet resources:

1. Add the following JSON to the `package.manifest` file:

{% code title="package.manifest" %}
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
{% endcode %}

2. Create a stylesheet in our `CustomWelcomeDashboard` folder called `customwelcomedashboard.css`, and add some style:

{% code title="CustomWelcomeDashboard.csss" %}
```css
.welcome-dashboard h1 {
    font-size:4em;
    color:purple;
}
```
{% endcode %}

The stylesheet will be loaded and applied to our dashboard. Add images and HTML markup as required.

![Custom Dashboard Welcome Message With styles...](../images/welcomemessagewithstyles-v10.png)

{% hint style="info" %}
One caveat is that the `package.manifest` file is loaded into memory when Umbraco starts up. If you are adding a new stylesheet or JavaScript file you will need to start and stop your application for it to be loaded.
{% endhint %}

{% hint style="info" %}
**For version 9 and above**

If the title doesn't change color, [Smidge](https://github.com/shazwazza/smidge) may be caching the CSS and JavaScript. To clear the cache and get it to load in the new JavaScript and CSS, you can configure the [Runtime minification settings](../../reference/configuration/runtimeminificationsettings.md) in the `appsettings.json` file. When you reload the page, you'll see the colorful title.

For information on creating bundles of your site's CSS or JavaScript files in your code, see the [Bundling & Minification for JavaScript and CSS](../../fundamentals/design/stylesheets-javascript.md#bundling--minification-for-javascript-and-css) section.

**Smidge with RunTimeMinification setting is scheduled for removal on Umbraco 14. You can install the package separately if needed.**
{% endhint %}

Hopefully, now you can see the potential of what you can provide to an editor as a basic welcome dashboard.

## Step 4: Adding functionality

We can add functionality to the dashboard by associating an AngularJS controller with the HTML view.

1. Add a new file to the `CustomWelcomeDashboard` folder called `customwelcomedashboard.controller.js` where our controller code will live.
2. Register the AngularJS controller to the Umbraco Angular module:

{% code title="customwelcomedashboard.controller.js" %}
```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope) {
    var vm = this;
    alert("hello world");
});
```
{% endcode %}

3. Update the outer div to wire up the controller to the view In the HTML view:

{% code title="WelcomeDashboard.html" %}
```html
<div class="welcome-dashboard" ng-controller="CustomWelcomeDashboardController as vm">
```
{% endcode %}

{% hint style="info" %}
The use of `vm` (short for view model) is to enable communication between the view and the controller.
{% endhint %}

4. Update the `package.manifest` file to load the additional controller JavaScript file when the dashboard is displayed:

{% code title="package.manifest" %}
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
{% endcode %}

Once done, we should receive the 'Hello world' alert every time the dashboard is reloaded in the content section.

## Step 5: Using Umbraco Angular Services and Directives

Umbraco has a fine selection of angular directives, resources, and services that you can use in your custom property editors and dashboards.

The details are in the [Backoffice UI](../../reference/api-documentation.md). For this example, it would be nice to welcome the editor by name. To achieve this we can use the `userService` to customize our dashboard welcome message and increase friendliness.

1. Inject the `userService` into our AngularJS controller:

{% code title="customwelcomedashboard.controller.js" %}
```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope,userService) {
```
{% endcode %}

2. Use the `userService's` promise based `getCurrentUser()` method to get the details of the currently logged-in user:

{% code title="customwelcomedashboard.controller.js" %}
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
{% endcode %}

{% hint style="info" %}
Notice you can use `console.log()` to write out to the browser console window what is being returned by the promise. This helps to debug, but also understand what properties are available to use.
{% endhint %}

3. Update the view to incorporate the current user's name in our Welcome Message:

{% code title="WelcomeDashboard.html" %}
```html
<h1><localize key="welcomeDashboard_heading">Default heading</localize> {{vm.UserName}}</h1>
```
{% endcode %}

![Custom Dashboard Welcome Message With Current User's Name](../images/welcomemessagepersonalised-v10.png)

### Add a list of edited articles

An editor may find it useful to see a list of articles they have been editing along with a link to load and continue editing. This could be instead of having to remember and find the item again in the Umbraco Content Tree.

We can make use of Umbraco's Angular resource for retrieving audit log information.

We add `logResource` to the method and use the `getPagedUserLog` method to return a list of activities the current user has performed recently.

1. Inject the `logResource` into our controller:

{% code title="customwelcomedashboard.controller.js" %}
```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope, userService, logResource) {
```
{% endcode %}

2. Add a property on our `ViewModel` to store the log information:

{% code title="customwelcomedashboard.controller.js" %}
```js
vm.UserLogHistory = []; 
```
{% endcode %}

3. Add to our `WelcomeDashboard.html` View some markup using angular's `ng-repeat` to display a list of these log entries:

{% code title="WelcomeDashboard.html" %}
```html
<h2>We know what you edited last week...</h2>
<ul>
    <li ng-repeat="logEntry in vm.UserLogHistory.items">{{logEntry.nodeId}} - {{logEntry.logType}} - {{logEntry.timestamp  | date:'medium'}}</li>
</ul>
```
{% endcode %}

4. Populate the array of entries using the `logResource` In our controller.

The `getPagedUserLog` method expects to receive a `JSON object` containing information to filter the log by:

{% code title="customwelcomedashboard.controller.js" %}
```js
var userLogOptions = {
    pageSize: 10,
    pageNumber: 1,
    orderDirection: "Descending",
    sinceDate: new Date(2018, 0, 1)
};
```
{% endcode %}

These options should retrieve the last ten activities for the current user in descending order since the start of 2018.

5. Pass the options into the `getPagedUserLog` like so:

{% code title="customwelcomedashboard.controller.js" %}
```js
logResource.getPagedUserLog(userLogOptions)
    .then(function (response) {
        console.log(response);
        vm.UserLogHistory = response;
    });
```
{% endcode %}

Take a look at the output of console.log of the response in your browser to see the kind of information retrieved from the log:

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
            userName: "Jakob N"
    pageNumber: 1
    pageSize: 10
    totalItems: 1
    totalPages: 1
```

It's nearly all we need but missing information about the item that was saved and published.

We can use the `entityResource`, another Umbraco Angular resource to enable us to retrieve more information about an entity given its id.

6. Inject the following code into our angular controller:

{% code title="customwelcomedashboard.controller.js" %}
```js
angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope, userService, logResource, entityResource) {
```
{% endcode %}

We need to loop through the log items from the `logResource`. Since this includes everything, we need to filter out activities we're not interested in eg, Macro Saves, or DocType Saves. Generally, we need the entry in the log to have a `nodeId`, a `logType` of 'save' and an entity type of Media or Content.

The `entityResource` has a `getById` method that accepts the `ID` of the item and the entity `type` to retrieve useful information about the entity. For example, its Name and Icon.

The `getById` method is supported on the following entity types:

* Document (content)
* Media
* Member Type
* Member Group
* Media Type
* Document Type
* Member
* Data Types

This needs to be defined before we loop through the entries.

Putting this together it will look like this:

{% code title="customwelcomedashboard.controller.js" %}
```js
  logResource.getPagedUserLog(userLogOptions)
        .then(function (response) {
            console.log(response);
            vm.UserLogHistory = response;

            // define the entity types that we care about, in this case only content and media
            var supportedEntityTypes = ["Document", "Media"];

            // define an empty array "nodes we know about"
            var nodesWeKnowAbout = [];

            // define an empty array "filtered log entries"
            var filteredLogEntries = [];

            // loop through the entries in the User Log History
            angular.forEach(response.items, function (item) {

              // if the item is already in our "nodes we know about" array, skip to the next log entry
              if (nodesWeKnowAbout.includes(item.nodeId)) {
                return;
              }

              // if the log entry is not for an entity type that we care about, skip to the next log entry
              if (!supportedEntityTypes.includes(item.entityType)) {
                return;
              }

              // if the user did not save or publish, skip to the next log entry
              if (item.logType !== "Save" && item.logType !== "Publish") {
                return;
              }

              // if the item does not have a valid nodeId, skip to the next log entry
              if (item.nodeId < 0) {
                return;
              }

              // now, push the item's nodeId to our "nodes we know about" array
              nodesWeKnowAbout.push(item.nodeId);

              // use entityResource to retrieve details of the content/media item
              var ent = entityResource.getById(item.nodeId, item.entityType).then(function (ent) {
                  console.log(ent);
                  item.Content = ent;
              });

              // get the edit url
              if (item.entityType === "Document") {
                  item.editUrl = "content/content/edit/" + item.nodeId;
              }
              if (item.entityType === "Media") {
                  item.editUrl = "media/media/edit/" + item.nodeId;
              }

              // push the item to our "filtered log entries" array
              filteredLogEntries.push(item);

            // end of loop
            });

            // populate the view with our "filtered log entries" array
            vm.UserLogHistory.items = filteredLogEntries;

        // end of function
        });
```
{% endcode %}

7. Update the view to use the additional retrieved entity information:

{% code title="WelcomeDashboard.html" %}
```js
<h2>We know what you edited last week...</h2>
<ul class="unstyled">
    <li ng-repeat="logEntry in vm.UserLogHistory.items">
        <i class="{{logEntry.Content.icon}}"></i> <a href="/Umbraco/#/{{logEntry.editUrl}}">{{logEntry.Content.name}} <span ng-if="logEntry.comment">- {{logEntry.comment}}</span></a> - <span class="text-muted">(Edited on: {{logEntry.timestamp  | date:'medium'}})</span>
    </li>
</ul>
```
{% endcode %}

We now have a list of recently saved content and media on our Custom Dashboard:

![We know what you edited last week...](../images/WeKnowWhatYouEditedLastWeek-v10.png)

{% hint style="info" %}
The URL `/umbraco/#/content/content/edit/1234` is the path to open up a particular entity (with id 1234) ready for editing.

The `logResource` has a few bugs prior to version 8.1.4. If you are on a lower version this may not give the expected result.
{% endhint %}

### Creating a shortcut for creating new content

A key user journeys an editor will make in the backoffice is to create content. If it is a person's job to create new blog entries, why not create a handy shortcut to help them achieve this common task?

We can add a shortcut to allow the users to add a blog post.

To do this we add the following code to our view:

{% code title="WelcomeDashboard.html" %}
```html
<div>
    <a class="btn btn-primary btn-large" href="/umbraco/#/content/content/edit/1065?doctype=BlogPost&create=true">
        <i class="icon-edit"></i>
        Create New Blog Post
    </a>
</div>
```
{% endcode %}

`1065` is the `ID` of our blog section and `blogPost` is the alias of the type of document we want to create.

![Handy shortcut buttons](../images/CreateNewBlogPost-v10.png)

At this point we are done with the tutorial, your files should contain this:

<details>

<summary>CustomWelcomeDashboardController</summary>

{% code title="customwelcomedashboard.controller.js" %}
```javascript
// Some angular.module("umbraco").controller("CustomWelcomeDashboardController", function ($scope, userService, logResource, entityResource) {
    var vm = this;
    vm.UserName = "guest";

    var user = userService.getCurrentUser().then(function (user) {
        console.log(user);
        vm.UserLogHistory = [];
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

            // define the entity types that we care about, in this case only content and media
            var supportedEntityTypes = ["Document", "Media"];

            // define an empty array "nodes we know about"
            var nodesWeKnowAbout = [];

            // define an empty array "filtered log entries"
            var filteredLogEntries = [];

            // loop through the entries in the User Log History
            angular.forEach(response.items, function (item) {

              // if the item is already in our "nodes we know about" array, skip to the next log entry
              if (nodesWeKnowAbout.includes(item.nodeId)) {
                return;
              }

              // if the log entry is not for an entity type that we care about, skip to the next log entry
              if (!supportedEntityTypes.includes(item.entityType)) {
                return;
              }

              // if the user did not save or publish, skip to the next log entry
              if (item.logType !== "Save" && item.logType !== "Publish") {
                return;
              }

              // if the item does not have a valid nodeId, skip to the next log entry
              if (item.nodeId < 0) {
                return;
              }

              // now, push the item's nodeId to our "nodes we know about" array
              nodesWeKnowAbout.push(item.nodeId);

              // use entityResource to retrieve details of the content/media item
              var ent = entityResource.getById(item.nodeId, item.entityType).then(function (ent) {
                  console.log(ent);
                  item.Content = ent;
              });

              // get the edit url
              if (item.entityType === "Document") {
                  item.editUrl = "content/content/edit/" + item.nodeId;
              }
              if (item.entityType === "Media") {
                  item.editUrl = "media/media/edit/" + item.nodeId;
              }

              // push the item to our "filtered log entries" array
              filteredLogEntries.push(item);

            // end of loop
            });

            // populate the view with our "filtered log entries" array
            vm.UserLogHistory.items = filteredLogEntries;

        // end of function
        });

});
```
{% endcode %}

</details>

<details>

<summary>WelcomeDashboard.html</summary>

{% code title="WelcomeDashboard.html" %}
```html
<div class="welcome-dashboard" ng-controller="CustomWelcomeDashboardController as vm">
    <h1><localize key="welcomeDashboard_heading">Default heading</localize> {{vm.UserName}}</h1>
    <p><localize key="welcomeDashboard_bodytext">Default bodytext</localize></p>
    <p><localize key="welcomeDashboard_copyright">Default copyright</localize></p>

    <h2>We know what you edited last week...</h2>
    <ul class="unstyled">
        <li ng-repeat="logEntry in vm.UserLogHistory.items">
            <i class="{{logEntry.Content.icon}}"></i> <a href="/Umbraco/#/{{logEntry.editUrl}}">{{logEntry.Content.name}} <span ng-if="logEntry.comment">- {{logEntry.comment}}</span></a> - <span class="text-muted">(Edited on: {{logEntry.timestamp  | date:'medium'}})</span>
        </li>
    </ul>

    <div>
        <a class="btn btn-primary btn-large" href="/umbraco/#/content/content/edit/1065?doctype=BlogPost&create=true">
            <i class="icon-edit"></i>
            Create New Blog Post
        </a>
    </div>
</div>
```
{% endcode %}

</details>

![Custom Dashboard extended with UI Library Card](<../images/extendedWithUiLibrary (1).png>)

## **Extending with Custom External Data**

You can create custom Angular services/resources to interact with your own serverside data using the`UmbracoAuthorizedJsonController`.

Have a look at the [property editor tutorial](../creating-a-property-editor/part-4.md) step which explains how this can be done.

## Going Further

With all of the steps completed, you should have a functional dashboard that will let the logged-in user see the changes they made! Hopefully, this tutorial has given you some ideas on what is possible to do when creating a dashboard.

You can also go further and [extend the dashboard](extending-the-dashboard-using-the-umbraco-ui-library.md) with UI elements from the Umbraco UI Library.

Remember to check out the [Angular API docs](../../reference/api-documentation.md) for more info on all of the resources and services you can find for the backoffice.
