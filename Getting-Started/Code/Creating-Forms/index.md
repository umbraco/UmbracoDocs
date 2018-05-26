# Creating forms
Creating forms requires that you know your way around .NET MVC. So if you are familiar with adding view models, views and controllers you are ready to make your first form.

*You can also use [Umbraco forms](https://umbraco.com/products/umbraco-forms/). It lets you and/or your editors create and handle forms in the backoffice. This includes setting up validation, redirecting and storing and sending form data. Great UI, easily extendable and supported by Umbraco HQ.*

In this example we'll create a basic contact form contain name, email and message field.

### Creating the view model
First we're going to create the model for the contact form by adding a new class to the `/Models` folder. Let's call it `ContactFormViewModel.cs`

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;

    namespace MyFirstForm.Models
    {
        public class ContactFormViewModel {
            public string Name { get; set; }
            public string Email { get; set; }
            public string Message { get; set; }
        }
    }

Build your solution after adding the model.

### Creating the view
Next we add the view for the form to the `/View/Partials` folder. Because we've added the model and built the solution we can add it as a strongly typed view.

The view can be built with standard with standard MVC helpers:

    @model MyFirstForm.Models.ContactFormViewModel

    @using(Html.BeginUmbracoForm("Submit", "ContactForm")) {
        <div>
            @Html.TextBoxFor(m=>m.Name)
        </div>
        <div>
            @Html.TextBoxFor(m=>m.Email)
        </div>
        <div>
            @Html.TextAreaFor(m=>m.Message)
        </div>
        <input type="submit" name="Submit" value="Submit" />
    }

### Adding the controller
Finally we're going to add the controller. Simply add a controller to the `/Controllers` folder, name it `ContactController` and make sure to use an __empty MVC controller__ as the template.


    using MyFirstForm.Models;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Mvc;
    using Umbraco.Web.Mvc;

    namespace MyFirstForm.Controllers
    {
        public class ContactFormController : SurfaceController
        {
            [HttpPost]
            public ActionResult Submit(ContactFormViewModel model)
            {
                if (!ModelState.IsValid)
                    return CurrentUmbracoPage();

                /// Work with form data here

                return RedirectToCurrentUmbracoPage();
            }
        }
    }

If the model state is invalid `CurrentUmbracoPage()` will send the user back to the form. If valid you can work with the form data (e.g. sending an email to site admin) and them `RedirectToCurrentUmbracoPage();`

## Adding the form to a template
You can add the form to a template by rendering the partial view:

    @using MyFirstForm.Models;

    @{
        Html.RenderPartial("~/Views/Partials/ContactForm.cshtml", new ContactFormViewModel());
    }

## Adding the form through the backoffice
To add the form to your site we'll make a macro. This also makes it possible to let editors add the form to a page using the richtext editor.

#### Creating a macro
Go to the developer section and right click the menu icon on the __Partial Views Macro Files__ node. Name the macro *Contact Form*, select an empty snippet and leave the __Create Macro__ checkbox checked.

In the partial view we're going to render our contact form using the view model we created earlier.

    @inherits Umbraco.Web.Macros.PartialViewMacroPage

    @using MyFirstForm.Models;

    @{
        Html.RenderPartial("~/Views/Partials/ContactForm.cshtml", new ContactFormViewModel());
    }


#### Adding the macro
Last thing to do before we can add the form to a page is to allow the macro in a richtext editor.
Select the expand the __Macros__ node and select the __Contact Form__ Macro. Check the to boxes under __Editor Settings__.

Now you can add the form to a page that has a rich text editor.

### More information
- [Surface Controllers](../../../Reference/Routing/surface-controllers.md)
- [Custom controllers](../../../Reference/Routing/custom-controllers.md)
- [Routing](../../../Reference/Routing/)

### Umbraco TV
- [Chapter: Surface Controllers](http://umbraco.tv/videos/umbraco-v7/developer/fundamentals/surface-controllers/)
