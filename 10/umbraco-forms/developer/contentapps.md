---
meta.Title: Content Apps
---

# Content Apps

[Umbraco Content Apps](https://docs.umbraco.com/umbraco-cms/extending/content-apps) can be configured to appear alongside forms in the Umbraco Forms backoffice section.

They will appear after the default "Design" and "Settings" apps when editing a form in the backoffice:

![Umbraco Forms Content App](<images/content-app (1) (1).png>)

A content app such as the following would display only in the forms section:

```csharp
    public class TestFormsContentApp : IContentAppFactory
    {
        public ContentApp GetContentAppFor(object source, IEnumerable<IReadOnlyUserGroup> userGroups)
        {
            // Only show app on forms
            if (source is FormDesign)
            {
                return new ContentApp
                {
                    Alias = "testFormsContentApp",
                    Name = "Test App",
                    Icon = "icon-calculator",
                    View = "/App_Plugins/TestFormsContentApp/testformscontentapp.html",
                    Weight = 0,
                };
            }

            return null;
        }
    }
```

Within the `/App_Plugins/TestFormsContentApp/` folder we need the client-side files, for which an example is shown below:

`package.manifest`:

```json
{
    "contentApps": [
    {
        "name": "Test Forms Content App",
        "alias": "TestFormsContentApp",
        "weight": 0,
        "icon": "icon-calculator",
        "view": "~/App_Plugins/TestFormsContentApp/testformscontentapp.html",
        "show": [
            "+content/*",
            "+media/*",
            "+member/*",
            "+forms/*"
        ]
    }
    ],
    "javascript": [
        "~/App_Plugins/TestFormsContentApp/testformscontentapp.controller.js"
    ]
}
```

`testformscontentapp.html`:

```html
<div ng-controller="My.TestFormsContentApp as vm">
    <umb-box>
        <umb-box-header title="Forms Content App"></umb-box-header>
        <umb-box-content>
            <p>Current form: <b>{{vm.formName}}</b></p>
        </umb-box-content>
    </umb-box>
</div>
```

`testformscontentapp.controller.js`:

```js
angular.module("umbraco")
    .controller("My.TestFormsContentApp", function ($routeParams, formResource) {
        var vm = this;
        formResource.getWithWorkflowsByGuid($routeParams.id)
            .then(function (response) {
                vm.formName = response.data.name;
            });
    });
```

Finally, it needs to be registered via a composer:

```csharp
    public class TestSiteComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.ContentApps().Append<TestFormsContentApp>();
       }
    }
}
```
