#Dropdown list multiple

`Returns: Comma Separated String`

Displays a list of preset values as a list where multiple values can be selected. The value saved is a comma separated string of the text values. 

##Data Type Definition Example

![Dropdown list multiple Data Type Definition](images/wip.png)

##Content Example 

![Dropdown list multiple Content](images/wip.png)

##MVC View Example

###Typed:
	
	@{
	  if (Model.Content.HasValue("superHeros")){                                                     
	       <ul>                                                        
	      @foreach(var item in Model.Content.GetPropertyValue<string>("superHeros").Split(',')) { 
	        <li>@item</li>
	      }
	    </ul>                                                                                       
	  }
	}

###Dynamic:                              

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
    