---
versionFrom: 9.0.0
meta.Title: "ServerRegistration"
meta.Description: "Represents a registered server in a multiple-servers environment."
---

# ServerRegistration
The `ServerRegistration` class represents a registered server in a multiple-servers environment.

* **Namespace:** `Umbraco.Cms.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:

```csharp
using Umbraco.Cms.Core.Models;
```

## Constructors

### new ServerRegistration(string serverAddress, string serverIdentity, DateTime registered)

Constructor for creating a new ServerRegistration object where the necessary parameters are the serverAddress as a `string`, the serverIdentity as a `string` and the date and time of registration as a `DateTime`

### new ServerRegistration(int id, string serverAddress, string serverIdentity, DateTime registered, DateTime accessed, bool isActive, bool isSchedulingPublisher)

A second constructor exists but it should not be used because it is used to reconstruct a `ServerRegistration` from the data source.


## Properties

