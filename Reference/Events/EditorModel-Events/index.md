---
keywords: EditorModelEventManager setting default values
versionFrom: 8.0.0
---

# EditorModel Events

The `EditorModelEventManager` class is used to emit events that enable you to manipulate the model used by the backoffice before it is loaded into an editor  (for example the SendingContentModel event fires just before a content item is loaded into the backoffice for editing). It is therefore the perfect event to use to set a default value for a particular property, or perhaps to hide a property/tab/Content App from a certain editor.

## Usage

Example usage of the `EditorModelEventManager` '*SendingContentModel*' event - eg set the default PublishDate for a new NewsArticle to be today's date:
```csharp
using System;
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Web.Editors;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class SubscribeToEditorModelEventsComposer : ComponentComposer<SubscribeToEditorModelEvents>
    {
    //this automatically adds the component to the Components collection of the Umbraco composition
    }

    public class SubscribeToEditorModelEvents : IComponent
    {
        // initialize: runs once when Umbraco starts
        public void Initialize()
        {
           EditorModelEventManager.SendingContentModel += EditorModelEventManager_SendingContentModel;
        }

        // terminate: runs once when Umbraco stops
        public void Terminate()
        {
        }

      private void EditorModelEventManager_SendingContentModel(System.Web.Http.Filters.HttpActionExecutedContext sender, EditorModelEventArgs<Umbraco.Web.Models.ContentEditing.ContentItemDisplay> e)
        {
            // set a default value for NewsArticle PublishDate property, the editor can override this, but we will suggest it should be today's date
            if (e.Model.ContentTypeAlias == "newsArticle")
            {
            //access the property you want to pre-populate
            //note each content item can have 'variations' - each variation is represented by the `ContentVariantDisplay` class, which has an IEnumerable of Tabs, and each Tab is an IEnumerable of `ContentPropertyDisplay` properties for each property in the document type
                var pubDateProperty = e.Model.Variants.FirstOrDefault().Tabs.FirstOrDefault(f=>f.Alias=="Content").Properties.FirstOrDefault(f => f.Alias == "publishDate");
                if (pubDateProperty.Value == null || String.IsNullOrEmpty(pubDateProperty.Value.ToString()))
                {
                    // set default value if the date property is null or empty
                    pubDateProperty.Value = DateTime.UtcNow;
                }
            }
        }
    }
}
```
## Events

<table>
    <tr>
        <th>Event</th>
        <th>Signature</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>SendingContentModel</td>
        <td>(HttpActionExecutedContext sender,  EditorModelEventArgs&ltContentItemDisplay&gt; e)</td>
        <td>
        Raised just before the editor model is sent for editing in the content section <br />
        NOTE: 'e' contains a model property of *Umbraco.Web.Models.ContentEditing.ContentItemDisplay* type which in turn contains the tabs and properties of the elements about to be loaded for editing
        </td>
    </tr>
    <tr>
        <td>SendingMediaModel</td>
        <td>(HttpActionExecutedContext sender,  EditorModelEventArgs&ltMediaItemDisplay&gt; e)</td>
        <td>
        Raised just before the editor model is sent for editing in the media section <br />
        NOTE: 'e' contains a model property of *Umbraco.Web.Models.ContentEditing.MediaItemDisplay* type which in turn contains the tabs and properties of the elements about to be loaded for editing
        </td>
    </tr>
    <tr>
        <td>SendingMemberModel</td>
        <td>(HttpActionExecutedContext sender,  EditorModelEventArgs&ltMemberDisplay&gt; e)</td>
        <td>
        Raised just before the editor model is sent for editing in the member section.<br />
        NOTE: 'e' contains a model property of *Umbraco.Web.Models.ContentEditing.MemberDisplay* type which in turn contains the tabs and properties of the elements about to be loaded for editing 
        </td>
    </tr>
    <tr>
        <td>SendingUserModel</td>
        <td>(HttpActionExecutedContext sender,  EditorModelEventArgs&ltUserDisplay&gt; e)</td>
        <td>
        Raised just before the editor model is sent for editing in the user section.<br />
        NOTE: 'e' contains a model property of *Umbraco.Web.Models.ContentEditing.UserDisplay* type which in turn contains the tabs and properties of the elements about to be loaded for editing
        </td>
            </tr>
       <tr>
             <td>SendingDashboardModel</td>
        <td>(HttpActionExecutedContext sender, EditorModelEventArgs&ltIEnumerable&ltTab&ltIDashboardSlim&gt;&gt;&gt; e)</td>
        <td>
        Raised just before the a dashboard is retrieved in a section.<br />
        NOTE: 'e' contains a model property that is an IEnumerable of *Umbraco.Web.Models.ContentEditing.Tab<Umbraco.Core.Dashboards.DashboardSlim>* each Tab object gives you access to Label, Alias, Properties and whether it IsActive, and the DashboardSlim gives you access to the alias and path to the angularJS view for the dashboard.
        </td>
    </tr>
   </table>

### EditorModelEventArgs

The EditorModelEventArgs class has two properties, one 'Model' representing the type of Model being sent, eg 'ContentItemDisplay' and an 'UmbracoContext' property representing the current context.

#### ContentItemDisplay

A model representing a content item to be displayed in the backoffice

* TemplateAlias
* Urls
* AllowPreview - Determines whether previewing is allowed for this node, By default this is true but by using events developers can toggle this off for certain documents if there is nothing to preview
* AllowedActions - The allowed 'actions' based on the user's permissions - Create, Update, Publish, Send to publish
* IsBlueprint
* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection

#### MediaItemDisplay

A model representing a media item to be displayed in the backoffice

* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection

#### MemberDisplay

A model representing a member to be displayed in the backoffice

* Username
* Email
* MembershipScenario
* MemberProviderFieldMapping - This is used to indicate how to map the membership provider properties to the save model, this mapping will change if a developer has opted to have custom member property aliases specified in their membership provider config, or if we are editing a member that is not an Umbraco member (custom provider)
* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection    

## Samples

The events exposed by the `EditorModelEventManager` class gives you a lot of options to customize the backoffice experience. You can can find inspiration from the various samples provided below:

* [Customizing the "Links" box](Customizing-the-links-box)
