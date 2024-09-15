The main two pillars of personalization that the uMarketingSuite offers is personas and customer journeys. The impact of a content page has on these can be managed on the Content Score tab in the Personalization (content) app on the top right of any page.

But sometimes you want to have more fine grained control over when something does (or doesn't) score. For example if a user places an order, the user has shifted from the customer journey step "**think**" to "**do**". This might be difficult to accomplish through the Content Scoring UI in Umbraco, but it can easily be done by code.

To manage scoring for personas, we will need to get a reference to **IPersonaService**. For the customer journey, we will need the **ICustomerJourneyService**. Both services can be found under the namespace  **uMarketingSuite.Business.Personalization.Services**.

To implement our example above, we will be using the **ICustomerJourneyService**. To modify the customer journey step scoring, we will need to know the **id** of the step we are trying to score. For your own implementation you could hardcode the ID's (since they are unlikely to change), but we can also fetch them by name through the **ICustomerJourneyGroupRepository**.

To resolve the required services, we will use Dependency Injection:

    ICustomerJourneyGroupRepository _customerJourneyGroupRepository;ICustomerJourneyService _customerJourneyService;public MyController(ICustomerJourneyGroupRepository customerJourneyGroupRepository, ICustomerJourneyService customerJourneyService){    _customerJourneyGroupRepository = customerJourneyGroupRepository;    _customerJourneyService = customerJourneyService;}

We will now request UMS to provide the customer journey step "**Do**" from the group "**Customer Journey**" *(note: this is the default name for the customer journey upon installation).*

    var customerJourneyGroup = _customerJourneyGroupRepository.GetAll().FirstOrDefault(group => group.Title == "Customer Journey");
    var stepDo = customerJourneyGroup.Steps.FirstOrDefault(step => step.Title == "Do");

We can now inspect the **stepDo** variable and find out it's **Id**. To score the step, we simply provide the id and the score to the CustomerJourneyService:

    _customerJourneyService.ScoreCustomerJourneyStep(stepDo.Id, 100);

We have now added a **score of 100** to the Customer Journey step "**Do**". It is also possible to add negative scores. In our example we could also decrease the scores for "**See**" and "**Think**" since the user is no longer (shifting away) from that step of the Customer Journey. The implementation strategy is the same for personas.

Another, more advanced, example could be on how to reset the score of a persona for a given visitor. Using the same approach as above to fetch the **persona** instead of a Customer Journey for the current visitor, we can get the visitor's current score based on the Persona Id, and subtract that exact score from said visitor.

    public IActionResult ResetPersonaScoreToZero(long personaId){    var visitorId = _visitorContext.GetVisitorExternalId();    if(visitorId.HasValue)    {        var personaGroups = _personaGroupRepository.GetPersonaScoresByVisitor(visitorId.Value);        var personaGroup = personaGroups.FirstOrDefault(x => x.Personas.Any(y => y.Id == personaId));        var persona = personaGroup?.Personas.FirstOrDefault(x => x.Id == personaId);        if (persona != null)        {            _personaService.ScorePersona(visitorId.Value, personaId, persona.Score * -1);            return Ok($"Subtracted {persona.Score} from visitor {visitorId}");        }    }    return Ok("OK");}

The custom scoring feature is available for uMarketingSuite version 1.8.0 or higher.