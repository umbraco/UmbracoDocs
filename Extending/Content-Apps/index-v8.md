---
versionFrom: 8.0.0
---

# Content Apps

## What are Content Apps?

Content Apps encapsulate **companion read-only information** relating to the current content item in the Umbraco backoffice.

Content Apps are a new concept in v8. Editors can switch from editing 'Content' to accessing contextual information related to the item they are editing.

![Content Apps in back office](images/content-apps-location.png)

### Default Content Apps
**'Info'** - The 'Info' Content App is a default Content App for all items, similar to the 'Info' tab in Umbraco V7 for displaying Links, History and Status of the current content item.

### Custom Content Apps

You can extend Umbraco by creating your own custom companion Content Apps. For example, you could create a Google Analytics integration within a Content App that displays to editors, the current 'page views' for the content item they are editing.

#### Controlling Appearance/Position

You can associate an icon with your custom Content App, control the position (between 'Content' and 'Info') where your custom Content App should appear via a 'weighting' number

#### Permissions ####

Content Apps can be configured to appear dependent on Section, Content Type and User Group Permissions. 

#### Read-Only?

Content Apps are designed to be companions to the Content Item. They should enhance the editor's experience by enabling quick access to contextual information for the particular content item they are editing. Content Apps are not intended to be used for the editing of content, they are not the equivalent of V7's tabs!

## Creating a Custom Content App

This guide explains how to set up a custom Content App in the following steps:

* Adding a Content App that displays for all content and media items
* Limiting the Content App to appear for only specific content types
* Limiting which user groups can see the Content App

A basic understanding of how to use AngularJS with Umbraco is required.  If you have created a property value editor before, this will all feel very familiar.

### Setting up the Plugin

The first thing we do is create a new folder inside `/App_Plugins` folder. We will call it `CakeContentApp`

Next we need to create a manifest file to describe what this Content App does. This manifest will tell Umbraco about our new Content App and allows us to inject any needed files into the application.  

Create a new file in the `/App_Plugins/CakeContentApp/` folder and name it `package.manifest`. In this new file, copy the code snippet below and save it. This code describes the Content App. To help you understand the JSON, read the inline comments for details on each bit:

```json5
{
    // define the content apps you want to create
    "contentApps": [
        {
            "name": "Cake", // required - the name that appears under the icon, everyone loves cake, right?
            "alias": "appCake", // required - unique alias for your app
            "weight": 0, // optional, default is 0, use values between -99 and +99 to appear between the existing Content (-100) and Info (100) apps
            "icon": "icon-cupcake", // required - the icon to use
            "view": "~/App_Plugins/CakeContentApp/cakecontentapp.html" // required - the location of the view file
        }
    ],
    // array of files we want to inject into the application on app_start
    "javascript": [
        "~/App_Plugins/CakeContentApp/cakecontentapp.controller.js"
    ]
}
```

### Creating the View and the Controller

Add 2 additional files to the `/App_Plugins/CakeContentApp/` folder:
- `cakecontentapp.html`
- `cakecontentapp.controller.js`

These 2 files will be our main files for the app, with the .html file handling the view and the .js file handling the functionality.

In the .js file we declare our AngularJS controller and inject umbraco's editorState and userService:

```javascript
angular.module("umbraco")
    .controller("My.CakeContentApp", function ($scope, editorState, userService) {

        var vm = this;
        vm.CurrentNodeId = editorState.current.id;
        vm.CurrentNodeAlias = editorState.current.contentTypeAlias;
        vm.Counter = 0;

        vm.UpdateCounter = function () {
            vm.Counter++;

            // we can add a badge to the app by defining $scope.model.badge - options are:
            // - count: Optional. Adds a number to the badge. 
            // - type: Optional. Sets the "severity" color of the badge - use "warning" or "alert".
            $scope.model.badge = {
                count: vm.Counter,
                type: vm.Counter > 9 ? "alert" : vm.Counter > 4 ? "warning" : null
            };
        };

        var user = userService.getCurrentUser().then(function (user) {
            console.log(user);
            vm.UserName = user.name;
        });
        
    });
```

And in the .html file:

```csharp
<div class="umb-box" ng-controller="My.CakeContentApp as vm">
    <div class="umb-box-header">
        <div class="umb-box-header-title">
            Hello cakes are awesome
        </div>
    </div>
    <div class="umb-box-content">
        <h3>Count: {{vm.Counter}}</h3>
        <button ng-click="vm.UpdateCounter()" class="btn" prevent-default>Update Counter</button>

        <ul>
            <li>Current node id: <b>{{vm.CurrentNodeId}}</b></li>
            <li>Current node alias: <b>{{vm.CurrentNodeAlias}}</b></li>
            <li>Current user: <b>{{vm.UserName}}</b></li>
        </ul>
    </div>
</div>
```

### Checking it works

After the above edits are done, restart your application. Go to any content node and you should now see an app called Cake. Clicking on the icon should say "Hello cakes are awesome" and confirm the details of the current item and user.  You can now adapt your Content App to retrieve external data using the standard Umbraco and AngularJS approach.

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

If the 'show' directive is omitted then the app will be shown for all content types.

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

If a role restriction is given in the manifest, it overrides any other restrictions based on type.

## Creating a Content App in C#

This is an example of how to register a Content App with C# and perform your own custom logic to show a Content App.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using Umbraco.Core.Components;
using Umbraco.Core.Models;
using Umbraco.Core.Models.ContentEditing;
using Umbraco.Core.Models.Membership;

namespace Umbraco.Web.UI
{
    public class CakeContentAppComponent : UmbracoComponentBase, IUmbracoUserComponent
    {
        public override void Compose(Composition composition)
        {
            base.Compose(composition);

            // Add our cake content app into the composition aka into the DI
            composition.ContentApps().Append<CakeContentApp>();

        }
    }

    public class CakeContentApp : IContentAppDefinition
    {
        public ContentApp GetContentAppFor(object source, IEnumerable<IReadOnlyUserGroup> userGroups)
        {
            // Some logic depending on the object type
            // To show or hide CakeContentApp
            switch (source)
            {
                // Some logic depending on the object type
                // To show or hide CakeContentApp
                switch (source)
                {
                    // Do not show Content App if doctype/content type is a container
                    case IContent content when content.ContentType.IsContainer:
                        return null;

                    // Don't show for media items
                    case IMedia media:
                        return null;

                    case IContent content:
                        break;

                    default:
                        throw new NotSupportedException($"Object type {source.GetType()} is not supported here.");
                }

                // Can implement some logic with userGroups if needed
                // Allowing us to display the Content App with some restrictions for certain groups
                if (userGroups.Any(x=> x.Alias.ToLowerInvariant() == "admin") == false)

                // Do not show content app if doctype/content type is a container
                case IContent content when content.ContentType.IsContainer:
                    return null;

                // Don't show for media items
                case IMedia media:
                    return null;

                case IContent content:
                    break;

                default:
                    throw new NotSupportedException($"Object type {source.GetType()} is not supported here.");
            }

            // Can implement some logic with userGroups if needed
            // Allowing us to display the content app with some restrictions for certain groups
            if (userGroups.Any(x=> x.Alias.ToLowerInvariant() == "admin") == false)
                return null;

            var cakeApp = new ContentApp
            {
                Alias = "appCake",
                Name = "Cake",
                Icon = "icon-cupcake",
                View = "/App_Plugins/CakeContentApp/cakecontentapp.html",
                Weight = 0
            };
        
            return cakeApp;
        }
    }
}
```
    
You will still need to add all of the files you added above but, because your C# code is adding the Content App, the package.manifest file can be simplified like this:

```json5
{
    // array of files we want to inject into the application on app_start
    "javascript": [
        "~/App_Plugins/MyContentApp/mycontentapp.controller.js"
    ]
}
```
