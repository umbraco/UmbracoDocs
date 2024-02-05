---
description: "Represents a registered server in a multiple-servers environment."
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

Constructor for creating a new ServerRegistration object. The necessary parameters are the serverAddress as a `string`, the serverIdentity as a `string` and the date and time of registration as a `DateTime`

### new ServerRegistration(int id, string serverAddress, string serverIdentity, DateTime registered, DateTime accessed, bool isActive, bool isSchedulingPublisher)

A second constructor exists but it should not be used because it is used to reconstruct a `ServerRegistration` from the data source.

## Properties

### .Accessed

Gets the date and time the registration was last accessed.

```csharp
// Given a `IServerRegistrationService` object get the first ServerRegistration and return Accessed
var serverRegistration = serverRegistrationService.GetActiveServers().FirstOrDefault();
return serverRegistration.Accessed;
```

### .IsActive

Gets or sets a value indicating whether the server is active.

```csharp
// Given a `IServerRegistrationService` object get the first ServerRegistration and return IsActive
var serverRegistration = serverRegistrationService.GetActiveServers().FirstOrDefault();
return serverRegistration.IsActive;
```

### .IsSchedulingPublisher

Gets or sets a value indicating whether the server has the SchedulingPublisher role

```csharp
// Given a `IServerRegistrationService` object get the first ServerRegistration and return IsSchedulingPublisher
var serverRegistration = serverRegistrationService.GetActiveServers().FirstOrDefault();
return serverRegistration.IsSchedulingPublisher;
```

### .Registered

Gets the date and time the registration was created.

```csharp
// Given a `IServerRegistrationService` object get the first ServerRegistration and return Registered
var serverRegistration = serverRegistrationService.GetActiveServers().FirstOrDefault();
return serverRegistration.Registered;
```

### .ServerAddress

Gets or sets the server URL.

```csharp
// Given a `IServerRegistrationService` object get the first ServerRegistration and return ServerAddress
var serverRegistration = serverRegistrationService.GetActiveServers().FirstOrDefault();
return serverRegistration.ServerAddress;
```

### .ServerIdentity

Gets or sets the server unique identity.

```csharp
// Given a `IServerRegistrationService` object get the first ServerRegistration and return ServerIdentity
var serverRegistration = serverRegistrationService.GetActiveServers().FirstOrDefault();
return serverRegistration.ServerIdentity;
```
