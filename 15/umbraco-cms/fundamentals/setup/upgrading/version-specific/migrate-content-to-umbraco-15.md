---
description: >-
  This article will help you migrate content to Umbraco 15, and outline options to skip this content migration
---

# Migrate content to Umbraco 15

Umbraco 15 changes the internal data format of all [Block Editors](../../../../fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/block-editor/README.md).

If you maintain a large Umbraco site with extensive Block Editor usage, the upgrade to Umbraco 15+ might require a long-running content migration. For the duration of the migration, your site will be unresponsive and unable to serve requests.

You can track the progress of the migration in the logs.

It is advised to [clean up old content versions](../../../../fundamentals/data/content-version-cleanup.md) before upgrading. This will make the migration run faster.

## Opting out of the content migration

It is strongly recommended to let the migration run as part of the upgrade. However, if you are upgrading to Umbraco versions 15, 16, or 17, you _can_ opt out of the migration. Your site will continue to work, albeit with a certain degree of performance degradation.

{% hint style="warning" %}
Blocks in Rich Text Editors might not work as expected if you opt out of the content migration.
{% endhint %}

You can opt out of migrating each Block Editor type individually. To opt-out, add an `IComposer` implementation to configure the `ConvertBlockEditorPropertiesOptions` before initiating the upgrade process:

{% code title="DisableBlockEditorMigrationComposer.cs" %}

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Infrastructure.Migrations.Upgrade.V_15_0_0;

namespace UmbracoDocs.Samples;

public class DisableBlockEditorMigrationComposer : IComposer
{
    [Obsolete]
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.Configure<ConvertBlockEditorPropertiesOptions>(options =>
        {
            // setting this to true will skip the migration of all Block List properties
            options.SkipBlockListEditors = false;

            // setting this to true will skip the migration of all Block Grid properties
            options.SkipBlockGridEditors = false;

            // setting this to true will skip the migration of all Rich Text Editor properties
            options.SkipRichTextEditors = false;
        });
}
```

{% endcode %}

Subsequently, you are responsible for performing the content migration yourself. This _must_ be done before upgrading past Umbraco 17.

Custom code is required to perform the content migration. You can find inspiration in the core migrations:

- [`ConvertBlockListEditorProperties`](https://github.com/umbraco/Umbraco-CMS/blob/contrib/src/Umbraco.Infrastructure/Migrations/Upgrade/V_15_0_0/ConvertBlockListEditorProperties.cs) for Block List properties.
- [`ConvertBlockGridEditorProperties`](https://github.com/umbraco/Umbraco-CMS/blob/contrib/src/Umbraco.Infrastructure/Migrations/Upgrade/V_15_0_0/ConvertBlockGridEditorProperties.cs) for Block Grid properties.
- [`ConvertRichTextEditorProperties`](https://github.com/umbraco/Umbraco-CMS/blob/contrib/src/Umbraco.Infrastructure/Migrations/Upgrade/V_15_0_0/ConvertRichTextEditorProperties.cs) for Rich Text Editor properties.

{% hint style="warning" %}
This custom code should not run while editors are working in the Umbraco backoffice.

The site may require a restart once the content migration is complete.
{% endhint %}
