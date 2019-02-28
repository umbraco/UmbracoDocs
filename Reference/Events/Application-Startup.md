---
versionFrom: 8.0.0
---

# Adding startup events & event registration

In order to bind to certain events in the Umbraco application you need to make these registrations during application using a Component and a Composer.

## Use a Component to register events

:::note
Applies to: Umbraco 8.0.0+
:::

A [Component](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Composing.IComponent.html) is an implementation of IComponent that allows developers to execute code during the Umbraco start up and shut down process.
A [Composer](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.Composing.IUserComposer.html is used to add your custom Component to Umbraco.

This example will populate an 'excerpt' property for newly created content items based on the main article text:

```csharp
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Events;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class AddingExerptSetterComponentComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            // Append our component to the collection of Components
            // It will be the last one to be run
            composition.Components().Append<ExerptSettingComponent>();
        }
    }

    public class ExerptSettingComponent : IComponent
    {
        // initialize: runs once when Umbraco starts
        public void Initialize()
        {
            ContentService.Saving += ContentService_Saving;
        }

        // terminate: runs once when Umbraco stops
        public void Terminate()
        {
        }

 /// <summary>
        /// Listen for when content is being saved, check if it is a new item and fill in some
        /// default data.
        /// </summary>
        private void ContentService_Saving(IContentService sender, SaveEventArgs<IContent> e)
        {
            foreach (var content in e.SavedEntities
                // Check if the content item type has a specific alias
                .Where(c => c.Alias.InvariantEquals("MyContentType"))
                // Check if it is a new item
                .Where(c => c.IsNewEntity()))
            {
                // Check if the item has a property called 'richText'
                if (content.HasProperty("richText"))
                {
                    // get the rich text value
                    var val = c.GetValue<string>("richText");
                    // if there is a rich text value, set a default value in a 
                    // field called 'excerpt' that is the first
                    // 200 characters of the rich text value
                    c.SetValue("excerpt", val == null
                        ? string.Empty
                        : string.Join("", val.StripHtml().StripNewLines().Take(200)));
                }
            }
        }
    }
}

```
## Related Links

* [Composing](../../Implementation/Composing/index.md)
* [Troubleshooting Slow Startup](Troubleshooting-Slow-Startup.md)

