---
versionFrom: 8.0.0
---

# How to implement a 404 Page

To implement your own 404 finder, create a class which implements the interface *IContentLastChanceFinder* and registering it as the last chance content finder using an *IComposer*. A ContentLastChanceFinder will always return a 404 status code. - [Using an IContentFinder for Custom 404s](../../routing/request-pipeline/IContentFinder#notfoundhandlers)
