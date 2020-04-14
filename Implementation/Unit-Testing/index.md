---
versionFrom: 8.0.0
meta.Title: "Unit Testing Umbraco"
meta.Description: "A guide to getting started with unit testing in Umbraco"
---

# Unit Testing Umbraco

These examples are for Umbraco 8+ and they rely on [NUnit](https://nunit.org/) and [Moq](https://github.com/moq/moq4).

# Mocking

When testing components in Umbraco, especially controllers, there are a few dependencies that needs to be mocked / faked in order to get your unit tests running. Every Umbraco controller has two constructors: one empty constructor without any parameters for anyone not interested in unit testing or dependency injections, and one with full constructor injection which contains all parameters needed for proper unit testing. A lot of these dependencies are interfaces, which are mocked using Mock.Of<>, but there are still a few explicit non-interface dependencies that needs to be faked. In this documentation all mocks and fakes have been placed in a base class to avoid having to repeat this setup in every test class.

```csharp
public abstract class UmbracoBaseTest 
{
    public ServiceContext ServiceContext;
    public MembershipHelper MembershipHelper;
    public UmbracoHelper UmbracoHelper;
    public UmbracoMapper UmbracoMapper;

    public Mock<ICultureDictionary> CultureDictionary;
    public Mock<ICultureDictionaryFactory> CultureDictionaryFactory;
    public Mock<IPublishedContentQuery> PublishedContentQuery;

    public Mock<HttpContextBase> HttpContext;
    public Mock<IMemberService> memberService;
    public Mock<IPublishedMemberCache> memberCache;

    [SetUp]
    public virtual void SetUp()
    {
        this.SetupHttpContext();
        this.SetupCultureDictionaries();
        this.SetupPublishedContentQuerying();
        this.SetupMembership();

        this.ServiceContext = ServiceContext.CreatePartial();
        this.UmbracoHelper = new UmbracoHelper(Mock.Of<IPublishedContent>(), Mock.Of<ITagQuery>(), this.CultureDictionaryFactory.Object, Mock.Of<IUmbracoComponentRenderer>(), this.PublishedContentQuery.Object, this.MembershipHelper);
        this.UmbracoMapper = new UmbracoMapper(new MapDefinitionCollection(new List<IMapDefinition>()));
    }

    public virtual void SetupHttpContext()
    {
        this.HttpContext = new Mock<HttpContextBase>();
    }

    public virtual void SetupCultureDictionaries()
    {
        this.CultureDictionary = new Mock<ICultureDictionary>();
        this.CultureDictionaryFactory = new Mock<ICultureDictionaryFactory>();
        this.CultureDictionaryFactory.Setup(x => x.CreateDictionary()).Returns(this.CultureDictionary.Object);
    }

    public virtual void SetupPublishedContentQuerying()
    {
        this.PublishedContentQuery = new Mock<IPublishedContentQuery>();
    }

    public virtual void SetupMembership()
    {
        this.memberService = new Mock<IMemberService>();
        var memberTypeService = Mock.Of<IMemberTypeService>();
        var membershipProvider = new MembersMembershipProvider(memberService.Object, memberTypeService);

        this.memberCache = new Mock<IPublishedMemberCache>();
        this.MembershipHelper = new MembershipHelper(this.HttpContext.Object, this.memberCache.Object, membershipProvider, Mock.Of<RoleProvider>(), memberService.Object, memberTypeService, Mock.Of<IUserService>(), Mock.Of<IPublicAccessService>(), AppCaches.NoCache, Mock.Of<ILogger>());
    }

    public void SetupPropertyValue(Mock<IPublishedContent> publishedContentMock, string alias, object value, string culture = null, string segment = null)
    {
        var property = new Mock<IPublishedProperty>();
        property.Setup(x => x.Alias).Returns(alias);
        property.Setup(x => x.GetValue(culture, segment)).Returns(value);
        property.Setup(x => x.HasValue(culture, segment)).Returns(value != null);
        publishedContentMock.Setup(x => x.GetProperty(alias)).Returns(property.Object);
    }
}
```

:::tip
```ServiceContext.CreatePartial()``` has several optional parameters, and by naming them you only need to mock the dependencies that you actually need, for example: ```ServiceContext.CreatePartial(contentService: Mock.Of<IContentService>());```
:::

## Testing a ContentModel

See [Reference documentation on Returning a view with a custom model](https://our.umbraco.com/documentation/Reference/Routing/custom-controllers#returning-a-view-with-a-custom-model).

```csharp
public class MyCustomViewModel : ContentModel
{
    public MyCustomViewModel(IPublishedContent content) : base(content) { }

    public string Heading => this.Content.Value<string>(nameof(Heading));
}

[TestFixture]
public class MyCustomModelTests : UmbracoBaseTest
{
    [SetUp]
    public override void SetUp()
    {
        base.SetUp();
    }

    [Test]
    [TestCase("", "")]
    [TestCase("My Heading", "My Heading")]
    [TestCase("Another Heading", "Another Heading")]
    public void GivenPublishedContent_WhenGetHeading_ThenReturnCustomViewModelWithHeadingValue(string value, string expected)
    {
        var publishedContent = new Mock<IPublishedContent>();
        base.SetupPropertyValue(publishedContent, nameof(MyCustomViewModel.Heading), value);
        
        var model = new MyCustomViewModel(publishedContent.Object);
        
        Assert.AreEqual(expected, model.Heading);
    }
}
```

## Testing a RenderMvcController

See [Reference documentation for Custom controllers (Hijacking Umbraco Routes)](https://our.umbraco.com/documentation/reference/routing/custom-controllers#creating-a-custom-controller).

```csharp
public class HomeController : RenderMvcController
{
    public HomeController(IGlobalSettings globalSettings, IUmbracoContextAccessor umbracoContextAccessor, ServiceContext serviceContext, AppCaches appCaches, IProfilingLogger profilingLogger, UmbracoHelper umbracoHelper) : base(globalSettings, umbracoContextAccessor, serviceContext, appCaches, profilingLogger, umbracoHelper) { }

    public override ActionResult Index(ContentModel model)
    {
        var myCustomModel = new MyCustomModel(model.Content);

        myCustomModel.MyProperty1 = "Hello World";

        return View(myCustomModel);
    }
}

public class MyCustomModel : ContentModel
{
    public MyCustomModel(IPublishedContent content) : base(content) { }

    public string MyProperty1 { get; set; }
}

[TestFixture]
public class HomeControllerTests : UmbracoBaseTest
{
    private HomeController controller;

    [SetUp]
    public override void SetUp()
    {
        base.SetUp();
        this.controller = new HomeController(Mock.Of<IGlobalSettings>(), Mock.Of<IUmbracoContextAccessor>(), base.ServiceContext, AppCaches.NoCache, Mock.Of<IProfilingLogger>(), base.UmbracoHelper);
    }

    [Test]
    public void WhenIndexAction_ThenResultIsIsAssignableFromContentResult()
    {
        var model = new ContentModel(new Mock<IPublishedContent>().Object);

        var result = this.controller.Index(model);

        Assert.IsAssignableFrom<ViewResult>(result);
    }

    [Test]
    public void GivenContentModel_WhenIndex_ThenReturnViewModelWithMyProperty()
    {
        var model = new ContentModel(new Mock<IPublishedContent>().Object);

        var result = (MyCustomModel)((ViewResult)this.controller.Index(model)).Model;

        Assert.AreEqual("Hello World", result.MyProperty1);
    }
}
```

## Testing a SurfaceController

See [Reference documentation on SurfaceControllers](../../Reference/Routing/surface-controllers.md).

```csharp
public class MySurfaceController : SurfaceController
{
    public MySurfaceController(IUmbracoContextAccessor umbracoContextAccessor, IUmbracoDatabaseFactory umbracoDatabaseFactory, ServiceContext serviceContext, AppCaches appCaches, ILogger logger, IProfilingLogger profilingLogger, UmbracoHelper umbracoHelper) : base(umbracoContextAccessor, umbracoDatabaseFactory, serviceContext, appCaches, logger, profilingLogger, umbracoHelper) { }

    public ActionResult Index()
    {
        return Content("Hello World");
    }
}

[TestFixture]
public class MySurfaceControllerTests : UmbracoBaseTest
{
    private MySurfaceController controller;

    [SetUp]
    public override void SetUp()
    {
        base.SetUp();
        this.controller = new MySurfaceController(Mock.Of<IUmbracoContextAccessor>(), Mock.Of<IUmbracoDatabaseFactory>(), base.ServiceContext, AppCaches.NoCache, Mock.Of<ILogger>(), Mock.Of<IProfilingLogger>(), base.UmbracoHelper);
    }

    [Test]
    public void WhenIndexAction_ThenResultIsIsAssignableFromContentResult()
    {
        var result = this.controller.Index();

        Assert.IsAssignableFrom<ContentResult>(result);
    }

    [Test]
    public void GivenResultIsAssignableFromContentResult_WhenIndexAction_ThenContentIsExpected()
    {
        var result = (ContentResult)this.controller.Index();

        Assert.AreEqual("Hello World", result.Content);
    }
}
```

## Testing an UmbracoApiController

See [Reference documentation on UmbracoApiControllers](https://our.umbraco.com/documentation/Reference/Routing/WebApi/#locally-declared-controller).

:::warning
This requires **Umbraco version 8.4 or higher**, due to a resolved [issue](https://github.com/umbraco/Umbraco-CMS/pull/6764).
:::

```csharp

public class ProductsController : UmbracoApiController
{
    public ProductsController(IGlobalSettings globalSettings, IUmbracoContextAccessor umbracoContextAccessor, ISqlContext sqlContext, ServiceContext serviceContext, AppCaches appCaches, IProfilingLogger profilingLogger, IRuntimeState runtimeState, UmbracoHelper umbracoHelper, UmbracoMapper umbracoMapper) : base(globalSettings, umbracoContextAccessor, sqlContext, serviceContext, appCaches, profilingLogger, runtimeState, umbracoHelper, umbracoMapper) { }

    public IEnumerable<string> GetAllProducts()
    {
        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
    }
}

[TestFixture]
public class ProductsControllerTests : UmbracoBaseTest
{
    private ProductsController controller;

    [SetUp]
    public override void SetUp()
    {
        base.SetUp();
        this.controller = new ProductsController(Mock.Of<IGlobalSettings>(), Mock.Of<IUmbracoContextAccessor>(), Mock.Of<ISqlContext>(), this.ServiceContext, AppCaches.NoCache, Mock.Of<IProfilingLogger>(), Mock.Of<IRuntimeState>(), base.UmbracoHelper, base.UmbracoMapper);
    }

    [Test]
    public void WhenGetAllProducts_ThenReturnViewModelWithExpectedProducts()
    {
        var expected = new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };

        var result = this.controller.GetAllProducts();

        Assert.AreEqual(expected, result);
    }
}

```

## Testing ICultureDictionary using the UmbracoHelper
See [Core documentation on the interface ICultureDictionary](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Dictionary.ICultureDictionary.html).

```csharp
public class HomeController : RenderMvcController
{
    public HomeController(IGlobalSettings globalSettings, IUmbracoContextAccessor umbracoContextAccessor, ServiceContext serviceContext, AppCaches appCaches, IProfilingLogger profilingLogger, UmbracoHelper umbracoHelper) : base(globalSettings, umbracoContextAccessor, serviceContext, appCaches, profilingLogger, umbracoHelper) { }

    public override ActionResult Index(ContentModel model)
    {
        var myCustomModel = new MyCustomModel(model.Content)
        {
            MyProperty1 = this.Umbraco.GetDictionaryValue("myDictionaryKey")
        };

        return View(myCustomModel);
    }
}

[TestFixture]
public class HomeControllerTests : UmbracoBaseTest
{
    private HomeController controller;
    private Mock<ICultureDictionary> cultureDictionary;

    [SetUp]
    public override void SetUp()
    {
        base.SetUp();
        this.controller = new HomeController(Mock.Of<IGlobalSettings>(), Mock.Of<IUmbracoContextAccessor>(), base.ServiceContext, AppCaches.NoCache, Mock.Of<IProfilingLogger>(), base.UmbracoHelper);
    }

    [Test]
    [TestCase("myDictionaryKey", "myDictionaryValue")]
    public void GivenMyDictionaryKey_WhenIndexAction_ThenReturnViewModelWithMyPropertyDictionaryValue(string key, string expected)
    {
        var model = new ContentModel(new Mock<IPublishedContent>().Object);
        base.CultureDictionary.Setup(x => x[key]).Returns(expected);

        var result = (MyCustomModel)((ViewResult)this.controller.Index(model)).Model;

        Assert.AreEqual(expected, result.MyProperty1);
    }
}
```

## Testing IPublishedContentQuery using the UmbracoHelper
See [Core documentation on the interface IPublishedContentQuery](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Web.IPublishedContentQuery.html).

```csharp
public class MyCustomController : RenderMvcController
{
    public MyCustomController(IGlobalSettings globalSettings, IUmbracoContextAccessor umbracoContextAccessor, ServiceContext serviceContext, AppCaches appCaches, IProfilingLogger profilingLogger, UmbracoHelper umbracoHelper) : base(globalSettings, umbracoContextAccessor, serviceContext, appCaches, profilingLogger, umbracoHelper) { }

    public override ActionResult Index(ContentModel model)
    {
        var myCustomModel = new MyOtherCustomModel(model.Content)
        {
            OtherContent = this.Umbraco.Content(1062)
        };

        return View(myCustomModel);
    }
}

public class MyOtherCustomModel : ContentModel 
{
    public MyOtherCustomModel(IPublishedContent content) : base(content) { }
    public IPublishedContent OtherContent { get; set; }
}

[TestFixture]
public class MyCustomControllerTests : UmbracoBaseTest
{
    private MyCustomController controller;

    [SetUp]
    public override void SetUp()
    {
        base.SetUp();
        this.controller = new MyCustomController(Mock.Of<IGlobalSettings>(), Mock.Of<IUmbracoContextAccessor>(), base.ServiceContext, AppCaches.NoCache, Mock.Of<IProfilingLogger>(), base.UmbracoHelper);
    }

    [Test]
    public void GivenContentQueryReturnsOtherContent_WhenIndexAction_ThenReturnViewModelWithOtherContent()
    {
        var currentContent = new ContentModel(new Mock<IPublishedContent>().Object);
        var otherContent = Mock.Of<IPublishedContent>();
        base.PublishedContentQuery.Setup(x => x.Content(1062)).Returns(otherContent);

        var result = (MyOtherCustomModel)((ViewResult)this.controller.Index(currentContent)).Model;

        Assert.AreEqual(otherContent, result.OtherContent);
    }
}
```

## Testing GetCurrentMember using the MembershipHelper
In this example we have a controller which renders a profile page, by using ```Umbraco.MembershipHelper.GetCurrentMember()```.
This involves a lot of different dependencies working together behind the scenes such as the ```MembershipHelper```, ```IMemberService```, ```IPublishedMemberCache``` and the ```HttpContext``` which needs to be mocked for our tests to run smoothly.

```csharp
public class MemberProfileController : RenderMvcController
{
    public MemberProfileController(IGlobalSettings globalSettings, IUmbracoContextAccessor umbracoContextAccessor, ServiceContext serviceContext, AppCaches appCaches, IProfilingLogger profilingLogger, UmbracoHelper umbracoHelper) : base(globalSettings, umbracoContextAccessor, serviceContext, appCaches, profilingLogger, umbracoHelper) { }

    public override ActionResult Index(ContentModel model)
    {
        var viewModel = new MemberProfile(model.Content)
        {
            Member = this.Umbraco.MembershipHelper.GetCurrentMember()
        };
        return View(viewModel);
    }
}

public class MemberProfile : ContentModel
{
    public MemberProfile(IPublishedContent content) : base(content) { }
    public IPublishedContent Member { get; set; }
}

[TestFixture]
public class MemberProfileControllerTests : UmbracoBaseTest 
{
    private MemberProfileController controller;
    
    [SetUp]
    public override void SetUp()
    {
        base.SetUp();
        this.controller = new MemberProfileController(Mock.Of<IGlobalSettings>(), Mock.Of<IUmbracoContextAccessor>(), base.ServiceContext, AppCaches.NoCache, Mock.Of<IProfilingLogger>(), base.UmbracoHelper);
    }

    [Test]
    [TestCase("member1")]
    [TestCase("member2")]
    public void GivenExistingMemberIsAuthenticated_WhenIndexAction_ThenReturnViewModelWithCurrentMember(string username)
    {
        var member = new Mock<IMember>();
        member.Setup(x => x.Username).Returns(username);
        base.memberService.Setup(x => x.GetByUsername(username)).Returns(member.Object);

        var expected = Mock.Of<IPublishedContent>();
        base.memberCache.Setup(x => x.GetByMember(member.Object)).Returns(expected);

        var identity = new Mock<IIdentity>();
        identity.Setup(user => user.IsAuthenticated).Returns(true);
        identity.Setup(user => user.Name).Returns(username);

        var principal = new Mock<IPrincipal>();
        principal.Setup(user => user.Identity).Returns(identity.Object);

        this.HttpContext.Setup(ctx => ctx.User).Returns(principal.Object);
        Thread.CurrentPrincipal = principal.Object;

        var actual = (MemberProfile)((ViewResult)this.controller.Index(new ContentModel(Mock.Of<IPublishedContent>()))).Model;

        Assert.AreEqual(expected, actual.Member);
    }

    [Test]
    [TestCase("member1")]
    [TestCase("member2")]
    public void GivenExistingMemberIsNotAuthenticated_WhenIndexAction_ThenReturnViewModelWithNullMember(string username)
    {
        var member = new Mock<IMember>();
        member.Setup(x => x.Username).Returns(username);
        base.memberService.Setup(x => x.GetByUsername(username)).Returns(member.Object);
        base.memberCache.Setup(x => x.GetByMember(member.Object)).Returns(Mock.Of<IPublishedContent>());
        
        var actual = (MemberProfile)((ViewResult)this.controller.Index(new Umbraco.Web.Models.ContentModel(Mock.Of<IPublishedContent>()))).Model;

        Assert.Null(actual.Member);
    }
}
```
