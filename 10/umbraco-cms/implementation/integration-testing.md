---
meta.Title: Integration Testing Umbraco
description: A guide to getting started with integration testing in Umbraco
---

# Integration Testing

These examples are for Umbraco 10. They use [NUnit](https://nunit.org/) as the testing framework. Leveraging [Umbraco.Cms.Tests.Integration](https://github.com/umbraco/Umbraco-CMS/tree/main/tests/Umbraco.Tests.Integration) providing base classes. Beware that the Nuget package has an issue fixed in v10.3.1. So it is recommended to use this version.

## Getting started

First you have to create a new UnitTest project based on NUnit and install the package into the project.

```csharp
//Create project
dotnet new nunit
//Install Umbraco.Tests.Integration package
dotnet add package Umbraco.Cms.Tests.Integration
```

After the project is created and the package is added we have to create an `appsettings.Tests.json` file and a GlobalSetup class.

The `appsettings.Tests.json` can be a bit tricky, as a file with the same name is provided by the package but currently isn't picked up properly. A workaround is to create the file as `appsettings.json` and then rename the file.

The GlobalSetup is necessary to call the `GlobalSetupTeardown` class present in the package. This class makes sure that configuration is read and everything is setup as needed. Here is a sample that can be used:

```csharp
[SetUpFixture]
public class CustomGlobalSetupTeardown
{
    private static GlobalSetupTeardown _setupTearDown;

    [OneTimeSetUp]
    public void SetUp()
    {
        _setupTearDown = new GlobalSetupTeardown();
        _setupTearDown.SetUp();
    }

    [OneTimeTearDown]
    public void TearDown()
    {
        _setupTearDown.TearDown();
    }
}
```

Important: The class shouldn't have a namespace!

## Creating a test

To create a test you have to create a new class in your project. This class has to be derived from `UmbracoIntegrationTest`. This gives you access to some helper methods that you can use.

Second is the `[UmbracoTest]`-attribute that has to be set on the class. This attribute is responsible to set which type of database setup you want to use in your test class.

The available options are:

* None
* NewEmptyPerFixture
* NewEmptyPerTest
* NewSchemaPerFixture
* NewSchemaPerTest

Basic sample:

```csharp
using Umbraco.Cms.Tests.Integration;

[TestFixture]
[UmbracoTest(Database = UmbracoTestOptions.Database.NewSchemaPerTest)]
public class IntegrationTests : UmbracoIntegrationTest
{

}
```

## Testing a notification

Start by making a NotificationHandler, this example will be of one canceling overwrites on content named "Root", so if you have some content named "Root" published, you cannot change it.

```csharp
public class MyNotificationHandler : INotificationHandler<ContentSavingNotification>
{
    public void Handle(ContentSavingNotification notification)
    {
        foreach (var content in notification.SavedEntities)
        {
            if (content.PublishName == "Root")
            {
                notification.CancelOperation(new EventMessage("Cancelled", "Please do not change root content",
                    EventMessageType.Error));
            }
        }
    }
}
```

Then we can make an integration test, we do have to register our notification in the test like you would do with a composer, we can do this by overriding the `CustomTestSetupMethod` and adding the notification. After this, we can build our ContentType and Content with their respective builders. When we are saving both the ContentType & Content, we need the services to do so, so we use the `GetRequiredService<IService>` method that can get the services we need. We can then use `Assert.Multiple()` to do multiple asserts.

```csharp
[TestFixture]
[UmbracoTest(Database = UmbracoTestOptions.Database.NewSchemaPerTest)]
public class Tests : UmbracoIntegrationTest
{
    protected override void CustomTestSetup(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentSavingNotification, MyNotificationHandler>();
    }
    [Test]
    [TestCase("Root", true, OperationResultType.FailedCancelledByEvent)]
    [TestCase("Home Page", false, OperationResultType.Success)]
    public void Notification_Cancels_ContentType_If_AllowAsRoot(string name, bool hasErrors, OperationResultType expectedResult)
    {
        //Make ContentType and save
        var contentType = new ContentTypeBuilder()
            .WithId(0)
            .WithContentVariation(ContentVariation.Nothing)
            .Build();
        var contentTypeService = GetRequiredService<IContentTypeService>();
        contentTypeService.Save(contentType);
        //Make some content and publish it
        var content = new ContentBuilder()
            .WithContentType(contentType)
            .WithName(name)
            .Build();
        var contentService = GetRequiredService<IContentService>();
        contentService.SaveAndPublish(content);
        //Try to save the content
        var publishResult = contentService.Save(content);
        //assert
        var errors = publishResult.EventMessages.GetAll()
            .Where(x => x.MessageType == EventMessageType.Error);
        Assert.Multiple(() =>
        {
            Assert.AreEqual(hasErrors, errors.Any());
            Assert.AreEqual(expectedResult, publishResult.Result);
        });
    }
}
```

## Testing with a schema

So one of the awesome things about integration tests, is that you can set up a site, download the package for it, and we can run this state for every test. This means that you do not have to go through and set up your tests with data like we do in the above example with the builder pattern.

To start with we decorate our class with the `[UmbracoTest]` attribute and we again derive from `UmbracoIntegrationTest`. Then what you wanna do is set up your Umbraco site, go to the packages section and create your own package. Download the package and place the XML file next to your testing class. You want to have the build action of that XML file to be `EmbeddedResource`

Now we're almost ready to start testing! The last thing we wanna do is have a Setup method to install the package on your site.

```csharp
[SetUp]
public void MySetup()
{
    var xml = PackageMigrationResource.GetEmbeddedPackageDataManifest(this.GetType());
    var packagingService = GetRequiredService<IPackagingService>();
    packagingService.InstallCompiledPackageData(xml);
}
```

Now you're all set to start testing with your own site! Let's try and see how that would look! Here's an example test, where we test that content is deleted, if you delete the Document Types, as you can see, this time we do not have to use builder patterns to set up our site!

```csharp
[Test]
public void Ensure_No_Content_After_Doctype_Is_Deleted()
{
    var contentTypeService = GetRequiredService<IContentTypeService>();
    var contentTypes = contentTypeService.GetAll();
    Assert.AreEqual(true, contentTypes.Count() > 0);
    foreach (var contentType in contentTypes)
    {
        if (contentType.ParentId == Constants.System.Root)
        {
            contentTypeService.Delete(contentType);
        }
    }
    var contentService = GetRequiredService<IContentService>();
    var contents = contentService.GetRootContent();
    Assert.AreEqual(0, contents.Count());
    Assert.AreEqual(0, contentTypeService.GetAll().Count());
}
```

## Testing from controller to database

Sometimes we want to test from a controller action and down to the database. In this case, we use the built-in concept of a test server. All you need to do is to use the base class UmbracoTestServerTestBase. Let’s take an example:

```csharp
[TestFixture]
public class BackOfficeAssetsControllerTests: UmbracoTestServerTestBase
{
    [Test]
    public async Task EnsureSuccessStatusCode()
    {
        // Arrange
        var url = PrepareApiControllerUrl<BackOfficeAssetsController>(x => x.GetSupportedLocales());

        // Act
        var response = await Client.GetAsync(url);

        // Assert
        Assert.AreEqual(HttpStatusCode.OK, response.StatusCode);
    }
}
```

In this example you have to note three things:

* You still need the `CustomGlobalSetupTeardown` class
* The PrepareUrl to get the URL of an Action and ensure all services use the URL information when requested.
* The Client which is a normal HttpClient, but the base URL points to the test server that is set up for each test.

Note that you can still use GetRequiredService to get the services required to seed data.

Keep in mind that integration tests require a lot of setup before the test executes. So execution time will be many times longer compared to a unit test.
