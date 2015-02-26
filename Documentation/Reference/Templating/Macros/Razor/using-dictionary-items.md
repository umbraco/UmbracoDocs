#Accessing Umbraco Dictionary Items from Razor
Dictionary Items can be accessed from Razor in different ways
##Using DynamicDictionary
###@Dictionary["dictionaryItemAlias"]
	@Dictionary["Home"]
###@Dictionary.DictionaryItemAlias
	@Dictionary.Home
##Using C# API
###umbraco.library.GetDictionaryItem("dictionaryItemAlias")
Get the dictionary item with the specified key `@umbraco.library.GetDictionaryItem("Home")`
###umbraco.library.GetDictionaryItems("dictionaryItemAlias")
Gets the dictionary item with the specified key and its child dictionary items
