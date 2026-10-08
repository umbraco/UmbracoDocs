---
description: >-
  The main two pillars of personalization that the Umbraco Engage offers are
  personas and customer journeys.
---

# Add custom scoring

The impact of the content page on these can be managed on the Content Score tab in the Personalization app on the top right.

Sometimes you want more fine-grained control over when something does (or doesn't) score. For example, if a user places an order, the user has shifted from the customer journey step "**think**" to "**do**".

This might be difficult to accomplish through the Content Scoring UI in Umbraco, but can be done by code.

To manage scoring for personas, we need to get a reference to `IPersonaService`. For the customer journey, we will need the `ICustomerJourneyService`. Both services can be found under the namespace `Umbraco.Engage.Infrastructure.Personalization.Services`.

Both services support two ways to identify entities:
- **Numeric IDs** (e.g., `personaId`, `customerJourneyStepId`) - Legacy approach using database IDs
- **GUID Keys** (e.g., `personaKey`, `stepKey`) - Preferred approach using Umbraco's GUID-based identifiers

To implement the example above, the `ICustomerJourneyService` will be used. To modify the customer journey step scoring, the ID or Key of the step being updated must be known. For an implementation, the IDs/Keys can be hardcoded (since they are unlikely to change), or they can be fetched by name through the `ICustomerJourneyGroupRepository`.

To resolve the required services, we will use Dependency Injection:

{% code overflow="wrap" %}
```csharp
ICustomerJourneyGroupRepository _customerJourneyGroupRepository;
ICustomerJourneyService _customerJourneyService;

public MyController(
    ICustomerJourneyGroupRepository customerJourneyGroupRepository,
    ICustomerJourneyService customerJourneyService) {
        
  _customerJourneyGroupRepository = customerJourneyGroupRepository;
  _customerJourneyService = customerJourneyService;
}
```
{% endcode %}

We will now request Umbraco Engage to provide the customer journey step "**Do**" from the group "**Customer Journey**".

{% hint style="info" %}
This is the default name for the customer journey upon installation.
{% endhint %}

{% code overflow="wrap" %}
```csharp
var customerJourneyGroup = _customerJourneyGroupRepository.GetAll().FirstOrDefault(group => group.Title == "Customer Journey");
var stepDo = customerJourneyGroup.Steps.FirstOrDefault(step => step.Title == "Do");
```
{% endcode %}

Inspect the step **Do** variable and find its `Id` or `Key`. To score the step, provide either the numeric ID or the GUID Key and the score to the `CustomerJourneyService`:

```csharp
// Using numeric ID (legacy approach)
_customerJourneyService.ScoreCustomerJourneyStep(stepDo.Id, 100);

// Using GUID Key (preferred approach)
_customerJourneyService.ScoreCustomerJourneyStep(stepDo.Key, 100);
```

We have now added a **score of 100** to the Customer Journey step "**Do**". It is also possible to add negative scores. In our example, we can decrease the scores for "**See**" and "**Think**".

Since the user is no longer (shifting away) from that step of the Customer Journey the implementation strategy is the same for personas.

Another, more advanced, example could be on how to reset the score of a persona for a given visitor. Use the same approach as above to fetch the **persona** instead of the Customer Journey for the current visitor. Get the visitor's current score based on the Persona ID or Key, and subtract that exact score from said visitor.

{% hint style="info" %}

When scoring outside of a regular HttpContext request (for example, in background jobs or external integrations), use the overload with `PersonalizationScoreType`. The `PersonalizationScoreType` enum specifies whether the score is `Implicit` (behavior-based) or `Explicit` (direct assignment).
{% endhint %}

```csharp
// Using numeric ID
public IActionResult ResetPersonaScoreToZero(long personaId)
{
    var visitorId = _visitorContext.GetVisitorExternalId();

    if (visitorId.HasValue)
    {
        var personaGroups = _personaGroupRepository.GetPersonaScoresByVisitor(visitorId.Value);
        var personaGroup = personaGroups.FirstOrDefault(x => x.Personas.Any(y => y.Id == personaId));
        var persona = personaGroup?.Personas.FirstOrDefault(x => x.Id == personaId);
        if (persona != null)
        {
            _personaService.ScorePersona(visitorId.Value, personaId, persona.Score * -1, PersonalizationScoreType.Explicit);
            return Ok($"Subtracted {persona.Score} from visitor {visitorId}");
        }
    }

    return Ok("OK");
}

// Using GUID Key (preferred approach)
public IActionResult ResetPersonaScoreToZero(Guid personaKey)
{
    var visitorId = _visitorContext.GetVisitorExternalId();

    if (visitorId.HasValue)
    {
        var personaGroups = _personaGroupRepository.GetPersonaScoresByVisitor(visitorId.Value);
        var personaGroup = personaGroups.FirstOrDefault(x => x.Personas.Any(y => y.Key == personaKey));
        var persona = personaGroup?.Personas.FirstOrDefault(x => x.Key == personaKey);
        if (persona != null)
        {
            _personaService.ScorePersona(visitorId.Value, personaKey, persona.Score * -1, PersonalizationScoreType.Explicit);
            return Ok($"Subtracted {persona.Score} from visitor {visitorId}");
        }
    }

    return Ok("OK");
}
```

{% hint style="info" %}
The following overloads should only be used within the context of a regular HttpContext request, as they automatically resolve the current visitor.

-  `ScorePersona(long personaId, int score)`, 
- `ScorePersona(Guid personaKey, int score)`, 
- `ScoreCustomerJourneyStep(long customerJourneyStepId, int score)`, and 
- `ScoreCustomerJourneyStep(Guid stepKey, int score)`

{% endhint %}

## Available Method Overloads

### IPersonaService

| Method | Parameters | Use Case |
|--------|------------|----------|
| `ScorePersona` | `(long personaId, int score)` | Within HttpContext, using numeric ID |
| `ScorePersona` | `(Guid personaKey, int score)` | Within HttpContext, using GUID key (preferred) |
| `ScorePersona` | `(Guid visitorExternalId, long personaId, int score, PersonalizationScoreType scoreType)` | Outside HttpContext, using numeric ID |
| `ScorePersona` | `(Guid visitorExternalId, Guid personaKey, int score, PersonalizationScoreType scoreType)` | Outside HttpContext, using GUID key (preferred) |

### ICustomerJourneyService

| Method | Parameters | Use Case |
|--------|------------|----------|
| `ScoreCustomerJourneyStep` | `(long customerJourneyStepId, int score)` | Within HttpContext, using numeric ID |
| `ScoreCustomerJourneyStep` | `(Guid stepKey, int score)` | Within HttpContext, using GUID key (preferred) |
| `ScoreCustomerJourneyStep` | `(Guid visitorExternalId, long customerJourneyStepId, int score, PersonalizationScoreType scoreType)` | Outside HttpContext, using numeric ID |
| `ScoreCustomerJourneyStep` | `(Guid visitorExternalId, Guid stepKey, int score, PersonalizationScoreType scoreType)` | Outside HttpContext, using GUID key (preferred) |
