# Cool things you can do with strongly-typed models...

## Declarative style in Razor

One cool thing that XSLT has is the **apply-templates** and **match="..."** that lets you declare how to handle various types of content. So you tell XSLT how to render some types of content, and then you just ask XSLT to "render that content" and it will figure it out. Much nicer than ugly huge **switch(...)** or **if-else** statements.

Turns out it is possible to do something similar in Razor. Assuming `content` is an `IPublishedContent` instance that can be of any content type (but is strongly typed, and is not a dynamic):


    @* declare how to render a news item *@
    @helper RenderContent(NewsItem item)
    {
      <div>News! @item.Title</div>
    }

    @* declare how to render a product *@
    @helper RenderContent(Product product)
    {
      <div>Product! @product.Name cheap at @product.Price</div>
    }

    @* render our content *@
    @RenderContent((dynamic) content)

By casting the strongly-typed to a dynamic when calling the **RenderContent** method, you tell C# to do late runtime binding and pick the proper **RenderContent** implementation depending on the actual CLR type of the **content** object. Using dynamic here is OK and will not pollute the rest of the code.

### Navigation

TODO - document how navigation can be made easier by using things such as `.Children<NewsItem>()` or `.FirstChild<ProductList>()`.