#Radiobutton List

`Returns: Integer`

Pretty much like the name indicates this Data type enables editors to choose from list of radiobuttons. The settings for this data type include the data storage type (Date, Integer, Ntext, Nvarchar) and the prevalues the RadioButton list should hold.

##Settings

###Database datatype

This setting is maintained for legacy however it should be set to Integer as the property editor stores the value which is always a integer.

###Prevalues

Add, edit and reorder the prevalues for the property editor. To edit click on the text and a edit textbox will appear. To reorder click on the "sort" text and drag up or down.

![Radiobutton List Settings](images/Radiobutton-List-Settings.jpg?raw=true)

##Data Type Definition Example

![Radiobutton List Data Type Definition](images/Radiobutton-List-DataType.jpg?raw=true)

##Content Example 

![Radiobutton List Content](images/Radiobutton-List-Content.jpg?raw=true)

##MVC View Example

###Typed:

Coming soon...

###Dynamic: 

Coming soon...

##Razor Macro (DynamicNode) Example

	@{
		if (Model.HasValue("robotsIndex")){	
			<meta name="robots" content="@umbraco.library.GetPreValueAsString(Convert.ToInt32(Model.robotsIndex)).ToLower()"/>	
		}
	}

##XSLT Macro Example

	<meta name="robots" content="{$Exslt.ExsltStrings:lowercase(umbraco.library:GetPreValueAsString($currentPage/robotsIndex))}"/>