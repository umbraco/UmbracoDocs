---
versionFrom: 8.0.0
---

# Packages on Umbraco Cloud

If you want to use or develop packages for Umbraco Cloud there are a few things to consider and be aware of. One such thing is that custom property editors may need a ValueConnector to transform their content between environments.

# ValueConnectors

A ValueConnector is an extension to Deploy that allows you to transform data when you deploy content of any kind between environments. This is mostly used to transfer id based content between environments.

An example of creating one in your package would be if you for example had a custom property editor that allowed you to write in the id of a media node. Not a very usable property editor but it will work for this example.

So you have a property editor with a textarea input, that saves an id as a string, looks like this:

![Property editor](images/property-editor.png)

Then in the template you have something like this:

```csharp
<img src="@Umbraco.Media(Model.Value("BadMedia")).Url" />
```

Renders the image perfectly! 

However now you do a content transfer to your Cloud environment, and one of three things will happen:

1. You got super lucky and the ID you had on local happened to be the same as what your media item was assigned on your Cloud environment.
1. Your page will now show a different image as the id you had corresponds to something else on this environment.
1. You will get a YSOD as it can't find any media items with that id.

To prevent this from happening we will need to use a ValueConnector.

## Testing a ValueConnector

Before we start working on making a ValueConnector a few notes on how to test and work with them. You probably will need to test the values that are being converted, but you probably also doesn't want to build, git push, content transfer to see that the value may not have changed.

First thing we will do is create the ValueConnector using the interface. If you implement it you will get something like this:

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Core.Deploy;
using Umbraco.Core.Models;

namespace valueconnector.Core.Controllers
{
    public class BadMediaValueConnector : IValueConnector
    {
        public BadMediaValueConnector()
        {
        }
        public IEnumerable<string> PropertyEditorAliases => new[] {"BadMediaPicker"};

        public string ToArtifact(object value, PropertyType propertyType, ICollection<ArtifactDependency> dependencies)
        {
            return value.ToString();
        }

        public object FromArtifact(string value, PropertyType propertyType, object currentValue)
        {
            return currentValue;
        }
    }
}
```

In this case I had a Cloud site that I cloned down using the [uaas.cmd](https://umbra.co/uaas-cmd) tool. Meaning I have a class library I add the valueconnector to, that automatically have some references included and that will automatically build a dll - projectalias.core.dll and put it in the websites bin folder when building. 

This has no impact on the way you work, but it may help you understand why some things are named the way they are.

So at this point I have my one local site, however to test this I will push this all to the Cloud site and then clone it down again.

At this point I have two local sites, one cloned down with the uaas.cmd tool. Meaning it has a visual studio solution and a class library, and the other is a regular clone I will spin up in VS Code.

Site 1:
Full Visual Studio solution
Running on http://localhost:6240/ (Randomly generated)
Has the ValueConnector in a class library that is built to a dll and copied to the websites bin on build

Site 2: 
A website served through VS Code (Could be IIS or anything else, doesn't matter)
Running on http://localhost:17025/ (Randomly generated)
Has the ValueConenctor dll in the bin from the clone

Now we will set up these two identical sites to transfer content to eachother, to do so go to `site1/Config/UmbracoDeploy.config` and edit the live environment url to be Site2's url (http://localhost:17025/ in my case).
Then do the same for site2 but put in site1's domain as the "live" one.

At this point you should be able to go to the backoffice of either environment and do a Content transfer to live, and it should end up on the other (Assuming no errors from your custom connector).

## Debugging a transfer

At this point we haven't done anything to the ValueConverter yet, other than return the original value. Now we will attach Visual Studio to the IIS processes and try a transfer to see what it sends along.

Go to Visual Studio, hit "Attach to Process" (default ALT + CTRL + P), and choose your two IIS processes. Add breakpoints in the `ToArtifact` and `FromArtifact` methods and go to site2, then try to do a content transfer to live (site2).

It will hit your breakpoint, and if you continue you will then get an error. On the breakpoint you can see why though, it should look like this:

![Hitting the breakpoint](images/hitting-breakpoints.png)

Here you can see that value is null, so if you try to return `value.ToString()` you will get a null exception. So we will change the `ToArtifact` method a little:

```csharp
public string ToArtifact(object value, PropertyType propertyType, ICollection<ArtifactDependency> dependencies)
{
    var svalue = value as string;
    if (string.IsNullOrWhiteSpace(svalue))
        return null;

    return value.ToString();
}
```

But at this point you can't reattach the process as the code has changed. So we build, go to site1/bin and copy projectalias.Core.dll and projectalias.Core.pdb into site2/bin and then attach to process and try another transfer.

The workflow here is not optimal, but a lot quicker than trying to deploy to Cloud everytime, and with this you can attach the debugger as well to help you out.

Let's sync up, attach the debugger and attempt another transfer. Now you will see that `value` is null a few times, then your hardcoded id a few times, but nothing breaks here. Suddenly you will hit the `FromArtifact` method instead:

![Hitting FromArtifact](images/fromArtifact.png)

Here you will notice that the value is what you had returned in `ToArtifact`.

## Creating our ValueConnector

Well enough about testing. You may have realised at this point that the flow is something like this:

Site1 content transfer initated -> Hit the `ToArtifact` method on the environment -> Send to site2 -> Hit the `FromArtifact` method on site 2 -> Property data on site2

So in our case, what we want to do is to ensure the id is changed in a transfer. We do this by converting the id to a GUID in the `ToArtifact` method, then it gets transfered to site2. On site 2 we will convert it back to an id in the `FromArtifact` method. This way the user will still see an id on the content node, the id they see will be updated to the correct one though.

:::warning

In this example there would be no way for Deploy to know to also transfer the image, so we assume that you would transfer all content and images to ensure it is on the target environment under a different id.

That is not a good assumption, and you may have noticed that there is a parameter on the ToArtifact method that you could update by finding the image and adding it to `ICollection<ArtifactDependency> dependencies`. 
:::

So in order to convert to a GUID in the `ToArtifact` method, we will update the code:

```csharp
public string ToArtifact(object value, PropertyType propertyType, ICollection<ArtifactDependency> dependencies)
{
    var svalue = value as string;
    if (string.IsNullOrWhiteSpace(svalue))
        return null;

    if (int.TryParse(svalue, out var intvalue))
        return null;

    var getKeyAttempt = _entityService.GetKey(intvalue, UmbracoObjectTypes.Media);

    if (getKeyAttempt.Success)
    {
        var udi = new GuidUdi(Constants.UdiEntityType.Media, getKeyAttempt.Result);
        dependencies.Add(new ArtifactDependency(udi, false, ArtifactDependencyMode.Exist));

        return udi.ToString();
    }
    else
    {
        _logger.Debug<BadMediaValueConnector>($"Couldn't convert integer value #{intvalue} to UDI");
    }

    return string.Empty;
}
```

You can find references on the methods used here in our API documentation:

<!-- vale off -->

- [EntityService.GetKey](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.Implement.EntityService.html#Umbraco_Core_Services_Implement_EntityService_GetKey_System_Int32_Umbraco_Core_Models_UmbracoObjectTypes_)
- [new GuidUdi](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.GuidUdi.html#Umbraco_Core_GuidUdi__ctor_System_String_System_Guid_)
- [new ArtifactDependency](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Deploy.ArtifactDependency.html#Umbraco_Core_Deploy_ArtifactDependency__ctor_Umbraco_Core_Udi_System_Boolean_Umbraco_Core_Deploy_ArtifactDependencyMode_)

<!-- vale on -->

When stepping through the code we can see that everything seems to work fine:

![Stepped through code](images/steppingThroughCode.png)

Note: Showing the variable values is a feature of [ReSharper](https://www.jetbrains.com/resharper/) 

By the time we hit `FromArtifact` value of `"umb://media/00c9eff861654f52be7a33367c3561a4"` all that is left to do is convert back to an int.

```csharp
public object FromArtifact(string value, PropertyType propertyType, object currentValue)
{
    if (string.IsNullOrWhiteSpace(value))
        return value;

    if (!GuidUdi.TryParse(value, out var udi) || udi.Guid == Guid.Empty)
        return value;

    var getIdAttempt = _entityService.GetId(udi.Guid, UmbracoObjectTypes.Media);

    if (!getIdAttempt.Success) return value;

    return getIdAttempt.Result.ToString();
}
```

Here is a gif showing the valueconnectoer in action in the end, but uploading a new image, updating the id on the node, transfering then seeing the image on the new environment and the id updated:

![Full workflow gif](images/valueconnector.gif)

The final ValueConnector code is this:

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Core;
using Umbraco.Core.Deploy;
using Umbraco.Core.Logging;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace valueconnector.Core.Controllers
{
    public class BadMediaValueConnector : IValueConnector
    {
        private readonly IEntityService _entityService;
        private readonly ILogger _logger;
        public BadMediaValueConnector(IEntityService entityService, ILogger logger)
        {
            _entityService = entityService;
            _logger = logger;
        }
        public IEnumerable<string> PropertyEditorAliases => new[] {"BadMediaPicker"};

        public string ToArtifact(object value, PropertyType propertyType, ICollection<ArtifactDependency> dependencies)
        {
            var svalue = value as string;
            if (string.IsNullOrWhiteSpace(svalue))
                return null;

            if (!int.TryParse(svalue, out var intvalue))
                return null;

            var getKeyAttempt = _entityService.GetKey(intvalue, UmbracoObjectTypes.Media);

            if (getKeyAttempt.Success)
            {
                var udi = new GuidUdi(Constants.UdiEntityType.Media, getKeyAttempt.Result);
                dependencies.Add(new ArtifactDependency(udi, false, ArtifactDependencyMode.Exist));

                return udi.ToString();
            }
            else
            {
                _logger.Debug<BadMediaValueConnector>($"Couldn't convert integer value #{intvalue} to UDI");
            }

            return string.Empty;
        }

        public object FromArtifact(string value, PropertyType propertyType, object currentValue)
        {
            if (string.IsNullOrWhiteSpace(value))
                return value;

            if (!GuidUdi.TryParse(value, out var udi) || udi.Guid == Guid.Empty)
                return value;

            var getIdAttempt = _entityService.GetId(udi.Guid, UmbracoObjectTypes.Media);

            if (!getIdAttempt.Success) return value;

            return getIdAttempt.Result.ToString();
        }
    }
}

```