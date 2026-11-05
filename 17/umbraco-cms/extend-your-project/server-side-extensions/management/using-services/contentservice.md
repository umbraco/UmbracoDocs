---
description: Learn how to get, create, and publish content using the Content Service.
---

# Content Service

The `IContentService` reads and manages content items (`IContent`) in the database. It works with both draft and published versions. Use it for management tasks such as imports, migrations, and background jobs.

| Task | Service |
|---|---|
| Render or read published content | `IPublishedContentCache` or `IPublishedContentQuery`. See [Querying](../../../../develop-with-umbraco/templating-and-rendering/querying/README.md). |
| Create, update, or publish content as a specific user, identified by key | `IContentEditingService` and `IContentPublishingService` |
| Manage content directly, without validation | `IContentService` |

The examples on this page use two Document Types: *Catalogue* and *Product*. *Product* is allowed as a child of *Catalogue*. *Product* has a `category` property (`Textstring`) and a `price` property (`Numeric`).

Replace the aliases and keys with values from your own project.

## Getting Content

The following example retrieves content by key. `GetCategory()` reads a property value from a single content item. `GetChildren()` returns a page of the item's children.

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;

namespace MyProject.Services;

public class GetContentDemo
{
    private readonly IContentService _contentService;

    public GetContentDemo(IContentService contentService) => _contentService = contentService;

    public string? GetCategory(Guid key)
    {
        IContent? content = _contentService.GetById(key);

        // Reads the draft value. Pass published: true to read the published value.
        return content?.GetValue<string>("category");
    }

    public IEnumerable<IContent> GetChildren(Guid parentKey, int pageIndex, int pageSize)
    {
        IContent? parent = _contentService.GetById(parentKey);
        if (parent is null)
        {
            return [];
        }

        return _contentService.GetPagedChildren(
            parent.Id,
            pageIndex,
            pageSize,
            out long totalRecords,
            propertyAliases: null,
            filter: null,
            ordering: null);
    }
}
```

Pass `null` for `propertyAliases` to load all properties. Pass an empty array to load no custom properties.

Other retrieval methods include `GetByIds()`, `GetRootContent()`, `GetPagedDescendants()`, and `GetPagedOfType()`.

## Creating and Publishing Content

The following example creates a *Product* under a *Catalogue* page. It sets the property values, saves the content, and then publishes it.

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;

namespace MyProject.Services;

public class CreateProductDemo
{
    private readonly IContentService _contentService;

    public CreateProductDemo(IContentService contentService) => _contentService = contentService;

    public PublishResult CreateProduct(Guid catalogueKey, string name, string category, int price)
    {
        IContent product = _contentService.Create(name, catalogueKey, "product");
        product.SetValue("category", category);
        product.SetValue("price", price);

        OperationResult saveResult = _contentService.Save(product);
        if (saveResult.Success is false)
        {
            throw new InvalidOperationException($"Saving failed: {saveResult.Result}");
        }

        // "*" publishes invariant content.
        return _contentService.Publish(product, ["*"]);
    }
}
```

{% hint style="info" %}
Call `Save()` before `Publish()`. If the content has unsaved changes, `Publish()` neither publishes nor saves them. It returns a `PublishResult` with the status `FailedPublishUnsavedChanges` instead of throwing an exception.
{% endhint %}

`IContentService` does not validate property values when saving. Content with a missing mandatory value is saved, but `Publish()` returns `FailedPublishContentInvalid`.

### Saving and Publishing in one Call

`SaveAndPublish()` saves and publishes in one call. The following example creates a *Product* and saves and publishes it with a single method call. For invariant content, pass an empty array.

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;

namespace MyProject.Services;

public class SaveAndPublishDemo
{
    private readonly IContentService _contentService;

    public SaveAndPublishDemo(IContentService contentService) => _contentService = contentService;

    public PublishResult CreateProduct(Guid catalogueKey, string name)
    {
        IContent product = _contentService.Create(name, catalogueKey, "product");

        // For invariant content, pass an empty array. Wildcards ("*") are not accepted.
        return _contentService.SaveAndPublish(product, []);
    }
}
```

{% hint style="warning" %}
`SaveAndPublish()` does not accept wildcards. Passing `"*"` throws an `InvalidOperationException`. `Publish()` accepts both `"*"` and an empty array for invariant content.
{% endhint %}

### Multilingual Content

For a Document Type that varies by culture, set a name for each culture. Save the content, and then pass the cultures to publish:

```csharp
product.SetCultureName("Microphone", "en-US");
product.SetCultureName("Mikrofon", "da");

_contentService.Save(product);
PublishResult result = _contentService.Publish(product, ["en-US", "da"]);
```

A successful culture publish returns the status `SuccessPublishCulture`. To publish all cultures, pass `["*"]` to `Publish()`. `SaveAndPublish()` requires explicit cultures, for example `["en-US", "da"]`.

{% hint style="warning" %}
For content that varies by culture, `SaveAndPublish()` with an empty array saves the content but publishes no cultures. It still returns `SuccessPublishCulture`.
{% endhint %}

For information on retrieving a site's languages, see [Creating a Multilingual Site](../../../../develop-with-umbraco/tutorials/multilanguage-setup.md#getting-all-the-languages-for-a-site).

## Publishing a Branch

The following example publishes a page and all its descendants, including descendants that have never been published.

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;

namespace MyProject.Services;

public class PublishBranchDemo
{
    private readonly IContentService _contentService;

    public PublishBranchDemo(IContentService contentService) => _contentService = contentService;

    public IEnumerable<PublishResult> PublishBranch(Guid rootKey)
    {
        IContent content = _contentService.GetById(rootKey)
            ?? throw new InvalidOperationException($"Could not find content with key: {rootKey}.");

        return _contentService.PublishBranch(content, PublishBranchFilter.IncludeUnpublished, ["*"]);
    }
}
```

The `PublishBranchFilter` option can include one or more of the following flags:

* `Default` - publishes only published content with pending changes.
* `IncludeUnpublished` - publishes unpublished content and published content with pending changes.
* `ForceRepublish` - republishes all published content, even if unchanged.
* `All` - combines `IncludeUnpublished` and `ForceRepublish`.

The root of the branch is published even if it has never been published, whichever filter you use. For multilingual content, replace `"*"` with the cultures to publish, for example `["en-US", "da"]`.

## Identifying the User performing an Action

`IContentService` methods take an optional `int userId`. If you omit it, the action is recorded against the super user.

`IContentService` does not accept a user key. To record an action against a user identified by key, use one of the following approaches.

### Using the Editing and Publishing Services

`IContentEditingService` and `IContentPublishingService` take a `Guid userKey`. Pass `Constants.Security.SuperUserKey`, or the key of a specific user.

The following example creates a *Product* with `IContentEditingService`, and then publishes it with `IContentPublishingService`. Both calls record the action against the user identified by `userKey`.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Models.ContentEditing;
using Umbraco.Cms.Core.Models.ContentPublishing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Services.OperationStatus;

namespace MyProject.Services;

public class CreateProductWithKeysDemo
{
    private readonly IContentEditingService _contentEditingService;
    private readonly IContentPublishingService _contentPublishingService;
    private readonly IContentTypeService _contentTypeService;

    public CreateProductWithKeysDemo(
        IContentEditingService contentEditingService,
        IContentPublishingService contentPublishingService,
        IContentTypeService contentTypeService)
    {
        _contentEditingService = contentEditingService;
        _contentPublishingService = contentPublishingService;
        _contentTypeService = contentTypeService;
    }

    public async Task<ContentPublishingOperationStatus> CreateAndPublishAsync(Guid catalogueKey, Guid userKey, string name, string category, int price)    {
        IContentType productType = _contentTypeService.Get("product")
            ?? throw new InvalidOperationException("Could not find the 'product' document type.");

        var createModel = new ContentCreateModel
        {
            ContentTypeKey = productType.Key,
            ParentKey = catalogueKey,
            Variants = [new VariantModel { Name = name }],
            Properties =
            [
                new PropertyValueModel { Alias = "category", Value = category },
                new PropertyValueModel { Alias = "price", Value = price },
            ],
        };

        Attempt<ContentCreateResult, ContentEditingOperationStatus> createAttempt =
            await _contentEditingService.CreateAsync(createModel, userKey);

        // The content can be created even when property validation fails.
        // Check the status, not only Success.
        if (createAttempt.Status is not ContentEditingOperationStatus.Success || createAttempt.Result.Content is null)
        {
            throw new InvalidOperationException($"Creating failed: {createAttempt.Status}");
        }

        Attempt<ContentPublishingResult, ContentPublishingOperationStatus> publishAttempt =
            await _contentPublishingService.PublishAsync(
                createAttempt.Result.Content.Key,
                [new CulturePublishScheduleModel { Culture = "*" }],
                userKey);

        return publishAttempt.Status;
    }
}
```

Unlike `IContentService`, `IContentEditingService` validates the Document Type, the parent, and the property values. If property validation fails, the content is still created. The status is `PropertyValidationError`, and `Success` is `true`. Check the status, not only `Success`.

### Resolving a User Key to an ID

To keep using `IContentService`, resolve the user key to an ID with `IUserIdKeyResolver`. The following example publishes existing content and records the action against the resolved user:

```csharp
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;

namespace MyProject.Services;

public class PublishAsUserDemo
{
    private readonly IContentService _contentService;
    private readonly IUserIdKeyResolver _userIdKeyResolver;

    public PublishAsUserDemo(IContentService contentService, IUserIdKeyResolver userIdKeyResolver)
    {
        _contentService = contentService;
        _userIdKeyResolver = userIdKeyResolver;
    }

    public async Task<PublishResult> PublishAsync(Guid contentKey, Guid userKey)
    {
        IContent content = _contentService.GetById(contentKey)
            ?? throw new InvalidOperationException($"Could not find content with key: {contentKey}.");

        int userId = await _userIdKeyResolver.GetAsync(userKey);

        return _contentService.Publish(content, ["*"], userId);
    }
}
```

## Reading Values from Date Property Editors

The Date Only, Date Time (Unspecified), Date Time (with time zone), and Time Only property editors store values as JSON:

```json
{"date":"2026-11-03T00:00:00+00:00","timeZone":null}
```

`IContentService` returns this JSON as a string. The following example reads a Date Only property, deserializes it into a `DateTimeDto`, and returns a `DateOnly`:

```csharp
using System.Text.Json;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;
using static Umbraco.Cms.Core.PropertyEditors.ValueConverters.DateTimeValueConverterBase;

namespace MyProject.Services;

public class GetDateValueDemo
{
    private readonly IContentService _contentService;

    public GetDateValueDemo(IContentService contentService) => _contentService = contentService;

    public DateOnly? GetDate(Guid key, string propertyAlias)
    {
        IContent? content = _contentService.GetById(key);
        var rawValue = content?.GetValue<string>(propertyAlias);

        if (string.IsNullOrEmpty(rawValue))
        {
            return null;
        }

        DateTimeDto? dto = JsonSerializer.Deserialize<DateTimeDto>(rawValue);

        return dto is null ? null : DateOnly.FromDateTime(dto.Date.Date);
    }
}
```

The legacy Date Picker (`Umbraco.DateTime`) returns a `DateTime`, not JSON.
