---
description: "In this article we describe what Nullable reference types is."
---

# Nullable Reference Types

From Umbraco version 10, Nullable Reference Types is enabled by default in Umbraco.

Nullable reference types is a group of features introduced in C# 8.0. These features can be used to minimize the likelihood that your code causes the runtime to throw `System.NullReferenceException`.

Nullable reference types includes three features that help you avoid these exceptions, including the ability to explicitly mark a reference type as nullable:

- Improved static flow analysis that determines if a variable may be null before dereferencing it.
- Attributes that annotate APIs so that the flow analysis determines null-state.
- Variable annotations that developers use to explicitly declare the intended null-state for a variable.

To learn more about Nullable Reference Types, refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/dotnet/csharp/nullable-references)
