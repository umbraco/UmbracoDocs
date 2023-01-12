# Filtering using Linq

```csharp
.Where(p => p.Price > 400)
.OrderBy(p => p.ProductName)
.OrderByDescending(p=>p.Price)
.GroupBy(p => p.Category)
.Take(3)
.Skip(3)
.InGroupsOf
.IsVisible()
.Select(s => s.Supplier)
.Distinct()
.OfType<MyContentType>()
```
