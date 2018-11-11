---
keywords: EditorModelEventManager
versionTo: 7.4.0
---

# Pre-EditorModel Events solutions

Before Umbraco version 7.4, there was no real way of interfering with the "model" requested by Angular.

You would set default values after the content created event.

Using e.g. an event handler class something like the following:

    public class InitializeNewMyDocumentTypeContent : ApplicationEventHandler
    {
        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            ContentService.Created += ContentCreated;
            base.ApplicationStarted(umbracoApplication, applicationContext);
        }

        private void ContentCreated(IContentService sender, NewEventArgs<IContent> e)
        {
            if (e.Entity.ContentType.Alias == "MyDocumentType")
            {
                e.Entity.SetValue("pageTitle", "Untitled");
                sender.Save(e.Entity);
            }
        }
    }
