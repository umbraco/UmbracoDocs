# Using View Components

In the previous versions of MVC, we used Child Actions to build reusable components/widgets consisting of both Razor markup and backend logic. The backend logic was implemented as a controller action and marked with a *[ChildActionOnly]* attribute. Child Actions are no longer supported in ASP.NET Core MVC. Instead, we will use the *View Component* feature.

## View Component Overview

View components replace the traditional Controller (SurfaceController)/Partial View relationship and instead offers a modular approach of separating your views in to several smaller units. View Components are self-contained objects that consistently render HTML from a Razor view.

View components are:

- Generated from a C# class
- Derived from the base class ViewComponent and
- Associated with a Razor file (*.cshtml) to generate markup.

[View components](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/view-components?view=aspnetcore-5.0) are similar to partial views but they are much more powerful compared to the partial views. View components do not use model binding, instead they work with the data provided when calling it.

View Components can be implemented in any part of the web application. There are some possibilities to duplicate code like Header, Navigation Pane, Login Panel, Menu, Shopping Cart, Footer, BlockList Items and so on. View Components behave like a web part containing both business logic and UI design. This is because they create a package which can be reused in multiple parts of the web application.

A view component code consists of two parts:

- The View Component class derived from the `ViewComponent` class:

    ```csharp
    [ViewComponent(Name = "Employee")]
    public class EmployeeViewComponent : ViewComponent
    {}
    ```

- Returns a Task object as `IViewComponentResult`:

    ```csharp
    public IViewComponentResult Invoke()
    {
        return Content("Hi I'm an Employee Component");
    }
    ```

### Create a class for a ViewComponent

In this example, let's create a ViewComponent for a Product List and render it on the *HomePage* of the website.

Create a folder named **ProductView**. In this folder, create a new class named **ProductViewViewComponent.cs** as below:

```csharp
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

namespace Umbraco.Docs.Samples.Web.Components.ProductView;

public class ProductViewViewComponent : ViewComponent
{
    public IViewComponentResult Invoke()
    {
        List<string> products = new List<string>() {
            "Product 1", "Product 2", "Product 3", "Product 4", "Product 5"
        };

        return View(products);
    }
}
```

### Create a View for ViewComponent

In **Views** folder, create new folders at `Views\Shared\Components\ProductView`. In the **ProductView** folder, create a new file named **Default.cshtml** as below:

```csharp
<h1> Welcome to your Home Page </h1>
<h2>Products List</h2>
<ul>
    @foreach (var product in Model)
    {
        <li>@product</li>
    }
</ul>
```

#### UmbracoHelper in a ViewComponent

Adding the following declaration will give access to the UmbracoHelper object inside the ViewComponent View

```csharp
@inject Umbraco.Cms.Web.Common.UmbracoHelper Umbraco
```

### Invoking a View Component

You can invoke a ViewComponent from anywhere (even from within a Controller or another ViewComponent). Since this is our Product List, we want it rendered on the Home page - so we’ll invoke it from our HomePage.cshtml file using:

```csharp
 @(await Component.InvokeAsync("ProductView"))
```

You can read about different ways of invoking your view component in the [View components in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/view-components?view=aspnetcore-5.0#invoking-a-view-component) section of the Microsoft Documentation.view=aspnetcore-5.0)

## View Component Locations

By default, the framework searches for the Component View path in the following areas:

- `/Views/{Controller Name Folder}/Components/{View Component Name Folder}/{View Name}`
- `/Views/Shared/Components/{View Component Name Folder}/{View Name}`
