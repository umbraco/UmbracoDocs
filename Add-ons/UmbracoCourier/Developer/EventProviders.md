# Item Event Provider

An Item event provider allows a developer to attach events to items during an extraction.  Examples of usage could be:

* Triggering Lucene indexing
* Publishing items
* Refreshing caches
* Rebooting application pool

It is basically events you would like to postpone / queue until after all data has been safely extracted and the database is done with its transaction, unlocking the inserted and updated data. 

The `ItemEventProviders` is a replacement of the standard Umbraco event system, as Courier does not use the standard Umbraco API, and can therefore not trigger the standard event handlers, which is usually a good thing. We won’t trigger any 3rd party handlers or accidently cause a endless loop, everything is isolated which also increases the success rate.

But in some cases, it is needed to trigger an event as soon as Courier 2 is done extracting its items. Which is why the ItemEventProviders has been added.

## A sample item event provider
This is a very simple provider, as it simply has an alias and a execute method which sends a message to twitter:

	public class test : ItemEventProvider
	{
	    public override string Alias
	    {
	        get { return "TweeTOnDeploy"; }
	    }
	
	    public override void Execute(ItemIdentifier itemId,SerializableDictionary<string, string> Parameters)
	    {
	        My.Custom.TweetLibrary("woah, I just deployed some stuff");
	    }
	}
	
## Triggering the item event provider
Item event providers are triggered from either the Item provider itself during extraction, or from an added data resolver.  

For both of them, you call the Courier Execution Context, and tell it to either queue the event for later or trigger it now.

	//execute the event code now
	ExecutionContext.ExecuteEvent("TweeTOnDeploy", item.ItemId, null);
	 
	//execute the event when Deployment is completed
	ExecutionContext.QueueEvent("TweeTOnDeploy", item.ItemId, null, Umbraco.Courier.Core.Enums.EventManagerSystemQueues.DeploymentComplete);
	
	
## Queues
Item event providers are added to built-in queues which triggers at different times. The standard queues are:

### ExtractionComplete
Triggers when all items have been extracted
### PostProcessingComplete
Triggers when all items marked for postprocessing has been processed
### DBTransactionComplete
Happens just after the database transaction is committed and the Database frees the locks
### DeploymentComplete
Happens after all built-in processes has been run