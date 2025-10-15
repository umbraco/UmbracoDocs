# Declaring your property editor

Generally Umbraco supports two different ways to declare a property editor. Most commonly one would create a `package.manifest` file, and then use it for declaring one or more property editors. But as an alternative, property editors can also be declared using C#.

A property editor consists of a number of mandatory properties, and some optional ones as well. As such, the outer JSON object for the property editor has the following properties:

| Name                | Type    | Required | Description                                                                                                                                                                                                                                            |
| ------------------- | ------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `alias`             | string  | Yes      | A unique alias that identifies the property editor.                                                                                                                                                                                                    |
| `name`              | string  | Yes      | The friendly name of the property editor, shown in the Umbraco backoffice.                                                                                                                                                                             |
| `editor`            | object  | Yes      | This describes details about the editor. See the table below for further information.                                                                                                                                                                  |
| `icon`              | string  | No       | A CSS class for the icon to be used in the **Select Editor** dialog - eg: `icon-autofill`.                                                                                                                                                             |
| `group`             | string  | No       | The group to place this editor in within the **Select Editor** dialog. Use a new group name or alternatively use an existing one such as **Pickers**.                                                                                                  |
| `isParameterEditor` | boolean | No       | Enables the property editor as a macro parameter editor. Can be either `true` or `false` (default).                                                                                                                                                    |
| `defaultConfig`     | object  | No       | Provides a collection of default configuration values, in cases the property editor is not configured or is used a parameter editor (which doesn't allow configuration). The object is a key/value collection and must match the prevalue fields keys. |

The `editor` object then has the following properties:

| Name         | Type    | Required | Description                                                                                                                                                         |
| ------------ | ------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `view`       | string  | Yes      | This is the full path to the HTML view for your property editor.                                                                                                    |
| `hideLabel`  | bool    | Yes      | If set to `true`, this hides the label for the property editor when used in Umbraco on a Document Type.                                                             |
| `valueType`  | object  | No       | This is the type of data you want your property editor to save to Umbraco. Possible values are `STRING`, `JSON`, `DATETIME`, `TEXT` and `INT`. Default is `STRING`. |
| `validation` | object  | No       | Object describing required validators on the editor.                                                                                                                |
| `isReadOnly` | boolean | No       | If set to true this makes the property editor read only.                                                                                                            |

## Using a Package Manifest

A package manifest is a file specific to your package or custom code. This file is always stored in a folder in `/App_Plugins/{YourPackageName}`, and with the name `package.manifest` :

```json
{
    "propertyEditors": [
        {
            "alias": "Sir.Trevor",
            "name": "Sir Trevor",
            "editor": {
                "view": "/App_Plugins/SirTrevor/SirTrevor.html",
                "hideLabel": true,
                "valueType": "JSON"
            }
        }
    ],
    "javascript": [
        "/App_Plugins/SirTrevor/SirTrevor.controller.js"
    ]
}
```

This example manifest specifies a **Sir Trevor** property editor via the `propertyEditors` collection, and also adds a single JavaScript file via the `javascript` property.

The actual **Sir Trevor** property editor has some additional configuration. It's a block based editor, so for instance it has a prevalue for setting the maximum amount of blocks allowed. In full, the `package.manifest` file for the Sir Trevor package looks like:

```json
{
  "propertyEditors": [
    {
      "alias": "Sir.Trevor",
      "name": "Sir Trevor",
      "editor": {
        "view": "/App_Plugins/SirTrevor/SirTrevor.html",
        "hideLabel": true,
        "valueType": "JSON"
      },
      "prevalues": {
        "fields": [
          {
            "label": "Maximum number of blocks",
            "description": "The total maximum number of blocks (of any type) that can be displayed (0 = infinite).",
            "key": "blockLimit",
            "view": "requiredfield",
            "validation": [
              {
                "type": "Required"
              }
            ]
          },
          {
            "label": "Align editor centered",
            "description": "If the editor doesn't span the entire width of the content editing area, center it. Otherwise left aligned.",
            "key": "editorAlignCentered",
            "view": "boolean"
          },
          {
            "label": "Editor width",
            "description": "The width the Sir Trevor editor will expand to, most likely 100%.",
            "key": "editorWidth",
            "view": "requiredfield",
            "validation": [
              {
                "type": "Required"
              }
            ]
          },
          {
            "label": "Maximum editor width",
            "description": "The maximum width the Sir Trevor editor will expand to, i.e. 500px or 80%.",
            "key": "editorMaxWidth",
            "view": "requiredfield",
            "validation": [
              {
                "type": "Required"
              }
            ]
          },
          {
            "label": "Block types",
            "description": "Configure the block types available to the user.",
            "key": "blocktypes",
            "view": "~/App_Plugins/SirTrevor/settings/blocktypes.html"
          }
        ]
      }
    }
  ],
  "javascript": [
    "/App_Plugins/SirTrevor/SirTrevor.controller.js",
    "/App_Plugins/SirTrevor/settings/settings.blocktypes.controller.min.js",
    "/App_Plugins/SirTrevor/settings/settings.resource.min.js"
  ]
}
```

## Using Csharp

The same property editor can be declared using C# instead using the `DataEditor` class and decorating the class with the `DataEditor` attribute:

```csharp
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.WebAssets;
using Umbraco.Cms.Infrastructure.WebAssets;

namespace UmbracoEightExamples.PropertyEditors
{
    [DataEditor(
        "Sir.Trevor",
        EditorType.PropertyValue,
        "Sir Trevor",
        "/App_Plugins/SirTrevor/SirTrevor.html",
        ValueType = ValueTypes.Json,
        HideLabel = true)]
    [PropertyEditorAsset(AssetType.Javascript, "/App_Plugins/SirTrevor/SirTrevor.controller.js")]
    public class SirTrevorEditor : DataEditor
    {
        public SirTrevorEditor(
            IDataValueEditorFactory dataValueEditorFactory,
            EditorType type = EditorType.PropertyValue)
            : base(dataValueEditorFactory, type)
        {
        }
    }
}
```

Also notice how the `PropertyEditorAsset` attribute is used to load the `SirTrevor.controller.js` JavaScript file.

### DataEditor attribute

The [DataEditor](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.PropertyEditors.DataEditorAttribute.html) attribute shown in the example above is the primary component to declaring the property editor in C#. Notice that the first four properties must be set through the constructor.

| Name           | Type                                                                                                      | Required | Description                                                                                                                       |
| -------------- | --------------------------------------------------------------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `Alias`        | string                                                                                                    | Yes      | Gets the unique alias of the editor.                                                                                              |
| `EditorType`   | [EditorType](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.PropertyEditors.EditorType.html) | Yes      | Gets the type of the editor. Possible values are `EditorType.PropertyValue`, `EditorType.MacroParameter` or `EditorType.Nothing`. |
| `Name`         | string                                                                                                    | Yes      | Gets the friendly name of the editor.                                                                                             |
| `View`         | string                                                                                                    | Yes      | Gets the view to use to render the editor.                                                                                        |
| `ValueType`    | string                                                                                                    | No       | Gets or sets the type of the edited value.                                                                                        |
| `HideLabel`    | boolean                                                                                                   | No       | Gets or sets a value indicating whether the editor should be displayed without its label.                                         |
| `Icon`         | string                                                                                                    | No       | Gets or sets an optional icon.                                                                                                    |
| `Group`        | string                                                                                                    | No       | Gets or sets an optional group.                                                                                                   |
| `IsDeprecated` | boolean                                                                                                   | No       | Gets or sets a value indicating whether the value editor is deprecated.                                                           |

### PropertyEditorAsset attribute

As shown in the C# example, the [PropertyEditorAsset](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Infrastructure.WebAssets.PropertyEditorAssetAttribute.html) attribute was used to make Umbraco load the specified JavaScript file.

The constructor of the attribute takes the type of the assets as the first parameter. Possible values are either `AssetType.Javascript` or `AssetType.Css`. The second parameter is the URL of the asset.

### DataEditor class

In the example above, the `SirTrevorEditor` class doesn't really do much. For more basic property editors, the C# approach may require a bit more work compared to that of `package.manifest` files. But as property editors grow in complexity, using C# becomes a bit more useful - and also lets you do things not possible with `package.manifest` files.

The [DataEditor](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.PropertyEditors.DataEditor.html) class defines a virtual `CreateConfigurationEditor` method. It returns a model which is used for the Angular view when editing the prevalues of a Data Type.

Virtual methods are methods declared in a parent class. These methods have a default implementation that can be overridden in classes that inherit from the parent class. For instance in the example below, we can override the method and provide our own `SirTrevorConfigurationEditor` instead of what Umbraco returns by default.

```csharp
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.WebAssets;
using Umbraco.Cms.Infrastructure.WebAssets;

namespace UmbracoEightExamples.PropertyEditors
{
    [DataEditor(
        "Sir.Trevor",
        EditorType.PropertyValue,
        "Sir Trevor",
        "/App_Plugins/SirTrevor/SirTrevor.html",
        ValueType = ValueTypes.Json,
        HideLabel = true)]
    [PropertyEditorAsset(AssetType.Javascript, "/App_Plugins/SirTrevor/SirTrevor.controller.js")]
    public class SirTrevorEditor : DataEditor
    {
        public SirTrevorEditor(
            IDataValueEditorFactory dataValueEditorFactory,
            EditorType type = EditorType.PropertyValue)
            : base(dataValueEditorFactory, type)
        {
        }

        protected override IConfigurationEditor CreateConfigurationEditor() => new SirTrevorConfigurationEditor();

    }
}
```

In this case, the `SirTrevorConfigurationEditor` class doesn't do much either - but notice that it inherits from `ConfigurationEditor<SirTrevorConfiguration>`, meaning the configuration will be of type `SirTrevorConfiguration`:

```csharp
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.Services;

namespace UmbracoEightExamples.PropertyEditors
{
    public class SirTrevorConfigurationEditor : ConfigurationEditor<SirTrevorConfiguration>
    {
        public SirTrevorConfigurationEditor(IIOHelper ioHelper, IEditorConfigurationParser editorConfigurationParser) : base(ioHelper, editorConfigurationParser)
        {
        }
    }
}
```

The referenced `SirTrevorConfiguration` class is then what declares the configuration fields of when editing a Data Type using the Sir Trevor property editor:

```csharp
using Umbraco.Cms.Core.PropertyEditors;

namespace UmbracoEightExamples.PropertyEditors
{
    public class SirTrevorConfiguration
    {
        [ConfigurationField("blockLimit", "Maximum number of blocks", "requiredfield",
            Description = "The total maximum number of blocks (of any type) that can be displayed (0 = infinite).")]
        public int BlockLimit { get; set; }

        [ConfigurationField("editorAlignCentered", "Align editor centered", "boolean",
            Description =
                "If the editor doesn't span the entire width of the content editing area, center it. Otherwise left aligned.")]
        public bool EditorAlignCentered { get; set; }

        [ConfigurationField("editorWidth", "Editor width", "requiredfield",
            Description = "The width the Sir Trevor editor will expand to, most likely 100%.")]
        public int EditorWidth { get; set; }

        [ConfigurationField("editorMaxWidth", "Maximum editor width", "requiredfield",
            Description = "The maximum width the Sir Trevor editor will expand to, i.e. 500px or 80%.")]
        public int EditorMaxWidth { get; set; }

        [ConfigurationField("blocktypes", "Block types", "/App_Plugins/SirTrevor/settings/blocktypes.html",
            Description = "Configure the block types available to the user.")]
        public object BlockTypes { get; set; }
    }
}
```

A benefit of this approach (opposed to `package.manifest` files) is that we can now refer to the configuration using a strongly typed model - eg. as in this example Razor view:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;
@using Umbraco.Cms.Core.Services
@using UmbracoEightExamples.PropertyEditors
@inject IDataTypeService DataTypeService

@{
    var dt = DataTypeService.GetDataType(1234);

    if (dt is not null)
    {
        <pre>@dt.Name</pre>

        <pre>@(dt.Configuration as SirTrevorConfiguration)</pre>

        <pre>@(dt.ConfigurationAs<SirTrevorConfiguration>())</pre>
    }
}
```

Both instances of `IDataType` and `PublishedDataType` have a `Configuration` property. When looking across all data types and property editors, there is no common type for the configuration, so the return value is `object`. To get the strongly typed model, you can either cast the configuration value on your own, or use the generic `ConfigurationAs` extension method as shown above.

Like mentioned before, the `SirTrevorConfigurationEditor` class doesn't really do much in this example with the Sir Trevor property editor. But the **Multi Node Tree Picker** and others of Umbraco's build in property editors also override the `ToValueEditor` method.

This method is used when the strongly typed configuration value is converted to the model used by the Angular logic in the backoffice. So with the implementation of the [MultiNodePickerConfigurationEditor](https://github.com/umbraco/Umbraco-CMS/blob/ade9bb73246caf25a7073f2b9e5262641a201863/src/Umbraco.Web/PropertyEditors/MultiNodePickerConfigurationEditor.cs) class, some additional configuration fields are sent along. For instance that it's a multi picker and that the ID type should be URI's. These are configuration values that the user should not be able to edit, but the property editor may still rely on them.

```csharp
using Umbraco.Cms.Core.IO;
using Umbraco.Cms.Core.Services;

namespace Umbraco.Cms.Core.PropertyEditors;

/// <summary>
///     Represents the configuration for the multinode picker value editor.
/// </summary>
public class MultiNodePickerConfigurationEditor : ConfigurationEditor<MultiNodePickerConfiguration>
{
    public MultiNodePickerConfigurationEditor(IIOHelper ioHelper, IEditorConfigurationParser editorConfigurationParser)
        : base(ioHelper, editorConfigurationParser) =>
        Field(nameof(MultiNodePickerConfiguration.TreeSource))
            .Config = new Dictionary<string, object> { { "idType", "udi" } };

    /// <inheritdoc />
    public override Dictionary<string, object> ToConfigurationEditor(MultiNodePickerConfiguration? configuration)
    {
        // sanitize configuration
        Dictionary<string, object> output = base.ToConfigurationEditor(configuration);

        output["multiPicker"] = configuration?.MaxNumber > 1;

        return output;
    }

    /// <inheritdoc />
    public override IDictionary<string, object> ToValueEditor(object? configuration)
    {
        IDictionary<string, object> d = base.ToValueEditor(configuration);
        d["multiPicker"] = true;
        d["showEditButton"] = false;
        d["showPathOnHover"] = false;
        d["idType"] = "udi";
        return d;
    }
}
```
