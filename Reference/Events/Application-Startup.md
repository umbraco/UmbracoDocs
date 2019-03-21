---
versionFrom: 8.0.0
---

# Application StartUp

The ApplicationEventHandler approach for registering events has been removed in Umbraco V8, The new approach for registering custom code at 'ApplicationStarted' / 'ApplicationStarting' uses a combination of 'Components' and 'Composers', you can find examples on the [Composing](../../Implementation/Composing) page.

Core developer Stephan also has a series of blog posts about the changes:

- [Composing Umbraco v8](https://www.zpqrtbnk.net/posts/composing-umbraco-v8/)
- [Composing Umbraco v8 Collections](https://www.zpqrtbnk.net/posts/composing-umbraco-v8-collections/)
- [Composing Umbraco v8 Components](https://www.zpqrtbnk.net/posts/composing-umbraco-v8-components/)


