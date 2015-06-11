#FindPublishedContentAndTemplate()

This method is called on the "PublishedContentRequest.PrepareRequest()" method.  
We discuss shortly what this method is doing:

1. FindPublishedContent ()
2. Handles redirects
3. HandlePublishedContent()
4. FindTemplate()
5. FollowExternalRedirect()
6. HandleWildcardDomains()

#### HandlePublishedContent
- No content?
 - Run the LastChanceFinder
 - Is an IContentFinder, resolved by ContentLastChanceFinderResolver
 - By default, is null (= ugly 404)
- Follow internal redirects
 - Take care of infinite loops
- Ensure user has access to published content
 - Else redirect to login or access denied published content
- Loop while there is no content
 - Take care of infinite loops

#### FindTemplate
- Use altTemplate if
 - Initial content
 - Internal redirect content, and InternalRedirectPreservesTemplate is true
- No alternate template?
 - Use the current template if one has already been selected
 - Else use the template specified for the content, if any
- Alternate template?
  - Use the alternate template, if any
  - Else use what’s already there: a template, else none
- Alternate template is used only if displaying the intended content
  - Except for internal redirects
  - If you enable InternalRedirectPreservesTemplate
  - Which is false by default
- Alternate template replaces whatever template the finder might have set
  - ContentFinderByNiceUrlAndTemplate
  - /path/to/page/template1?altTemplate=template2  template2
- Alternate template does not falls back to the specified template for the content
  - /path/to/page?altTemplate=missing  no template
  - Even if the page has a template
- But preserves whatever template the finder might have set
  - /path/to/page/template1?altTemplate=missing  template1
- Yes, these rules are arbitrary… feedback?  Get to the [Dev Group](https://groups.google.com/forum/#!forum/umbraco-dev)!

#### FollowExternalRedirect()
- content.GetPropertyValue<string>("umbracoRedirect")
- If it’s there, sets the published content request to redirect to the content
- Will trigger an external (browser) redirect

#### HandleWildcardDomains()

![](images/culture-and-hostnames.png)

- Finds the deepest wildcard domain between
 - domain root (or top)
 - request’s published content
- If found, updates the request’s culture accordingly

This actually implements separation between hostnames and cultures
