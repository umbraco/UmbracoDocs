---
versionFrom: 8.0.0
---

# Unit Testing Umbraco

These examples requires [NUnit](https://nunit.org/) and [Moq](https://github.com/moq/moq4).

## SetUp

The ```Current.Factory``` needs to be mocked before each unit test that has an Umbraco dependency, or you'll get an ```InvalidOperationException``` saying that  **"No factory has been set"**.

```csharp
[SetUp]
public void SetUp()
{
     Current.Factory = new Mock<IFactory>().Object;
}
```

## TearDown

The ```Current.Factory``` needs to be reset after each test, or you'll get an ```InvalidOperationException``` in your second test saying that **"A factory has already been set"**.

```csharp
[TearDown]
public void TearDown() 
{
     Current.Reset();
}
```

## Render MVC Controller

See [Reference documentation for Custom controllers (Hijacking Umbraco Routes)](https://our.umbraco.com/documentation/reference/routing/custom-controllers#creating-a-custom-controller). 

```csharp
public class HomeController : RenderMvcController 
{
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
public class HomeControllerTests 
{
    private HomeController controller;

    [SetUp]
    public void SetUp() 
    {
        Current.Factory = new Mock<IFactory>().Object;
        this.controller = new HomeController();
    }

    [TearDown]
    public virtual void TearDown() 
    {
        Current.Reset();
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

## Surface Controller

See [Reference documentation on SurfaceControllers](../../Reference/Routing/surface-controllers.md).

```csharp
public class MySurfaceController : SurfaceController 
{
    public ActionResult Index() 
    {
        return Content("Hello World");
    }
}

[TestFixture]
public class MySurfaceControllerTests
{
    private MySurfaceController controller;

    [SetUp]
    public void SetUp() 
    {
        Current.Factory = new Mock<IFactory>().Object;
        this.controller = new MySurfaceController();
    }

    [TearDown]
    public void TearDown() 
    {
        Current.Reset();
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

## Umbraco API Controller

See [Reference documentation on UmbracoApiControllers](https://our.umbraco.com/documentation/Reference/Routing/WebApi/#locally-declared-controller).

```csharp

public class ProductsController : UmbracoApiController
{
    public IEnumerable<string> GetAllProducts()
    {
        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
    }
}

[TestFixture]
public class ProductsControllerTests
{
    private ProductsController controller;

    [SetUp]
    public void SetUp()
    {
        Current.Factory = new Mock<IFactory>().Object;
        this.controller = new ProductsController();
    }

    [TearDown]
    public virtual void TearDown()
    {
        Current.Reset();
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

## Content Model

See [Reference documentation on Returning a view with a custom model](https://our.umbraco.com/documentation/Reference/Routing/custom-controllers#returning-a-view-with-a-custom-model).

```csharp
public class MyCustomViewModel : ContentModel 
{
    public MyCustomViewModel(IPublishedContent content) : base(content) { }

    public string Heading => this.Content.Value<string>(nameof(Heading));
}

[TestFixture]
public class MyCustomModelTests 
{
    private Mock<IPublishedContent> content;

    [SetUp]
    public void SetUp() 
    {
        Current.Factory = new Mock<IFactory>().Object;
        this.content = new Mock<IPublishedContent>();
    }

    [TearDown]
    public void TearDown() 
    {
        Current.Reset();
    }

    [Test]
    [TestCase("", "")]
    [TestCase(null, null)]
    [TestCase("My Heading", "My Heading")]
    [TestCase("Another Heading", "Another Heading")]
    public void GivenPublishedContent_WhenGetHeading_ThenReturnCustomViewModelWithHeadingValue(string value, string expected)
    {
        this.SetupPropertyValue(nameof(MyCustomViewModel.Heading), value);
        var model = new MyCustomViewModel(this.content.Object);
        Assert.AreEqual(expected, model.Heading);
    }

    private void SetupPropertyValue(string alias, object value, string culture = null, string segment = null)
    {
        var property = new Mock<IPublishedProperty>();
        property.Setup(x => x.Alias).Returns(alias);
        property.Setup(x => x.GetValue(culture, segment)).Returns(value);
        property.Setup(x => x.HasValue(culture, segment)).Returns(value != null);
        this.content.Setup(x => x.GetProperty(alias)).Returns(property.Object);
    }
}
```

## Dictionaries
The ```ICultureDictionary``` is used to fetch Dictionary values from Umbraco. It's the equivalent of using ```UmbracoHelper.GetDictionaryValue(string key)```, but with less mocking required.

See [Core documentation on the interface ICultureDictionary](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Dictionary.ICultureDictionary.html).

```csharp
// Only necessary if the ICultureDictionary is not already registered.
public class CultureDictionaryComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
        composition.Register<ICultureDictionary, DefaultCultureDictionary>(Lifetime.Scope);
    }
}

public class MyDictionaryDependentController : RenderMvcController
{
    private readonly ICultureDictionary cultureDictionary;

    public MyDictionaryDependentController(ICultureDictionary cultureDictionary)
    {
        this.cultureDictionary = cultureDictionary;
    }

    public override ActionResult Index(ContentModel model)
    {
        var myCustomModel = new MyCustomModel(model.Content)
        {
            MyProperty1 = this.cultureDictionary["myDictionaryKey"]
        };

        return View(myCustomModel);
    }
}

[TestFixture]
public class MyDictionaryDependentControllerTests
{
    private MyDictionaryDependentController controller;
    private Mock<ICultureDictionary> cultureDictionary;

    [SetUp]
    public void SetUp()
    {
        Current.Factory = new Mock<IFactory>().Object;
        this.cultureDictionary = new Mock<ICultureDictionary>();
        this.controller = new MyDictionaryDependentController(this.cultureDictionary.Object);
    }

    [TearDown]
    public virtual void TearDown()
    {
        Current.Reset();
    }

    [Test]
    [TestCase("myDictionaryKey", "myDictionaryValue")]
    public void GivenMyDictionaryKey_WhenIndex_ThenReturnViewModelWithMyPropertyDictionaryValue(string key, string expected)
    {
        var model = new ContentModel(new Mock<IPublishedContent>().Object);
        this.cultureDictionary.Setup(x => x[key]).Returns(expected);

        var result = (MyCustomModel)((ViewResult)this.controller.Index(model)).Model;

        Assert.AreEqual(expected, result.MyProperty1);
    }
}
```

## Content Querying
The ```IPublishedContentQuery``` is used to fetch Content from Umbraco. It's the equivalent of using ```UmbracoHelper.Content(object id)```, but with less mocking required.

See [Core documentation on the interface IPublishedContentQuery](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Web.IPublishedContentQuery.html).

```csharp
public class MyCustomController : RenderMvcController
{
    private readonly IPublishedContentQuery contentQuery;

    public MyCustomController(IPublishedContentQuery contentQuery)
    {
        this.contentQuery = contentQuery;
    }

    public override ActionResult Index(ContentModel model)
    {
        var myCustomModel = new MyCustomModel(model.Content)
        {
            OtherContent = this.contentQuery.Content(1062)
        };

        return View(myCustomModel);
    }
}

[TestFixture]
public class MyCustomControllerTests
{
    private MyCustomController controller;
    private Mock<IPublishedContentQuery> contentQuery;

    [SetUp]
    public void SetUp()
    {
        Current.Factory = new Mock<IFactory>().Object;
        this.contentQuery = new Mock<IPublishedContentQuery>();
        this.controller = new MyCustomController(this.contentQuery.Object);
    }

    [TearDown]
    public virtual void TearDown()
    {
        Current.Reset();
    }

    [Test]
    public void GivenContentQueryReturnsOtherContent_WhenIndex_ThenReturnViewModelWithOtherContent()
    {
        var currentContent = new ContentModel(new Mock<IPublishedContent>().Object);
        var otherContent = Mock.Of<IPublishedContent>();
        this.contentQuery.Setup(x => x.Content(1062)).Returns(otherContent);
        
        var result = (MyCustomModel)((ViewResult)this.controller.Index(currentContent)).Model;

        Assert.AreEqual(otherContent, result.OtherContent);
    }
}
```