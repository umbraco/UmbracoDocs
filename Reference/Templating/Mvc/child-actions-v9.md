---
versionFrom: 9.0.0
---

# Using View Components in Umbraco

In previous versions of MVC, we used Child Actions to build reusable components/widgets consisting of both Razor markup and logic. The logic was implemented as a controller action and marked with a [ChildActionOnly] attribute. Child Actions are no longer supported in ASP.NET Core MVC. Instead, we will use the new *View Component* feature.

## What is a View Component

View components replace the traditional Controller (SurfaceController)/Partial View relationship and instead offer a modular approach of separating your views in to several smaller units.

[View components in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/view-components?view=aspnetcore-5.0) are similar to partial views, but they're much more powerful.

### Create a class for a ViewComponent

In this example, let's create a ViewComponent for a Product List and render it on the Home page of the website.

Create a folder named **ProductView**. In this folder, create a new class named **ProductViewComponent.cs** as below:

```csharp
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

namespace ViewComponentSample.ViewComponents
{
    [ViewComponent(Name = "ProductView")]
    public class ProductViewComponent : ViewComponent
    {
        public IViewComponentResult Invoke()
        {
            List<string> products = new List<string>() {
                "Product 1", "Product 2", "Product 3", "Product 4", "Product 5"
            };
            return View(products);
        }

    }

}

```

### Create a View for ViewComponent

In **Views** folder, create new folders with the path `Views\Shared\Components\ProductView`. In the **ProductView** folder, create a new file named **Index.cshtml** as below:

```csharp
<h1> Welcome to your Home Page <h1>
<h2>Products List</h2>
<ul>
    @foreach (var product in Model)
    {
        <li>@product</li>
    }
</ul>
```

### Invoking a View Component

You can invoke a ViewComponent from anywhere (even from within a Controller or another ViewComponent) but since this is our Product List, we want it rendered on the Home page, so we’ll invoke it from our HomePage.cshtml file using:

```csharp
 @(await Component.InvokeAsync("ProductView")) 
```

You can read about different ways of invoking your view component in the [View components in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/view-components?view=aspnetcore-5.0#invoking-a-view-component) section of the Microsoft Docuemntation.view=aspnetcore-5.0)
