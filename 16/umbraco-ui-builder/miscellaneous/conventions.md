---
description: Guidelines for fluent configuration and naming conventions in Umbraco UI Builder.
---

# Conventions

## Fluent Conventions

Umbraco UI Builder follows a fluent configuration style, allowing method chaining for concise and readable code. Alternatively, a lambda expression can be used for a more structured approach.

### Chaining Example

```csharp
config.AddSection("Repositories")
      .Tree()
      .AddCollection<People>(p => p.Id, "Person", "People");
```

### Lambda Expression Example Example

```csharp
config.AddSection("Repositories", sectionConfig => {  
    sectionConfig.Tree(treeConfig => {  
        treeConfig.AddCollection<People>(p => p.Id, "Person", "People");  
    });  
});
```

## Naming Conventions

* Methods prefixed with **Add** allow multiple configurations.
* Methods prefixed with **Set** permit only one instance within the current configuration context.
