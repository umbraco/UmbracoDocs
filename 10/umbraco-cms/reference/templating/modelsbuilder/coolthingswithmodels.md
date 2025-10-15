---


meta.Title: "Cool Things to do With Models"
description: "Cool things you can do with models"
---
# Cool things you can do with strongly-typed models

It's possible with Razor to define functions for rendering HTML, we can leverage our strongly typed models when doing this, and even provide overloads for different types of models, that will automatically called for different models using `dynamic`

```csharp
@functions
{
  // Declare how to render a news item
  void RenderContent(NewsItem item)
  {
    <div>News! @item.Title</div>
  }

  // Declare how to render a product
  void RenderContent(Product item)
  {
    <div>Product! @product.Name cheap at @product.Price</div>
  }
}

@{
  RenderContent((dynamic) Model);
}
```

Now, it's not recommended to create a single template and doing all the rendering via razor function, but it can be quite nifty for rendering search results, and so on.

A thing that's important to note here is that `RenderContent` is called from a codeblock, and not as `@RenderContent((dynamic) Model);` the reason for this is that if you try to use the latter, razor will expect for the function to return something for it to render.

By casting the strongly-typed to a dynamic when calling the **RenderContent** method, you tell C# to do late runtime binding and pick the proper **RenderContent** implementation depending on the actual CLR type of the **content** object. Using dynamic here is OK and will not pollute the rest of the code.
