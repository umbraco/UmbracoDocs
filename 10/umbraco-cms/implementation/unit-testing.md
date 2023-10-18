---
meta.Title: Unit Testing Umbraco
description: A guide to getting started with unit testing in Umbraco
---

# Unit Testing Umbraco

These examples inspire unit testing in Umbraco with Umbraco 9.x, 10.x, 11.x and 12.x, using [NUnit](https://nunit.org/), [Moq](https://github.com/moq/moq4), and [AutoFixture](https://github.com/AutoFixture/AutoFixture). There are many ways of testing Umbraco and there’s no right or wrong way.

When testing components in Umbraco, such as controllers, helpers, services etc. these components often require that you provide a couple of dependencies in your classes using [dependency injection](../reference/using-ioc.md). This is because a lot of magic happens “under the hood” of Umbraco and these dependencies are needed for that magic to happen.

{% hint style="info" %}
Writing Unit Tests increases awareness of underlying dependencies, enhancing your skills as an Umbraco developer.
{% endhint %}

## Mocking

These tests follows an approach thats based on isolating your tests from Umbraco and mock as much of Umbraco’s dependencies as possible. Think of it like you’re not testing Umbraco, you’re testing how your implementation code interacts with Umbraco’s behavior.

Once you become familiar with these underlying dependencies, you may consider replacing them with actual implementations. This can lean towards integration or end-to-end testing, but the decision is yours. Again these examples should be a source of inspiration and the quickest way to get started with Unit Testing.

{% hint style="info" %}
If you are new to mocking you can read more on this topic [here](https://martinfowler.com/bliki/TestDouble.html) or use the [Moq Quickstart](https://github.com/Moq/moq4/wiki/Quickstart) guide. For more inspiration and other ways of how to write tests in Umbraco there's a blogpost from HQ member Bjarke Berg about [Automated Testing](https://umbraco.com/blog/automated-testing-in-umbraco/).
{% endhint %}

### Testing a ContentModel

See [Reference documentation on Executing an Umbraco request](default-routing/execute-request.md#executing-an-umbraco-request).

```csharp
public class PageViewModel : ContentModel
{
    public PageViewModel(IPublishedContent content) : base(content) { }
    
    public string Heading => (string)this.Content.GetProperty(nameof(Heading)).GetValue();
}

public class PageViewModelTests
{
    [Test, AutoData]
    public void Given_PublishedContent_When_GetHeading_Then_ReturnPageViewModelWithHeading(string value, Mock<IPublishedContent> content)
    {
        SetupPropertyValue(content, nameof(PageViewModel.Heading), value);
                        
        var viewModel = new PageViewModel(content.Object);

        Assert.AreEqual(value, viewModel.Heading);
    }

    public void SetupPropertyValue(Mock<IPublishedContent> content, string propertyAlias, string propertyValue, string culture = null)
    {
        var property = new Mock<IPublishedProperty>();
        property.Setup(x => x.Alias).Returns(nameof(PageViewModel.Heading));
        property.Setup(x => x.GetValue(culture, null)).Returns(propertyValue);
        content.Setup(x => x.GetProperty(propertyAlias)).Returns(property.Object);
    }
}
```

### Testing a RenderController

See [Reference documentation for Custom controllers (Hijacking Umbraco Routes)](../reference/routing/custom-controllers.md#creating-a-custom-controller).

```csharp
public class PageController : RenderController
{
    public PageController(ILogger<RenderController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor) : base(logger, compositeViewEngine, umbracoContextAccessor) { }

    public IActionResult Page(ContentModel model)
    {
        return View(new PageViewModel(model.Content));
    }
}

public class PageControllerTests
{
    private PageController controller;

    [SetUp]
    public void SetUp()
    {
        this.controller = new PageController(Mock.Of<ILogger<RenderController>>(), Mock.Of<ICompositeViewEngine>(), Mock.Of<IUmbracoContextAccessor>());
    }

     [Test, AutoData]
    public void When_PageAction_ThenResultIsIsAssignableFromContentResult(Mock<IPublishedContent> content)
    {
        var model = new ContentModel(content.Object);

        var result = this.controller.Page(model);

        Assert.IsAssignableFrom<ViewResult>(result);
    }

    [Test, AutoData]
    public void Given_PublishedContentHasHeading_When_PageAction_Then_ReturnViewModelWithHeading_With_AutoFixture(string value, Mock<IPublishedContent> content)
    {
        SetupPropertyValue(content, nameof(PageViewModel.Heading), value);

        var viewModel = (PageViewModel)((ViewResult)this.controller.Page(new ContentModel(content.Object))).ViewData.Model;

        Assert.AreEqual(value, viewModel.Heading);
    }

    public void SetupPropertyValue(Mock<IPublishedContent> content, string propertyAlias, string propertyValue, string culture = null)
    {
        var property = new Mock<IPublishedProperty>();
        property.Setup(x => x.Alias).Returns(nameof(PageViewModel.Heading));
        property.Setup(x => x.GetValue(culture, null)).Returns(propertyValue);
        content.Setup(x => x.GetProperty(propertyAlias)).Returns(property.Object);
    }
}
```

### Testing a SurfaceController

See [Reference documentation on SurfaceControllers](../reference/routing/surface-controllers/).

```csharp
public class PageSurfaceController : SurfaceController
{
    public PageSurfaceController(IUmbracoContextAccessor umbracoContextAccessor, IUmbracoDatabaseFactory databaseFactory, ServiceContext services, AppCaches appCaches, IProfilingLogger profilingLogger, IPublishedUrlProvider publishedUrlProvider) : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider) { }

    [HttpPost]
    public IActionResult Submit()
    {
        return Content("H5YR!");
    }
}

public class PageSurfaceControllerTests
{
    private PageSurfaceController controller;

    [SetUp]
    public void SetUp()
    {
        this.controller = new PageSurfaceController(Mock.Of<IUmbracoContextAccessor>(), Mock.Of<IUmbracoDatabaseFactory>(), ServiceContext.CreatePartial(), AppCaches.NoCache, Mock.Of<IProfilingLogger>(), Mock.Of<IPublishedUrlProvider>());
    }

    [Test]
    public void When_SubmitAction_ThenResultIsIsAssignableFromContentResult()
    {
        var result = this.controller.Submit();

        Assert.IsAssignableFrom<ContentResult>(result);
    }

    [Test]
    public void When_SubmitAction_Then_ExpectHelloWorld()
    {
        var result = (ContentResult)this.controller.Submit();

        Assert.AreEqual("H5YR!", result.Content);
    }
}
```

{% hint style="info" %}
`ServiceContext.CreatePartial()` has optional parameters, and by naming them you only need to mock the dependencies that you need, for example: `ServiceContext.CreatePartial(contentService: Mock.Of<IContentService>());`
{% endhint %}

## Testing an UmbracoApiController

See [Reference documentation on UmbracoApiControllers](../reference/routing/umbraco-api-controllers/README.md#locally-declared-controller).

```csharp
public class ProductsController : UmbracoApiController
{
    public IEnumerable<string> GetAllProducts()
    {
        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
    }

    [HttpGet]
    public JsonResult GetAllProductsJson()
    {
        return new JsonResult(this.GetAllProducts());
    }
}

public class ProductsControllerTests
{
    private ProductsController controller;

    [SetUp]
    public void SetUp()
    {
        this.controller = new ProductsController();
    }

    [Test]
    public void WhenGetAllProducts_ThenReturnViewModelWithExpectedProducts()
    {
        var expected = new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };

        var result = this.controller.GetAllProducts();

        Assert.AreEqual(expected, result);
    }

    [Test]
    public void WhenGetAllProductsJson_ThenReturnViewModelWithExpectedJson()
    {
        var json = JsonConvert.SerializeObject(this.controller.GetAllProductsJson().Value);

        Assert.AreEqual("[\"Table\",\"Chair\",\"Desk\",\"Computer\",\"Beer fridge\"]", json);
    }
}
```

## Testing ICultureDictionary using the UmbracoHelper

See [Core documentation on the interface ICultureDictionary](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Dictionary.ICultureDictionary.html).

```csharp
public class HomeController : RenderController
{
    private readonly UmbracoHelper umbracoHelper;

    public HomeController(UmbracoHelper umbracoHelper, ILogger<RenderController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor) : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
        this.umbracoHelper = umbracoHelper;
    }

    public IActionResult Home(ContentModel model)
    {
        var myCustomModel = new PageViewModel(model.Content)
        {
            MyDictionaryProperty = this.umbracoHelper.GetDictionaryValue("myDictionaryKey")
        };

        return View(myCustomModel);
    }
}

public class HomeControllerTests
{
    private Mock<ICultureDictionary> cultureDictionary;
    private Mock<ICultureDictionaryFactory> cultureDictionaryFactory;
    private UmbracoHelper umbracoHelper;
    private HomeController controller;

    [SetUp]
    public void SetUp()
    {
        this.cultureDictionary = new Mock<ICultureDictionary>();
        this.cultureDictionaryFactory = new Mock<ICultureDictionaryFactory>();
        this.cultureDictionaryFactory.Setup(x => x.CreateDictionary()).Returns(this.cultureDictionary.Object);
        this.umbracoHelper = new UmbracoHelper(this.cultureDictionaryFactory.Object, Mock.Of<IUmbracoComponentRenderer>(), Mock.Of<IPublishedContentQuery>());
        this.controller = new HomeController(this.umbracoHelper, Mock.Of<ILogger<RenderController>>(), Mock.Of<ICompositeViewEngine>(), Mock.Of<IUmbracoContextAccessor>());
    }

    [Test, AutoData]
    public void GivenMyDictionaryKey_WhenIndexAction_ThenReturnViewModelWithMyPropertyDictionaryValue(string expected)
    {
        var model = new ContentModel(new Mock<IPublishedContent>().Object);            
        this.cultureDictionary.Setup(x => x["myDictionaryKey"]).Returns(expected);

        var result = (PageViewModel)((ViewResult)this.controller.Home(model)).Model;

        Assert.AreEqual(expected, result.MyDictionaryProperty);
    }
}
```
