# Code Samples Reference

Full guidelines for adding code samples to Umbraco documentation.

## Code Block with Caption (GitBook syntax)

````markdown
{% code title="MyController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;

namespace YourProjectNamespace.Controllers;

public class MyController : Controller
{
    // Implementation here
}
```
{% endcode %}
````

- `title` shows the filename above the code block
- Use `lineNumbers="true"` only when referencing specific lines in text

## Code Block with Line Numbers

````markdown
{% code title="MyComposer.cs" lineNumbers="true" %}
```csharp
namespace My.Website;

public class MyComposer : IComposer
{
    // ...
}
```
{% endcode %}
````

## Best Practices

### Define Context
Always describe what the code sample does, where it goes, and when to use it before presenting it.

### Add Captions
Use the filename as the caption (`title` parameter). If from a `.cs` file, use `FileName.cs`.

### Syntax Highlighting
Always specify the language after the opening triple backticks:
- `csharp` — C# code
- `json` — JSON config
- `xml` — XML config
- `html` — HTML/Razor views
- `javascript` or `typescript` — JS/TS code
- `bash` or `shell` — command line
- `yaml` — YAML files
- `markdown` — Markdown examples
- `none` — when the language isn't supported

### Complete, Compilable Code
- Include relevant `using` statements
- Code should compile as-is when possible
- Include namespace declarations

### File-Scoped Namespaces
Use file-scoped namespaces (C# 10+):

```csharp
// Good
namespace MyProject;

public class MyClass { }
```

```csharp
// Avoid
namespace MyProject
{
    public class MyClass { }
}
```

### Real-Life Examples
- Avoid `foo`, `bar`, `baz` placeholders
- Use realistic names that reflect actual Umbraco usage
- Keep examples neutral and general

### Inline Comments
For longer code samples, add inline comments to explain sections rather than surrounding the code with paragraphs of text.

### Check for Errors
Double-check all code for syntax errors and typos before committing.

## Types of Code Samples

### Inline Code
Use backticks for method names, property names, values, and code elements within text:
```markdown
Each item is treated as a standard `IPublishedElement` entity.
```

### Small Snippets
Use between article sections to highlight specific implementations. Keep focused on one concept.

### Large Code Samples
- Wrap in expandable blocks using the filename as title
- Use line numbers when referencing specific lines in surrounding text
- Add inline comments for clarity
