---
meta.Title: "Creating Forms"
description: "Information on creating forms in Umbraco"
---


# Creating Forms

Creating forms requires that you know your way around .NET Core MVC. So if you are familiar with adding view models, views and controllers you are ready to make your first form.

{% hint style="info" %}
You can also use [Umbraco forms](https://umbraco.com/products/umbraco-forms/). It lets you and/or your editors create and handle forms in the backoffice. This includes setting up validation, redirecting and storing and sending form data. Great UI, extendable and supported by Umbraco HQ.
{% endhint %}

In this example we'll create a basic contact form containing a name, email and message field.

## Creating the view model

First, we're going to create the model for the contact form by adding a new class to the `/Models` folder. If the folder doesn't already exist, create it at the root of your website. Let's call it `ContactFormViewModel.cs`

```csharp
namespace MyFirstForm.Models
{
    public class ContactFormViewModel 
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string Message { get; set; }
    }
}
```

Build your solution after adding the model.

### Creating the view

Next, we add the view for the form to the `/View/Partials` folder. Because we've added the model and built the solution we can add it as a strongly typed view.

Name your view "ContactForm".

The view can be built with standard MVC helpers:

```csharp
@using MyFirstForm.Controllers
@model MyFirstForm.Models.ContactFormViewModel

@using (Html.BeginUmbracoForm<ContactFormController>(nameof(ContactFormController.Submit)))
{
    <div class="input-group">
        <label asp-for="Name"></label>
        <input asp-for="Name" />
    </div>
    <div>
        <label asp-for="Email"></label>
        <input asp-for="Email" />
    </div>
    <div>
        <label asp-for="Message"></label>
        <textarea asp-for="Message"></textarea>
    </div>
    <br/>
    <input type="submit" name="Submit" value="Submit" />
}
```

### Adding the controller

Finally, we're going to add the controller. Create a new empty class in the `/Controllers` folder (if the folder doesn't already exist, create it at the root of the website). Name it `ContactFormController` and make it inherit from `SurfaceController`. Inheriting from `SurfaceController` requires that you call its base constructor. If you are using an IDE: Integrated Development Environment, this can be done automatically.

```csharp
using Microsoft.AspNetCore.Mvc;
using MyFirstForm.Models;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Persistence;
using Umbraco.Cms.Web.Website.Controllers;

namespace MyFirstForm.Controllers
{
    public class ContactFormController : SurfaceController
    {
        public ContactFormController(
            IUmbracoContextAccessor umbracoContextAccessor,
            IUmbracoDatabaseFactory databaseFactory,
            ServiceContext services,
            AppCaches appCaches,
            IProfilingLogger profilingLogger,
            IPublishedUrlProvider publishedUrlProvider) 
            : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
        {}

        [HttpPost]
        public IActionResult Submit(ContactFormViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return CurrentUmbracoPage();
            }
            
            // Work with form data here

            return RedirectToCurrentUmbracoPage();
        }
    }
}
```

If the model state is invalid, `CurrentUmbracoPage()` will send the user back to the form. If valid, you can work with the form data, for example, sending an email to site admin and then `RedirectToCurrentUmbracoPage();`.

## Adding the form to a template

You can add the form to a template by rendering the partial view:

```csharp
@using MyFirstForm.Models;

@{
    Html.RenderPartial("~/Views/Partials/ContactForm.cshtml", new ContactFormViewModel());
}
```

## Adding the form through the backoffice

To add the form to your site we'll make a macro. This also makes it possible to let editors add the form to a page using the rich text editor.

### Creating a macro

Go to the Settings section and right-click the __Partial Views Macro Files__ node. Choose "Create" and select __New partial view macro__. Name the macro *Contact Form*.

In the partial view, we're going to render our contact form using the view model we created earlier.

```csharp
@inherits Umbraco.Cms.Web.Common.Macros.PartialViewMacroPage;

@using MyFirstForm.Models;

@{
    Html.RenderPartial("~/Views/Partials/ContactForm.cshtml", new ContactFormViewModel());
}
```

#### Adding the macro

The last thing to do before we can add the form to a page is to __allow the Macro in a rich text editor__. Expand the __Macros__ node and select the __Contact Form__ Macro. Check the boxes under __Editor Settings__.

{% hint style="info" %}
If you don't see your new macro listed, right click __Macros__ and select __Reload__.
{% endhint %}

Now you can add the form to a page that has a rich text editor.

### More information

- [Surface Controllers](../../reference/routing/surface-controllers/README.md)
- [Custom controllers](../../reference/routing/custom-controllers.md)
- [Routing](../../reference/routing/README.md)
