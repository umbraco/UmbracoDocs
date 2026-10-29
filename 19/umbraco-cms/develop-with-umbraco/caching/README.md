---
description: Configure response caching and server-side output caching to improve the performance of your Umbraco website.
---

# Caching

Umbraco supports two approaches to caching. Response caching uses HTTP headers to control browser and proxy caching. Website output caching stores the full rendered HTML on the server and skips the Razor pipeline on subsequent requests.

* [Response Caching](response-caching.md) - configure `Cache-Control` headers to control how browsers and proxies cache responses.
* [Website Output Caching](website-output-caching.md) - enable server-side output caching for Razor-rendered pages to avoid re-executing the rendering pipeline.
