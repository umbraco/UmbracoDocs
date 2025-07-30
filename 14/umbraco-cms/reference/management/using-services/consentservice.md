# Consent Service

A service for handling lawful data processing requirements.

## What is a Consent

A consent is fully identified by a source (whoever is consenting), a context (for example, an application), and an action (whatever is consented). A consent state registers the state of the consent (granted, revoked...).

## Register a new consent

Consent can be given or revoked or changed via the `RegisterConsent` method, which creates a new `Consent` entity to track the consent.

## Get the current state

Getter methods of this service return the current state of a consent, that is the latest [IConsent](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Models.IConsent.html) entity that was created.

## Revoking a consent

Revoking a consent is performed by registering a revoked consent.

A consent _cannot be deleted_. It can only be revoked by registering a "revoked consent".

## Examples

```csharp
// store a new consent
var newConsent = _consentService.RegisterConsent("userId", "Our.Custom.Umbraco.Plugin", "AllowedToEmail", ConsentState.Granted, "some comments");

// lookup a consent
var consents = _consentService.LookupConsent("userId", "Our.Custom.Umbraco.Plugin", "AllowedToEmail", sourceStartsWith : true);
if (consents != null && consents.Any())
{
    var currentConsent = consents.First(c => c.Current == true);
    if(currentConsent.State  == ConsentState.Granted)
    {
        // Do what you need
    }
    else
    {
        // the state is None, Pending or Revoked
    }
}
```
