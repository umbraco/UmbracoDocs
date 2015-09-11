#Published Content Request Preparation

Is called in `UmbracoModule`:

    void ProcessRequest(…)

What it does:

- It ensures Umbraco is ready, and the request is a document request.
- Creates a PublishedContentRequest instance
- Runs PublishedContentRequestEngine.PrepareRequest() for that instance
- Handles redirects and status
- Forwards missing content to ugly 404
- Forwards to either WebForms or MVC

## PrepareRequest
The ProcessRequest method calls the PublishedContentRequestEngine.PrepareRequest method. The prepare request takes care of:

- FindDomain()
- Handles redirects
- Sets culture
- FindPublishedContentAndTemplate()
- Sets culture (again, in case it was changed)
- Triggers PublishedContentRequest.Prepared event
- Sets culture (again, in case it was changed)
- Handles redirects and missing content
- Initializes a few internal stuff

We will discuss a few of these steps below.

### FindDomain()
The FindDomain method looks for a domain matching the request Uri

- Using a greedy match: “domain.com/foo” takes over “domain.com”
- Sets published content request’s domain
- If a domain was found
	- Sets published content request’s culture accordingly
	- Computes domain Uri based upon the current request ("domain.com" for "http://domain.com" or "https://domain.com")
- Else
- Sets published content request’s culture by default
(first language, else system)

### FindPublishedContentAndTemplate()
1. FindPublishedContent ()
2. Handles redirects
3. HandlePublishedContent()
4. FindTemplate()
5. FollowExternalRedirect()
6. HandleWildcardDomains()

If content is not found, the ContentFinder kicks in.  In the past this was handled by the INotFoundHandler, but the new request pipeline uses [IContentFinder](IContentFinder.md).

More information can be found [here](FindPublishedContentAndTemplate.md).

UmbracoModule will pick up the redirect and redirect...  There is no need to write your own redirects:

    PublishedContentRequest.Prepared += (sender, args) =>
    {
      var request = sender as PublishedContentRequest;  
      if (!request.HasPublishedContent) return;

      var content = request.PublishedContent;
      var redirect = content.GetPropertyValue<string>("myRedirect");
      
      if (!string.IsNullOrWhiteSpace(redirect))
        request.SetRedirect(redirect);
    }

## Forward to either WebForms or Mvc

Concerning Webforms - that's the same as v4 (no change).  That means that MVC has been made possible by the pipeline.

You can of course create your own Mvc RenderController: 


    // This is the default controller
    public class RenderMvcController : UmbracoController
    { … }

    // But feel free to use your own
    public class DefaultRenderMvcControllerResolver
    { … }

Note: a missing template goes to MVC

There's one by default but you can use your own, so still time to change the view...

As a reminder, [Route hijacking](../../Reference/Templating/Mvc/custom-routes.md) works like this: 

- create a **MyContentType**Controller
  - Will run in place of the default controller
  - For every content of type **MyContentType**
- Specific action runs if name matches the template alias
- Otherwise default (Index) action runs

## Missing template?
In case the PrepareRequest can not find a template:

* it will verify if this is route hijacking
* otherwise handles these steps:
  *  HandlePublishedContent()
  * FindTemplate()
  * Handle redirects, etc.
  * Ugly 404 (w/ message)
  * Transfer to WebForms or MVC…

## Other things which got routed in the process
* The /Base Rest service
* WebApi
* Mvc Routes
