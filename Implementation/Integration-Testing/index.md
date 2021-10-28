---
versionFrom: 9.1.0
needsV9Update: false
meta.Title: "Integration Testing Umbraco"
meta.Description: "A guide to getting started with integration testing in Umbraco"
---

# Integration Testing Umbraco


These examples are for Umbraco 8+ and they rely on [NUnit](https://nunit.org/) and [Umbraco.Cms.Tests.Integration](https://github.com/Umbraco).

# Using the NuGet package and attributes in your class

In your NUnit class you need to use the NuGet package Umbraco.Cms.Tests.Integration, and then decorate your class with the TestFixture attribute & UmbracoTest attribute, with the UmbracoTest attributes there are multiple options:
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

Start by making a NotificationHandler, this example will be of one cancelling overwrites on content named "Root", so if you have some content named "Root" published, you cannot change it.

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
Then we can make an integration tests, we do have to register our notification in the test like you would do with a composer, we can do this by overriding the `CustomTestSetupMethod` and adding the notification.
After this we can build our ContentType and Content with their respective builders.
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



