---
title: DateReportData<TValue>
description: API reference for DateReportData<TValue> in Umbraco Commerce
---
## DateReportData&lt;TValue&gt;

```csharp
public class DateReportData<TValue>
```

**Namespace**
* [Umbraco.Commerce.Core.Models.Reporting](README.md)

### Constructors

#### DateReportData&lt;TValue&gt;

The default constructor.

```csharp
public DateReportData()
```


### Properties

#### CurrentTotalsOverTime

```csharp
public IEnumerable<DateRecord<TValue>> CurrentTotalsOverTime { get; set; }
```


---

#### PercentageChange

```csharp
public decimal? PercentageChange { get; set; }
```


---

#### PercentagePointChange

```csharp
public decimal? PercentagePointChange { get; set; }
```


---

#### PreviousTotalsOverTime

```csharp
public IEnumerable<DateRecord<TValue>> PreviousTotalsOverTime { get; set; }
```


---

#### Total

```csharp
public TValue Total { get; set; }
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
