---
versionTo: 7.3.0
---

# Changes to UmbracoHelper in 7.3.0

## IsProtected

Previously you had to add a child Id to the `IsProtected` mehthod on the `UmbracoHelper`.

```csharp
// Old example (pre 7.3)
@foreach (var child in CurrentPage.Children) {
    <h2>@child.Name</h2>
    @if(Umbraco.IsProtected(child.id, child.Path)){
        <blink>Members only</blink>
    }
}
```

In newer version the child id parameter is removed, an only the Path parameter is necessary.
