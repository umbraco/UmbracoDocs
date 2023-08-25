---
description: Conventions used by Konstrukt, the back office UI builder for Umbraco.
---

# Conventions

## Fluent Conventions

Most configuration methods in Konstrukt aim to be fluent in nature, in that they return a relevant config instance allowing you to chain multiple method calls together in one. For those who prefer to be a bit more verbose, many methods also accept an optional lambda expression which allows you to pass in a delegate to perform the inner configuration of the element being defined.

```csharp
// Chaining example
config.AddSection("Repositories").Tree().AddCollection<People>(p => p.Id, "Person", "People");

// Delegate example
config.AddSection("Repositories", sectionConfig => {
    sectionConfig.Tree(treeConfig => {
        treeConfig.AddCollection<People>(p => p.Id, "Person", "People");
    });
});
```

## Naming Conventions

Throughout the API, where a method name starts with **Add** then multiple configurations can be declared, whereas if a method name starts with **Set** then only one instance of the configuration can be declared within the current configuration context.