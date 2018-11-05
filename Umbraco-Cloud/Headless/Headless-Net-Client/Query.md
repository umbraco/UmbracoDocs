### Query data with the .NET Headless Client

_The .NET Headless Client provides great options for query content as well as working with strongly typed objects. 
This document will cover both basic queries where you filter on a document type and a single property but also more advanced ones where you can use either XPath or Lucene queries for maximum flexibility_

To get content from Headless, you'll use the Headless Service described in the other documents, so this assumes you already have made HeadlessClient class in your solution. If not, then go back and read about how you set that up.

*The Headless Query API is async, so if your application doesn't work with async you'll need to call .Result in the end of the query.*

#### Simple Queries
Often you just need to get either all content of a specific Document Type or getting content that matches one or few properties. For this purpose you can use the fluent interface provided, where you get the convenience of using Intellisense. For queries more complex than this scenario - such as grouped queries - you'll get better results using XPath or Lucene queries which is explained below.

##### Getting started
When you query headless you can choose to either get all content that matches your query (`GetAll()`, `Query()` or `Search()` all of which can be typed) or getting the first item:
```
using Umbraco.Headless.Client.Net.Models;
using Umbraco.Headless.Client.Net.QueryBuilder;

...

// Example of filtering by build-in Umbraco property and get the best (first) match  

var query = Query
    .Where
    .Name
    .EqualTo("Unicorn Pinot Noir");

var contentWithSpecificName = 
    await HeadlessClient.Instance.Query(query);
    
contentWithSpecificName.First();

// Example of filtering by custom property with the alias tags and get all content that matches

var query = Query
    .Where
    .Property("tags")
    .Contains("pinotnoir");

var allContentWithHeadlessTags = 
    await HeadlessClient.Instance.Query(query);
```

##### Filter on Document Types with strongly typed classes 
You can also filter on document types and get them back as strongly typed objects. Let's start with an example and then we'll explain below:
```
// Create a class that matches your Document Type and inherits from a ContentItem
// which contains basic meta data and makes Headless understand your content model
using System.Collections.Generic;
using Umbraco.Headless.Client.Net.Models;

namespace Our.Umbraco.Headless.Examples.Models
{
    // The alias of our Document Type is "wine" and matching isn't case sensitive
    public class Wine : ContentBase
    {
        // we can add the custom properties from our document type 
        // as Strongly Typed .NET Properties
        public string Grape { get; set; }
        public string Area { get; set; }
        public string Description { get; set; }        
        public int Rating { get; set; }
        public bool ReadyForShipment { get; set; }
        public string[] Tags { get; set; }        
        public List<ContentItem> RelatedWine { get; set; }
    }
}

// Now that we have a strongly typed version, we can get all wines from Headless by 
// passing in our Class
using Umbraco.Headless.Client.Net.Models;
using Umbraco.Headless.Client.Net.QueryBuilder;
using Our.Umbraco.Headless.Examples.Models;

...

// Getting all wine  
var allWine = 
    await HeadlessClient
    .Instance
    .GetAll<Wine>();

// Of course we can also use the filtering we learned about in the previous example, so
// getting all wine that's a pinot noir grape

var query = Query
    .Where
    .Property("tags")
    .Contains("pinotnoir");

var allWine = 
    await HeadlessClient
    .Instance
    .Query<Wine>(query);

// As this is strongly typed it's easy to work with the content afterwards:
foreach(var wine in allWine) {
    Console.WriteLine(wine.Name);
    Console.WriteLine(wine.Description);
    
    foreach (var relatedWine in wine.RelatedWine) {
        Console.WriteLine(relatedWine.Name);
    }
}
```

#### Advanced queries with XPath and Lucene
If you need more advanced queries, so you use XPath or Lucene instead of the fluent interface. This is useful for fast search in a big repository of content or for more advanced/grouped queries. Let's say we want all content from Headless that contains the tag "pinotnoir":
```
using Umbraco.Headless.Client.Net.Models;
using Umbraco.Headless.Client.Net.QueryBuilder;
using Our.Umbraco.Headless.Examples.Models;

...
var content = await HeadlessClient.Instance.Search("tags:'pinotnoir'");

// we can also combine what we've learned such as filter on document type:
var content = await HeadlessClient.Instance.Search<Wine>("tags:'pinotnoir' OR tags:'riesling'");

```
