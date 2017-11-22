# EditorModel Events #

The **EditorModelEventManager** class is used to emit events that enable you to manipulate the model used by the backoffice before it is loaded into an editor  (for example the SendingContentModel event fires just before a content item is loaded into the backoffice for editing). It is therefore the perfect event to use to set a default value for a particular property, or perhaps to hide a property/tab from a certain editor.

## Usage ##

Example usage of the **EditorModelEventManager** '*SendingContentModel*' event - eg set the default PublishDate for a new NewsArticle to be today's date:

    using Umbraco.Core;
    using Umbraco.Core.Events;
    using Umbraco.Core.Models;
    using Umbraco.Web.Editors;
	using Umbraco.Web.Models.ContentEditing;
    
    namespace My.Namespace
    {
        public class MyEventHandler : ApplicationEventHandler
        {

			protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
            {
				EditorModelEventManager.SendingContentModel += EditorModelEventManager_SendingContentModel;   
            }            
    
             private void EditorModelEventManager_SendingContentModel(System.Web.Http.Filters.HttpActionExecutedContext sender, EditorModelEventArgs<Umbraco.Web.Models.ContentEditing.ContentItemDisplay> e)
			{

            //set a default value for NewsArticle PublishDate property, the editor can override this, but we will suggest it should be todays date
            if (e.Model.ContentTypeAlias == "newsArticle")
            {
               var pubDateProperty = e.Model.Properties.FirstOrDefault(f => f.Alias == "publishDate");
                if (pubDateProperty.Value == null || String.IsNullOrEmpty(pubDateProperty.Value.ToString())){
				//set default value if the date property is null or empty
                    pubDateProperty.Value = DateTime.UtcNow;
                }
            }
        }
        }
    }

## Events ##

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
        Raised when ContentService.Save is called in the API.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default).<br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:<br/>
		<em>NOTE: If the entity is brand new then HasIdentity will equal false.</em>
            <ol>
                <li>SavedEntities: Gets the collection of IContent objects being saved.</li>
            </ol>
        </td>
    </tr>
    <tr>
            <td>SendingMediaModel</td>
        <td>(HttpActionExecutedContext sender,  EditorModelEventArgs&ltMediaItemDisplay&gt; e)</td>
        <td>
        Raised when ContentService.Save is called in the API and after data has been persisted.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Save method call (true by default). <br />
        "sender" will be the current IContentService object.<br />
        "e" will provide:<br/>
		<em>NOTE: <a href="determining-new-entity">See here on how to determine if the entity is brand new</a></em>
            <ol>
                <li>SavedEntities: Gets the saved collection of IContent objects.</li>
            </ol>
        </td>
    </tr>
    <tr>
     <td>SendingMemberModel</td>
        <td>(HttpActionExecutedContext sender,  EditorModelEventArgs&ltMemberDisplay&gt; e)</td>
        <td>
        Raised when ContentService.Publishing is called in the API.<br />
        NOTE: It can be skipped completely if the parameter "raiseEvents" is set to false during the Publish method call (true by default).<br />
        "sender" will be the current IPublishingStrategy object.<br />
        "e" will provide:<br/>
		<em>NOTE: If the entity is brand new then HasIdentity will equal false.</em>
            <ol>
                <li>PublishedEntities: Gets the collection of IContent objects being published.</li>
            </ol>
        </td>
    </tr>   
</table>

### EditorModelEventArgs ###

The EditorModelEventArgs class has two properties, one 'Model' representing the type of Model being sent, eg 'ContentItemDisplay' and an 'UmbracoContext' property representing the current context.

#### ContentItemDisplay ####

A model representing a content item to be displayed in the backoffice
* TemplateAlias
* Urls
* AllowPreview - Determines whether previewing is allowed for this node, By default this is true but by using events developers can toggle this off for certain documents if there is nothing to preview
* AllowedActions - The allowed 'actions' based on the user's permissions - Create, Update, Publish, Send to publish
* IsBlueprint
* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection

#### MediaItemDisplay ####

A model representing a media item to be displayed in the backoffice
* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection

#### MemberDisplay ####

A model representing a member to be displayed in the backoffice
* Username
* Email
* MembershipScenario
* MemberProviderFieldMapping - This is used to indicate how to map the membership provider properties to the save model, this mapping will change if a developer has opted to have custom member property aliases specified in their membership provider config, or if we are editing a member that is not an Umbraco member (custom provider)
* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection