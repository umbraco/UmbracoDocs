---
versionFrom: 9.0.0
meta.Title: "Unit Testing Umbraco"
meta.Description: "A guide to getting started with unit testing in Umbraco"
---

# Unit Testing Umbraco

These examples are for Umbraco 9 and they rely on [NUnit](https://nunit.org/), [Moq](https://github.com/moq/moq4) and [AutoFixture](https://github.com/AutoFixture/AutoFixture) and they should be considered inspiration of how to get started with Unit Testing in Umbraco. There are many ways of testing Umbraco and there’s no right or wrong way.

When testing various components in Umbraco, such as controllers, helpers, services etc. these components often require that you provide a couple of dependencies in your classes using [dependency injection](https://our.umbraco.com/documentation/reference/using-ioc/). This is because a lot of magic happens “under the hood” of Umbraco and these dependencies are needed for that magic to happen.

:::note
When you are writing Unit Tests you will become a lot more aware of these underlying dependencies and what they do, which in return will make you an even better Umbraco developer.
:::

## Mocking
These tests follows an approach thats based on isolating your tests from Umbraco and mock as much of Umbraco’s dependencies as possible. Think of it like you’re not testing Umbraco, you’re testing how your implementation code interacts with Umbraco’s behavior.

Once you get familiar with these underlying dependencies you might want to start looking in to replacing them with actual implementations (leaning more towards integration or E2E testing) but that’s completely up to you. Again these examples should be a source of inspiration and the quickest way to get started with Unit Testing.

:::tip
If you are new to mocking you can read more on this topic [here](https://martinfowler.com/bliki/TestDouble.html) or use the [Moq Quickstart](https://github.com/Moq/moq4/wiki/Quickstart) guide. 
For more inspiration and other ways of how to write tests in Umbraco there's a blogpost from HQ member Bjarke Berg about [Automated Testing](https://umbraco.com/blog/automated-testing-in-umbraco/).
:::

### Testing a ContentModel

See [Reference documentation on Executing an Umbraco request](https://our.umbraco.com/Documentation/Implementation/Default-Routing/Execute-Request/#executing-an-umbraco-request).

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

See [Reference documentation for Custom controllers (Hijacking Umbraco Routes)](https://our.umbraco.com/documentation/reference/routing/custom-controllers#creating-a-custom-controller).

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

See [Reference documentation on SurfaceControllers](https://our.umbraco.com/Documentation/Reference/Routing/surface-controllers-actions).

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

:::tip
```ServiceContext.CreatePartial()``` has several optional parameters, and by naming them you only need to mock the dependencies that you actually need, for example: ```ServiceContext.CreatePartial(contentService: Mock.Of<IContentService>());```
:::