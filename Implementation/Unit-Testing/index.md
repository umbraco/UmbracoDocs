---
versionFrom: 9.0.0
meta.Title: "Unit Testing Umbraco"
meta.Description: "A guide to getting started with unit testing in Umbraco"
---

# Unit Testing Umbraco

These examples are for Umbraco 9+ and they rely on [NUnit](https://nunit.org/), [Moq](https://github.com/moq/moq4) and [AutoFixture](https://github.com/AutoFixture/AutoFixture).

## Testing a ContentModel

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

## Testing a RenderController

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

## Testing a SurfaceController

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