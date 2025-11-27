# Adding a UI Builder repository as a prevalue source

When using [Umbraco UI Builder](https://docs.umbraco.com/umbraco-ui-builder/) alongside Umbraco Forms, you can use a configured UI Builder repository as a prevalue source.

To do this, you will need to create a custom `FieldPreValueSourceType` source that uses UI Builder's `SectionConfiguration` property editor. Once configured, you can select a repository and fetch the prevalues from there.

## Example

The following class shows how to create a `UIBuilderRepository` prevalue source type.

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;
using Umbraco.Cms.Core.Models;
using Umbraco.Forms.Core;
using Umbraco.Forms.Core.Attributes;
using Umbraco.Forms.Core.Models;
using Umbraco.UIBuilder.Configuration;
using Umbraco.UIBuilder.Services;

namespace MyFormsExtensions
{
    public class UIBuilderRepository : FieldPreValueSourceType
    {
        private readonly UIBuilderConfig _config;
        private readonly EntityService _entityService;

        public UIBuilderRepository(
            UIBuilderConfig config,
            EntityService entityService)
        {
            Id = new Guid("ED56A31B-56FD-41EA-9D21-755750879D13");
            Name = "UI Builder Repository";
            Alias = "uiBuilderRepository";
            Description = "Use a UI Builder repository as a prevalue source.";
            Icon = "icon-file-cabinet";

            _config = config;
            _entityService = entityService;
        }

        [Setting("Source", Description = "Select the source section, collection and data view", View = "UiBuilder.PropertyEditorUi.EntityPicker.SectionConfiguration", IsMandatory = true, DisplayOrder = 10)]
        public virtual string Source { get; set; } = string.Empty;

        public override Task<List<PreValue>> GetPreValuesAsync(Field? field, Form? form)
        {
            var result = new List<PreValue>();

            UIBuilderSectionConfiguration? configuration = ParseSourceConfiguration();
            if (configuration != null)
            {
                if (!string.IsNullOrEmpty(configuration.Collection))
                {
                    CollectionConfig collectionConfig = _config.Collections[configuration.Collection];
                    IEnumerable<object> entities;

                    if (string.IsNullOrEmpty(configuration.DataView))
                    {
                        entities = _entityService.GetAllEntities(collectionConfig);
                    }
                    else
                    {
                        var allEntities = new List<object>();
                        const int pageSize = 100;
                        int pageNumber = 1;
                        long totalPages = 0;

                        while (pageNumber == 1 || pageNumber <= totalPages)
                        {
                            PagedResult<object> pagedResult = _entityService.FindEntities(
                                collectionConfig,
                                pageNumber: pageNumber,
                                pageSize: pageSize,
                                dataViewAlias: configuration.DataView);

                            if (pagedResult.Items != null)
                            {
                                allEntities.AddRange(pagedResult.Items);
                            }

                            if (pageNumber == 1)
                            {
                                totalPages = pagedResult.TotalPages;
                            }

                            pageNumber++;
                        }

                        entities = allEntities;
                    }

                    foreach (var entity in entities)
                    {
                        var id = GetPropertyValue(collectionConfig.IdProperty, entity);
                        var name = GetPropertyValue(collectionConfig.NameProperty, entity);

                        result.Add(new PreValue()
                        {
                            Id = id?.ToString() ?? string.Empty,
                            Caption = name?.ToString() ?? string.Empty,
                            Value = id?.ToString() ?? string.Empty
                        });
                    }
                }
            }

            result = result.OrderBy(x => x.Id).ToList();
            return Task.FromResult(result);
        }

        public override List<Exception> ValidateSettings()
        {
            var exceptions = new List<Exception>();

            UIBuilderSectionConfiguration? configuration = ParseSourceConfiguration();
            if (configuration != null)
            {
                if (string.IsNullOrEmpty(configuration.Section))
                {
                    exceptions.Add(new Exception("'Section' setting has not been set"));
                }

                if (string.IsNullOrEmpty(configuration.Collection))
                {
                    exceptions.Add(new Exception("'Collection' setting has not been set"));
                }
            }

            return exceptions;
        }

        private UIBuilderSectionConfiguration? ParseSourceConfiguration()
        {
            if (string.IsNullOrEmpty(Source))
            {
                return null;
            }

            List<UIBuilderSectionConfigItem>? config = JsonSerializer.Deserialize<List<UIBuilderSectionConfigItem>>(Source);
            var result = new UIBuilderSectionConfiguration();

            if (config != null)
            {
                foreach (UIBuilderSectionConfigItem item in config)
                {
                    switch (item.Alias)
                    {
                        case "section":
                            result.Section = item.Value;
                            break;
                        case "collection":
                            result.Collection = item.Value;
                            break;
                        case "dataView":
                            result.DataView = item.Value;
                            break;
                        case "labels":
                            if (!string.IsNullOrEmpty(item.Value))
                            {
                                result.Labels = JsonSerializer.Deserialize<UIBuilderLabels>(item.Value);
                            }
                            break;
                    }
                }
            }

            return result;
        }

        private static object? GetPropertyValue(PropertyConfig? propertyConfig, object entity)
        {
            if (propertyConfig == null)
            {
                return null;
            }

            return propertyConfig.PropertyGetter?.Invoke(entity) ?? propertyConfig.PropertyExpression.Compile().DynamicInvoke(entity);
        }
    }

    internal class UIBuilderSectionConfigItem
    {
        [JsonPropertyName("alias")]
        public string? Alias { get; set; }

        [JsonPropertyName("value")]
        public string? Value { get; set; }
    }

    internal class UIBuilderSectionConfiguration
    {
        public string? Section { get; set; }
        public string? Collection { get; set; }
        public string? DataView { get; set; }
        public UIBuilderLabels? Labels { get; set; }
    }

    internal class UIBuilderLabels
    {
        [JsonPropertyName("plural")]
        public string? Plural { get; set; }

        [JsonPropertyName("singular")]
        public string? Singular { get; set; }
    }
}
```

And registered with:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
      builder.WithCollectionBuilder<FieldPreValueSourceCollectionBuilder>()
            .Add<UIBuilderRepository>();
    }
}
```

This will then make the **UI Builder Repository** available when creating a new prevalue source:

![UI Builder Repository available as a prevalue source](./images/uibuilder-repository-prevalue-source.png)

Once selected,  you can pick a **Section**, **Collection**, and **Data View** from the configured UI Builder repositories:

![Selecting a UI Builder repository as a prevalue source](./images/uibuilder-repository-prevalue-configuration.png)
