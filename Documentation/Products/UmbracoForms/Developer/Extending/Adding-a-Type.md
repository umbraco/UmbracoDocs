#Adding a type to the provider model

To add a new type, no matter if it's a workflow, field, data source, etc, there is a number of tasks to perform to connect to the Forms provider model. This chapter walks through each step and describes how each part works. This chapter will reference the creation of a workflow type. It is however the same process for all types.
##Preparations
Create a new asp.net or class project in Visual Studio add references to the Umbraco.Forms.Core.dll.
##Adding the type to Forms
The Forms api contains a collection of classes that the provider model automaticly registers. So to add a new type to Forms you simply inherit from the right class. In the sample below we use the class for the workflow type.

	public class Class1 : Umbraco.Forms.Core.WorkflowType 
	{ 
		public override WorkflowExecutionStatus Execute(Umbraco.Forms.Core.Record record) 
		{ 
			throw new NotImplementedException(); 
		} 

		public override List<Exception> ValidateSettings() { 
			throw new NotImplementedException(); 
		} 
	}
When you implement this class you get two methods added. One of them is Execute which performs the execution of the workflow and the other is a method which validates the workflow settings, we will get back to these settings later on.

Even though we have the class inheritance in place, we still need to add a bit of default information.

##Setting up basic type information
Even though we have the class inheritance in place, we still need to add a bit of default information. This information is added in the class's empty constructor like this:
	
	public Class1() { 
		this.Name = "The logging workflow"; 
		this.Id = new Guid("D6A2C406-CF89-11DE-B075-55B055D89593"); 
		this.Description = "This will save an entry to the log"; 
	}
All three are mandatory and the ID must be unique, otherwise the type might conflict with an existing one.
##Adding settings to a type
Now that we have a basic class setup, we would like to pass setting items to the type. So we can reuse the type on multiple items but with different settings. To add a setting to a type, we simply add a property to the class, and give it a specific attribute like this:

	[Umbraco.Forms.Core.Attributes.Setting("Log Header", 
			description = "Log item header", 
			view = "TextField")] 
	public string LogHeader { get; set; }
The Umbraco.Forms.Core.Attributes.Setting registers the property in Umbraco Forms and there will automatically be UI and storage generated for it. In the attribute a name, description and the view to be rendered is defined.

With the attribute in place, the property value is set every time the class is instantiated by Umbraco Forms. This means you can use the property in your code like this:

	[Umbraco.Forms.Core.Attributes.Setting("Document ID", 
			description = "Node the log entry belongs to", 
			view = "Pickers.Content")] 
	public string document { get; set; } 

	public override Enums.WorkflowExecutionStatus Execute(Record record) { 
		Log.Add(LogTypes.Debug, int.Parse(document), "record submitted from: " + record.IP); 
	}
For all types that uses the provider model, settings work this way. By adding the Setting attribute Forms automatically registers the property in the UI and sets the value when the class is instantiated.
##Validate type settings with ValidateSettings()
The ValidateSettings() method which can be found on all types supporting dynamic settings, is used for making sure the data entered by the user is valid and works with the type.

	public override List<Exception> ValidateSettings() { 
		List<Exception> exceptions = new List<Exception>(); 
		int docId = 0; 
		if (!int.TryParse(document, out docId)) 
			exceptions.Add(new Exception("Document is not a valid integer")); 
		return exceptions; 
	}
##Registering the class with Umbraco and Forms

Finally compile the project and copy the .dll to your website /bin folder or copy the .cs file to the app_code directory. The website will now restart and your type will be registered automatically, no configuration 
needed. Also look in the reference chapter for complete class implementations of workflows, fields and export types
