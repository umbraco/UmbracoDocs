---
versionFrom: 9.1.0
versionTo: 10.0.0
meta.Title: "Integration Testing Umbraco"
meta.Description: "A guide to getting started with integration testing in Umbraco"
---

# Integration Testing Umbraco

These examples are for Umbraco 9.1+ and they rely on [NUnit](https://nunit.org/) and [Umbraco.Cms.Tests.Integration](https://github.com/umbraco/Umbraco-CMS/tree/v10/contrib/tests/Umbraco.Tests.Integration).

## Using the NuGet package and attributes in your class

In your NUnit class, you need to use the NuGet package Umbraco.Cms.Tests.Integration, and then decorate your class with the TestFixture attribute & UmbracoTest attribute, with the UmbracoTest attributes there are multiple options:

- None
- NewEmptyPerFixture
- NewEmptyPerTest
- NewSchemaPerFixture
- NewSchemaPerTest

Besides that you also need to derive from the UmbracoIntegrationTest class, with this you are now ready to start Integration Testing.

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

Then we can make an integration test, we do have to register our notification in the test like you would do with a composer, we can do this by overriding the `CustomTestSetupMethod` and adding the notification.
After this, we can build our ContentType and Content with their respective builders.
When we are saving both the ContentType & Content, we need the services to do so, so we use the `GetRequiredService<IService>` method that can get the services we need.
We can then use `Assert.Multiple()` to do multiple asserts

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

So one of the awesome things about integration tests, is that you can set up a site, download the package for it, and we can run this state for every test.
This means that you do not have to go through and set up your tests with data like we do in the above example with the builder pattern.

To start with we decorate our class with the `[UmbracoTest]` attribute and we again derive from `UmbracoIntegrationTest`
Then what you wanna do is set up your Umbraco site, go to the packages section and create your own package. Download the package and place the XML file next to your testing class. You want to have the build action of that XML file to be `EmbeddedResource`

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

Now you're all set to start testing with your own site! Let's try and see how that would look!
Here's an example test, where we test that content is deleted, if you delete the Document Types, as you can see, this time we do not have to use builder patterns to set up our site!

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
