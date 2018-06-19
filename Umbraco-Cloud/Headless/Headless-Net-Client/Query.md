### Query data with the .NET Headless Client

_The .NET Headless Client provides great options for query content as well as working with strongly typed objects. 
This document will cover both basic queries where you filter on a document type and a single property but also more advanced ones where you
can use either XPath or Lucene queries for maximum flexibility_

#### Simple Queries
Often you just need to get either all content of a specific Document Type or getting content that matches one or few properties. For this purpose
you can use the fluent interface provided, where you get the convenience of using Intellisense. For queries more complex than this scenario - such as grouped queries - you'll
get better results using XPath or Lucene queries which is explained below.


#### Advanced queries with XPath and Lucene
