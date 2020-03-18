---
versionFrom: 8.0.0
meta.Title: "Content Apps"
meta.Description: "A guide to Umbraco Content Apps in the backoffice"
---

# Content Apps

## What are Content Apps?

Content Apps are **companions** to the editing experience when working with content or media in the Umbraco backoffice.

Content Apps are a new concept in Umbraco 8. Editors can switch from editing 'Content' to accessing contextual information related to the item they are editing.

![Content Apps in backoffice](images/content-app-1.png)

### Default Content Apps

**'Info'** - The 'Info' Content App is a default Content App for all items, replacing the 'Info' tab in Umbraco 7 for displaying Links, History and Status of the current content item.

### Custom Content Apps

As an integrated part of Umbraco it is possible for you as a developer to create and provide your editors with helpful Content Apps.

For example, you could create a Google Analytics integration within a Content App that displays to editors the current 'page views' for the content item they are editing.

#### Controlling Appearance/Position

You can associate an icon and control the position of your custom Content App. The position, for example between 'Content' and 'Info', is set via a 'weighting' number.

#### Permissions

Content Apps can be configured to appear dependent on Section, Content Type and User Group Permissions.

#### Read-Only?

Content Apps are designed to be companions to the Content Item. They should enhance the editor's experience by enabling quick access to contextual information for the particular content item they are editing. Content Apps are not intended to be used for the editing content.

## Creating a Custom Content App

This guide explains how to set up a custom Content App in the following steps:

* Adding a Content App that counts how many words are added for each property type
* Limiting the Content App to appear for only specific content types
* Limiting which user groups can see the Content App

A basic understanding of how to use AngularJS with Umbraco is required.  If you have created a property value editor before, this will all feel very familiar.

### Setting up the Plugin

The first thing we do is create a new folder inside `/App_Plugins` folder. We will call it `WordCounter`.

Next we need to create a manifest file to describe what this Content App does. This manifest will tell Umbraco about our new Content App and allows us to inject any needed files into the application.

Create a new file in the `/App_Plugins/WordCounter/` folder and name it `package.manifest`. In this new file, copy the code snippet below and save it. This code describes the Content App. To help you understand the JSON, read the inline comments for details on each bit:

```json5
{
    // define the content apps you want to create
    "contentApps": [
    {
        "name": "Word Counter", // required - the name that appears under the icon
        "alias": "wordCounter", // required - unique alias for your app
        "weight": 0, // optional, default is 0, use values between -99 and +99 to appear between the existing Content (-100) and Info (100) apps
        "icon": "icon-calculator", // required - the icon to use
        "view": "~/App_Plugins/WordCounter/wordcounter.html", // required - the location of the view file
    }
    ],
    // array of files we want to inject into the application on app_start
    "javascript": [
        "~/App_Plugins/WordCounter/wordcounter.controller.js"
    ]
}
```

### Creating the View and the Controller

Add 2 additional files to the `/App_Plugins/WordCounter/` folder:

- `wordcounter.html`
- `wordcounter.controller.js`

These 2 files will be our main files for the app, with the `.html` file handling the view and the `.js` file handling the functionality.

In the `.js` file we declare our AngularJS controller and inject Umbraco's editorState and userService:

```javascript
angular.module("umbraco")
    .controller("My.WordCounterApp", function ($scope, editorState, userService, contentResource) {

        var vm = this;
        vm.CurrentNodeId = editorState.current.id;
        vm.CurrentNodeAlias = editorState.current.contentTypeAlias;

        var counter = contentResource.getById(vm.CurrentNodeId).then(function (node) {
            var properties = node.variants[0].tabs[0].properties;

            vm.propertyWordCount = {};

            var index;
            for (index = 0; index < properties.length; ++index) {
                var words = properties[index].value;
                var wordCount = words.trim().split(/\s+/).length;

                vm.propertyWordCount[properties[index].label] = wordCount;
            }
        });

        var user = userService.getCurrentUser().then(function (user) {
            vm.UserName = user.name;
        });

    });
```

And in the `.html` file:

```csharp
<div  ng-controller="My.WordCounterApp as vm">
    <umb-box>
        <umb-box-header
            title="Amount of words for each property" />
        <umb-box-content>
            <div ng-repeat="(key, value) in vm.propertyWordCount">
                <p>Property: <span style="font-style:italic">{{key}}</span>, amount of words: <span style="font-style:italic">{{value}}</span> </p>
            </div>
            <hr />

            <ul>
                <li>Current node id: <b>{{vm.CurrentNodeId}}</b></li>
                <li>Current node alias: <b>{{vm.CurrentNodeAlias}}</b></li>
                <li>Current user: <b>{{vm.UserName}}</b></li>
            </ul>
        </umb-box-content>
    </umb-box>
</div>
```

### Checking it works

After the above edits are done, restart your application. Go to any content node and you should now see an app called Word Counter. Clicking on the icon should say "Amount of words for each property" and confirm the details of the current item and user.  You can now adapt your Content App to retrieve external data using the standard Umbraco and AngularJS approach.

![Content App in action: Word Counter](images/content-app-2.png)

### Limiting according to Content Type

You can set your Content App to only show for specific content types by updating your `package.manifest` file and adding a 'show' directive to the Content App definition. For example:

```json5
{
    "contentApps": [
        {
            "show": [
                "-content/homePage", // hide for content type 'homePage'
                "+content/*", // show for all other content types
                "+media/*" // show for all media types
            ]
        }
    ]
}
```

:::tip
When the 'show' directive is omitted then the app will be shown for all content types.

Also, when you want to exclude content types, make sure to include all the rest using `"+content/*"`.
:::

### Limiting according to User Role

In a similar way, you can limit your Content App according to user roles (groups).  For example:

```json5
{
    "contentApps": [
        {
            "show": [
                "+role/admin"  // show for 'admin' user group
            ]
        }
    ]
}
```

:::tip
When a role restriction is given in the manifest, it overrides any other restrictions based on type.
:::

## Creating a Content App in C#

This is an example of how to register a Content App with C# and perform your own custom logic to show a Content App.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using Umbraco.Core.Composing;
using Umbraco.Core.Models;
using Umbraco.Core.Models.ContentEditing;
using Umbraco.Core.Models.Membership;

namespace Umbraco.Web.UI
{

    public class WordCounterAppComponent : IUserComposer
    {
        public void Compose(Composition composition)
        {
            // Add our word counter content app into the composition aka into the DI
            composition.ContentApps().Append<WordCounterApp>();
        }
    }

    public class WordCounterApp : IContentAppFactory
    {
        public ContentApp GetContentAppFor(object source, IEnumerable<IReadOnlyUserGroup> userGroups)
        {
            // Can implement some logic with userGroups if needed
            // Allowing us to display the content app with some restrictions for certain groups
            if (userGroups.All(x => x.Alias.ToLowerInvariant() != Umbraco.Core.Constants.Security.AdminGroupAlias))
                return null;
			
            // only show app on content items
            if(source is IContent)
            {
                var wordCounterApp = new ContentApp
                {
                    Alias = "wordCounter",
                    Name = "Word Counter",
                    Icon = "icon-calculator",
                    View = "/App_Plugins/WordCounter/wordcounter.html",
                    Weight = 0                
                };
                
                return wordCounterApp;
            }
            
            return null;
        }        
    }
}
```

You will still need to add all of the files you added above but, because your `C#` code is adding the Content App, the `package.manifest` file can be simplified like this:

```json5
{
    // array of files we want to inject into the application on app_start
    "javascript": [
        "~/App_Plugins/WordCounter/wordcounter.controller.js"
    ]
}
```

## Notification badges

There are times when you want to draw the attention of editors to your content badge, so they know they need to take some action. That is where notification badges come in to play.

When you set a badge, a circle with a chosen background and a number in it will be added to the content app icon.

![Content App badge](images/content-app-badge.png)

You can enable a badge by using this code in the angular controller of your content app.

```javascript
$scope.model.badge = {
  count: 5, // the number for the badge - anything non-zero triggers the badge
  type: "warning" // optional: determines the badge color - "warning" = dark yellow, "alert" = red, anything else = blue (matching the top-menu background color)
};
```

From version 8.4.0 and up it is also possible to set a notification badge from an `IContentAppFactory`. This is achieved by setting the badge property on the ContentApp model.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using Umbraco.Core.Composing;
using Umbraco.Core.Models;
using Umbraco.Core.Models.ContentEditing;
using Umbraco.Core.Models.Membership;

namespace Umbraco.Web.UI
{

    public class WordCounterAppComponent : IUserComposer
    {
        public void Compose(Composition composition)
        {
            // Add our word counter content app into the composition aka into the DI
            composition.ContentApps().Append<WordCounterApp>();
        }
    }

    public class WordCounterApp : IContentAppFactory
    {
        public ContentApp GetContentAppFor(object source, IEnumerable<IReadOnlyUserGroup> userGroups)
        {
            // Can implement some logic with userGroups if needed
            // Allowing us to display the content app with some restrictions for certain groups
            if (userGroups.All(x => x.Alias.ToLowerInvariant() != Umbraco.Core.Constants.Security.AdminGroupAlias))
                return null;
            
            // only show app on content items
            if(source is IContent)
            {
                var wordCounterApp = new ContentApp
                {
                    Alias = "wordCounter",
                    Name = "Word Counter",
                    Icon = "icon-calculator",
                    View = "/App_Plugins/WordCounter/wordcounter.html",
                    Weight = 0,
                    Badge = new ContentAppBadge { Count = 5 , Type = ContentAppBadgeType.Warning }                
                };
                
                return wordCounterApp;               
            
            }
            
            return null;
        }  
    }
}
```

Possible values for the `ContentAppBadge` Type are *Default*, *Alert* and *Warning*.
