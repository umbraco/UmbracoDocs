#Accessing Dictionary Items from Razor
_Dictionary Items can be accessed from Razor in different ways
##@Dictionary["dictionaryItemAlias"]
        <li><a href="/">@Dictionary["Home"]</a></li>
##umbraco.GetDictionaryItem("dictionaryItemAlias"]
Get the dictionary item with the specified key
        <li><a href="/">@umbraco.library.GetDictionaryItem("Home")</a></li>
##umbraco.GetDictionaryItems("dictionaryItemAlias"]
Gets the dictionary item with the specified key and it's child dictionary items
