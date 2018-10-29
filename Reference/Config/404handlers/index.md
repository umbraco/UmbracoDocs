# 404handlers.config

**Obsolete.  The concept of *NotFoundHandlers* has been replaced by [Content Finders](../../routing/request-pipeline/IContentFinder)**

_Configuration file for legacy *NotFoundHandlers*. These are used to register custom code within the Umbraco incoming request pipeline, including the legacy way to handle a custom 404 error._

The Default Handlers are listed in this configuration file for 'backwards compatibility':

    <NotFoundHandlers>
      <notFound assembly="umbraco" type="SearchForAlias" />
      <notFound assembly="umbraco" type="SearchForTemplate"/>
      <notFound assembly="umbraco" type="SearchForProfile"/>
      <notFound assembly="umbraco" type="handle404"/>
    </NotFoundHandlers>

## Backwards compatibility

If you upgrade from an older version of Umbraco then legacy *NotFoundHandlers* listed here 'should' still work - The request pipeline contains a *ContentFinderByNotFoundHandlers* IContentFinder that will attempt to execute the functionality of any legacy *NotFoundHandlers*, but it's recommended to move your custom request handling logic to IContentFinders.

## Implementing 404 not found properly

Custom 404's are now handled within a custom *IContentFinder* by setting the Is404 property to true for the *PublishedContentRequest* processed by the *IContentFinder* or by registering the *IContentFinder* as a *ContentLastChanceFinder* - [Using an IContentFinder for Custom 404s](../../routing/request-pipeline/IContentFinder#notfoundhandlers)
