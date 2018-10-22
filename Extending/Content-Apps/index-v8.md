---
versionFrom: 8.0.0
---

# Content Apps

These are a new concept in v8. 'Content' and 'Info', highlighted in the image below, are the built-in content apps for all items in the Content section. 

![Content Apps in back office](images/content-apps-location.png)

We can also add our own custom content apps to appear alongside the built-in ones. These can be for all content and media items, or they can be dependent on content type.  They can also be dependent on the current user's permissions.

Content Apps are intended to enhance the editor's experience by displaying extra information related to the current content item, such as Google Analytics data, not for doing data-entry.

## Creating a Custom Content App

This guide explains how to set up a custom content app in the following steps:

* Adding a content app that displays for all content and media items
* Limiting the content app to appear for only specific content types
* Limiting which user groups can see the content app

A basic understanding of how to use AngularJS with Umbraco is required.  If you have created a property value editor before, this will all feel very familiar.

### Setting up the Plugin

The first thing we do is create a new folder inside `/App_Plugins` folder. We will call it `CakeContentApp`

Next we need to create a manifest file to describe what this content app does. This manifest will tell Umbraco about our new content app and allows us to inject any needed files into the application.  

Add the file `/App_Plugins/CakeContentApp/package.manifest` and inside add the JSON to describe the content app. Have a look at the inline comments in the JSON below for details on each bit:

    {
        // define the content apps you want to create
        contentApps: [
            {
                "name": "Cake", // required - the name that appears under the icon, everyone loves cake, right?
                "alias": "appCake", // required - unique alias for your app
                "weight": 0, // optional, default is 0, use values between -99 and +99 to appear between the existing Content (-100) and Info (100) apps
                "icon": "icon-cupcake", // required - the icon to use
                "view": "~/App_Plugins/CakeContentApp/cakecontentapp.html" // required - the location of the view file
            }
        ]
        ,
        // array of files we want to inject into the application on app_start
        javascript: [
            '~/App_Plugins/CakeContentApp/cakecontentapp.controller.js'
        ]
    }

### Creating the View and the Controller

Then add 2 files to the /app_plugins/CakeContentApp/ folder:
- `cakecontentapp.html`
- `cakecontentapp.controller.js`

These will be our main files for the app, with the .html file handling the view and the .js file handling the functionality.

In the .js file we declare our AngularJS controller and inject umbraco's editorState and userService:

    angular.module("umbraco")
        .controller("My.CakeContentApp", function ($scope, editorState, userService) {

            var vm = this;
            vm.CurrentNodeId = editorState.current.id;
            vm.CurrentNodeAlias = editorState.current.contentTypeAlias;

            var user = userService.getCurrentUser().then(function (user) {
                console.log(user);
                vm.UserName = user.name;
            });
        });

And in the .html file:

    <div class="umb-box" ng-controller="My.CakeContentApp as vm">
        <div class="umb-box-header">
            <div class="umb-box-header-title">
                Hello cakes are awesome
            </div>
        </div>
        <div class="umb-box-content">
            <ul>
                <li>Current node id: <b>{{vm.CurrentNodeId}}</b></li>
                <li>Current node alias: <b>{{vm.CurrentNodeAlias}}</b></li>
                <li>Current user: <b>{{vm.UserName}}</b></li>
            </ul>
        </div>
    </div>

### Checking it works

After the above edits are done, restart your application. Go to any content node and you should now see an app called Cake. Clicking on the icon should say "Hello cakes are awesome" and confirm the details of the current item and user.  You can now adapt your content app to retrieve external data using the standard Umbraco and AngularJS approach.

### Limiting according Content Type

You can set your content app to only show for specific content types by updating your `package.manifest` file and adding a 'show' directive. For example:

    "show": [ 
        "-content/homePage", // hide for content type 'homePage'
        "+content/*", // show for all other content types
        "+media/*" // show for all media types
    ]

If the 'show' directive is omitted then the app will be shown for all content types.

### Limiting according to User Role

In a similar way you can limit your content app according to user roles (groups).  For example:

    "show": [
        "+role/admin"  // show for 'admin' user group
    ]

## Creating a Content App in C#

This is an example of how to register a content app with C# and perform your own custom logic to show a content app.

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
    
You will still need to add all of the files you added above but, because your C# code is adding the content app, the package.manifest file can be simplified like this:

```
{
    // array of files we want to inject into the application on app_start
    javascript: [
        '~/App_Plugins/MyContentApp/mycontentapp.controller.js'
    ]
}
```
