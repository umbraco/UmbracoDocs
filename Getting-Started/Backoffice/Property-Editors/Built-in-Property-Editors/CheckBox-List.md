# Checkbox List

`Returns: Comma Separated String`

Displays a list of preset values as a list of checkbox controls. The text saved is a comma separated string of text values.

NOTE: Unlike other property editors, the Prevalue IDs are not directly accessible in Razor

## Data Type Definition Example

![True/Checkbox List Definition](images/wip.png)

## Content Example 

![Checkbox List Example](images/wip.png)

## MVC View Example

### Typed

	@{
	  if (Model.Content.HasValue("superHeros")){                                                     
	       <ul>                                                        
	      @foreach(var item in Model.Content.GetPropertyValue<string>("superHeros").Split(',')) { 
	        <li>@item</li>
	      }
	    </ul>                                                                                       
	  }
	}

### Dynamic (Obsolete)

The below example is using Dynamic access content access, which is considered obsolete and is not recommended to use. However the example is included for historical reasons if for instance a developer has overtaken a project where this approach is being used. This approach will be obsolete when Umbraco 8 is released and therefore is best to use the strongly typed example listed above.

	@{
	    if (CurrentPage.HasValue("superHeros"))
	    {
	        <ul>
	            @foreach (var item in CurrentPage.superHeros.Split(','))
	            {
	                <li>@item</li>
	            }
	        </ul>
	    }
	}
    
