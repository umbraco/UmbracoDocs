---
description: Examine uses Lucene as its search and index engine. Searching using Examine with Lucene can be powerful and fast.
---

# Searching with Examine

{% hint style="info" %}
As of version 19, use the [Search](../../search/README.md) section for implemented search in Umbraco CMS.

While Examine continues to power the search functionality under the hood, the content in this article is considered obsolete.
{% endhint %}

The Examine documentation is found here [https://shazwazza.github.io/Examine/](https://shazwazza.github.io/Examine/) and the source code repository for Examine is here [https://github.com/Shazwazza/Examine](https://github.com/Shazwazza/Examine).

Examine allows you to index and search data quickly. Examine is a library that sits on top of [Lucene.Net](https://lucenenet.apache.org/), a high performance search engine library. Examine provides APIs to make searching and indexing as straight forward as possible. Umbraco provides a further layer on top, UmbracoExamine. This opens up the Umbraco-specific APIs for indexing and searching content and media out of the box.

Examine is provider based so it is extensible and allows you to configure your own custom indexes if required. The backoffice search in Umbraco also uses this same search engine, so you can trust that you're in good hands.

## Umbraco Training

{% include "../../../.gitbook/includes/umbraco-searching-and-indexing-training-course.md" %}
