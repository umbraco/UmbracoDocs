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

To implement our example above, we will be using the `ICustomerJourneyService`. To modify the customer journey step scoring, we need to know the ID of the step we are trying to score. For your implementation you could hardcode the IDs (since they are unlikely to change), we can also fetch them by name through the `ICustomerJourneyGroupRepository`.

To resolve the required services, we will use Dependency Injection:

{% code overflow="wrap" %}

```csharp
ICustomerJourneyGroupRepository _customerJourneyGroupRepository;ICustomerJourneyService _customerJourneyService;public MyController(ICustomerJourneyGroupRepository customerJourneyGroupRepository, ICustomerJourneyService customerJourneyService){    _customerJourneyGroupRepository = customerJourneyGroupRepository;    _customerJourneyService = customerJourneyService;}
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

We can now inspect the step **Do** variable and find its `ID`. To score the step, we provide the `ID` and the score to the `CustomerJourneyService`:

```csharp
_customerJourneyService.ScoreCustomerJourneyStep(stepDo.Id, 100);
```

We have now added a **score of 100** to the Customer Journey step "**Do**". It is also possible to add negative scores. In our example, we can decrease the scores for "**See**" and "**Think**".

Since the user is no longer (shifting away) from that step of the Customer Journey the implementation strategy is the same for personas.

Another, more advanced, example could be on how to reset the score of a persona for a given visitor. We can use the same approach as above to fetch the **persona** instead of the Customer Journey for the current visitor. We can get the visitor's current score based on the Persona ID, and subtract that exact score from said visitor.

```csharp
public IActionResult ResetPersonaScoreToZero(long personaId){    var visitorId = _visitorContext.GetVisitorExternalId();    if(visitorId.HasValue)    {        var personaGroups = _personaGroupRepository.GetPersonaScoresByVisitor(visitorId.Value);        var personaGroup = personaGroups.FirstOrDefault(x => x.Personas.Any(y => y.Id == personaId));        var persona = personaGroup?.Personas.FirstOrDefault(x => x.Id == personaId);        if (persona != null)        {            _personaService.ScorePersona(visitorId.Value, personaId, persona.Score * -1);            return Ok($"Subtracted {persona.Score} from visitor {visitorId}");        }    }    return Ok("OK");}
```
