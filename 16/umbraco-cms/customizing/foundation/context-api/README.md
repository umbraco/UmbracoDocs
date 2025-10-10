---
description: The Context API allows Umbraco backoffice extensions to share data and functionality
---

# Context API
The Context API in Umbraco is a communication system that allows backoffice extensions to share data and functionality through the component hierarchy. The functionality and data is exposed in `contexts`.

Umbraco provides many built-in contexts for common functionality like workspace management, content editing, and user interfaces. You can also create your own custom contexts when you need to share specific data or services between your extensions.

First, we'll cover the fundamentals of the Context API, like the concepts.
Then we'll consume a context.
And then we'll create our own context using an example.
