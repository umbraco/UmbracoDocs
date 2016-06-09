#Member Picker

`Returns: Member ID`

The member picker opens a panel to pick a specific member from the member section. The value saved is the selected member ID.

##Data Type Definition Example

![Media Picker Data Type Definition](images/Member-Picker-DataType.png)

##Content Example 

![Memebr Picker Content](images/Member-Picker-Content.png)

##MVC View Example

###Typed:

	@{
		if(Model.Content.HasValue("author")){
			var member = Umbraco.TypedMember(Model.Content.GetPropertyValue<int>("author"));
				@member.Name
		}
	}

###Dynamic:                              

	@{
		if(CurrentPage.HasValue("author")){
			var member = Umbraco.TypedMember(CurrentPage.author);
				@member.Name
		}
	}
	
