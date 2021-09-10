---
versionFrom: 8.0.0
versionRemoved: 9.0.0
meta.Title: "Umbraco CacheRefresher Events"
meta.Description: "Information on the various CacheRefresher events available"
---

# CacheRefresher Events

Cacherefresher events happen when the cache updates. They are not commonly used, but are sometimes nessecary instead of the Content or Media Service events as the cache events trigger later.

## Usage

Image you have some sort of product content nodes that are nested under product collection nodes. But you've extended the ExternalIndex for the product items to contain some of the collection info to make them searchable in a productsearcher. If you then update the product collection you'd want the index for the products under it to also be updated with the new collection data. Here we can use a concentcache event:

```csharp
using Examine;
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Changes;
using Umbraco.Examine;
using Umbraco.Web.Cache;

namespace Test.Composers {
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class ContentCacheRefresherEventComposer : ComponentComposer<ContentCacheRefresherEventComponent> {
    }

    public class ContentCacheRefresherEventComponent : IComponent {
        private readonly IContentService _contentService;
        private readonly IIndex _index;
        private readonly IPublishedContentValueSetBuilder _valueSetBuilder;

        public ContentCacheRefresherEvent(IContentService contentService, IPublishedContentValueSetBuilder valueSetBuilder, IExamineManager examineManager) {
            _contentService = contentService;
            _valueSetBuilder = valueSetBuilder;
            _examineManager = examineManager;            
        }

        public void Initialize() {
             if (!_examineManager.TryGetIndex(Umbraco.Core.Constants.UmbracoIndexes.ExternalIndexName, out IIndex index))
                throw new InvalidOperationException($"No index found by name {Umbraco.Core.Constants.UmbracoIndexes.ExternalIndexName}");
            _index = index;
            ContentCacheRefresher.CacheUpdated += ContentCacheRefresher_CacheUpdated;
        }

        private void ContentCacheRefresher_CacheUpdated(ContentCacheRefresher sender, Umbraco.Core.Cache.CacheRefresherEventArgs e) {
            foreach (var payload in (ContentCacheRefresher.JsonPayload[])e.MessageObject) {
                if (payload.ChangeTypes.HasType(TreeChangeTypes.RefreshNode)) {
                    var content = _contentService.GetById(payload.Id);

                    if(content.ContentType.Alias == "productCollection") {
                        // May need to do smaller pages for larger sites, but for smaller simple sites we can just get all children like this
                        var children = _contentService.GetPagedChildren(payload.Id, 0, 999, out long totalRecords);

                        IContent[] childArray = children.Cast<IContent>().ToArray();

                        _index.IndexItems(_valueSetBuilder.GetValueSets(childArray));
                    }                    
                }
            }
        }

        public void Terminate() {
            ContentCacheRefresher.CacheUpdated -= ContentCacheRefresher_CacheUpdated;
        }
    }
}
```
