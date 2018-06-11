# Member Picker

`Returns: Member ID`

The member picker opens a panel to pick a specific member from the member section. The value saved is the selected member ID.

## Data Type Definition Example

![Media Picker Data Type Definition](images/Member-Picker-DataType.png)

## Content Example 

![Memebr Picker Content](images/Member-Picker-Content.png)

## MVC View Example

### Typed:

	@{
		if(Model.Content.HasValue("author")){
			var member = Umbraco.TypedMember(Model.Content.GetPropertyValue<int>("author"));
				@member.Name
		}
	}

### Dynamic (Obsolete):

The below example is using Dynamic access content access, which is considered obsolete and is not recommended to use. However the example is included for historical reasons if for instance a developer has overtaken a project where this approach is being used. This approach will be obsolete when Umbraco 8 is released and therefore is best to use the strongly typed example listed above.                             

	@{
		if(CurrentPage.HasValue("author")){
			var member = Umbraco.TypedMember(CurrentPage.author);
				@member.Name
		}
	}
	
